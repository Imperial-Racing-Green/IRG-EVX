/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd._AutoDetectionDataCounter = 0;

wpd.AutoDetectionData = class {
    constructor() {
        // public
        this.imageWidth = 0;
        this.imageHeight = 0;
        this.fgColor = [0, 0, 255];
        this.bgColor = [255, 255, 255];
        this.mask = new Set();
        this.binaryData = new Set();
        this.colorDetectionMode = 'fg';
        this.colorDistance = 120;
        this.algorithm = null;
        this.name = wpd._AutoDetectionDataCounter++;
    }

    serialize() {
        // if there's no algo, or if the algo was never run (no algoData),
        // then just return null as there's no reason to save this data.
        if (this.algorithm == null) {
            return null;
        }
        let algoData = this.algorithm.serialize();
        if (algoData == null) {
            return null;
        }

        let compressedMask = wpd.rle.encode(Array.from(this.mask.values()).sort((a, b) => {
            return (a - b);
        }));

        return {
            fgColor: this.fgColor,
            bgColor: this.bgColor,
            mask: compressedMask,
            colorDetectionMode: this.colorDetectionMode,
            colorDistance: this.colorDistance,
            algorithm: algoData,
            name: this.name,
            imageWidth: this.imageWidth,
            imageHeight: this.imageHeight
        };
    }

    deserialize(jsonObj) {
        this.fgColor = jsonObj.fgColor;
        this.bgColor = jsonObj.bgColor;
        this.imageWidth = jsonObj.imageWidth;
        this.imageHeight = jsonObj.imageHeight;
        if (jsonObj.mask != null) {
            let uncompressedMaskData = wpd.rle.decode(jsonObj.mask);
            this.mask = new Set();
            for (let i of uncompressedMaskData) {
                this.mask.add(i);
            }
        }
        this.colorDetectionMode = jsonObj.colorDetectionMode;
        this.colorDistance = jsonObj.colorDistance;

        if (jsonObj.algorithm != null) {
            let algoType = jsonObj.algorithm.algoType;
            if (algoType === "AveragingWindowAlgo") {
                this.algorithm = new wpd.AveragingWindowAlgo();
            } else if (algoType === "AveragingWindowWithStepSizeAlgo") {
                this.algorithm = new wpd.AveragingWindowWithStepSizeAlgo();
            } else if (algoType === "BarExtractionAlgo") {
                this.algorithm = new wpd.BarExtractionAlgo();
            } else if (algoType === "BlobDetectorAlgo") {
                this.algorithm = new wpd.BlobDetectorAlgo();
            } else if (algoType === "XStepWithInterpolationAlgo") {
                this.algorithm = new wpd.XStepWithInterpolationAlgo();
            }
            this.algorithm.deserialize(jsonObj.algorithm);
        }

        this.name = jsonObj.name;
    }

    generateBinaryDataFromMask(imageData) {
        this.binaryData = new Set();
        let refColor = this.colorDetectionMode === 'fg' ? this.fgColor : this.bgColor;
        for (let imageIdx of this.mask) {
            let ir = imageData.data[imageIdx * 4];
            let ig = imageData.data[imageIdx * 4 + 1];
            let ib = imageData.data[imageIdx * 4 + 2];
            let ia = imageData.data[imageIdx * 4 + 3];
            if (ia === 0) {
                // for completely transparent part of the image, assume white
                ir = 255;
                ig = 255;
                ib = 255;
            }
            let dist = wpd.dist3d(ir, ig, ib, refColor[0], refColor[1], refColor[2]);
            if (this.colorDetectionMode === 'fg') {
                if (dist <= this.colorDistance) {
                    this.binaryData.add(imageIdx);
                }
            } else {
                if (dist >= this.colorDistance) {
                    this.binaryData.add(imageIdx);
                }
            }
        }
    }

    generateBinaryDataUsingFullImage(imageData) {
        this.binaryData = new Set();
        let refColor = this.colorDetectionMode === 'fg' ? this.fgColor : this.bgColor;
        for (let imageIdx = 0; imageIdx < imageData.data.length; imageIdx++) {
            let ir = imageData.data[imageIdx * 4];
            let ig = imageData.data[imageIdx * 4 + 1];
            let ib = imageData.data[imageIdx * 4 + 2];
            let ia = imageData.data[imageIdx * 4 + 3];
            if (ia === 0) {
                // for completely transparent part of the image, assume white
                ir = 255;
                ig = 255;
                ib = 255;
            }
            let dist = wpd.dist3d(ir, ig, ib, refColor[0], refColor[1], refColor[2]);
            if (this.colorDetectionMode === 'fg') {
                if (dist <= this.colorDistance) {
                    this.binaryData.add(imageIdx);
                }
            } else {
                if (dist >= this.colorDistance) {
                    this.binaryData.add(imageIdx);
                }
            }
        }
    }

    generateBinaryData(imageData) {
        if (this.mask == null || this.mask.size == 0) {
            this.generateBinaryDataUsingFullImage(imageData);
        } else {
            this.generateBinaryDataFromMask(imageData);
        }
    }
};

wpd.GridDetectionData = class {
    constructor() {
        this.mask = {
            xmin: null,
            xmax: null,
            ymin: null,
            ymax: null,
            pixels: []
        };
        this.lineColor = [255, 255, 255];
        this.colorDistance = 10;
        this.gridData = null;
        this.gridMask = {
            xmin: null,
            xmax: null,
            ymin: null,
            ymax: null,
            pixels: new Set()
        };
        this.binaryData = new Set();
        this.imageWidth = 0;
        this.imageHeight = 0;
        this.backupImageData = null;
        this.gridBackgroundMode = true;
    }

    generateBinaryData(imageData) {
        this.binaryData = new Set();
        this.imageWidth = imageData.width;
        this.imageHeight = imageData.height;

        // use the full image if no grid mask is present
        if (this.gridMask.pixels == null || this.gridMask.pixels.size === 0) {
            this.gridMask.pixels = new Set();

            for (let yi = 0; yi < this.imageHeight; yi++) {
                for (let xi = 0; xi < this.imageWidth; xi++) {
                    let img_index = yi * this.imageWidth + xi;
                    let ir = imageData.data[img_index * 4];
                    let ig = imageData.data[img_index * 4 + 1];
                    let ib = imageData.data[img_index * 4 + 2];
                    let ia = imageData.data[img_index * 4 + 3];

                    if (ia === 0) {
                        // assume white color when image is transparent
                        ir = 255;
                        ig = 255;
                        ib = 255;
                    }

                    let dist = wpd.dist3d(this.lineColor[0], this.lineColor[1], this.lineColor[2],
                        ir, ig, ib);

                    if (this.gridBackgroundMode) {
                        if (dist > this.colorDistance) {
                            this.binaryData.add(img_index);
                            this.gridMask.pixels.add(img_index);
                        }
                    } else {
                        if (dist < this.colorDistance) {
                            this.binaryData.add(img_index);
                            this.gridMask.pixels.add(img_index);
                        }
                    }
                }
            }
            this.gridMask.xmin = 0;
            this.gridMask.xmax = this.imageWidth;
            this.gridMask.ymin = 0;
            this.gridMask.ymax = this.imageHeight;
            return;
        }

        for (let img_index of this.gridMask.pixels) {
            let ir = imageData.data[img_index * 4];
            let ig = imageData.data[img_index * 4 + 1];
            let ib = imageData.data[img_index * 4 + 2];
            let ia = imageData.data[img_index * 4 + 3];

            let dist =
                wpd.dist3d(this.lineColor[0], this.lineColor[1], this.lineColor[2], ir, ig, ib);

            if (this.gridBackgroundMode) {
                if (dist > this.colorDistance) {
                    this.binaryData.add(img_index);
                }
            } else {
                if (dist < this.colorDistance) {
                    this.binaryData.add(img_index);
                }
            }
        }
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

// calibration info
wpd.Calibration = class {

    constructor(dim) {
        this._dim = dim;
        this._px = [];
        this._py = [];
        this._dimensions = dim == null ? 2 : dim;
        this._dp = [];
        this._selections = [];

        // public:
        this.labels = [];
        this.labelPositions = [];
        this.maxPointCount = 0;
    }

    getCount() {
        return this._px.length;
    }

    getDimensions() {
        return this._dimensions;
    }

    addPoint(pxi, pyi, dxi, dyi, dzi) {
        let plen = this._px.length;
        let dlen = this._dp.length;
        this._px[plen] = pxi;
        this._py[plen] = pyi;
        this._dp[dlen] = dxi;
        this._dp[dlen + 1] = dyi;
        if (this._dimensions === 3) {
            this._dp[dlen + 2] = dzi;
        }
    }

    getPoint(index) {
        if (index < 0 || index >= this._px.length)
            return null;

        return {
            px: this._px[index],
            py: this._py[index],
            dx: this._dp[this._dimensions * index],
            dy: this._dp[this._dimensions * index + 1],
            dz: this._dimensions === 2 ? null : this._dp[this._dimensions * index + 2]
        };
    }

    changePointPx(index, npx, npy) {
        if (index < 0 || index >= this._px.length) {
            return;
        }
        this._px[index] = npx;
        this._py[index] = npy;
    }

    setDataAt(index, dxi, dyi, dzi) {
        if (index < 0 || index >= this._px.length)
            return;
        this._dp[this._dimensions * index] = dxi;
        this._dp[this._dimensions * index + 1] = dyi;
        if (this._dimensions === 3) {
            this._dp[this._dimensions * index + 2] = dzi;
        }
    }

    findNearestPoint(x, y, threshold) {
        threshold = (threshold == null) ? 50 : parseFloat(threshold);
        let minDist = 0;
        let minIndex = -1;

        for (let i = 0; i < this._px.length; i++) {
            let dist = Math.sqrt((x - this._px[i]) * (x - this._px[i]) +
                (y - this._py[i]) * (y - this._py[i]));
            if ((minIndex < 0 && dist <= threshold) || (minIndex >= 0 && dist < minDist)) {
                minIndex = i;
                minDist = dist;
            }
        }
        return minIndex;
    }

    selectPoint(index) {
        if (this._selections.indexOf(index) < 0) {
            this._selections.push(index);
        }
    }

    selectNearestPoint(x, y, threshold) {
        let minIndex = this.findNearestPoint(x, y, threshold);
        if (minIndex >= 0) {
            this.selectPoint(minIndex);
        }
    }

    getSelectedPoints() {
        return this._selections;
    }

    unselectAll() {
        this._selections = [];
    }

    isPointSelected(index) {
        return this._selections.indexOf(index) >= 0;
    }

    dump() {
        console.log(this._px);
        console.log(this._py);
        console.log(this._dp);
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.ColorGroup = (function() {
    var CGroup = function(tolerance) {
        var totalPixelCount = 0,
            averageColor = {
                r: 0,
                g: 0,
                b: 0
            };

        tolerance = tolerance == null ? 100 : tolerance;

        this.getPixelCount = function() {
            return totalPixelCount;
        };

        this.getAverageColor = function() {
            return averageColor;
        };

        this.isColorInGroup = function(r, g, b) {
            if (totalPixelCount === 0) {
                return true;
            }

            var dist = (averageColor.r - r) * (averageColor.r - r) +
                (averageColor.g - g) * (averageColor.g - g) +
                (averageColor.b - b) * (averageColor.b - b);

            return (dist <= tolerance * tolerance);
        };

        this.addPixel = function(r, g, b) {
            averageColor.r = (averageColor.r * totalPixelCount + r) / (totalPixelCount + 1.0);
            averageColor.g = (averageColor.g * totalPixelCount + g) / (totalPixelCount + 1.0);
            averageColor.b = (averageColor.b * totalPixelCount + b) / (totalPixelCount + 1.0);
            totalPixelCount = totalPixelCount + 1;
        };
    };
    return CGroup;
})();

wpd.colorAnalyzer = (function() {
    function getTopColors(imageData) {

        var colorGroupColl = [], // collection of color groups
            pixi, r, g, b, a, groupi, groupMatched, rtnVal = [],
            avColor, tolerance = 120;

        colorGroupColl[0] = new wpd.ColorGroup(tolerance); // initial group

        for (pixi = 0; pixi < imageData.data.length; pixi += 4) {
            r = imageData.data[pixi];
            g = imageData.data[pixi + 1];
            b = imageData.data[pixi + 2];
            a = imageData.data[pixi + 3];
            if (a === 0) {
                r = 255;
                g = 255;
                b = 255;
            }

            groupMatched = false;

            for (groupi = 0; groupi < colorGroupColl.length; groupi++) {
                if (colorGroupColl[groupi].isColorInGroup(r, g, b)) {
                    colorGroupColl[groupi].addPixel(r, g, b);
                    groupMatched = true;
                    break;
                }
            }

            if (!groupMatched) {
                colorGroupColl[colorGroupColl.length] = new wpd.ColorGroup(tolerance);
                colorGroupColl[colorGroupColl.length - 1].addPixel(r, g, b);
            }
        }

        // sort groups
        colorGroupColl.sort(function(a, b) {
            if (a.getPixelCount() > b.getPixelCount()) {
                return -1;
            } else if (a.getPixelCount() < b.getPixelCount()) {
                return 1;
            }
            return 0;
        });

        for (groupi = 0; groupi < colorGroupColl.length; groupi++) {

            avColor = colorGroupColl[groupi].getAverageColor();

            rtnVal[groupi] = {
                r: parseInt(avColor.r, 10),
                g: parseInt(avColor.g, 10),
                b: parseInt(avColor.b, 10),
                pixels: colorGroupColl[groupi].getPixelCount(),
                percentage: 100.0 * colorGroupColl[groupi].getPixelCount() / (0.25 * imageData.data.length)
            };
        }

        return rtnVal;
    }

    return {
        getTopColors: getTopColors
    };
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.ConnectedPoints = class {
    constructor(connectivity) {
        this._connections = [];
        this._selectedConnectionIndex = -1;
        this._selectedPointIndex = -1;
        this._connectivity = connectivity;
    }

    addConnection(plist) {
        this._connections.push(plist);
    }

    clearAll() {
        this._connections = [];
    }

    getConnectionAt(index) {
        if (index < this._connections.length) {
            return this._connections[index];
        }
    }

    replaceConnectionAt(index, plist) {
        if (index < this._connections.length) {
            this._connections[index] = plist;
        }
    }

    deleteConnectionAt(index) {
        if (index < this._connections.length) {
            this._connections.splice(index, 1);
        }
    }

    connectionCount() {
        return this._connections.length;
    }

    findNearestPointAndConnection(x, y) {
        var minConnIndex = -1,
            minPointIndex = -1,
            minDist, dist, ci, pi;

        for (ci = 0; ci < this._connections.length; ci++) {
            for (pi = 0; pi < this._connections[ci].length; pi += 2) {
                dist = (this._connections[ci][pi] - x) * (this._connections[ci][pi] - x) +
                    (this._connections[ci][pi + 1] - y) * (this._connections[ci][pi + 1] - y);
                if (minPointIndex === -1 || dist < minDist) {
                    minConnIndex = ci;
                    minPointIndex = pi / 2;
                    minDist = dist;
                }
            }
        }

        return {
            connectionIndex: minConnIndex,
            pointIndex: minPointIndex
        };
    }

    selectNearestPoint(x, y) {
        var nearestPt = this.findNearestPointAndConnection(x, y);
        if (nearestPt.connectionIndex >= 0) {
            this._selectedConnectionIndex = nearestPt.connectionIndex;
            this._selectedPointIndex = nearestPt.pointIndex;
        }
    }

    deleteNearestConnection(x, y) {
        var nearestPt = this.findNearestPointAndConnection(x, y);
        if (nearestPt.connectionIndex >= 0) {
            this.deleteConnectionAt(nearestPt.connectionIndex);
        }
    }

    isPointSelected(connectionIndex, pointIndex) {
        if (this._selectedPointIndex === pointIndex &&
            this._selectedConnectionIndex === connectionIndex) {
            return true;
        }
        return false;
    }

    getSelectedConnectionAndPoint() {
        return {
            connectionIndex: this._selectedConnectionIndex,
            pointIndex: this._selectedPointIndex
        };
    }

    unselectConnectionAndPoint() {
        this._selectedConnectionIndex = -1;
        this._selectedPointIndex = -1;
    }

    setPointAt(connectionIndex, pointIndex, x, y) {
        this._connections[connectionIndex][pointIndex * 2] = x;
        this._connections[connectionIndex][pointIndex * 2 + 1] = y;
    }

    getPointAt(connectionIndex, pointIndex) {
        return {
            x: this._connections[connectionIndex][pointIndex * 2],
            y: this._connections[connectionIndex][pointIndex * 2 + 1]
        };
    }
};

wpd.DistanceMeasurement = class extends wpd.ConnectedPoints {
    constructor() {
        super(2);
    }

    getDistance(index) {
        if (index < this._connections.length && this._connectivity === 2) {
            var dist = Math.sqrt((this._connections[index][0] - this._connections[index][2]) *
                (this._connections[index][0] - this._connections[index][2]) +
                (this._connections[index][1] - this._connections[index][3]) *
                (this._connections[index][1] - this._connections[index][3]));
            return dist; // this is in pixels!
        }
    }
};

wpd.AngleMeasurement = class extends wpd.ConnectedPoints {
    constructor() {
        super(3);
    }

    getAngle(index) {
        if (index < this._connections.length && this._connectivity === 3) {

            var ang1 = wpd.taninverse(-(this._connections[index][5] - this._connections[index][3]),
                    this._connections[index][4] - this._connections[index][2]),
                ang2 = wpd.taninverse(-(this._connections[index][1] - this._connections[index][3]),
                    this._connections[index][0] - this._connections[index][2]),
                ang = ang1 - ang2;

            ang = 180.0 * ang / Math.PI;
            ang = ang < 0 ? ang + 360 : ang;
            return ang;
        }
    }
};

wpd.AreaMeasurement = class extends wpd.ConnectedPoints {
    constructor() {
        super(-1); // connectivity can vary here depending on number of points in the polygon
    }

    getArea(index) {
        // return pixel area of polygons
        if (index < this._connections.length) {
            if (this._connections[index].length >= 4) {
                let totalArea = 0.0;
                for (let pi = 0; pi < this._connections[index].length; pi += 2) {

                    let px1 = this._connections[index][pi];
                    let py1 = this._connections[index][pi + 1];

                    let px2 = 0.0;
                    let py2 = 0.0;
                    if (pi <= this._connections[index].length - 4) {
                        px2 = this._connections[index][pi + 2];
                        py2 = this._connections[index][pi + 3];
                    } else {
                        px2 = this._connections[index][0];
                        py2 = this._connections[index][1];
                    }
                    totalArea += (px1 * py2 - px2 * py1);
                }
                totalArea /= 2.0;
                return totalArea;
            }
        }
        return 0;
    }

    getPerimeter(index) {
        if (index < this._connections.length) {
            let totalDist = 0.0;
            let px_prev = 0.0;
            let py_prev = 0.0;
            for (let pi = 0; pi < this._connections[index].length; pi += 2) {
                let px = this._connections[index][pi];
                let py = this._connections[index][pi + 1];
                if (pi >= 2) {
                    totalDist += Math.sqrt((px - px_prev) * (px - px_prev) +
                        (py - py_prev) * (py - py_prev));
                }
                // include the connection between the last and first point in the set (only when >=
                // 2 sides in the polygon):
                if (pi == this._connections[index].length - 2 && pi >= 4) {
                    let px0 = this._connections[index][0];
                    let py0 = this._connections[index][1];
                    totalDist += Math.sqrt((px - px0) * (px - px0) + (py - py0) * (py - py0));
                }
                px_prev = px;
                py_prev = py;
            }
            return totalDist;
        }
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.plotDataProvider = (function() {
    let _ds = null;

    function setDataSource(ds) {
        _ds = ds;
    }

    function getData() {
        var axes = wpd.appData.getPlotData().getAxesForDataset(_ds);

        if (axes instanceof wpd.BarAxes) {
            return getBarAxesData(_ds, axes);
        } else {
            return getGeneralAxesData(_ds, axes);
        }
    }

    function getBarAxesData(dataSeries, axes) {
        var fields = [],
            fieldDateFormat = [],
            rawData = [],
            isFieldSortable = [],
            rowi, coli,
            dataPt, transformedDataPt, lab;

        for (rowi = 0; rowi < dataSeries.getCount(); rowi++) {

            dataPt = dataSeries.getPixel(rowi);
            transformedDataPt = axes.pixelToData(dataPt.x, dataPt.y);

            rawData[rowi] = [];

            // metaData[0] should be the label:
            if (dataPt.metadata == null) {
                lab = "Bar" + rowi;
            } else {
                lab = dataPt.metadata[0];
            }
            rawData[rowi][0] = lab;
            // transformed value
            rawData[rowi][1] = transformedDataPt[0];
            // other metadata if present can go here in the future.
        }

        fields = ['Label', 'Value'];
        isFieldSortable = [false, true];

        return {
            fields: fields,
            fieldDateFormat: fieldDateFormat,
            rawData: rawData,
            allowConnectivity: false,
            connectivityFieldIndices: [],
            isFieldSortable: isFieldSortable
        };
    }

    function getGeneralAxesData(dataSeries, axes) {
        // 2D XY, Polar, Ternary, Image, Map

        var fields = [],
            fieldDateFormat = [],
            connectivityFieldIndices = [],
            rawData = [],
            isFieldSortable = [],
            rowi, coli, pt, ptData, metadi,
            hasMetadata = dataSeries.hasMetadata(),
            metaKeys = dataSeries.getMetadataKeys(),
            metaKeyCount = hasMetadata === true ? metaKeys.length : 0,
            ptmetadata;

        for (rowi = 0; rowi < dataSeries.getCount(); rowi++) {

            pt = dataSeries.getPixel(rowi);
            ptData = axes.pixelToData(pt.x, pt.y);
            rawData[rowi] = [];

            // transformed coordinates
            for (coli = 0; coli < ptData.length; coli++) {
                rawData[rowi][coli] = ptData[coli];
            }

            // metadata
            for (metadi = 0; metadi < metaKeyCount; metadi++) {
                if (pt.metadata == null || pt.metadata[metadi] == null) {
                    ptmetadata = 0;
                } else {
                    ptmetadata = pt.metadata[metadi];
                }
                rawData[rowi][ptData.length + metadi] = ptmetadata;
            }
        }

        fields = axes.getAxesLabels();
        if (hasMetadata) {
            fields = fields.concat(metaKeys);
        }

        for (coli = 0; coli < fields.length; coli++) {
            if (coli < axes.getDimensions()) {
                connectivityFieldIndices[coli] = coli;
                if (axes.isDate != null && axes.isDate(coli)) {
                    fieldDateFormat[coli] = axes.getInitialDateFormat(coli);
                }
            }

            isFieldSortable[coli] = true; // all fields are sortable
        }

        return {
            fields: fields,
            fieldDateFormat: fieldDateFormat,
            rawData: rawData,
            allowConnectivity: true,
            connectivityFieldIndices: connectivityFieldIndices,
            isFieldSortable: isFieldSortable
        };
    }

    return {
        setDataSource: setDataSource,
        getData: getData
    };
})();

wpd.measurementDataProvider = (function() {
    let _ms = null;

    function setDataSource(ms) {
        _ms = ms;
    }

    function getData() {
        var fields = [],
            fieldDateFormat = [],
            rawData = [],
            isFieldSortable = [],
            plotData = wpd.appData.getPlotData(),
            axes = plotData.getAxesForMeasurement(_ms),
            isMap = axes != null && (axes instanceof wpd.MapAxes),
            conni;

        if (_ms instanceof wpd.DistanceMeasurement) {
            for (conni = 0; conni < _ms.connectionCount(); conni++) {
                rawData[conni] = [];
                rawData[conni][0] = 'Dist' + conni;
                if (isMap) {
                    rawData[conni][1] = axes.pixelToDataDistance(_ms.getDistance(conni));
                } else {
                    rawData[conni][1] = _ms.getDistance(conni);
                }
            }

            fields = ['Label', 'Distance'];
            isFieldSortable = [false, true];

        } else if (_ms instanceof wpd.AngleMeasurement) {

            for (conni = 0; conni < _ms.connectionCount(); conni++) {
                rawData[conni] = [];
                rawData[conni][0] = 'Theta' + conni;
                rawData[conni][1] = _ms.getAngle(conni);
            }

            fields = ['Label', 'Angle'];
            isFieldSortable = [false, true];

        } else if (_ms instanceof wpd.AreaMeasurement) {

            for (conni = 0; conni < _ms.connectionCount(); conni++) {
                rawData[conni] = [];
                rawData[conni][0] = 'Poly' + conni;
                if (isMap) {
                    rawData[conni][1] = axes.pixelToDataArea(_ms.getArea(conni));
                    rawData[conni][2] = axes.pixelToDataDistance(_ms.getPerimeter(conni));
                } else {
                    rawData[conni][1] = _ms.getArea(conni);
                    rawData[conni][2] = _ms.getPerimeter(conni);
                }
            }

            fields = ['Label', 'Area', 'Perimeter'];
            isFieldSortable = [false, true, true];
        }

        return {
            fields: fields,
            fieldDateFormat: fieldDateFormat,
            rawData: rawData,
            allowConnectivity: false,
            connectivityFieldIndices: [],
            isFieldSortable: isFieldSortable
        };
    }

    return {
        getData: getData,
        setDataSource: setDataSource
    };
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

// Data from a series
wpd.Dataset = class {
    constructor(dim) {
        this._dim = dim;
        this._dataPoints = [];
        this._connections = [];
        this._selections = [];
        this._hasMetadata = false;
        this._mkeys = [];

        // public:
        this.name = "Defaut Dataset";
        this.variableNames = ['x', 'y'];
    }

    hasMetadata() {
        return this._hasMetadata;
    }

    setMetadataKeys(metakeys) {
        this._mkeys = metakeys;
    }

    getMetadataKeys() {
        return this._mkeys;
    }

    addPixel(pxi, pyi, mdata) {
        let dlen = this._dataPoints.length;
        this._dataPoints[dlen] = {
            x: pxi,
            y: pyi,
            metadata: mdata
        };
        if (mdata != null) {
            this._hasMetadata = true;
        }
    }

    getPixel(index) {
        return this._dataPoints[index];
    }

    setPixelAt(index, pxi, pyi) {
        if (index < this._dataPoints.length) {
            this._dataPoints[index].x = pxi;
            this._dataPoints[index].y = pyi;
        }
    }

    setMetadataAt(index, mdata) {
        if (index < this._dataPoints.length) {
            this._dataPoints[index].metadata = mdata;
        }
    }

    insertPixel(index, pxi, pyi, mdata) {
        this._dataPoints.splice(index, 0, {
            x: pxi,
            y: pyi,
            metadata: mdata
        });
    }

    removePixelAtIndex(index) {
        if (index < this._dataPoints.length) {
            this._dataPoints.splice(index, 1);
        }
    }

    removeLastPixel() {
        let pIndex = this._dataPoints.length - 1;
        removePixelAtIndex(pIndex);
    }

    findNearestPixel(x, y, threshold) {
        threshold = (threshold == null) ? 50 : parseFloat(threshold);
        let minDist = 0,
            minIndex = -1;
        for (let i = 0; i < this._dataPoints.length; i++) {
            let dist = Math.sqrt((x - this._dataPoints[i].x) * (x - this._dataPoints[i].x) +
                (y - this._dataPoints[i].y) * (y - this._dataPoints[i].y));
            if ((minIndex < 0 && dist <= threshold) || (minIndex >= 0 && dist < minDist)) {
                minIndex = i;
                minDist = dist;
            }
        }
        return minIndex;
    }

    removeNearestPixel(x, y, threshold) {
        let minIndex = this.findNearestPixel(x, y, threshold);
        if (minIndex >= 0) {
            this.removePixelAtIndex(minIndex);
        }
    }

    clearAll() {
        this._dataPoints = [];
        this._hasMetadata = false;
        this._mkeys = [];
    }

    getCount() {
        return this._dataPoints.length;
    }

    selectPixel(index) {
        if (this._selections.indexOf(index) >= 0) {
            return;
        }
        this._selections.push(index);
    }

    unselectAll() {
        this._selections = [];
    }

    selectNearestPixel(x, y, threshold) {
        let minIndex = this.findNearestPixel(x, y, threshold);
        if (minIndex >= 0) {
            this.selectPixel(minIndex);
        }
        return minIndex;
    }

    selectNextPixel() {
        for (let i = 0; i < this._selections.length; i++) {
            this._selections[i] = (this._selections[i] + 1) % this._dataPoints.length;
        }
    }

    selectPreviousPixel() {
        for (let i = 0; i < this._selections.length; i++) {
            let newIndex = this._selections[i];
            if (newIndex === 0) {
                newIndex = this._dataPoints.length - 1;
            } else {
                newIndex = newIndex - 1;
            }
            this._selections[i] = newIndex;
        }
    }

    getSelectedPixels() {
        return this._selections;
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

/* Parse dates and convert back and forth to Julian days */
var wpd = wpd || {};

wpd.dateConverter = (function() {
    function parse(input) {
        if (input == null) {
            return null;
        }

        if (typeof input === "string") {
            if (input.indexOf('/') < 0 && input.indexOf(':') < 0) {
                return null;
            }
        }

        return toJD(input);
    }

    function toJD(dateString) {
        dateString = dateString.toString();
        var dateParts = dateString.split(/[/ :]/),
            hasDatePart = dateString.indexOf('/') >= 0,
            year,
            month, date, hour, min, sec, timeIdxOffset, today, tempDate, rtnValue;

        if (dateParts.length <= 0 || dateParts.length > 6) {
            return null;
        }

        if (hasDatePart) {
            year = parseInt(dateParts[0], 10);
            month = parseInt(dateParts[1] === undefined ? 0 : dateParts[1], 10);
            date = parseInt(dateParts[2] === undefined ? 1 : dateParts[2], 10);
            timeIdxOffset = 3;
        } else {
            today = new Date();
            year = today.getFullYear();
            month = today.getMonth() + 1;
            date = today.getDate();
            timeIdxOffset = 0;
        }
        hour = parseInt(dateParts[timeIdxOffset] === undefined ? 0 : dateParts[timeIdxOffset], 10);
        min = parseInt(
            dateParts[timeIdxOffset + 1] === undefined ? 0 : dateParts[timeIdxOffset + 1], 10);
        sec = parseInt(
            dateParts[timeIdxOffset + 2] === undefined ? 0 : dateParts[timeIdxOffset + 2], 10);

        if (isNaN(year) || isNaN(month) || isNaN(date) || isNaN(hour) || isNaN(min) || isNaN(sec)) {
            return null;
        }

        if (month > 12 || month < 1) {
            return null;
        }

        if (date > 31 || date < 1) {
            return null;
        }

        if (hour > 23 || hour < 0) {
            return null;
        }

        if (min > 59 || min < 0) {
            return null;
        }

        if (sec > 59 || sec < 0) {
            return null;
        }

        // Temporary till I figure out julian dates:
        tempDate = new Date();
        tempDate.setUTCFullYear(year);
        tempDate.setUTCMonth(month - 1);
        tempDate.setUTCDate(date);
        tempDate.setUTCHours(hour, min, sec);
        rtnValue = parseFloat(Date.parse(tempDate));
        if (!isNaN(rtnValue)) {
            return rtnValue;
        }
        return null;
    }

    function formatDateNumber(dateNumber, formatString) {
        // round to smallest time unit
        var coeff = 1;

        if (formatString.indexOf('s') >= 0)
            coeff = 1000;
        else if (formatString.indexOf('i') >= 0)
            coeff = 1000 * 60;
        else if (formatString.indexOf('h') >= 0)
            coeff = 1000 * 60 * 60;
        else if (formatString.indexOf('d') >= 0)
            coeff = 1000 * 60 * 60 * 24;
        else if (formatString.indexOf('m') >= 0)
            coeff = 1000 * 60 * 60 * 24 * 365.2425 / 12;
        else if (formatString.indexOf('y') >= 0)
            coeff = 1000 * 60 * 60 * 24 * 365.2425;

        return formatDate(new Date(Math.round(new Date(dateNumber).getTime() / coeff) * coeff),
            formatString);
    }

    function formatDate(dateObject, formatString) {

        var longMonths = [],
            shortMonths = [],
            tmpDate = new Date();

        for (var i = 0; i < 12; i++) {
            tmpDate.setUTCMonth(i);
            longMonths.push(tmpDate.toLocaleString(undefined, {
                month: "long"
            }));
            shortMonths.push(tmpDate.toLocaleString(undefined, {
                month: "short"
            }));
        }

        var outputString = formatString;

        outputString = outputString.replace("YYYY", "yyyy");
        outputString = outputString.replace("YY", "yy");
        outputString = outputString.replace("MMMM", "mmmm");
        outputString = outputString.replace("MMM", "mmm");
        outputString = outputString.replace("MM", "mm");
        outputString = outputString.replace("DD", "dd");
        outputString = outputString.replace("HH", "hh");
        outputString = outputString.replace("II", "ii");
        outputString = outputString.replace("SS", "ss");

        outputString = outputString.replace("yyyy", dateObject.getUTCFullYear());

        var twoDigitYear = dateObject.getUTCFullYear() % 100;
        twoDigitYear = twoDigitYear < 10 ? '0' + twoDigitYear : twoDigitYear;

        outputString = outputString.replace("yy", twoDigitYear);

        outputString = outputString.replace("mmmm", longMonths[dateObject.getUTCMonth()]);
        outputString = outputString.replace("mmm", shortMonths[dateObject.getUTCMonth()]);
        outputString = outputString.replace("mm", ("0" + (dateObject.getUTCMonth() + 1)).slice(-2));
        outputString = outputString.replace("dd", ("0" + dateObject.getUTCDate()).slice(-2));

        outputString = outputString.replace("hh", ("0" + dateObject.getUTCHours()).slice(-2));
        outputString = outputString.replace("ii", ("0" + dateObject.getUTCMinutes()).slice(-2));
        outputString = outputString.replace("ss", ("0" + dateObject.getUTCSeconds()).slice(-2));

        return outputString;
    }

    function getFormatString(dateString) {
        var dateParts = dateString.split(/[/ :]/),
            hasDatePart = dateString.indexOf('/') >= 0,
            formatString = 'yyyy/mm/dd hh:ii:ss';

        if (dateParts.length >= 1) {
            formatString = hasDatePart ? 'yyyy' : 'hh';
        }

        if (dateParts.length >= 2) {
            formatString += hasDatePart ? '/mm' : ':ii';
        }

        if (dateParts.length >= 3) {
            formatString += hasDatePart ? '/dd' : ':ss';
        }

        if (dateParts.length >= 4) {
            formatString += ' hh';
        }

        if (dateParts.length >= 5) {
            formatString += ':ii';
        }

        if (dateParts.length === 6) {
            formatString += ':ss';
        }

        return formatString;
    }

    return {
        parse: parse,
        getFormatString: getFormatString,
        formatDateNumber: formatDateNumber
    };
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.gridDetectionCore = (function() {
    var hasHorizontal, hasVertical, xFrac = 0.1,
        yFrac = 0.1;

    function run(autoDetector) {
        var gridData = new Set(),
            xi, yi, xmin = autoDetector.gridMask.xmin,
            xmax = autoDetector.gridMask.xmax,
            ymin = autoDetector.gridMask.ymin,
            ymax = autoDetector.gridMask.ymax,
            dw = autoDetector.imageWidth,
            dh = autoDetector.imageHeight,
            linePixCount;

        if (hasVertical) {

            for (xi = xmin; xi <= xmax; xi++) {
                linePixCount = 0;
                for (yi = ymin; yi < ymax; yi++) {
                    if (autoDetector.binaryData.has(yi * dw + xi)) {
                        linePixCount++;
                    }
                }
                if (linePixCount > yFrac * (ymax - ymin)) {
                    for (yi = ymin; yi < ymax; yi++) {
                        gridData.add(yi * dw + xi);
                    }
                }
            }
        }

        if (hasHorizontal) {

            for (yi = ymin; yi <= ymax; yi++) {
                linePixCount = 0;
                for (xi = xmin; xi <= xmax; xi++) {
                    if (autoDetector.binaryData.has(yi * dw + xi)) {
                        linePixCount++;
                    }
                }
                if (linePixCount > xFrac * (xmax - xmin)) {
                    for (xi = xmin; xi <= xmax; xi++) {
                        gridData.add(yi * dw + xi);
                    }
                }
            }
        }

        return gridData;
    }

    function setHorizontalParameters(has_horizontal, y_perc) {
        hasHorizontal = has_horizontal;
        yFrac = Math.abs(parseFloat(y_perc) / 100.0);
    }

    function setVerticalParameters(has_vertical, x_perc) {
        hasVertical = has_vertical;
        xFrac = Math.abs(parseFloat(x_perc) / 100.0);
    }

    return {
        run: run,
        setHorizontalParameters: setHorizontalParameters,
        setVerticalParameters: setVerticalParameters
    };
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

/* Parse user provided expressions, dates etc. */
var wpd = wpd || {};

wpd.InputParser = class {
    constructor() {
        // public:
        this.isValid = false;
        this.isDate = false;
        this.formatting = null;
    }

    parse(input) {
        this.isValid = false;
        this.isDate = false;
        this.formatting = null;

        if (input == null) {
            return null;
        }

        if (typeof input === "string") {
            input = input.trim();

            if (input.indexOf('^') >= 0) {
                return null;
            }
        }

        let parsedDate = wpd.dateConverter.parse(input);
        if (parsedDate != null) {
            this.isValid = true;
            this.isDate = true;
            this.formatting = wpd.dateConverter.getFormatString(input);
            return parsedDate;
        }

        let parsedFloat = parseFloat(input);
        if (!isNaN(parsedFloat)) {
            this.isValid = true;
            return parsedFloat;
        }

        return null;
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

/**
 * Calculate inverse tan with range between 0, 2*pi.
 */
var wpd = wpd || {};

wpd.taninverse = function(y, x) {
    var inv_ans;
    if (y > 0) // I & II
        inv_ans = Math.atan2(y, x);
    else if (y <= 0) // III & IV
        inv_ans = Math.atan2(y, x) + 2 * Math.PI;

    if (inv_ans >= 2 * Math.PI)
        inv_ans = 0.0;
    return inv_ans;
};

wpd.sqDist2d = function(x1, y1, x2, y2) {
    return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
};

wpd.sqDist3d = function(
    x1, y1, z1, x2, y2,
    z2) {
    return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2);
};

wpd.dist2d = function(x1, y1, x2, y2) {
    return Math.sqrt(wpd.sqDist2d(x1, y1, x2, y2));
};

wpd.dist3d = function(x1, y1, z1, x2, y2,
    z2) {
    return Math.sqrt(wpd.sqDist3d(x1, y1, z1, x2, y2, z2));
};

wpd.mat = (function() {
    function det2x2(m) {
        return m[0] * m[3] - m[1] * m[2];
    }

    function inv2x2(m) {
        var det = det2x2(m);
        return [m[3] / det, -m[1] / det, -m[2] / det, m[0] / det];
    }

    function mult2x2(m1, m2) {
        return [
            m1[0] * m2[0] + m1[1] * m2[2], m1[0] * m2[1] + m1[1] * m2[3],
            m1[2] * m2[0] + m1[3] * m2[2], m1[2] * m2[1] + m1[3] * m2[3]
        ];
    }

    function mult2x2Vec(m, v) {
        return [m[0] * v[0] + m[1] * v[1], m[2] * v[0] + m[3] * v[1]];
    }

    function multVec2x2(v, m) {
        return [m[0] * v[0] + m[2] * v[1], m[1] * v[0] + m[3] * v[1]];
    }

    return {
        det2x2: det2x2,
        inv2x2: inv2x2,
        mult2x2: mult2x2,
        mult2x2Vec: mult2x2Vec,
        multVec2x2: multVec2x2
    };
})();

wpd.cspline =
    function(x, y) {
        var len = x.length,
            cs = {
                x: x,
                y: y,
                len: len,
                d: []
            },
            l = [],
            b = [],
            i;

        /* TODO: when len = 1, return the same value. For len = 2, do a linear interpolation */
        if (len < 3) {
            return null;
        }

        b[0] = 2.0;
        l[0] = 3.0 * (y[1] - y[0]);
        for (i = 1; i < len - 1; ++i) {
            b[i] = 4.0 - 1.0 / b[i - 1];
            l[i] = 3.0 * (y[i + 1] - y[i - 1]) - l[i - 1] / b[i - 1];
        }

        b[len - 1] = 2.0 - 1.0 / b[len - 2];
        l[len - 1] = 3.0 * (y[len - 1] - y[len - 2]) - l[len - 2] / b[len - 1];

        i = len - 1;
        cs.d[i] = l[i] / b[i];
        while (i > 0) {
            --i;
            cs.d[i] = (l[i] - cs.d[i + 1]) / b[i];
        }

        return cs;
    }

wpd.cspline_interp =
    function(cs, x) {
        var i = 0,
            t, a, b, c, d;
        if (x >= cs.x[cs.len - 1] || x < cs.x[0]) {
            return null;
        }

        /* linear search to find the index */
        while (x > cs.x[i]) {
            i++;
        }

        i = (i > 0) ? i - 1 : 0;
        t = (x - cs.x[i]) / (cs.x[i + 1] - cs.x[i]);
        a = cs.y[i];
        b = cs.d[i];
        c = 3.0 * (cs.y[i + 1] - cs.y[i]) - 2.0 * cs.d[i] - cs.d[i + 1];
        d = 2.0 * (cs.y[i] - cs.y[i + 1]) + cs.d[i] + cs.d[i + 1];
        return a + b * t + c * t * t + d * t * t * t;
    }


// Homography matrix for perspective transformations based on pixel coordinates of corner points.
wpd.calculateHomographyMatrix = function(orignalCorners, finalCorners) {
    let sourcePtr = wpd.wasmHelper.arrayToPtr(originalCorners);
    let targetPtr = wpd.wasmHelper.arrayToPtr(finalCorners);
    let homographyPtr = Module._newDoubleArray(9);
    Module._computeHomography(sourcePtr, targetPtr, homographyPtr);
    let H = wpd.wasmHelper.ptrToArray(homographyPtr);
    wpd.wasmHelper.freePtr(sourcePtr);
    wpd.wasmHelper.freePtr(targetPtr);
    wpd.wasmHelper.freePtr(homographyPtr);
    return H; // flattened homography matrix
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

// Plot information

wpd.PlotData = class {
    constructor() {
        this._topColors = null;
        this._axesColl = [];
        this._datasetColl = [];
        this._measurementColl = [];
        this._objectAxesMap = new Map();
        this._datasetAutoDetectionDataMap = new Map();
        this._gridDetectionData = null;
    }

    reset() {
        this._axesColl = [];
        this._datasetColl = [];
        this._measurementColl = [];
        this._objectAxesMap = new Map();
        this._datasetAutoDetectionDataMap = new Map();
        this._gridDetectionData = null;
    }

    setTopColors(topColors) {
        this._topColors = topColors;
    }

    getTopColors(topColors) {
        return this._topColors;
    }

    addAxes(ax) {
        this._axesColl.push(ax);
        if (this._axesColl.length === 1 && this._datasetColl.length === 0) {
            let ds = new wpd.Dataset();
            ds.name = "Default Dataset";
            this.addDataset(ds);
        }
    }

    getAxesColl() {
        return this._axesColl;
    }

    getAxesNames() {
        let names = [];
        this._axesColl.forEach((ax) => {
            names.push(ax.name);
        });
        return names;
    }

    deleteAxes(ax) {
        let axIdx = this._axesColl.indexOf(ax);
        if (axIdx >= 0) {
            this._axesColl.splice(axIdx, 1);

            // take care of dependents
            this._objectAxesMap.forEach((val, key, map) => {
                if (val === ax) {
                    map.set(key, null);
                }
            });
        }
    }

    getAxesCount() {
        return this._axesColl.length;
    }

    addDataset(ds) {
        this._datasetColl.push(ds);
        // by default bind ds to last axes
        const axCount = this._axesColl.length;
        if (axCount > 0) {
            let axes = this._axesColl[axCount - 1];
            this.setAxesForDataset(ds, axes);
        }
    }

    getDatasets() {
        return this._datasetColl;
    }

    getDatasetNames() {
        let names = [];
        this._datasetColl.forEach((ds) => {
            names.push(ds.name);
        });
        return names;
    }

    getDatasetCount() {
        return this._datasetColl.length;
    }

    addMeasurement(ms) {
        this._measurementColl.push(ms);

        // if this is a distance measurement, then attach to fist existing image or map axes:
        if (ms instanceof wpd.DistanceMeasurement && this._axesColl.length > 0) {
            for (let aIdx = 0; aIdx < this._axesColl.length; aIdx++) {
                if (this._axesColl[aIdx] instanceof wpd.MapAxes || this._axesColl[aIdx] instanceof wpd.ImageAxes) {
                    this.setAxesForMeasurement(ms, this._axesColl[aIdx]);
                    break;
                }
            }
        }
    }

    getMeasurementsByType(mtype) {
        let mcoll = [];
        this._measurementColl.forEach(m => {
            if (m instanceof mtype) {
                mcoll.push(m);
            }
        });
        return mcoll;
    }

    deleteMeasurement(ms) {
        var msIdx = this._measurementColl.indexOf(ms);
        if (msIdx >= 0) {
            this._measurementColl.splice(msIdx, 1);
            this._objectAxesMap.delete(ms);
        }
    }

    setAxesForDataset(ds, ax) {
        this._objectAxesMap.set(ds, ax);
    }

    setAxesForMeasurement(ms, ax) {
        this._objectAxesMap.set(ms, ax);
    }

    setAutoDetectionDataForDataset(ds, autoDetectionData) {
        this._datasetAutoDetectionDataMap.set(ds, autoDetectionData);
    }

    getAxesForDataset(ds) {
        return this._objectAxesMap.get(ds);
    }

    getAxesForMeasurement(ms) {
        return this._objectAxesMap.get(ms);
    }

    getAutoDetectionDataForDataset(ds) {
        let ad = this._datasetAutoDetectionDataMap.get(ds);
        if (ad == null) { // create one if no autodetection data is present!
            ad = new wpd.AutoDetectionData();
            this.setAutoDetectionDataForDataset(ds, ad);
        }
        return ad;
    }

    getGridDetectionData() {
        if (this._gridDetectionData == null) {
            this._gridDetectionData = new wpd.GridDetectionData();
        }
        return this._gridDetectionData;
    }

    deleteDataset(ds) {
        var dsIdx = this._datasetColl.indexOf(ds);
        if (dsIdx >= 0) {
            this._datasetColl.splice(dsIdx, 1);
            this._objectAxesMap.delete(ds);
            this._datasetAutoDetectionDataMap.delete(ds);
        }
    }

    _deserializePreVersion4(data) {
        // read axes info
        if (data.axesType == null) {
            return true;
        }
        if (data.axesType !== "ImageAxes" &&
            (data.calibration == null || data.axesParameters == null)) {
            return false;
        }

        // get calibration points
        let calibration = null;
        if (data.axesType !== "ImageAxes") {
            if (data.axesType === "TernaryAxes") {
                calibration = new wpd.Calibration(3);
            } else {
                calibration = new wpd.Calibration(2);
            }
            for (let calIdx = 0; calIdx < data.calibration.length; calIdx++) {
                calibration.addPoint(data.calibration[calIdx].px, data.calibration[calIdx].py,
                    data.calibration[calIdx].dx, data.calibration[calIdx].dy,
                    data.calibration[calIdx].dz);
            }
        }

        let axes = null;
        if (data.axesType === "XYAxes") {
            axes = new wpd.XYAxes();
            calibration.labels = ['X1', 'X2', 'Y1', 'Y2'];
            calibration.labelPositions = ['N', 'N', 'E', 'E'];
            calibration.maxPointCount = 4;
            axes.calibrate(calibration, data.axesParameters.isLogX, data.axesParameters.isLogY);
        } else if (data.axesType === "BarAxes") {
            axes = new wpd.BarAxes();
            calibration.labels = ['P1', 'P2'];
            calibration.labelPositions = ['S', 'S'];
            calibration.maxPointCount = 2;
            axes.calibrate(calibration, data.axesParameters.isLog);
        } else if (data.axesType === "PolarAxes") {
            axes = new wpd.PolarAxes();
            calibration.labels = ['Origin', 'P1', 'P2'];
            calibration.labelPositions = ['E', 'S', 'S'];
            calibration.maxPointCount = 3;
            axes.calibrate(calibration, data.axesParameters.isDegrees,
                data.axesParameters.isClockwise);
        } else if (data.axesType === "TernaryAxes") {
            axes = new wpd.TernaryAxes();
            calibration.labels = ['A', 'B', 'C'];
            calibration.labelPositions = ['S', 'S', 'E'];
            calibration.maxPointCount = 3;
            axes.calibrate(calibration, data.axesParameters.isRange100,
                data.axesParameters.isNormalOrientation);
        } else if (data.axesType === "MapAxes") {
            axes = new wpd.MapAxes();
            calibration.labels = ['P1', 'P2'];
            calibration.labelPositions = ['S', 'S'];
            calibration.maxPointCount = 2;
            axes.calibrate(calibration, data.axesParameters.scaleLength,
                data.axesParameters.unitString);
        } else if (data.axesType === "ImageAxes") {
            axes = new wpd.ImageAxes();
        }

        if (axes != null) {
            this._axesColl.push(axes);
        }

        // datasets
        if (data.dataSeries != null) {
            for (let dsIdx = 0; dsIdx < data.dataSeries.length; dsIdx++) {
                const dsData = data.dataSeries[dsIdx];
                let ds = new wpd.Dataset();
                ds.name = dsData.name;
                if (dsData.metadataKeys != null) {
                    ds.setMetadataKeys(dsData.metadataKeys);
                }
                for (let pxIdx = 0; pxIdx < dsData.data.length; pxIdx++) {
                    ds.addPixel(dsData.data[pxIdx].x, dsData.data[pxIdx].y,
                        dsData.data[pxIdx].metadata);
                }
                this.addDataset(ds);
                this.setAxesForDataset(ds, axes);
            }
        }

        // measurements

        // distances
        if (data.distanceMeasurementData != null) {
            let dist = new wpd.DistanceMeasurement();
            for (let cIdx = 0; cIdx < data.distanceMeasurementData.length; cIdx++) {
                dist.addConnection(data.distanceMeasurementData[cIdx]);
            }
            this.addMeasurement(dist);
            if (axes instanceof wpd.MapAxes) {
                this.setAxesForMeasurement(dist, axes);
            }
        }

        // angles
        if (data.angleMeasurementData != null) {
            let ang = new wpd.AngleMeasurement();
            for (let cIdx = 0; cIdx < data.angleMeasurementData.length; cIdx++) {
                ang.addConnection(data.angleMeasurementData[cIdx]);
            }
            this.addMeasurement(ang);
        }

        return true;
    }

    _deserializeVersion4(data) {
        // axes data
        if (data.axesColl != null) {
            for (let axIdx = 0; axIdx < data.axesColl.length; axIdx++) {
                const axData = data.axesColl[axIdx];

                // get calibration
                let calibration = null;
                if (axData.type !== "ImageAxes") {
                    if (axData.type === "TernaryAxes") {
                        calibration = new wpd.Calibration(3);
                    } else {
                        calibration = new wpd.Calibration(2);
                    }
                    for (let calIdx = 0; calIdx < axData.calibrationPoints.length; calIdx++) {
                        calibration.addPoint(axData.calibrationPoints[calIdx].px,
                            axData.calibrationPoints[calIdx].py,
                            axData.calibrationPoints[calIdx].dx,
                            axData.calibrationPoints[calIdx].dy,
                            axData.calibrationPoints[calIdx].dz);
                    }
                }

                // create axes
                let axes = null;
                if (axData.type === "XYAxes") {
                    axes = new wpd.XYAxes();
                    calibration.labels = ['X1', 'X2', 'Y1', 'Y2'];
                    calibration.labelPositions = ['N', 'N', 'E', 'E'];
                    calibration.maxPointCount = 4;
                    axes.calibrate(calibration, axData.isLogX, axData.isLogY);
                } else if (axData.type === "BarAxes") {
                    axes = new wpd.BarAxes();
                    calibration.labels = ['P1', 'P2'];
                    calibration.labelPositions = ['S', 'S'];
                    calibration.maxPointCount = 2;
                    axes.calibrate(calibration, axData.isLog,
                        axData.isRotated == null ? false : axData.isRotated);
                } else if (axData.type === "PolarAxes") {
                    axes = new wpd.PolarAxes();
                    calibration.labels = ['Origin', 'P1', 'P2'];
                    calibration.labelPositions = ['E', 'S', 'S'];
                    calibration.maxPointCount = 3;
                    axes.calibrate(calibration, axData.isDegrees, axData.isClockwise, axData.isLog);
                } else if (axData.type === "TernaryAxes") {
                    axes = new wpd.TernaryAxes();
                    calibration.labels = ['A', 'B', 'C'];
                    calibration.labelPositions = ['S', 'S', 'E'];
                    calibration.maxPointCount = 3;
                    axes.calibrate(calibration, axData.isRange100, axData.isNormalOrientation);
                } else if (axData.type === "MapAxes") {
                    axes = new wpd.MapAxes();
                    calibration.labels = ['P1', 'P2'];
                    calibration.labelPositions = ['S', 'S'];
                    calibration.maxPointCount = 2;
                    axes.calibrate(calibration, axData.scaleLength, axData.unitString);
                } else if (axData.type === "ImageAxes") {
                    axes = new wpd.ImageAxes();
                }

                if (axes != null) {
                    axes.name = axData.name;
                    this._axesColl.push(axes);
                }
            }
        }

        // datasets
        if (data.datasetColl != null) {
            for (let dsIdx = 0; dsIdx < data.datasetColl.length; dsIdx++) {
                const dsData = data.datasetColl[dsIdx];
                let ds = new wpd.Dataset();
                ds.name = dsData.name;
                if (dsData.metadataKeys != null) {
                    ds.setMetadataKeys(dsData.metadataKeys);
                }
                for (let pxIdx = 0; pxIdx < dsData.data.length; pxIdx++) {
                    ds.addPixel(dsData.data[pxIdx].x, dsData.data[pxIdx].y,
                        dsData.data[pxIdx].metadata);
                }
                this._datasetColl.push(ds);

                // set axes for this dataset
                const axIdx = this.getAxesNames().indexOf(dsData.axesName);
                if (axIdx >= 0) {
                    this.setAxesForDataset(ds, this._axesColl[axIdx]);
                }

                // autodetector
                if (dsData.autoDetectionData != null) {
                    let autoDetectionData = new wpd.AutoDetectionData();
                    autoDetectionData.deserialize(dsData.autoDetectionData);
                    this.setAutoDetectionDataForDataset(ds, autoDetectionData);
                }
            }
        }

        // measurements
        if (data.measurementColl != null) {
            for (let msIdx = 0; msIdx < data.measurementColl.length; msIdx++) {
                const msData = data.measurementColl[msIdx];
                let ms = null;
                if (msData.type === "Distance") {
                    ms = new wpd.DistanceMeasurement();
                    this._measurementColl.push(ms);
                    // set axes
                    const axIdx = this.getAxesNames().indexOf(msData.axesName);
                    if (axIdx >= 0) {
                        this.setAxesForMeasurement(ms, this._axesColl[axIdx]);
                    }
                } else if (msData.type === "Angle") {
                    ms = new wpd.AngleMeasurement();
                    this._measurementColl.push(ms);
                } else if (msData.type === "Area") {
                    ms = new wpd.AreaMeasurement();
                    this._measurementColl.push(ms);
                    // set axes
                    const axIdx = this.getAxesNames().indexOf(msData.axesName);
                    if (axIdx >= 0) {
                        this.setAxesForMeasurement(ms, this._axesColl[axIdx]);
                    }
                }
                // add connections
                if (ms != null) {
                    for (let cIdx = 0; cIdx < msData.data.length; cIdx++) {
                        ms.addConnection(msData.data[cIdx]);
                    }
                }
            }
        }

        return true;
    }

    deserialize(data) {
        this.reset();
        try {
            if (data.wpd != null && data.wpd.version[0] === 3) {
                return this._deserializePreVersion4(data.wpd);
            }
            if (data.version != null && data.version[0] === 4) {
                return this._deserializeVersion4(data);
            }
            return true;
        } catch (e) {
            console.log(e);
            return false;
        }
    }

    serialize() {
        let data = {};
        data.version = [4, 2];
        data.axesColl = [];
        data.datasetColl = [];
        data.measurementColl = [];

        // axes data
        for (let axIdx = 0; axIdx < this._axesColl.length; axIdx++) {
            const axes = this._axesColl[axIdx];
            let axData = {};
            axData.name = axes.name;
            if (axes instanceof wpd.XYAxes) {
                axData.type = "XYAxes";
                axData.isLogX = axes.isLogX();
                axData.isLogY = axes.isLogY();
            } else if (axes instanceof wpd.BarAxes) {
                axData.type = "BarAxes";
                axData.isLog = axes.isLog();
                axData.isRotated = axes.isRotated();
            } else if (axes instanceof wpd.PolarAxes) {
                axData.type = "PolarAxes";
                axData.isDegrees = axes.isThetaDegrees();
                axData.isClockwise = axes.isThetaClockwise();
                axData.isLog = axes.isRadialLog();
            } else if (axes instanceof wpd.TernaryAxes) {
                axData.type = "TernaryAxes";
                axData.isRange100 = axes.isRange100();
                axData.isNormalOrientation = axes.isNormalOrientation;
            } else if (axes instanceof wpd.MapAxes) {
                axData.type = "MapAxes";
                axData.scaleLength = axes.getScaleLength();
                axData.unitString = axes.getUnits();
            } else if (axes instanceof wpd.ImageAxes) {
                axData.type = "ImageAxes";
            }

            // calibration points
            if (!(axes instanceof wpd.ImageAxes)) {
                axData.calibrationPoints = [];
                for (let calIdx = 0; calIdx < axes.calibration.getCount(); calIdx++) {
                    axData.calibrationPoints.push(axes.calibration.getPoint(calIdx));
                }
            }

            data.axesColl.push(axData);
        }

        // datasets
        for (let dsIdx = 0; dsIdx < this._datasetColl.length; dsIdx++) {
            const ds = this._datasetColl[dsIdx];
            const axes = this.getAxesForDataset(ds);
            const autoDetectionData = this.getAutoDetectionDataForDataset(ds);
            let dsData = {};
            dsData.name = ds.name;
            dsData.axesName = axes != null ? axes.name : "";
            dsData.metadataKeys = ds.getMetadataKeys();
            dsData.data = [];
            for (let pxIdx = 0; pxIdx < ds.getCount(); pxIdx++) {
                let px = ds.getPixel(pxIdx);
                dsData.data[pxIdx] = px;
                if (axes != null) {
                    dsData.data[pxIdx].value = axes.pixelToData(px.x, px.y);
                }
            }
            dsData.autoDetectionData =
                autoDetectionData != null ? autoDetectionData.serialize() : null;
            data.datasetColl.push(dsData);
        }

        // measurements
        for (let msIdx = 0; msIdx < this._measurementColl.length; msIdx++) {
            const ms = this._measurementColl[msIdx];
            const axes = this.getAxesForMeasurement(ms);
            let msData = {};
            if (ms instanceof wpd.DistanceMeasurement) {
                msData.type = "Distance";
                msData.name = "Distance";
                msData.axesName = axes != null ? axes.name : "";
            } else if (ms instanceof wpd.AngleMeasurement) {
                msData.type = "Angle";
                msData.name = "Angle";
            } else if (ms instanceof wpd.AreaMeasurement) {
                msData.type = "Area";
                msData.name = "Area";
                msData.axesName = axes != null ? axes.name : "";
            }
            msData.data = [];
            for (let cIdx = 0; cIdx < ms.connectionCount(); cIdx++) {
                msData.data.push(ms.getConnectionAt(cIdx));
            }
            data.measurementColl.push(msData);
        }
        return data;
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

// Run-length encoder/decoder (Mainly used for masks)
wpd.rle = {};

// wpd.rle.encode - Encode a sorted array of integers
wpd.rle.encode = function(sortedArray) {
    // return an array as [[pos, count], [pos, count], ... ]
    let ret = [];
    let prevVal = null;
    let item = [0, 0];
    for (let val of sortedArray) {
        if (prevVal == null) { // first item
            item = [val, 1];
        } else if (val == prevVal + 1) { // continued item
            item[1]++;
        } else { // item ended
            ret.push(item);
            item = [val, 1];
        }
        prevVal = val;
    }
    // add last item
    if (item[1] != 0) {
        ret.push(item);
    }

    return ret;
};

// wpd.rle.decode - Decode RLE array with data as [[pos, count], [pos, count], ... ] etc.
wpd.rle.decode = function(rleArray) {
    let ret = [];
    for (let item of rleArray) {
        let val = item[0];
        let count = item[1];
        for (let i = 0; i < count; ++i) {
            ret.push(val + i);
        }
    }
    return ret;
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

onWASMLoad = function() {};

wpd.wasmHelper = {
    arrayToPtr: function(array) {
        let ptr = Module._newDoubleArray(array.length);
        Module.HEAPF64.set(new Float64Array(array), ptr / Float64Array.BYTES_PER_ELEMENT);
        return ptr;
    },
    ptrToArray: function(ptr, length) {
        let array = new Float64Array(length);
        array.set(Module.HEAPF64.subarray(ptr / Float64Array.BYTES_PER_ELEMENT, ptr / Float64Array.BYTES_PER_ELEMENT + length));
        return array;
    },
    freePtr: function(ptr) {
        Module._freeArray(ptr);
    },
    printVersion: function() {
        Module._printVersion();
    }
};/*
WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.AveragingWindowCore = class {

    constructor(binaryData, imageHeight, imageWidth, dx, dy, dataSeries) {
        this._binaryData = binaryData;
        this._imageHeight = imageHeight;
        this._imageWidth = imageWidth;
        this._dx = dx;
        this._dy = dy;
        this._dataSeries = dataSeries;
    }

    run() {
        var xPoints = [],
            xPointsPicked = 0,
            pointsPicked = 0,
            dw = this._imageWidth,
            dh = this._imageHeight,
            blobAvg = [],
            coli, rowi, firstbloby, bi, blobs, blbi, xi, yi,
            pi, inRange, xxi, oldX, oldY, avgX, avgY, newX, newY, matches, xStep = this._dx,
            yStep = this._dy;

        this._dataSeries.clearAll();

        for (coli = 0; coli < dw; coli++) {

            blobs = -1;
            firstbloby = -2.0 * yStep;
            bi = 0;

            // Scan vertically for blobs:

            for (rowi = 0; rowi < dh; rowi++) {
                if (this._binaryData.has(rowi * dw + coli)) {
                    if (rowi > firstbloby + yStep) {
                        blobs = blobs + 1;
                        bi = 1;
                        blobAvg[blobs] = rowi;
                        firstbloby = rowi;
                    } else {
                        bi = bi + 1;
                        blobAvg[blobs] =
                            parseFloat((blobAvg[blobs] * (bi - 1.0) + rowi) / parseFloat(bi));
                    }
                }
            }

            if (blobs >= 0) {
                xi = coli + 0.5;
                for (blbi = 0; blbi <= blobs; blbi++) {
                    yi = blobAvg[blbi] + 0.5; // add 0.5 to shift to the middle of the pixels
                    // instead of the starting edge.

                    xPoints[xPointsPicked] = [];
                    xPoints[xPointsPicked][0] = parseFloat(xi);
                    xPoints[xPointsPicked][1] = parseFloat(yi);
                    xPoints[xPointsPicked][2] =
                        true; // true if not filtered, false if processed already
                    xPointsPicked = xPointsPicked + 1;
                }
            }
        }

        if (xPointsPicked === 0) {
            return;
        }

        for (pi = 0; pi < xPointsPicked; pi++) {
            if (xPoints[pi][2] === true) { // if still available
                inRange = true;
                xxi = pi + 1;

                oldX = xPoints[pi][0];
                oldY = xPoints[pi][1];

                avgX = oldX;
                avgY = oldY;

                matches = 1;

                while ((inRange === true) && (xxi < xPointsPicked)) {
                    newX = xPoints[xxi][0];
                    newY = xPoints[xxi][1];

                    if ((Math.abs(newX - oldX) <= xStep) && (Math.abs(newY - oldY) <= yStep) &&
                        (xPoints[xxi][2] === true)) {
                        avgX = (avgX * matches + newX) / (matches + 1.0);
                        avgY = (avgY * matches + newY) / (matches + 1.0);
                        matches = matches + 1;
                        xPoints[xxi][2] = false;
                    }

                    if (newX > oldX + 2 * xStep) {
                        inRange = false;
                    }

                    xxi = xxi + 1;
                }

                xPoints[pi][2] = false;

                pointsPicked = pointsPicked + 1;
                this._dataSeries.addPixel(parseFloat(avgX), parseFloat(avgY));
            }
        }
        xPoints = [];
        return this._dataSeries;
    }
};/*
WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.AveragingWindowAlgo = class {

    constructor() {
        this._xStep = 10;
        this._yStep = 10;
        this._wasRun = false;
    }

    getParamList(axes) {
        return [
            ['ΔX', 'Px', this._xStep],
            ['ΔY', 'Px', this._yStep]
        ];
    }

    setParam(index, val) {
        if (index === 0) {
            this._xStep = val;
        } else if (index === 1) {
            this._yStep = val;
        }
    }

    getParam(index) {
        return index === 0 ? this._xStep : this._yStep;
    }

    serialize() {
        return this._wasRun ? {
                algoType: "AveragingWindowAlgo",
                xStep: this._xStep,
                yStep: this._yStep
            } :
            null;
    }

    deserialize(obj) {
        this._xStep = obj.xStep;
        this._yStep = obj.yStep;
        this._wasRun = true;
    }

    run(autoDetector, dataSeries, axes) {
        this._wasRun = true;
        let algoCore = new wpd.AveragingWindowCore(
            autoDetector.binaryData, autoDetector.imageHeight, autoDetector.imageWidth, this._xStep,
            this._yStep, dataSeries);
        algoCore.run();
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/
var wpd = wpd || {};

wpd.AveragingWindowWithStepSizeAlgo = class {

    constructor() {
        this._xmin = 0;
        this._xmax = 0;
        this._delx = 0.1;
        this._lineWidth = 30;
        this._ymin = 0;
        this._ymax = 0;
        this._wasRun = false;
    }

    getParamList(axes) {
        if (!this._wasRun) {
            if (axes != null && axes instanceof wpd.XYAxes) {
                let bounds = axes.getBounds();
                this._xmin = bounds.x1;
                this._xmax = bounds.x2;
                this._ymin = bounds.y3;
                this._ymax = bounds.y4;
            }
        }

        return [
            ["X_min", "Units", this._xmin],
            ["ΔX Step", "Units", this._delx],
            ["X_max", "Units", this._xmax],
            ["Y_min", "Units", this._ymin],
            ["Y_max", "Units", this._ymax],
            ["Line width", "Px", this._lineWidth]
        ];
    }

    setParam(index, val) {
        if (index === 0) {
            this._xmin = val;
        } else if (index === 1) {
            this._delx = val;
        } else if (index === 2) {
            this._xmax = val;
        } else if (index === 3) {
            this._ymin = val;
        } else if (index === 4) {
            this._ymax = val;
        } else if (index === 5) {
            this._lineWidth = val;
        }
    }

    getParam(index) {
        switch (index) {
            case 0:
                return this._xmin;
            case 1:
                return this._delx;
            case 2:
                return this._xmax;
            case 3:
                return this._ymin;
            case 4:
                return this._ymax;
            case 5:
                return this._lineWidth;
            default:
                return null;
        }
    }

    serialize() {
        return this._wasRun ? {
                algoType: "AveragingWindowWithStepSizeAlgo",
                xmin: this._xmin,
                delx: this._delx,
                xmax: this._xmax,
                ymin: this._ymin,
                ymax: this._ymax,
                lineWidth: this._lineWidth
            } :
            null;
    }

    deserialize(obj) {
        this._xmin = obj.xmin;
        this._delx = obj.delx;
        this._xmax = obj.xmax;
        this._ymin = obj.ymin;
        this._ymax = obj.ymax;
        this._lineWidth = obj.lineWidth;
        this._wasRun = true;
    }

    run(autoDetector, dataSeries, axes) {
        this._wasRun = true;
        var pointsPicked = 0,
            dw = autoDetector.imageWidth,
            dh = autoDetector.imageHeight,
            blobx = [],
            bloby = [],
            xi, xmin_pix, xmax_pix, ymin_pix, ymax_pix, dpix,
            r_unit_per_pix, step_pix, blobActive, blobEntry, blobExit, blobExitLocked, ii, yi,
            mean_ii, mean_yi, pdata;

        dataSeries.clearAll();

        for (xi = this._xmin; xi <= this._xmax; xi += this._delx) {
            step_pix = 1;

            pdata = axes.dataToPixel(xi, this._ymin);
            xmin_pix = pdata.x;
            ymin_pix = pdata.y;

            pdata = axes.dataToPixel(xi, this._ymax);
            xmax_pix = pdata.x;
            ymax_pix = pdata.y;

            dpix = Math.sqrt((ymax_pix - ymin_pix) * (ymax_pix - ymin_pix) +
                (xmax_pix - xmin_pix) * (xmax_pix - xmin_pix));
            r_unit_per_pix = (this._ymax - this._ymin) / dpix;

            blobActive = false;
            blobEntry = 0;
            blobExit = 0;
            // To account for noise or if actual thickness is less than specified thickness.
            // This flag helps to set blobExit at the end of the thin part or account for noise.
            blobExitLocked = false;

            for (ii = 0; ii <= dpix; ii++) {
                yi = -ii * step_pix * r_unit_per_pix + this._ymax;
                pdata = axes.dataToPixel(xi, yi);
                xi_pix = pdata.x;
                yi_pix = pdata.y;

                if (xi_pix >= 0 && xi_pix < dw && yi_pix >= 0 && yi_pix < dh) {
                    if (autoDetector.binaryData.has(parseInt(yi_pix, 10) * dw +
                            parseInt(xi_pix, 10))) {
                        if (blobActive === false) {
                            blobEntry = ii;
                            blobExit = blobEntry;
                            blobActive = true;
                            blobExitLocked = false;
                        }
                        // Resume collection, it was just noise
                        if (blobExitLocked === true) {
                            blobExit = ii;
                            blobExitLocked = false;
                        }
                    } else {

                        // collection ended before line thickness was hit. It could just be noise
                        // or it could be the actual end.
                        if (blobExitLocked === false) {
                            blobExit = ii;
                            blobExitLocked = true;
                        }
                    }

                    if (blobActive === true) {

                        if ((ii > blobEntry + this._lineWidth) || (ii == dpix - 1)) {
                            blobActive = false;

                            if (blobEntry > blobExit) {
                                blobExit = ii;
                            }

                            mean_ii = (blobEntry + blobExit) / 2.0;
                            mean_yi = -mean_ii * step_pix * r_unit_per_pix + this._ymax;

                            pdata = axes.dataToPixel(xi, mean_yi);
                            dataSeries.addPixel(parseFloat(pdata.x), parseFloat(pdata.y));
                            pointsPicked = pointsPicked + 1;
                        }
                    }
                }
            }
        }
    }
}/*
WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.BarValue = class {

    constructor() {
        this.npoints = 0;
        this.avgValTop = 0;
        this.avgValBot = 0;
        this.avgX = 0;
    }

    append(x, valTop, valBot) {
        this.avgX = (this.npoints * this.avgX + x) / (this.npoints + 1.0);
        this.avgValTop = (this.npoints * this.avgValTop + valTop) / (this.npoints + 1.0);
        this.avgValBot = (this.npoints * this.avgValBot + valBot) / (this.npoints + 1.0);
        this.npoints++;
    }

    isPointInGroup(x, valTop, valBot, del_x, del_val) {
        if (this.npoints === 0) {
            return true;
        }
        if (Math.abs(this.avgX - x) <= del_x && Math.abs(this.avgValTop - valTop) <= del_val &&
            Math.abs(this.avgValBot - valBot) <= del_val) {
            return true;
        }
        return false;
    }
};

wpd.BarExtractionAlgo = class {

    constructor() {
        this._delX = 30;
        this._delVal = 10;
        this._wasRun = false;
    }

    getParamList(axes) {
        var orientationAxes = axes.getOrientation().axes;
        if (orientationAxes === 'Y') {
            return [
                ['ΔX', 'Px', this._delX],
                ['ΔVal', 'Px', this._delVal]
            ];
        } else {
            return [
                ['ΔY', 'Px', this._delX],
                ['ΔVal', 'Px', this._delVal]
            ];
        }
    }

    setParam(index, val) {
        if (index === 0) {
            this._delX = parseFloat(val);
        } else if (index === 1) {
            this._delVal = parseFloat(val);
        }
    }

    getParam(index) {
        return index === 0 ? this._delX : this._delVal;
    }

    serialize() {
        return this._wasRun ? {
                algoType: "BarExtractionAlgo",
                delX: this._delX,
                delVal: this._delVal
            } :
            null;
    }

    deserialize(obj) {
        this._delX = obj.delX;
        this._delVal = obj.delVal;
        this._wasRun = true;
    }

    run(autoDetector, dataSeries, axes) {
        this._wasRun = true;
        var orientation = axes.getOrientation(),
            barValueColl = [],
            valTop, valBot, valCount, val,
            px, py, width = autoDetector.imageWidth,
            height = autoDetector.imageHeight,
            pixelAdded,
            barValuei, bv, dataVal, pxVal, mkeys, topVal, botVal,

            appendData = function(x, valTop, valBot, delX, delVal) {
                pixelAdded = false;
                for (barValuei = 0; barValuei < barValueColl.length; barValuei++) {
                    bv = barValueColl[barValuei];

                    if (bv.isPointInGroup(x, valTop, valBot, delX, delVal)) {
                        bv.append(x, valTop, valBot);
                        pixelAdded = true;
                        break;
                    }
                }
                if (!pixelAdded) {
                    bv = new wpd.BarValue();
                    bv.append(x, valTop, valBot);
                    barValueColl.push(bv);
                }
            };

        dataSeries.clearAll();

        // Switch directions based on axes orientation and direction of data along that axes:
        // For each direction, look for both top and bottom side of the bar to account for cases
        // where some bars are oriented in the increasing direction, while others are in a
        // decreasing direction
        if (orientation.axes === 'Y') {
            for (px = 0; px < width; px++) {
                valTop = 0;
                valBot = height - 1;
                valCount = 0;

                for (py = 0; py < height; py++) {
                    if (autoDetector.binaryData.has(py * width + px)) {
                        valTop = py;
                        valCount++;
                        break;
                    }
                }
                for (py = height - 1; py >= 0; py--) {
                    if (autoDetector.binaryData.has(py * width + px)) {
                        valBot = py;
                        valCount++;
                        break;
                    }
                }
                if (valCount === 2) { // found both top and bottom ends
                    appendData(px, valTop, valBot, this._delX, this._delVal);
                }
            }
        } else {
            for (py = 0; py < height; py++) {
                valTop = width - 1;
                valBot = 0;
                valCount = 0;

                for (px = width - 1; px >= 0; px--) {
                    if (autoDetector.binaryData.has(py * width + px)) {
                        valTop = px;
                        valCount++;
                        break;
                    }
                }
                for (px = 0; px < width; px++) {
                    if (autoDetector.binaryData.has(py * width + px)) {
                        valBot = px;
                        valCount++;
                        break;
                    }
                }
                if (valCount === 2) {
                    appendData(py, valTop, valBot, this._delX, this._delVal);
                }
            }
        }

        if (axes.dataPointsHaveLabels) {
            mkeys = dataSeries.getMetadataKeys();
            if (mkeys == null || mkeys[0] !== 'Label') {
                dataSeries.setMetadataKeys(['Label']);
            }
        }

        for (barValuei = 0; barValuei < barValueColl.length; barValuei++) {

            bv = barValueColl[barValuei];

            if (orientation.axes === 'Y') {
                valTop = axes.pixelToData(bv.avgX, bv.avgValTop)[0];
                valBot = axes.pixelToData(bv.avgX, bv.avgValBot)[0];
            } else {
                valTop = axes.pixelToData(bv.avgValTop, bv.avgX)[0];
                valBot = axes.pixelToData(bv.avgValBot, bv.avgX)[0];
            }

            if (valTop + valBot < 0) {
                val = orientation.direction === 'increasing' ? bv.avgValBot : bv.avgValTop;
            } else {
                val = orientation.direction === 'increasing' ? bv.avgValTop : bv.avgValBot;
            }

            if (axes.dataPointsHaveLabels) {

                if (orientation.axes === 'Y') {
                    dataSeries.addPixel(bv.avgX + 0.5, val + 0.5, ["Bar" + barValuei]);
                } else {
                    dataSeries.addPixel(val + 0.5, bv.avgX + 0.5, ["Bar" + barValuei]);
                }

            } else {

                if (orientation.axes === 'Y') {
                    dataSeries.addPixel(bv.avgX + 0.5, val + 0.5);
                } else {
                    dataSeries.addPixel(val + 0.5, bv.avgX + 0.5);
                }
            }
        }
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.BlobDetectorAlgo = class {

    constructor() {
        this._minDia = 0;
        this._maxDia = 5000;
        this._wasRun = false;
    }

    getParamList(axes) {
        if (axes != null && axes instanceof wpd.MapAxes) {
            return [
                ['Min Diameter', 'Units', this._minDia],
                ['Max Diameter', 'Units', this._maxDia]
            ];
        }
        return [
            ['Min Diameter', 'Px', this._minDia],
            ['Max Diameter', 'Px', this._maxDia]
        ];
    }

    setParam(index, val) {
        if (index === 0) {
            this._minDia = parseFloat(val);
        } else if (index === 1) {
            this._maxDia = parseFloat(val);
        }
    }

    serialize() {
        return this._wasRun ? {
                algoType: "BlobDetectorAlgo",
                minDia: this._minDia,
                maxDia: this._maxDia
            } :
            null;
    }

    deserialize(obj) {
        this._minDia = obj.minDia;
        this._maxDia = obj.maxDia;
        this._wasRun = true;
    }

    getParam(index) {
        return index === 0 ? this._minDia : this._maxDia;
    }

    run(autoDetector, dataSeries, axes) {
        this._wasRun = true;
        var dw = autoDetector.imageWidth,
            dh = autoDetector.imageHeight,
            pixelVisited = [],
            blobCount = 0,
            blobs = [],
            xi, yi, blobPtIndex, bIndex, nxi, nyi, bxi, byi, pcount, dia;

        if (dw <= 0 || dh <= 0 || autoDetector.binaryData == null ||
            autoDetector.binaryData.size === 0) {
            return;
        }

        dataSeries.clearAll();
        dataSeries.setMetadataKeys(["area", "moment"]);

        for (xi = 0; xi < dw; xi++) {
            for (yi = 0; yi < dh; yi++) {
                if (autoDetector.binaryData.has(yi * dw + xi) &&
                    !(pixelVisited[yi * dw + xi] === true)) {

                    pixelVisited[yi * dw + xi] = true;

                    bIndex = blobs.length;

                    blobs[bIndex] = {
                        pixels: [{
                            x: xi,
                            y: yi
                        }],
                        centroid: {
                            x: xi,
                            y: yi
                        },
                        area: 1.0,
                        moment: 0.0
                    };

                    blobPtIndex = 0;
                    while (blobPtIndex < blobs[bIndex].pixels.length) {
                        bxi = blobs[bIndex].pixels[blobPtIndex].x;
                        byi = blobs[bIndex].pixels[blobPtIndex].y;

                        for (nxi = bxi - 1; nxi <= bxi + 1; nxi++) {
                            for (nyi = byi - 1; nyi <= byi + 1; nyi++) {
                                if (nxi >= 0 && nyi >= 0 && nxi < dw && nyi < dh) {
                                    if (!(pixelVisited[nyi * dw + nxi] === true) &&
                                        autoDetector.binaryData.has(nyi * dw + nxi)) {

                                        pixelVisited[nyi * dw + nxi] = true;

                                        pcount = blobs[bIndex].pixels.length;

                                        blobs[bIndex].pixels[pcount] = {
                                            x: nxi,
                                            y: nyi
                                        };

                                        blobs[bIndex].centroid.x =
                                            (blobs[bIndex].centroid.x * pcount + nxi) /
                                            (pcount + 1.0);
                                        blobs[bIndex].centroid.y =
                                            (blobs[bIndex].centroid.y * pcount + nyi) /
                                            (pcount + 1.0);
                                        blobs[bIndex].area = blobs[bIndex].area + 1.0;
                                    }
                                }
                            }
                        }
                        blobPtIndex = blobPtIndex + 1;
                    }
                }
            }
        }

        for (bIndex = 0; bIndex < blobs.length; bIndex++) {
            blobs[bIndex].moment = 0;
            for (blobPtIndex = 0; blobPtIndex < blobs[bIndex].pixels.length; blobPtIndex++) {
                blobs[bIndex].moment =
                    blobs[bIndex].moment +
                    (blobs[bIndex].pixels[blobPtIndex].x - blobs[bIndex].centroid.x) *
                    (blobs[bIndex].pixels[blobPtIndex].x - blobs[bIndex].centroid.x) +
                    (blobs[bIndex].pixels[blobPtIndex].y - blobs[bIndex].centroid.y) *
                    (blobs[bIndex].pixels[blobPtIndex].y - blobs[bIndex].centroid.y);
            }
            if (axes instanceof wpd.MapAxes) {
                blobs[bIndex].area = plotData.axes.pixelToDataArea(blobs[bIndex].area);
            }

            dia = 2.0 * Math.sqrt(blobs[bIndex].area / Math.PI);
            if (dia <= this._maxDia && dia >= this._minDia) {
                // add 0.5 pixel offset to shift to the center of the pixels.
                dataSeries.addPixel(blobs[bIndex].centroid.x + 0.5, blobs[bIndex].centroid.y + 0.5,
                    [blobs[bIndex].area, blobs[bIndex].moment]);
            }
        }
    }
}/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

// Simple curve extraction with interpolation, but at user provided independents (x, theta etc.)
wpd.CustomIndependents = class {
    constructor() {
        this._xvals = [];
        this._ymin = 0;
        this._ymax = 0;
        this._smoothing = 0;
        this._wasRun = false;
    }

    deserialize(obj) {
        this._xvals = obj.xvals;
        this._ymin = obj.ymin;
        this._ymax = obj.ymax;
        this._smoothing = obj.smoothing;
        this._wasRun = true;
    }

    getParam(index) {
        switch (index) {
            case 0:
                return this._xvals;
            case 1:
                return this._ymin;
            case 2:
                return this._ymax;
            case 3:
                return this._smoothing;
            default:
                return null;
        }
    }

    setParam(index, val) {
        if (index === 0) {
            this._xvals = val;
        } else if (index === 1) {
            this._ymin = val;
        } else if (index === 2) {
            this._ymax = val;
        } else if (index === 3) {
            this._smoothing = val;
        }
    }

    serialize() {
        return this._wasRun ? {
            algoType: "CustomIndependents",
            xvals: this._xvals,
            ymin: this._ymin,
            ymax: this._ymax,
            smoothing: this._smoothing
        } : null;
    }

    run(autoDetector, dataSeries, axes) {
        this._wasRun = true;
        dataSeries.clearAll();
        let isLogX = axes.isLogX();
        let isLogY = axes.isLogY();

        // TODO: Finish implementation
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDigitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.XStepWithInterpolationAlgo = class {
    constructor() {
        this._xmin = 0;
        this._xmax = 1;
        this._delx = 0.1;
        this._smoothing = 0;
        this._ymin = 0;
        this._ymax = 0;
        this._wasRun = false;
    }

    getParamList(axes) {
        if (!this._wasRun) {
            if (axes != null && axes instanceof wpd.XYAxes) {
                let bounds = axes.getBounds();
                this._xmin = bounds.x1;
                this._xmax = bounds.x2;
                this._delx = (bounds.x2 - bounds.x1) / 50.0;
                this._ymin = bounds.y3;
                this._ymax = bounds.y4;
                this._smoothing = 0;
            }
        }
        return [
            ["X_min", "Units", this._xmin],
            ["ΔX Step", "Units", this._delx],
            ["X_max", "Units", this._xmax],
            ["Y_min", "Units", this._ymin],
            ["Y_max", "Units", this._ymax],
            ["Smoothing", "% of ΔX", this._smoothing]
        ];
    }

    setParam(index, val) {
        if (index === 0) {
            this._xmin = val;
        } else if (index === 1) {
            this._delx = val;
        } else if (index === 2) {
            this._xmax = val;
        } else if (index === 3) {
            this._ymin = val;
        } else if (index === 4) {
            this._ymax = val;
        } else if (index === 5) {
            this._smoothing = val;
        }
    }

    getParam(index) {
        switch (index) {
            case 0:
                return this._xmin;
            case 1:
                return this._delx;
            case 2:
                return this._xmax;
            case 3:
                return this._ymin;
            case 4:
                return this._ymax;
            case 5:
                return this._smoothing;
            default:
                return null;
        }
    }

    serialize() {
        return this._wasRun ? {
                algoType: "XStepWithInterpolationAlgo",
                xmin: this._xmin,
                delx: this._delx,
                xmax: this._xmax,
                ymin: this._ymin,
                ymax: this._ymax,
                smoothing: this._smoothing
            } :
            null;
    }

    deserialize(obj) {
        this._xmin = obj.xmin;
        this._delx = obj.delx;
        this._xmax = obj.xmax;
        this._ymin = obj.ymin;
        this._ymax = obj.ymax;
        this._smoothing = obj.smoothing;
        this._wasRun = true;
    }

    run(autoDetector, dataSeries, axes) {
        this._wasRun = true;
        var pointsPicked = 0,
            dw = autoDetector.imageWidth,
            dh = autoDetector.imageHeight,
            xi,
            dist_y_px, dist_x_px, ii, yi, jj, mean_yi, y_count, pdata, pdata0, pdata1, xpoints = [],
            ypoints = [],
            xpoints_mean = [],
            ypoints_mean = [],
            mean_x, mean_y, delx, dely, xinterp,
            yinterp, param_width = Math.abs(this._delx * (this._smoothing / 100.0)),
            cs,
            isLogX = axes.isLogX(),
            isLogY = axes.isLogY(),
            isDateX = axes.isDate(0),
            isDateY = axes.isDate(1),
            scaled_param_xmin = this._xmin,
            scaled_param_xmax = this._xmax,
            scaled_param_ymin = this._ymin,
            scaled_param_ymax = this._ymax,
            scaled_param_width = param_width,
            scaled_param_delx = this._delx;

        dataSeries.clearAll();

        if (isLogX) {
            scaled_param_xmax = Math.log10(scaled_param_xmax);
            scaled_param_xmin = Math.log10(scaled_param_xmin);
            scaled_param_width = Math.abs(Math.log10(this._delx) * this._smoothing / 100.0);
            scaled_param_delx = Math.log10(scaled_param_delx);
        }
        if (isLogY) {
            scaled_param_ymin = Math.log10(scaled_param_ymin);
            scaled_param_ymax = Math.log10(scaled_param_ymax);
        }

        // Calculate pixel distance between y_min and y_max:
        pdata0 = axes.dataToPixel(this._xmin, this._ymin);
        pdata1 = axes.dataToPixel(this._xmin, this._ymax);
        dist_y_px = Math.sqrt((pdata0.x - pdata1.x) * (pdata0.x - pdata1.x) +
            (pdata0.y - pdata1.y) * (pdata0.y - pdata1.y));
        dely = (scaled_param_ymax - scaled_param_ymin) / dist_y_px;

        // Calculate pixel distance between x_min and x_max:
        pdata1 = axes.dataToPixel(this._xmax, this._ymin);
        dist_x_px = Math.sqrt((pdata0.x - pdata1.x) * (pdata0.x - pdata1.x) +
            (pdata0.y - pdata1.y) * (pdata0.y - pdata1.y));
        delx = (scaled_param_xmax - scaled_param_xmin) / dist_x_px;

        if (Math.abs(scaled_param_width / delx) > 0 && Math.abs(scaled_param_width / delx) < 1) {
            scaled_param_width = delx;
        }

        xi = delx > 0 ? scaled_param_xmin - 2 * delx : scaled_param_xmin + 2 * delx;
        while ((delx > 0 && xi <= scaled_param_xmax + 2 * delx) ||
            (delx < 0 && xi >= scaled_param_xmax - 2 * delx)) {

            mean_yi = 0;
            y_count = 0;
            yi = scaled_param_ymin;
            while ((dely > 0 && yi <= scaled_param_ymax) || (dely < 0 && yi >= scaled_param_ymax)) {
                pdata = axes.dataToPixel(isLogX ? Math.pow(10, xi) : xi,
                    isLogY ? Math.pow(10, yi) : yi);
                if (pdata.x >= 0 && pdata.y >= 0 && pdata.x < dw && pdata.y < dh) {
                    if (autoDetector.binaryData.has(parseInt(pdata.y, 10) * dw +
                            parseInt(pdata.x, 10))) {
                        mean_yi = (mean_yi * y_count + yi) / (parseFloat(y_count + 1));
                        y_count++;
                    }
                }
                yi = yi + dely;
            }

            if (y_count > 0) {
                xpoints[pointsPicked] = parseFloat(xi);
                ypoints[pointsPicked] = parseFloat(mean_yi);
                pointsPicked = pointsPicked + 1;
            }

            xi = xi + delx;
        }

        if (xpoints.length <= 0 || ypoints.length <= 0) {
            return; // kill if nothing was detected so far.
        }

        if (scaled_param_width > 0) {
            xpoints_mean = [];
            ypoints_mean = [];

            xi = xpoints[0];
            while ((delx > 0 && xi <= xpoints[xpoints.length - 1]) ||
                (delx < 0 && xi >= xpoints[xpoints.length - 1])) {
                mean_x = 0;
                mean_y = 0;
                y_count = 0;
                for (ii = 0; ii < xpoints.length; ii++) {
                    if (xpoints[ii] <= xi + scaled_param_width &&
                        xpoints[ii] >= xi - scaled_param_width) {
                        mean_x = (mean_x * y_count + xpoints[ii]) / parseFloat(y_count + 1);
                        mean_y = (mean_y * y_count + ypoints[ii]) / parseFloat(y_count + 1);
                        y_count++;
                    }
                }

                if (y_count > 0) {
                    xpoints_mean[xpoints_mean.length] = mean_x;
                    ypoints_mean[ypoints_mean.length] = mean_y;
                }

                if (delx > 0) {
                    xi = xi + param_width;
                } else {
                    xi = xi - param_width;
                }
            }

        } else {
            xpoints_mean = xpoints;
            ypoints_mean = ypoints;
        }

        if (xpoints_mean.length <= 0 || ypoints_mean.length <= 0) {
            return;
        }

        xinterp = [];
        ii = 0;
        xi = scaled_param_xmin;

        if ((delx < 0 && this._delx > 0) || (delx > 0 && this._delx < 0)) {
            return;
        }

        while ((delx > 0 && xi <= scaled_param_xmax) || (delx < 0 && xi >= scaled_param_xmax)) {
            xinterp[ii] = xi;
            ii++;
            xi = xi + scaled_param_delx;
        }

        if (delx < 0) {
            xpoints_mean = xpoints_mean.reverse();
            ypoints_mean = ypoints_mean.reverse();
        }

        // Cubic spline interpolation:
        cs = wpd.cspline(xpoints_mean, ypoints_mean);
        if (cs != null) {
            yinterp = [];
            for (ii = 0; ii < xinterp.length; ++ii) {
                if (!isNaN(xinterp[ii])) {
                    yinterp[ii] = wpd.cspline_interp(cs, xinterp[ii]);
                    if (yinterp[ii] !== null) {
                        pdata = axes.dataToPixel(isLogX ? Math.pow(10, xinterp[ii]) : xinterp[ii],
                            isLogY ? Math.pow(10, yinterp[ii]) : yinterp[ii]);
                        dataSeries.addPixel(pdata.x, pdata.y);
                    }
                }
            }
        }
    }
};/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.BarAxes = (function() {
    var AxesObj = function() {
        // Throughout this code, it is assumed that "y" is the continuous axes and "x" is
        // the discrete axes. In practice, this shouldn't matter even if the orientation
        // is different.
        var isCalibrated = false,
            isLogScale = false,
            isRotatedAxes = false,
            x1, y1, x2, y2, p1, p2,
            orientation;

        this.isCalibrated = function() {
            return isCalibrated;
        };

        this.calibration = null;

        this.calibrate = function(calibration, isLog, isRotated) {
            this.calibration = calibration;
            isCalibrated = false;
            var cp1 = calibration.getPoint(0),
                cp2 = calibration.getPoint(1);

            x1 = cp1.px;
            y1 = cp1.py;
            x2 = cp2.px;
            y2 = cp2.py;
            p1 = parseFloat(cp1.dy);
            p2 = parseFloat(cp2.dy);

            if (isLog) {
                isLogScale = true;
                p1 = Math.log(p1) / Math.log(10);
                p2 = Math.log(p2) / Math.log(10);
            } else {
                isLogScale = false;
            }

            orientation = this.calculateOrientation();
            isRotatedAxes = isRotated;

            if (!isRotated) {
                // ignore rotation and assume axes is precisely vertical or horizontal
                if (orientation.axes == 'Y') {
                    x2 = x1;
                } else {
                    y2 = y1;
                }
                // recalculate orientation:
                orientation = this.calculateOrientation();
            }

            isCalibrated = true;
            return true;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [],
                c_c2 = ((pyi - y1) * (y2 - y1) + (x2 - x1) * (pxi - x1)) /
                ((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1));
            // We could return X pixel value (or Y, depending on orientation) but that's not very
            // useful. For now, just return the bar value. That's it.
            data[0] = (p2 - p1) * c_c2 + p1;
            if (isLogScale) {
                data[0] = Math.pow(10, data[0]);
            }
            return data;
        };

        this.dataToPixel = function(x, y) {
            // not implemented yet
            return {
                x: 0,
                y: 0
            };
        };

        this.pixelToLiveString = function(pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4);
        };

        this.isLog = function() {
            return isLogScale;
        };

        this.isRotated = function() {
            return isRotatedAxes;
        }

        this.getTransformationEquations = function() {
            return {
                pixelToData: ['This will be available in a future release.']
            };
        };

        this.dataPointsHaveLabels = true;

        this.dataPointsLabelPrefix = 'Bar';

        this.calculateOrientation = function() { // Used by auto-extract algo to switch orientation.
            var orientationAngle = wpd.taninverse(-(y2 - y1), x2 - x1) * 180 / Math.PI,
                orientation = {
                    axes: 'Y',
                    direction: 'increasing',
                    angle: orientationAngle
                },
                tol = 30; // degrees.

            if (Math.abs(orientationAngle - 90) < tol) {
                orientation.axes = 'Y';
                orientation.direction = 'increasing';
            } else if (Math.abs(orientationAngle - 270) < tol) {
                orientation.axes = 'Y';
                orientation.direction = 'decreasing';
            } else if (Math.abs(orientationAngle - 0) < tol ||
                Math.abs(orientationAngle - 360) < tol) {
                orientation.axes = 'X';
                orientation.direction = 'increasing';
            } else if (Math.abs(orientationAngle - 180) < tol) {
                orientation.axes = 'X';
                orientation.direction = 'decreasing';
            }

            return orientation;

        };

        this.getOrientation = function() {
            return orientation;
        };

        this.name = "Bar";
    };

    AxesObj.prototype.numCalibrationPointsRequired = function() {
        return 2;
    };

    AxesObj.prototype.getDimensions = function() {
        return 2;
    };

    AxesObj.prototype.getAxesLabels = function() {
        return ['Label', 'Y'];
    };

    return AxesObj;
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.ImageAxes = (function() {
    var AxesObj = function() {
        this.isCalibrated = function() {
            return true;
        };

        this.calibrate = function() {
            return true;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [pxi, pyi];
            return data;
        };

        this.dataToPixel = function(x, y) {
            return {
                x: x,
                y: y
            };
        };

        this.pixelToLiveString = function(pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toFixed(2) + ', ' + dataVal[1].toFixed(2);
        };

        this.getTransformationEquations = function() {
            return {
                pixelToData: ['x_data = x_pixel', 'y_data = y_pixel'],
                dataToPixel: ['x_pixel = x_data', 'y_pixel = y_data']
            };
        };

        this.name = "Image";
    };

    AxesObj.prototype.numCalibrationPointsRequired = function() {
        return 0;
    };

    AxesObj.prototype.getDimensions = function() {
        return 2;
    };

    AxesObj.prototype.getAxesLabels = function() {
        return ['X', 'Y'];
    };

    return AxesObj;
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.MapAxes = (function() {
    var AxesObj = function() {
        var isCalibrated = false,
            scaleLength, scaleUnits, dist,
            processCalibration = function(cal, scale_length, scale_units) {
                var cp0 = cal.getPoint(0),
                    cp1 = cal.getPoint(1);
                dist = Math.sqrt((cp0.px - cp1.px) * (cp0.px - cp1.px) +
                    (cp0.py - cp1.py) * (cp0.py - cp1.py));
                scaleLength = parseFloat(scale_length);
                scaleUnits = scale_units;
                return true;
            };

        this.calibration = null;

        this.isCalibrated = function() {
            return isCalibrated;
        };

        this.calibrate = function(calib, scale_length, scale_units) {
            this.calibration = calib;
            isCalibrated = processCalibration(calib, scale_length, scale_units);
            return isCalibrated;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [];
            data[0] = pxi * scaleLength / dist;
            data[1] = pyi * scaleLength / dist;
            return data;
        };

        this.pixelToDataDistance = function(distancePx) {
            return distancePx * scaleLength / dist;
        };

        this.pixelToDataArea = function(
            areaPx) {
            return areaPx * scaleLength * scaleLength / (dist * dist);
        };

        this.dataToPixel = function(a, b, c) {
            return {
                x: 0,
                y: 0
            };
        };

        this.pixelToLiveString = function(pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4) + ', ' + dataVal[1].toExponential(4);
        };

        this.getScaleLength = function() {
            return scaleLength;
        };

        this.getUnits = function() {
            return scaleUnits;
        };

        this.getTransformationEquations = function() {
            return {
                pixelToData: [
                    'x_data = ' + scaleLength / dist + '*x_pixel',
                    'y_data = ' + scaleLength / dist + '*y_pixel'
                ],
                dataToPixel: [
                    'x_pixel = ' + dist / scaleLength + '*x_data',
                    'y_pixel = ' + dist / scaleLength + '*y_data'
                ]
            };
        };

        this.name = "Map";
    };

    AxesObj.prototype.numCalibrationPointsRequired = function() {
        return 2;
    };

    AxesObj.prototype.getDimensions = function() {
        return 2;
    };

    AxesObj.prototype.getAxesLabels = function() {
        return ['X', 'Y'];
    };

    return AxesObj;
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.PolarAxes = (function() {
    var AxesObj = function() {
        var isCalibrated = false,
            isDegrees = false,
            isClockwise = false,
            isLog = false,

            x0, y0, x1, y1, x2, y2, r1, theta1, r2, theta2, dist10, dist20, dist12, phi0, alpha0;

        let processCalibration = function(cal, is_degrees, is_clockwise, is_log_r) {
            var cp0 = cal.getPoint(0),
                cp1 = cal.getPoint(1),
                cp2 = cal.getPoint(2);
            x0 = cp0.px;
            y0 = cp0.py;
            x1 = cp1.px;
            y1 = cp1.py;
            x2 = cp2.px;
            y2 = cp2.py;

            r1 = cp1.dx;
            theta1 = cp1.dy;

            r2 = cp2.dx;
            theta2 = cp2.dy;

            isDegrees = is_degrees;
            isClockwise = is_clockwise;

            if (isDegrees === true) { // if degrees
                theta1 = (Math.PI / 180.0) * theta1;
                theta2 = (Math.PI / 180.0) * theta2;
            }

            if (is_log_r) {
                isLog = true;
                r1 = Math.log(r1) / Math.log(10);
                r2 = Math.log(r2) / Math.log(10);
            }

            // Distance between 1 and 0.
            dist10 = Math.sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));

            // Distance between 2 and 0
            dist20 = Math.sqrt((x2 - x0) * (x2 - x0) + (y2 - y0) * (y2 - y0));

            // Radial Distance between 1 and 2.
            dist12 = dist20 - dist10;

            phi0 = wpd.taninverse(-(y1 - y0), x1 - x0);

            if (isClockwise) {
                alpha0 = phi0 + theta1;
            } else {
                alpha0 = phi0 - theta1;
            }

            return true;
        };

        this.calibration = null;

        this.isCalibrated = function() {
            return isCalibrated;
        };

        this.calibrate = function(calib, is_degrees, is_clockwise, is_log_r) {
            this.calibration = calib;
            isCalibrated = processCalibration(calib, is_degrees, is_clockwise, is_log_r);
            return isCalibrated;
        };

        this.isThetaDegrees = function() {
            return isDegrees;
        };

        this.isThetaClockwise = function() {
            return isClockwise;
        };

        this.isRadialLog = function() {
            return isLog;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [],
                rp, thetap;

            let xp = parseFloat(pxi);
            let yp = parseFloat(pyi);

            rp = ((r2 - r1) / dist12) *
                (Math.sqrt((xp - x0) * (xp - x0) + (yp - y0) * (yp - y0)) - dist10) +
                r1;

            if (isClockwise) {
                thetap = alpha0 - wpd.taninverse(-(yp - y0), xp - x0);
            } else {
                thetap = wpd.taninverse(-(yp - y0), xp - x0) - alpha0;
            }

            if (thetap < 0) {
                thetap = thetap + 2 * Math.PI;
            }

            if (isDegrees === true) {
                thetap = 180.0 * thetap / Math.PI;
            }

            if (isLog) {
                rp = Math.pow(10, rp);
            }

            data[0] = rp;
            data[1] = thetap;

            return data;
        };

        this.dataToPixel = function(r, theta) {
            return {
                x: 0,
                y: 0
            };
        };

        this.pixelToLiveString = function(pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4) + ', ' + dataVal[1].toExponential(4);
        };

        this.getTransformationEquations = function() {
            var rEqn = 'r = (' + (r2 - r1) / dist12 + ')*sqrt((x_pixel - ' + x0 +
                ')^2 + (y_pixel - ' + y0 + ')^2) + (' + (r1 - dist10 * (r2 - r1) / dist12) +
                ')',
                thetaEqn;

            if (isClockwise) {
                thetaEqn = alpha0 + '- atan2((' + y0 + ' - y_pixel), (x_pixel - ' + x0 + '))';
            } else {
                thetaEqn =
                    'atan2((' + y0 + ' - y_pixel), (x_pixel - ' + x0 + ')) - (' + alpha0 + ')';
            }

            if (isDegrees) {
                thetaEqn = 'theta = (180/PI)*(' + thetaEqn + '), theta = theta + 360 if theta < 0';
            } else {
                thetaEqn = 'theta = ' + thetaEqn + ' theta = theta + 2*PI if theta < 0';
            }

            return {
                pixelToData: [rEqn, thetaEqn]
            };
        };

        this.name = "Polar";
    };

    AxesObj.prototype.numCalibrationPointsRequired = function() {
        return 3;
    };

    AxesObj.prototype.getDimensions = function() {
        return 2;
    };

    AxesObj.prototype.getAxesLabels = function() {
        return ['r', 'θ'];
    };

    return AxesObj;
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.TernaryAxes = (function() {
    var AxesObj = function() {
        var isCalibrated = false,

            x0, y0, x1, y1, x2, y2, L, phi0, root3, isRange0to100, isOrientationNormal,

            processCalibration = function(cal, range100, is_normal) {
                var cp0 = cal.getPoint(0),
                    cp1 = cal.getPoint(1),
                    cp2 = cal.getPoint(2);

                x0 = cp0.px;
                y0 = cp0.py;
                x1 = cp1.px;
                y1 = cp1.py;
                x2 = cp2.px;
                y2 = cp2.py;

                L = Math.sqrt((x0 - x1) * (x0 - x1) + (y0 - y1) * (y0 - y1));

                phi0 = wpd.taninverse(-(y1 - y0), x1 - x0);

                root3 = Math.sqrt(3);

                isRange0to100 = range100;

                isOrientationNormal = is_normal;

                return true;
            };

        this.isCalibrated = function() {
            return isCalibrated;
        };

        this.calibration = null;

        this.calibrate = function(calib, range100, is_normal) {
            this.calibration = calib;
            isCalibrated = processCalibration(calib, range100, is_normal);
            return isCalibrated;
        };

        this.isRange100 = function() {
            return isRange0to100;
        };

        this.isNormalOrientation = function() {
            return isOrientationNormal;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [],
                rp, thetap, xx, yy, ap, bp, cp, bpt;

            let xp = parseFloat(pxi);
            let yp = parseFloat(pyi);

            rp = Math.sqrt((xp - x0) * (xp - x0) + (yp - y0) * (yp - y0));

            thetap = wpd.taninverse(-(yp - y0), xp - x0) - phi0;

            xx = (rp * Math.cos(thetap)) / L;
            yy = (rp * Math.sin(thetap)) / L;

            ap = 1.0 - xx - yy / root3;
            bp = xx - yy / root3;
            cp = 2.0 * yy / root3;

            if (isOrientationNormal == false) {
                // reverse axes orientation
                bpt = bp;
                bp = ap;
                ap = cp;
                cp = bpt;
            }

            if (isRange0to100 == true) {
                ap = ap * 100;
                bp = bp * 100;
                cp = cp * 100;
            }

            data[0] = ap;
            data[1] = bp;
            data[2] = cp;
            return data;
        };

        this.dataToPixel = function(a, b, c) {
            return {
                x: 0,
                y: 0
            };
        };

        this.pixelToLiveString = function(pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4) + ', ' + dataVal[1].toExponential(4) + ', ' +
                dataVal[2].toExponential(4);
        };

        this.getTransformationEquations = function() {
            var rpEqn =
                'rp = sqrt((x_pixel - ' + x0 + ')^2 + (y_pixel - ' + y0 + ')^2)/(' + L + ')',
                thetapEqn = 'thetap = atan2((' + y0 + ' -  y_pixel), (x_pixel - ' + x0 + ')) - (' +
                Math.atan2(-(y1 - y0), x1 - x0) + ')',
                apEqn = '1 - rp*(cos(thetap) - sin(thetap)/sqrt(3))',
                bpEqn = 'rp*(cos(thetap) - sin(thetap)/sqrt(3))',
                cpEqn = '2*rp*sin(thetap)/sqrt(3)',
                bpEqnt;

            if (isRange0to100) {
                apEqn = '100*(' + apEqn + ')';
                bpEqn = '100*(' + bpEqn + ')';
                cpEqn = '100*(' + cpEqn + ')';
            }

            apEqn = 'a_data = ' + apEqn;
            bpEqn = 'b_data = ' + bpEqn;
            cpEqn = 'c_data = ' + cpEqn;

            if (!isOrientationNormal) {
                bpEqnt = bpEqn;
                bpEqn = apEqn;
                apEqn = cpEqn;
                cpEqn = bpEqnt;
            }

            return {
                pixelToData: [rpEqn, thetapEqn, apEqn, bpEqn, cpEqn]
            };
        };

        this.name = "Ternary";
    };

    AxesObj.prototype.numCalibrationPointsRequired = function() {
        return 3;
    };

    AxesObj.prototype.getDimensions = function() {
        return 3;
    };

    AxesObj.prototype.getAxesLabels = function() {
        return ['a', 'b', 'c'];
    };

    return AxesObj;
})();/*
    WebPlotDigitizer - https://automeris.io/WebPlotDigitizer

    Copyright 2010-2019 Ankit Rohatgi <ankitrohatgi@hotmail.com>

    This file is part of WebPlotDigitizer.

    WebPlotDIgitizer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    WebPlotDigitizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with WebPlotDigitizer.  If not, see <http://www.gnu.org/licenses/>.
*/

var wpd = wpd || {};

wpd.XYAxes = (function() {
    var AxesObj = function() {
        var calibration, isCalibrated = false,
            isLogScaleX = false,
            isLogScaleY = false,

            isXDate = false,
            isYDate = false,

            initialFormattingX, initialFormattingY,

            x1, x2, x3, x4, y1, y2, y3, y4, xmin, xmax, ymin, ymax,
            a_mat = [0, 0, 0, 0],
            a_inv_mat = [0, 0, 0, 0],
            c_vec = [0, 0],

            processCalibration = function(cal, isLogX, isLogY) {
                if (cal.getCount() < 4) {
                    return false;
                }

                var cp1 = cal.getPoint(0),
                    cp2 = cal.getPoint(1),
                    cp3 = cal.getPoint(2),
                    cp4 = cal.getPoint(3),
                    ip = new wpd.InputParser(),
                    dat_mat, pix_mat;

                x1 = cp1.px;
                y1 = cp1.py;
                x2 = cp2.px;
                y2 = cp2.py;
                x3 = cp3.px;
                y3 = cp3.py;
                x4 = cp4.px;
                y4 = cp4.py;

                xmin = cp1.dx;
                xmax = cp2.dx;
                ymin = cp3.dy;
                ymax = cp4.dy;

                // Check for dates, validity etc.

                // Validate X-Axes:
                xmin = ip.parse(xmin);
                if (!ip.isValid) {
                    return false;
                }
                isXDate = ip.isDate;
                xmax = ip.parse(xmax);
                if (!ip.isValid || (ip.isDate != isXDate)) {
                    return false;
                }
                initialFormattingX = ip.formatting;

                // Validate Y-Axes:
                ymin = ip.parse(ymin);
                if (!ip.isValid) {
                    return false;
                }
                isYDate = ip.isDate;
                ymax = ip.parse(ymax);
                if (!ip.isValid || (ip.isDate != isYDate)) {
                    return false;
                }
                initialFormattingY = ip.formatting;

                isLogScaleX = isLogX;
                isLogScaleY = isLogY;

                // If x-axis is log scale
                if (isLogScaleX === true) {
                    xmin = Math.log(xmin) / Math.log(10);
                    xmax = Math.log(xmax) / Math.log(10);
                }

                // If y-axis is log scale
                if (isLogScaleY === true) {
                    ymin = Math.log(ymin) / Math.log(10);
                    ymax = Math.log(ymax) / Math.log(10);
                }

                dat_mat = [xmin - xmax, 0, 0, ymin - ymax];
                pix_mat = [x1 - x2, x3 - x4, y1 - y2, y3 - y4];

                a_mat = wpd.mat.mult2x2(dat_mat, wpd.mat.inv2x2(pix_mat));
                a_inv_mat = wpd.mat.inv2x2(a_mat);
                c_vec[0] = xmin - a_mat[0] * x1 - a_mat[1] * y1;
                c_vec[1] = ymin - a_mat[2] * x3 - a_mat[3] * y3;

                calibration = cal;
                return true;
            };

        this.getBounds = function() {
            return {
                x1: isLogScaleX ? Math.pow(10, xmin) : xmin,
                x2: isLogScaleX ? Math.pow(10, xmax) : xmax,
                y3: isLogScaleY ? Math.pow(10, ymin) : ymin,
                y4: isLogScaleY ? Math.pow(10, ymax) : ymax
            };
        };

        this.isCalibrated = function() {
            return isCalibrated;
        };

        this.calibration = null;

        this.calibrate = function(calib, isLogX, isLogY) {
            this.calibration = calib;
            isCalibrated = processCalibration(calib, isLogX, isLogY);
            return isCalibrated;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [],
                xp, yp, xf, yf, dat_vec;

            xp = parseFloat(pxi);
            yp = parseFloat(pyi);

            dat_vec = wpd.mat.mult2x2Vec(a_mat, [xp, yp]);
            dat_vec[0] = dat_vec[0] + c_vec[0];
            dat_vec[1] = dat_vec[1] + c_vec[1];

            xf = dat_vec[0];
            yf = dat_vec[1];

            // if x-axis is log scale
            if (isLogScaleX === true)
                xf = Math.pow(10, xf);

            // if y-axis is log scale
            if (isLogScaleY === true)
                yf = Math.pow(10, yf);

            data[0] = xf;
            data[1] = yf;

            return data;
        };

        this.dataToPixel = function(x, y) {
            var xf, yf, dat_vec, rtnPix;

            if (isLogScaleX) {
                x = Math.log(x) / Math.log(10);
            }
            if (isLogScaleY) {
                y = Math.log(y) / Math.log(10);
            }

            dat_vec = [x - c_vec[0], y - c_vec[1]];
            rtnPix = wpd.mat.mult2x2Vec(a_inv_mat, dat_vec);

            xf = rtnPix[0];
            yf = rtnPix[1];

            return {
                x: xf,
                y: yf
            };
        };

        this.pixelToLiveString = function(pxi, pyi) {
            var rtnString = '',
                dataVal = this.pixelToData(pxi, pyi);
            if (isXDate) {
                rtnString += wpd.dateConverter.formatDateNumber(dataVal[0], initialFormattingX);
            } else {
                rtnString += dataVal[0].toExponential(4);
            }
            rtnString += ', ';

            if (isYDate) {
                rtnString += wpd.dateConverter.formatDateNumber(dataVal[1], initialFormattingY);
            } else {
                rtnString += dataVal[1].toExponential(4);
            }
            return rtnString;
        };

        this.isDate = function(varIndex) {
            if (varIndex === 0) {
                return isXDate;
            } else {
                return isYDate;
            }
        };

        this.getInitialDateFormat = function(varIndex) {
            if (varIndex === 0) {
                return initialFormattingX;
            } else {
                return initialFormattingY;
            }
        };

        this.isLogX = function() {
            return isLogScaleX;
        };

        this.isLogY = function() {
            return isLogScaleY;
        };

        this.getTransformationEquations = function() {
            var xdEqn =
                '(' + a_mat[0] + ')*x_pixel + (' + a_mat[1] + ')*y_pixel + (' + c_vec[0] + ')',
                ydEqn =
                '(' + a_mat[2] + ')*x_pixel + (' + a_mat[3] + ')*y_pixel + (' + c_vec[1] + ')',
                xpEqn = 'x_pixel = (' + a_inv_mat[0] + ')*x_data + (' + a_inv_mat[1] +
                ')*y_data + (' + (-a_inv_mat[0] * c_vec[0] - a_inv_mat[1] * c_vec[1]) + ')',
                ypEqn = 'y_pixel = (' + a_inv_mat[2] + ')*x_data + (' + a_inv_mat[3] +
                ')*y_data + (' + (-a_inv_mat[2] * c_vec[0] - a_inv_mat[3] * c_vec[1]) + ')';

            if (isLogScaleX) {
                xdEqn = 'x_data = pow(10, ' + xdEqn + ')';
            } else {
                xdEqn = 'x_data = ' + xdEqn;
            }

            if (isLogScaleY) {
                ydEqn = 'y_data = pow(10, ' + ydEqn + ')';
            } else {
                ydEqn = 'y_data = ' + ydEqn;
            }

            if (isLogScaleX || isLogScaleY) {
                return {
                    pixelToData: [xdEqn, ydEqn]
                };
            }

            return {
                pixelToData: [xdEqn, ydEqn],
                dataToPixel: [xpEqn, ypEqn]
            };
        };

        this.getOrientation = function() {
            // Used by histogram auto-extract method only at the moment.
            // Just indicate increasing y-axis at the moment so that we can work with histograms.
            return {
                axes: 'Y',
                direction: 'increasing',
                angle: 90
            };
        };

        this.name = "XY";
    };

    AxesObj.prototype.numCalibrationPointsRequired = function() {
        return 4;
    };

    AxesObj.prototype.getDimensions = function() {
        return 2;
    };

    AxesObj.prototype.getAxesLabels = function() {
        return ['X', 'Y'];
    };

    return AxesObj;
})();
let Module = require("./wasm.js");

module.exports = { wpd: wpd };
