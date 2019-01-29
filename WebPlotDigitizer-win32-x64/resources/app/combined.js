/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.initApp = function() {// This is run when the page loads.

    wpd.browserInfo.checkBrowser();
    wpd.layoutManager.initialLayout();
    wpd.imageManager.loadFromURL('start.png');
    wpd.log();
    document.getElementById('loadingCurtain').style.display = 'none';

};

document.addEventListener("DOMContentLoaded", wpd.initApp, true);

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.AutoDetector = (function () {
    var obj = function () {

        this.fgColor = [0, 0, 200];
        this.bgColor = [255, 255, 255];
        this.mask = null;
        this.gridMask = { xmin: null, xmax: null, ymin: null, ymax: null, pixels: [] };
        this.gridLineColor = [255, 255, 255];
        this.gridColorDistance = 10;
        this.gridData = null;
        this.colorDetectionMode = 'fg';
        this.colorDistance = 120;
        this.algorithm = null;
        this.binaryData = null;
        this.gridBinaryData = null;
        this.imageData = null;
        this.imageWidth = 0;
        this.imageHeight = 0;
        this.gridBackgroundMode = true;
        this.topColors = null;
        this.backupImageData = null;
        
        this.reset = function () {
            this.mask = null;
            this.binaryData = null;
            this.imageData = null;
            this.gridData = null;
            this.gridMask = { xmin: null, xmax: null, ymin: null, ymax: null, pixels: [] };
        };

        this.generateBinaryDataFromMask = function () {

            var maski, img_index, dist, ir, ig, ib, ia,
                ref_color = this.colorDetectionMode === 'fg' ? this.fgColor : this.bgColor;

            for(maski = 0; maski < this.mask.length; maski++) {
                img_index = this.mask[maski];
                ir = this.imageData.data[img_index*4];
                ig = this.imageData.data[img_index*4+1];
                ib = this.imageData.data[img_index*4+2];
                ia = this.imageData.data[img_index*4+3];
                if(ia === 0) { // for transparent images, assume white RGB
                    ir = 255; ig = 255; ib = 255;
                }

                dist = wpd.dist3d(ir, ig, ib, ref_color[0], ref_color[1], ref_color[2]);

                if(this.colorDetectionMode === 'fg') {
                    if(dist <= this.colorDistance) {
                        this.binaryData[img_index] = true;
                    }
                } else {
                    if(dist >= this.colorDistance) {
                        this.binaryData[img_index] = true;
                    }
                }
            }
        };

        this.generateBinaryDataUsingFullImage = function () {
            
            var dist, img_index,
                ref_color = this.colorDetectionMode === 'fg' ? this.fgColor : this.bgColor,
                ir,ig,ib,ia; 

            for(img_index = 0; img_index < this.imageData.data.length/4; img_index++) {
                ir = this.imageData.data[img_index*4];
                ig = this.imageData.data[img_index*4+1];
                ib = this.imageData.data[img_index*4+2];
                ia = this.imageData.data[img_index*4+3];

                // If image is transparent, then assume white background.
                if(ia === 0) {
                    ir = 255; ig = 255; ib = 255;
                }
                
                dist = wpd.dist3d(ir, ig, ib, ref_color[0], ref_color[1], ref_color[2]);           

                if(this.colorDetectionMode === 'fg') {
                    if(dist <= this.colorDistance) {
                        this.binaryData[img_index] = true;
                    }
                } else {
                    if(dist >= this.colorDistance) {
                        this.binaryData[img_index] = true;
                    }
                }
            }
        };

        this.generateBinaryData = function () {

            this.binaryData = [];

            if(this.imageData == null) {
                this.imageHeight = 0;
                this.imageWidth = 0;
                return;
            }

            this.imageHeight = this.imageData.height;
            this.imageWidth = this.imageData.width;

            if (this.mask == null || this.mask.length === 0) {
                this.generateBinaryDataUsingFullImage();
            } else {
                this.generateBinaryDataFromMask();
            }
        };

        this.generateGridBinaryData = function () {
            this.gridBinaryData = [];

            if (this.imageData == null) {
                this.imageWidth = 0;
                this.imageHeight = 0;
                return;
            }
            
            this.imageWidth = this.imageData.width;
            this.imageHeight = this.imageData.height;

            var xi, yi, dist, img_index, maski, ir, ig, ib, ia;

            if (this.gridMask.pixels == null || this.gridMask.pixels.length === 0) {
                // Use full image if no mask is present
                maski = 0;
                this.gridMask.pixels = [];
                for(yi = 0; yi < this.imageHeight; yi++) {
                    for(xi = 0; xi < this.imageWidth; xi++) {
                        img_index = yi*this.imageWidth + xi;
                        ir = this.imageData.data[img_index*4];
                        ig = this.imageData.data[img_index*4+1];
                        ib = this.imageData.data[img_index*4+2];
                        ia = this.imageData.data[img_index*4+3];

                        if(ia === 0) { // assume white color when image is transparent
                            ir = 255; ig = 255; ib = 255;
                        }

                        dist = wpd.dist3d(this.gridLineColor[0], this.gridLineColor[1], this.gridLineColor[2], ir, ig, ib);
                        
                        if(this.gridBackgroundMode) {
                            if (dist > this.gridColorDistance) {
                                this.gridBinaryData[img_index] = true;
                                this.gridMask.pixels[maski] = img_index;
                                maski++;
                            }
                        } else {
                            if (dist < this.gridColorDistance) {
                                this.gridBinaryData[img_index] = true;
                                this.gridMask.pixels[maski] = img_index;
                                maski++;
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

            for (maski = 0; maski < this.gridMask.pixels.length; maski++) {
                img_index = this.gridMask.pixels[maski];
                ir = this.imageData.data[img_index*4];
                ig = this.imageData.data[img_index*4+1];
                ib = this.imageData.data[img_index*4+2];
                ia = this.imageData.data[img_index*4+3];

                dist = wpd.dist3d(this.gridLineColor[0], this.gridLineColor[1], this.gridLineColor[2], ir, ig, ib);

                if(this.gridBackgroundMode) {
                    if (dist > this.gridColorDistance) {
                        this.gridBinaryData[img_index] = true;
                    }
                } else {
                    if (dist < this.gridColorDistance) {
                        this.gridBinaryData[img_index] = true;
                    }
                }
            }
        };

    };
    return obj;
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
wpd.Calibration = (function () {

    var Calib = function(dim) {
        // Pixel information
        var px = [],
            py = [],

            // Data information
            dimensions = dim == null ? 2 : dim,
            dp = [],
            selections = [];

        this.labels = [];
        this.labelPositions = [];
        this.maxPointCount = 0;

        this.getCount = function () { return px.length; };
        this.getDimensions = function() { return dimensions; };
        this.addPoint = function(pxi, pyi, dxi, dyi, dzi) {
            var plen = px.length, dlen = dp.length;
            px[plen] = pxi;
            py[plen] = pyi;
            dp[dlen] = dxi; dp[dlen+1] = dyi;
            if(dimensions === 3) {
                dp[dlen+2] = dzi;
            }
        };

        this.getPoint = function(index) {
            if(index < 0 || index >= px.length) return null;

            return {
                px: px[index],
                py: py[index],
                dx: dp[dimensions*index],
                dy: dp[dimensions*index+1],
                dz: dimensions === 2 ? null : dp[dimensions*index + 2]
            };
        };

        this.changePointPx = function(index, npx, npy) {
            if(index < 0 || index >= px.length) {
                return;
            }
            px[index] = npx;
            py[index] = npy;
        };

        this.setDataAt = function(index, dxi, dyi, dzi) {
            if(index < 0 || index >= px.length) return;
            dp[dimensions*index] = dxi;
            dp[dimensions*index + 1] = dyi;
            if(dimensions === 3) {
                dp[dimensions*index + 2] = dzi;
            }
        };

        this.findNearestPoint = function(x, y, threshold) {
            threshold = (threshold == null) ? 50 : parseFloat(threshold);
            var minDist, minIndex = -1, 
                i, dist;
            for(i = 0; i < px.length; i++) {
                dist = Math.sqrt((x - px[i])*(x - px[i]) + (y - py[i])*(y - py[i]));
                if((minIndex < 0 && dist <= threshold) || (minIndex >= 0 && dist < minDist)) {
                    minIndex = i;
                    minDist = dist;
                }
            }
            return minIndex;
        };


        this.selectPoint = function(index) {
            if(selections.indexOf(index) < 0) {
                selections[selections.length] = index;
            }
        };

        this.selectNearestPoint = function (x, y, threshold) {
            var minIndex = this.findNearestPoint(x, y, threshold);
            if (minIndex >= 0) {
                this.selectPoint(minIndex);
            }
        };

        this.getSelectedPoints = function () {
            return selections;
        };

        this.unselectAll = function() {
            selections = [];
        };

        this.isPointSelected = function(index) {
            return selections.indexOf(index) >= 0;
        };

        this.dump = function() {
            console.log(px);
            console.log(py);
            console.log(dp);
        };
    };
    return Calib;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.ColorGroup = (function () {
    var CGroup = function(tolerance) {
        
        var totalPixelCount = 0,
            averageColor = {r: 0, g: 0, b: 0};
        
        tolerance = tolerance == null ? 100 : tolerance;

        this.getPixelCount = function () {
            return totalPixelCount;
        };

        this.getAverageColor = function () {
            return averageColor;
        };

        this.isColorInGroup = function (r, g, b) {
            if (totalPixelCount === 0) {
                return true;
            }

            var dist = (averageColor.r - r)*(averageColor.r - r) + (averageColor.g - g)*(averageColor.g - g) + (averageColor.b - b)*(averageColor.b - b);

            return (dist <= tolerance*tolerance);
        };

        this.addPixel = function (r, g, b) {
            averageColor.r = (averageColor.r*totalPixelCount + r)/(totalPixelCount + 1.0);
            averageColor.g = (averageColor.g*totalPixelCount + g)/(totalPixelCount + 1.0);
            averageColor.b = (averageColor.b*totalPixelCount + b)/(totalPixelCount + 1.0);
            totalPixelCount = totalPixelCount + 1;
        };

    };
    return CGroup;
})();



wpd.colorAnalyzer = (function () {

    function getTopColors (imageData) {

        var colorGroupColl = [], // collection of color groups
            pixi,
            r, g, b, a,
            groupi,
            groupMatched,
            rtnVal = [],
            avColor,
            tolerance = 120;

        colorGroupColl[0] = new wpd.ColorGroup(tolerance); // initial group
        
        for (pixi = 0; pixi < imageData.data.length; pixi += 4) {
            r = imageData.data[pixi];
            g = imageData.data[pixi + 1];
            b = imageData.data[pixi + 2];
            a = imageData.data[pixi + 3];
            if(a === 0) {
                r = 255; g = 255; b = 255;
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
            if ( a.getPixelCount() > b.getPixelCount() ) {
                return -1;
            } else if (a.getPixelCount() < b.getPixelCount() ) {
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
                percentage: 100.0*colorGroupColl[groupi].getPixelCount()/(0.25*imageData.data.length)
            };
        }

        return rtnVal;
    }

    return {
        getTopColors: getTopColors
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
        if(index < this._connections.length) {
            return this._connections[index];
        }   
    }

    replaceConnectionAt(index, plist) {
        if(index < this._connections.length) {
            this._connections[index] = plist;
        }
    }

    deleteConnectionAt(index) {
        if(index < this._connections.length) {
            this._connections.splice(index, 1);
        }
    }

    connectionCount() {
        return this._connections.length;
    }

    findNearestPointAndConnection(x, y) {
        var minConnIndex = -1,
            minPointIndex = -1,
            minDist, dist,
            ci, pi;

        for (ci = 0; ci < this._connections.length; ci++) {
            for (pi = 0; pi < this._connections[ci].length; pi+=2) {
                dist = (this._connections[ci][pi] - x)*(this._connections[ci][pi] - x) + (this._connections[ci][pi+1] - y)*(this._connections[ci][pi+1] - y);
                if (minPointIndex === -1 || dist < minDist) {
                    minConnIndex = ci;
                    minPointIndex = pi/2;
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
        if (this._selectedPointIndex === pointIndex && this._selectedConnectionIndex === connectionIndex) {
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
        this._connections[connectionIndex][pointIndex*2] = x;
        this._connections[connectionIndex][pointIndex*2 + 1] = y;
    }

    getPointAt(connectionIndex, pointIndex) {
        return {
            x: this._connections[connectionIndex][pointIndex*2],
            y: this._connections[connectionIndex][pointIndex*2 + 1]
        };
    }
};

wpd.DistanceMeasurement = class extends wpd.ConnectedPoints {
    constructor() {
        super(2);
    }

    getDistance(index) {
        if(index < this._connections.length && this._connectivity === 2) {
            var dist = Math.sqrt((this._connections[index][0] - this._connections[index][2])*(this._connections[index][0] - this._connections[index][2])
                + (this._connections[index][1] - this._connections[index][3])*(this._connections[index][1] - this._connections[index][3]));
            return dist; // this is in pixels!
        }
    }
};

wpd.AngleMeasurement = class extends wpd.ConnectedPoints {
    constructor() {
        super(3);
    }

    getAngle(index) {
        if(index < this._connections.length && this._connectivity === 3) {

            var ang1 = wpd.taninverse(-(this._connections[index][5] - this._connections[index][3]), this._connections[index][4] - this._connections[index][2]),
                ang2 = wpd.taninverse(-(this._connections[index][1] - this._connections[index][3]), this._connections[index][0] - this._connections[index][2]),
                ang = ang1 - ang2;

            ang = 180.0*ang/Math.PI;
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
        if(index < this._connections.length) {
            if(this._connections[index].length >= 4) {
                let totalArea = 0.0;
                for(let pi = 0; pi < this._connections[index].length; pi += 2) {

                    let px1 = this._connections[index][pi];
                    let py1 = this._connections[index][pi+1];
    
                    let px2 = 0.0;
                    let py2 = 0.0;
                    if(pi <= this._connections[index].length-4) {
                        px2 = this._connections[index][pi+2];
                        py2 = this._connections[index][pi+3];
                    } else {
                        px2 = this._connections[index][0];
                        py2 = this._connections[index][1];
                    }
                    totalArea += (px1*py2 - px2*py1);
                }
                totalArea /= 2.0;
                return totalArea;
            }
        }
        return 0;
    }

    getPerimeter(index) {
        if(index < this._connections.length) {
            let totalDist = 0.0;
            let px_prev = 0.0;
            let py_prev = 0.0;
            for(let pi = 0; pi < this._connections[index].length; pi += 2) {
                let px = this._connections[index][pi];
                let py = this._connections[index][pi+1];
                if(pi >= 2) {
                    totalDist += Math.sqrt((px-px_prev)*(px-px_prev) + (py-py_prev)*(py-py_prev));
                }
                // include the connection between the last and first point in the set (only when >= 2 sides in the polygon):
                if(pi == this._connections[index].length - 2 && pi >= 4) {
                    let px0 = this._connections[index][0];
                    let py0 = this._connections[index][1];
                    totalDist += Math.sqrt((px-px0)*(px-px0) + (py-py0)*(py-py0));
                }
                px_prev = px;
                py_prev = py;
            }
            return totalDist;
        }
    }
};/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

        if(axes instanceof wpd.BarAxes) {
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
            dataPt,
            transformedDataPt,
            lab;

        for (rowi = 0; rowi < dataSeries.getCount(); rowi++) {
            
            dataPt = dataSeries.getPixel(rowi);
            transformedDataPt = axes.pixelToData(dataPt.x, dataPt.y);
            
            rawData[rowi] = [];
            
            // metaData[0] should be the label:
            if(dataPt.metadata == null) {
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
            rowi,
            coli,
            pt,
            ptData,
            metadi,
            hasMetadata = dataSeries.hasMetadata(),
            metaKeys = dataSeries.getMetadataKeys(),
            metaKeyCount = hasMetadata === true ? metaKeys.length : 0,
            ptmetadata;
        
        for(rowi = 0; rowi < dataSeries.getCount(); rowi++) {

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
        if(hasMetadata) {
            fields = fields.concat(metaKeys);
        }

        for(coli = 0; coli < fields.length; coli++) {
            if(coli < axes.getDimensions()) {
                connectivityFieldIndices[coli] = coli;
                if(axes.isDate != null && axes.isDate(coli)) {
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
            for(conni = 0; conni < _ms.connectionCount(); conni++) {
                rawData[conni] = [];
                rawData[conni][0] = 'Dist' + conni;
                if(isMap) {
                    rawData[conni][1] = axes.pixelToDataDistance(_ms.getDistance(conni));
                } else {
                    rawData[conni][1] = _ms.getDistance(conni);
                }
            }
            
            fields = ['Label', 'Distance'];
            isFieldSortable = [false, true];

        } else if (_ms instanceof wpd.AngleMeasurement) {
            
            for(conni = 0; conni < _ms.connectionCount(); conni++) {
                rawData[conni] = [];
                rawData[conni][0] = 'Theta'+ conni;
                rawData[conni][1] = _ms.getAngle(conni);
            }

            fields = ['Label', 'Angle'];
            isFieldSortable = [false, true];

        } else if (_ms instanceof wpd.AreaMeasurement) {
            
            for(conni = 0; conni < _ms.connectionCount(); conni++) {
                rawData[conni] = [];
                rawData[conni][0] = 'Poly'+ conni;
                if(isMap) {
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
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
wpd.Dataset = (function () {
    return function (dim) {
        var dataPoints = [],
            connections = [],
            selections = [],
            hasMetadata = false,
            mkeys = [];

        this.name = "Default Dataset";

        this.variableNames = ['x', 'y'];

        this.hasMetadata = function () {
            return hasMetadata;
        };

        this.setMetadataKeys = function (metakeys) {
            mkeys = metakeys;
        };

        this.getMetadataKeys = function () {
            return mkeys;
        };

        this.addPixel = function(pxi, pyi, mdata) {
            var dlen = dataPoints.length;
            dataPoints[dlen] = {x: pxi, y: pyi, metadata: mdata};
            if (mdata != null) {
                hasMetadata = true;
            }
        };

        this.getPixel = function(index) {
            return dataPoints[index];
        };

        this.setPixelAt = function (index, pxi, pyi) {
            if(index < dataPoints.length) {
                dataPoints[index].x = pxi;
                dataPoints[index].y = pyi;
            }
        };

        this.setMetadataAt = function (index, mdata) {
            if (index < dataPoints.length) {
                dataPoints[index].metadata = mdata;
            }
        };

        this.insertPixel = function(index, pxi, pyi, mdata) {
            dataPoints.splice(index, 0, {x: pxi, y: pyi, metadata: mdata});
        };

        this.removePixelAtIndex = function(index) {
            if(index < dataPoints.length) {
                dataPoints.splice(index, 1);
            }
        };

        this.removeLastPixel = function() {
            var pIndex = dataPoints.length - 1;
            this.removePixelAtIndex(pIndex);
        };

        this.findNearestPixel = function(x, y, threshold) {
            threshold = (threshold == null) ? 50 : parseFloat(threshold);
            var minDist, minIndex = -1, 
                i, dist;
            for(i = 0; i < dataPoints.length; i++) {
                dist = Math.sqrt((x - dataPoints[i].x)*(x - dataPoints[i].x) + (y - dataPoints[i].y)*(y - dataPoints[i].y));
                if((minIndex < 0 && dist <= threshold) || (minIndex >= 0 && dist < minDist)) {
                    minIndex = i;
                    minDist = dist;
                }
            }
            return minIndex;
        };

        this.removeNearestPixel = function(x, y, threshold) {
            var minIndex = this.findNearestPixel(x, y, threshold);
            if(minIndex >= 0) {
                this.removePixelAtIndex(minIndex);
            }
        };

        this.clearAll = function() { 
            dataPoints = []; 
            hasMetadata = false; 
            mkeys = []; 
        };

        this.getCount = function() { return dataPoints.length; };
 
        this.selectPixel = function(index) {
            if(selections.indexOf(index) >= 0) {
                return;
            }
            selections[selections.length] = index;
        };

        this.unselectAll = function () {
            selections = [];
        };

        this.selectNearestPixel = function(x, y, threshold) {
            var minIndex = this.findNearestPixel(x, y, threshold);
            if(minIndex >= 0) {
                this.selectPixel(minIndex);
            }
            return minIndex;
        };

        this.selectNextPixel = function() {
            for(var i = 0; i < selections.length; i++) {
                selections[i] = (selections[i] + 1) % dataPoints.length;
            }
        };

        this.selectPreviousPixel = function() {
            var i, newIndex;
            for(i = 0; i < selections.length; i++) {
                newIndex = selections[i];
                if(newIndex === 0) {
                    newIndex = dataPoints.length - 1;
                } else {
                    newIndex = newIndex - 1;
                }
                selections[i] = newIndex;
            }
        };

        this.getSelectedPixels = function () {
            return selections;
        };

    };
})();


/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.dateConverter = (function () {

    function parse(input) {
        if(input == null) { return null; }

        if(typeof input === "string") {
            if(input.indexOf('/') < 0 && input.indexOf(':') < 0) { return null; }
        }

        return toJD(input);
    }

    function toJD(dateString) {
        dateString = dateString.toString();
	    var dateParts = dateString.split(/[/ :]/),
            hasDatePart = dateString.indexOf('/') >= 0,
			year,
			month,
			date,
            hour,
            min,
            sec,
            timeIdxOffset,
            today,
			tempDate,
			rtnValue;

        if(dateParts.length <= 0 || dateParts.length > 6) {
            return null;
        }

        if(hasDatePart){
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
        min = parseInt(dateParts[timeIdxOffset+1] === undefined ? 0 : dateParts[timeIdxOffset+1], 10);
        sec = parseInt(dateParts[timeIdxOffset+2] === undefined ? 0 : dateParts[timeIdxOffset+2], 10);

        if(isNaN(year) || isNaN(month) || isNaN(date) || isNaN(hour) || isNaN(min) || isNaN(sec)) {
            return null;
        }

        if(month > 12 || month < 1) {
            return null;
        }

        if(date > 31 || date < 1) {
            return null;
        }

        if(hour > 23 || hour < 0) {
            return null;
        }

        if(min > 59 || min < 0) {
            return null;
        }

        if(sec > 59 || sec < 0) {
            return null;
        }


        // Temporary till I figure out julian dates:
        tempDate = new Date();
        tempDate.setUTCFullYear(year);
        tempDate.setUTCMonth(month-1);
        tempDate.setUTCDate(date);
        tempDate.setUTCHours(hour, min, sec);
        rtnValue = parseFloat(Date.parse(tempDate));
        if(!isNaN(rtnValue)) {
            return rtnValue;
        }
        return null;
    }

    function formatDateNumber(dateNumber, formatString) {
        // round to smallest time unit
        var coeff = 1;

        if(formatString.indexOf('s') >= 0)
            coeff = 1000;
        else if(formatString.indexOf('i') >= 0)
            coeff = 1000 * 60;
        else if(formatString.indexOf('h') >= 0)
            coeff = 1000 * 60 * 60;
        else if(formatString.indexOf('d') >= 0)
            coeff = 1000 * 60 * 60 * 24;
        else if(formatString.indexOf('m') >= 0)
            coeff = 1000 * 60 * 60 * 24 * 365.2425 / 12;
        else if(formatString.indexOf('y') >= 0)
            coeff = 1000 * 60 * 60 * 24 * 365.2425;

        return formatDate(new Date(Math.round(new Date(dateNumber).getTime() / coeff) * coeff), formatString); 
    }

    function formatDate(dateObject, formatString) {

        var longMonths = [],
            shortMonths = [],
            tmpDate = new Date();

        for(var i = 0; i < 12; i++) {
            tmpDate.setUTCMonth(i);
            longMonths.push(tmpDate.toLocaleString(undefined, {month:"long"}));
            shortMonths.push(tmpDate.toLocaleString(undefined, {month:"short"}));
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

        var twoDigitYear = dateObject.getUTCFullYear()%100;
        twoDigitYear = twoDigitYear < 10 ? '0' + twoDigitYear : twoDigitYear;

        outputString = outputString.replace("yy", twoDigitYear);

        outputString = outputString.replace("mmmm", longMonths[dateObject.getUTCMonth()]);
        outputString = outputString.replace("mmm", shortMonths[dateObject.getUTCMonth()]);
        outputString = outputString.replace("mm", ("0" + (dateObject.getUTCMonth()+1)).slice(-2));
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
        
        if(dateParts.length >= 1) {
            formatString = hasDatePart ? 'yyyy' : 'hh';
        }

        if(dateParts.length >= 2) {
            formatString += hasDatePart ? '/mm' : ':ii';
        }

        if(dateParts.length >= 3) {
            formatString += hasDatePart ? '/dd' : ':ss';
        }

        if(dateParts.length >= 4) {
            formatString += ' hh';
        }

        if(dateParts.length >= 5) {
            formatString += ':ii';
        }

        if(dateParts.length === 6) {
            formatString += ':ss';
        }

        return formatString;
    }

    return {
        parse: parse,
        getFormatString: getFormatString,
        formatDateNumber: formatDateNumber
    };
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.gridDetectionCore = (function () {

    var hasHorizontal, hasVertical, xFrac = 0.1, yFrac = 0.1;

    function run(autoDetector) {
        var gridData = [],
            xi,
            yi,            
            xmin = autoDetector.gridMask.xmin,
            xmax = autoDetector.gridMask.xmax,
            ymin = autoDetector.gridMask.ymin,
            ymax = autoDetector.gridMask.ymax,
            dw = autoDetector.imageWidth,
            dh = autoDetector.imageHeight,
            linePixCount;
        
        if (hasVertical) {

            for(xi = xmin; xi <= xmax; xi++) {
                linePixCount = 0;
                for(yi = ymin; yi < ymax; yi++) {
                    if(autoDetector.gridBinaryData[yi*dw + xi] === true) {
                        linePixCount++;
                    }
                }
                if(linePixCount > yFrac*(ymax-ymin)) {
                    for(yi = ymin; yi < ymax; yi++) {
                        gridData[yi*dw + xi] = true;
                    }
                }
            }
        }

        if (hasHorizontal) {

            for(yi = ymin; yi <= ymax; yi++) {
                linePixCount = 0;
                for(xi = xmin; xi <= xmax; xi++) {
                    if(autoDetector.gridBinaryData[yi*dw + xi] === true) {
                        linePixCount++;
                    }
                }
                if(linePixCount > xFrac*(xmax-xmin)) {
                    for(xi = xmin; xi <= xmax; xi++) {
                        gridData[yi*dw + xi] = true;
                    }
                }
            }
             
        }

        return gridData;
    }

    function setHorizontalParameters(has_horizontal, y_perc) {
        hasHorizontal = has_horizontal;
        yFrac = Math.abs(parseFloat(y_perc)/100.0);
    }

    function setVerticalParameters(has_vertical, x_perc) {
        hasVertical = has_vertical;
        xFrac = Math.abs(parseFloat(x_perc)/100.0);
    }

    return {
        run: run,
        setHorizontalParameters: setHorizontalParameters,
        setVerticalParameters: setVerticalParameters
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.InputParser = (function () {
    var Parser = function () {
        this.parse = function (input) {
            this.isValid = false;
            this.isDate = false;
            this.formatting = null;

            if(input == null) {
                return null;
            }

            if(typeof input === "string") {
                input = input.trim();

                if(input.indexOf('^') >= 0) {
                    return null;
                }
            }

            var parsedDate = wpd.dateConverter.parse(input);
            if(parsedDate != null) {
                this.isValid = true;
                this.isDate = true;
                this.formatting = wpd.dateConverter.getFormatString(input);
                return parsedDate;
            }

            var parsedFloat = parseFloat(input);
            if(!isNaN(parsedFloat)) {
                this.isValid = true;
                return parsedFloat;
            }

            return null;
        };

        this.isValid = false;

        this.isDate = false;

        this.formatting = null;
    };
    return Parser;
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.taninverse = function(y,x) {
    var inv_ans;
    if (y>0) // I & II
    inv_ans = Math.atan2(y,x);
    else if (y<=0) // III & IV
    inv_ans = Math.atan2(y,x) + 2*Math.PI;

    if(inv_ans >= 2*Math.PI)
    inv_ans = 0.0;
    return inv_ans;
};

wpd.sqDist2d = function (x1, y1, x2, y2) {
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
};

wpd.sqDist3d = function (x1, y1, z1, x2, y2, z2) {
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) + (z1 - z2)*(z1 - z2);
};

wpd.dist2d = function (x1, y1, x2, y2) {
    return Math.sqrt(wpd.sqDist2d(x1, y1, x2, y2));
};

wpd.dist3d = function (x1, y1, z1, x2, y2, z2) {
    return Math.sqrt(wpd.sqDist3d(x1, y1, z1, x2, y2, z2));
};

wpd.mat = (function () {
    
    function det2x2(m) {
        return m[0]*m[3] - m[1]*m[2];
    }

    function inv2x2(m) {
        var det = det2x2(m);
        return [m[3]/det, -m[1]/det, -m[2]/det, m[0]/det];
    }

    function mult2x2(m1, m2) {
        return [
                    m1[0]*m2[0] + m1[1]*m2[2], 
                    m1[0]*m2[1] + m1[1]*m2[3], 
                    m1[2]*m2[0] + m1[3]*m2[2], 
                    m1[2]*m2[1] + m1[3]*m2[3]
               ];
    }

    function mult2x2Vec(m, v) {
        return [m[0]*v[0] + m[1]*v[1], m[2]*v[0] + m[3]*v[1]];
    }

    function multVec2x2(v, m) {
        return [m[0]*v[0] + m[2]*v[1], m[1]*v[0] + m[3]*v[1]];
    }

    return {
        det2x2: det2x2,
        inv2x2: inv2x2,
        mult2x2: mult2x2,
        mult2x2Vec: mult2x2Vec,
        multVec2x2: multVec2x2
    };
})();

wpd.cspline = function(x, y) {
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
    if(len < 3) {
        return null;
    }

    b[0] = 2.0;
    l[0] = 3.0*(y[1] - y[0]);
    for(i = 1; i < len-1; ++i) {
        b[i] = 4.0 - 1.0/b[i-1];
        l[i] = 3.0*(y[i+1] - y[i-1]) - l[i-1]/b[i-1];
    }

    b[len-1] = 2.0 - 1.0/b[len-2];
    l[len-1] = 3.0*(y[len-1] - y[len-2]) - l[len-2]/b[len-1];

    i = len-1;
    cs.d[i] = l[i]/b[i];
    while(i > 0) {
        --i;
        cs.d[i] = (l[i] - cs.d[i+1])/b[i];
    }

    return cs;
}

wpd.cspline_interp = function(cs, x) {
    var i = 0, t, a, b, c, d;
    if ( x >= cs.x[cs.len-1] || x < cs.x[0] ) {
        return null;
    }

    /* linear search to find the index */
    while(x > cs.x[i]) { i++; }

    i = (i > 0) ? i - 1: 0;
    t = (x - cs.x[i])/(cs.x[i+1] - cs.x[i]);
    a = cs.y[i];
    b = cs.d[i];
    c = 3.0*(cs.y[i+1] - cs.y[i]) - 2.0*cs.d[i] - cs.d[i+1];
    d = 2.0*(cs.y[i] - cs.y[i+1]) + cs.d[i] + cs.d[i+1];
    return a + b*t + c*t*t + d*t*t*t;
}

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
        this._autoDetector = null;
        this._topColors = null;
        this._axesColl = [];        
        this._datasetColl = [];
        this._measurementColl = [];        
        this._objectAxesMap = new Map();
    }

    reset() {        
        this._axesColl = [];        
        this._datasetColl = [];
        this._measurementColl = [];        
        this._objectAxesMap = new Map();  
    }

    addAxes(ax) {
        this._axesColl.push(ax);
        if(this._axesColl.length === 1 && this._datasetColl.length === 0) {       
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
        if(axIdx >= 0) {
            this._axesColl.splice(axIdx, 1);

            // take care of dependents
            this._objectAxesMap.forEach((val, key, map) => {
                if(val === ax) {
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
        if(axCount > 0) {
            let axes = this._axesColl[axCount-1];
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
        if(ms instanceof wpd.DistanceMeasurement && this._axesColl.length > 0) {
            for(let aIdx = 0; aIdx < this._axesColl.length; aIdx++) {
                if(this._axesColl[aIdx] instanceof wpd.MapAxes || this._axesColl[aIdx] instanceof wpd.ImageAxes) {
                    this.setAxesForMeasurement(ms, this._axesColl[aIdx]);
                    break;
                }
            }            
        }
    }

    getMeasurementsByType(mtype) {
        let mcoll = [];
        this._measurementColl.forEach(m => {
            if(m instanceof mtype) {
                mcoll.push(m);
            }
        });
        return mcoll;
    }

    deleteMeasurement(ms) {
        var msIdx = this._measurementColl.indexOf(ms);
        if(msIdx >= 0) {
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

    getAxesForDataset(ds) {
        return this._objectAxesMap.get(ds);
    }

    getAxesForMeasurement(ms) {
        return this._objectAxesMap.get(ms);
    }

    deleteDataset(ds) {
        var dsIdx = this._datasetColl.indexOf(ds);
        if(dsIdx >= 0) {
            this._datasetColl.splice(dsIdx, 1);
            this._objectAxesMap.delete(ds);
        }
    }
        
    getAutoDetector() {
        if(this._autoDetector == null) {
            this._autoDetector = new wpd.AutoDetector();
        }
        return this._autoDetector;
    }

    _deserializePreVersion4(data) {
        // read axes info
        if(data.axesType == null) {
            return true;
        }
        if(data.axesType !== "ImageAxes" && (data.calibration == null || data.axesParameters == null)) {
            return false;
        }

        // get calibration points
        let calibration = null;
        if(data.axesType !== "ImageAxes") {            
            if(data.axesType === "TernaryAxes") {
                calibration = new wpd.Calibration(3);
            } else {
                calibration = new wpd.Calibration(2);
            }
            for(let calIdx = 0; calIdx < data.calibration.length; calIdx++) {
                calibration.addPoint(
                    data.calibration[calIdx].px,
                    data.calibration[calIdx].py,
                    data.calibration[calIdx].dx,
                    data.calibration[calIdx].dy,
                    data.calibration[calIdx].dz
                );
            }
        }

        let axes = null;
        if(data.axesType === "XYAxes") {
            axes = new wpd.XYAxes();
            calibration.labels = ['X1', 'X2', 'Y1', 'Y2'];
            calibration.labelPositions = ['N', 'N', 'E', 'E'];
            calibration.maxPointCount = 4; 
            axes.calibrate(calibration, data.axesParameters.isLogX, data.axesParameters.isLogY);
        } else if(data.axesType === "BarAxes") {
            axes = new wpd.BarAxes();
            calibration.labels = ['P1', 'P2'];
            calibration.labelPositions = ['S', 'S'];
            calibration.maxPointCount = 2;
            axes.calibrate(calibration, data.axesParameters.isLog);
        } else if(data.axesType === "PolarAxes") {
            axes = new wpd.PolarAxes();
            calibration.labels = ['Origin', 'P1', 'P2'];
            calibration.labelPositions = ['E', 'S', 'S'];
            calibration.maxPointCount = 3;
            axes.calibrate(calibration, data.axesParameters.isDegrees, data.axesParameters.isClockwise);
        } else if(data.axesType === "TernaryAxes") {
            axes = new wpd.TernaryAxes();
            calibration.labels = ['A', 'B', 'C'];
            calibration.labelPositions = ['S', 'S', 'E'];
            calibration.maxPointCount = 3;
            axes.calibrate(calibration, data.axesParameters.isRange100, data.axesParameters.isNormalOrientation);
        } else if(data.axesType === "MapAxes") {
            axes = new wpd.MapAxes();
            calibration.labels = ['P1', 'P2'];
            calibration.labelPositions = ['S', 'S'];
            calibration.maxPointCount = 2;
            axes.calibrate(calibration, data.axesParameters.scaleLength, data.axesParameters.unitString);
        } else if(data.axesType === "ImageAxes") {
            axes = new wpd.ImageAxes();            
        }

        if(axes != null) {
            this._axesColl.push(axes);
        }
        
        // datasets
        if(data.dataSeries != null) {
            for(let dsIdx = 0; dsIdx < data.dataSeries.length; dsIdx++) {
                const dsData = data.dataSeries[dsIdx];
                let ds = new wpd.Dataset();
                ds.name = dsData.name;
                if(dsData.metadataKeys != null) {
                    ds.setMetadataKeys(dsData.metadataKeys);
                }
                for(let pxIdx = 0; pxIdx < dsData.data.length; pxIdx++) {
                    ds.addPixel(dsData.data[pxIdx].x, dsData.data[pxIdx].y, dsData.data[pxIdx].metadata);
                }
                this.addDataset(ds);
                this.setAxesForDataset(ds, axes);
            }
        }

        // measurements

        // distances
        if(data.distanceMeasurementData != null) {
            let dist = new wpd.DistanceMeasurement();
            for(let cIdx = 0; cIdx < data.distanceMeasurementData.length; cIdx++) {
                dist.addConnection(data.distanceMeasurementData[cIdx]);
            }
            this.addMeasurement(dist);
            if(axes instanceof wpd.MapAxes) {
                this.setAxesForMeasurement(dist, axes);
            }
        }        

        // angles
        if(data.angleMeasurementData != null) {
            let ang = new wpd.AngleMeasurement();
            for(let cIdx = 0; cIdx < data.angleMeasurementData.length; cIdx++) {
                ang.addConnection(data.angleMeasurementData[cIdx]);
            }
            this.addMeasurement(ang);            
        }

        return true;
    }

    _deserializeVersion4(data) {
        // axes data
        if(data.axesColl != null) {
            for(let axIdx = 0; axIdx < data.axesColl.length; axIdx++) {
                const axData = data.axesColl[axIdx];

                // get calibration
                let calibration = null;
                if(axData.type !== "ImageAxes") {
                    if(axData.type === "TernaryAxes") {
                        calibration = new wpd.Calibration(3);
                    } else {
                        calibration = new wpd.Calibration(2);
                    }
                    for(let calIdx = 0; calIdx < axData.calibrationPoints.length; calIdx++) {
                        calibration.addPoint(
                            axData.calibrationPoints[calIdx].px,
                            axData.calibrationPoints[calIdx].py,
                            axData.calibrationPoints[calIdx].dx,
                            axData.calibrationPoints[calIdx].dy,
                            axData.calibrationPoints[calIdx].dz
                        );
                    }
                }

                // create axes
                let axes = null;
                if(axData.type === "XYAxes") {
                    axes = new wpd.XYAxes();
                    calibration.labels = ['X1', 'X2', 'Y1', 'Y2'];
                    calibration.labelPositions = ['N', 'N', 'E', 'E'];
                    calibration.maxPointCount = 4;
                    axes.calibrate(calibration, axData.isLogX, axData.isLogY);
                } else if(axData.type === "BarAxes") {
                    axes = new wpd.BarAxes();
                    calibration.labels = ['P1', 'P2'];
                    calibration.labelPositions = ['S', 'S'];
                    calibration.maxPointCount = 2;
                    axes.calibrate(calibration, axData.isLog, axData.isRotated == null ? false : axData.isRotated);
                } else if(axData.type === "PolarAxes") {
                    axes = new wpd.PolarAxes();
                    calibration.labels = ['Origin', 'P1', 'P2'];
                    calibration.labelPositions = ['E', 'S', 'S'];
                    calibration.maxPointCount = 3;
                    axes.calibrate(calibration, axData.isDegrees, axData.isClockwise, axData.isLog);
                } else if(axData.type === "TernaryAxes") {
                    axes = new wpd.TernaryAxes();
                    calibration.labels = ['A', 'B', 'C'];
                    calibration.labelPositions = ['S', 'S', 'E'];
                    calibration.maxPointCount = 3;
                    axes.calibrate(calibration, axData.isRange100, axData.isNormalOrientation);
                } else if(axData.type === "MapAxes") {
                    axes = new wpd.MapAxes();
                    calibration.labels = ['P1', 'P2'];
                    calibration.labelPositions = ['S', 'S'];
                    calibration.maxPointCount = 2;
                    axes.calibrate(calibration, axData.scaleLength, axData.unitString);
                } else if(axData.type === "ImageAxes") {
                    axes = new wpd.ImageAxes();            
                }                

                if(axes != null) {
                    axes.name = axData.name;
                    this._axesColl.push(axes);
                }
            }
        }

        // datasets
        if(data.datasetColl != null) {
            for(let dsIdx = 0; dsIdx < data.datasetColl.length; dsIdx++) {
                const dsData = data.datasetColl[dsIdx];
                let ds = new wpd.Dataset();
                ds.name = dsData.name;
                if(dsData.metadataKeys != null) {
                    ds.setMetadataKeys(dsData.metadataKeys);
                }
                for(let pxIdx = 0; pxIdx < dsData.data.length; pxIdx++) {
                    ds.addPixel(dsData.data[pxIdx].x, dsData.data[pxIdx].y, dsData.data[pxIdx].metadata);
                }
                this._datasetColl.push(ds);
                
                // set axes for this dataset
                const axIdx = this.getAxesNames().indexOf(dsData.axesName);
                if(axIdx >= 0) {
                    this.setAxesForDataset(ds, this._axesColl[axIdx]);
                }                
            }
        }

        // measurements
        if(data.measurementColl != null) {
            for(let msIdx = 0; msIdx < data.measurementColl.length; msIdx++) {
                const msData = data.measurementColl[msIdx];
                let ms = null;
                if(msData.type === "Distance") {
                    ms = new wpd.DistanceMeasurement();
                    this._measurementColl.push(ms);
                    // set axes
                    const axIdx = this.getAxesNames().indexOf(msData.axesName);
                    if(axIdx >= 0) {
                        this.setAxesForMeasurement(ms, this._axesColl[axIdx]);
                    }  
                } else if(msData.type === "Angle") {
                    ms = new wpd.AngleMeasurement();
                    this._measurementColl.push(ms);
                } else if(msData.type === "Area") {
                    ms = new wpd.AreaMeasurement();
                    this._measurementColl.push(ms);
                    // set axes
                    const axIdx = this.getAxesNames().indexOf(msData.axesName);
                    if(axIdx >= 0) {
                        this.setAxesForMeasurement(ms, this._axesColl[axIdx]);
                    }  
                }
                // add connections
                if(ms != null) {
                    for(let cIdx = 0; cIdx < msData.data.length; cIdx++) {
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
            if(data.wpd != null && data.wpd.version[0] === 3) {
                return this._deserializePreVersion4(data.wpd);
            }
            if(data.version != null && data.version[0] === 4) {
                return this._deserializeVersion4(data);
            }                                    
            return true;
        }
        catch(e) {
            console.log(e);
            return false;
        }        
    }

    serialize() {
        let data = {};
        data.version = [4,0];        
        data.axesColl = [];
        data.datasetColl = [];
        data.measurementColl = [];
        
        // axes data
        for(let axIdx = 0; axIdx < this._axesColl.length; axIdx++) {
            const axes = this._axesColl[axIdx];
            let axData = {};
            axData.name = axes.name;
            if(axes instanceof wpd.XYAxes) {
                axData.type = "XYAxes";                
                axData.isLogX = axes.isLogX();
                axData.isLogY = axes.isLogY();                
            } else if(axes instanceof wpd.BarAxes) {
                axData.type = "BarAxes";
                axData.isLog = axes.isLog();
                axData.isRotated = axes.isRotated();
            } else if(axes instanceof wpd.PolarAxes) {
                axData.type = "PolarAxes";
                axData.isDegrees = axes.isThetaDegrees();
                axData.isClockwise = axes.isThetaClockwise();
                axData.isLog = axes.isRadialLog();
            } else if(axes instanceof wpd.TernaryAxes) {
                axData.type = "TernaryAxes";
                axData.isRange100 = axes.isRange100();
                axData.isNormalOrientation = axes.isNormalOrientation;
            } else if(axes instanceof wpd.MapAxes) {
                axData.type = "MapAxes";
                axData.scaleLength = axes.getScaleLength();
                axData.unitString = axes.getUnits();
            } else if(axes instanceof wpd.ImageAxes) {
                axData.type = "ImageAxes";
            }

            // calibration points
            if(!(axes instanceof wpd.ImageAxes)) {
                axData.calibrationPoints = [];
                for(let calIdx = 0; calIdx < axes.calibration.getCount(); calIdx++) {
                    axData.calibrationPoints.push(axes.calibration.getPoint(calIdx));
                }
            }

            data.axesColl.push(axData);
        }

        // datasets
        for(let dsIdx = 0; dsIdx < this._datasetColl.length; dsIdx++) {
            const ds = this._datasetColl[dsIdx];
            const axes = this.getAxesForDataset(ds);
            let dsData = {};
            dsData.name = ds.name;
            dsData.axesName = axes != null ? axes.name: "";
            dsData.metadataKeys = ds.getMetadataKeys();
            dsData.data = [];
            for(let pxIdx = 0; pxIdx < ds.getCount(); pxIdx++) {
                let px = ds.getPixel(pxIdx);
                dsData.data[pxIdx] = px;
                if(axes != null) {
                    dsData.data[pxIdx].value = axes.pixelToData(px.x, px.y);
                }
            }
            data.datasetColl.push(dsData);
        }

        // measurements
        for(let msIdx = 0; msIdx < this._measurementColl.length; msIdx++) {
            const ms = this._measurementColl[msIdx];
            const axes = this.getAxesForMeasurement(ms);
            let msData = {};
            if(ms instanceof wpd.DistanceMeasurement) {
                msData.type = "Distance";
                msData.name = "Distance";
                msData.axesName = axes != null ? axes.name : "";
            } else if(ms instanceof wpd.AngleMeasurement) {
                msData.type = "Angle";
                msData.name = "Angle";                
            } else if(ms instanceof wpd.AreaMeasurement) {
                msData.type = "Area";
                msData.name = "Area";
                msData.axesName = axes != null ? axes.name : "";
            }
            msData.data = [];
            for(let cIdx = 0; cIdx < ms.connectionCount(); cIdx++) {
                msData.data.push(ms.getConnectionAt(cIdx));
            }
            data.measurementColl.push(msData);
        }
        return data;
    }
};

/*
    WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

    Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.AveragingWindowCore = (function () {
    var Algo = function (binaryData, imageHeight, imageWidth, dx, dy, dataSeries) {
        this.run = function () {
            var xPoints = [],
                xPointsPicked = 0,
                pointsPicked = 0,
                dw = imageWidth,
                dh = imageHeight,
                blobAvg = [],
                coli, rowi,
                firstbloby,
                bi, blobs, blbi, xi, yi,
                pi, inRange, xxi, oldX, oldY, avgX, avgY, newX, newY,
                matches,
                xStep = dx,
                yStep = dy;

            dataSeries.clearAll();

            for (coli = 0; coli < dw; coli++) {

                blobs = -1;
                firstbloby = -2.0*yStep;
                bi = 0;

                // Scan vertically for blobs:

                for (rowi = 0; rowi < dh; rowi++) {
                    if(binaryData[rowi*dw + coli] === true) {
                        if (rowi > firstbloby + yStep) {
                            blobs = blobs + 1;
                            bi = 1;
                            blobAvg[blobs] = rowi;
                            firstbloby = rowi;
                        } else {
                            bi = bi + 1;
                            blobAvg[blobs] = parseFloat((blobAvg[blobs]*(bi-1.0) + rowi)/parseFloat(bi));
                        }
                    }
                }

                if (blobs >= 0) {
                    xi = coli + 0.5;
                    for (blbi = 0; blbi <= blobs; blbi++) {
                      yi = blobAvg[blbi] + 0.5; // add 0.5 to shift to the middle of the pixels instead of the starting edge.

                      xPoints[xPointsPicked] = [];
                      xPoints[xPointsPicked][0] = parseFloat(xi);
                      xPoints[xPointsPicked][1] = parseFloat(yi);
                      xPoints[xPointsPicked][2] = true; // true if not filtered, false if processed already
                      xPointsPicked = xPointsPicked + 1;
                    }
                }

              }

              if (xPointsPicked === 0) {
                    return;
              }

              for(pi = 0; pi < xPointsPicked; pi++) {
                if(xPoints[pi][2] === true) {// if still available
                  inRange = true;
                  xxi = pi+1;

                  oldX = xPoints[pi][0];
                  oldY = xPoints[pi][1];

                  avgX = oldX;
                  avgY = oldY;

                  matches = 1;

                  while((inRange === true) && (xxi < xPointsPicked)) {
                    newX = xPoints[xxi][0];
                    newY = xPoints[xxi][1];

                    if( (Math.abs(newX-oldX) <= xStep) && (Math.abs(newY-oldY) <= yStep) && (xPoints[xxi][2] === true)) {
                        avgX = (avgX*matches + newX)/(matches+1.0);
                        avgY = (avgY*matches + newY)/(matches+1.0);
                        matches = matches + 1;
                        xPoints[xxi][2] = false;
                    }

                    if (newX > oldX + 2*xStep) {
                        inRange = false;
                    }

                    xxi = xxi + 1;
                  }

                  xPoints[pi][2] = false;

                  pointsPicked = pointsPicked + 1;
                  dataSeries.addPixel(parseFloat(avgX), parseFloat(avgY));

                }

              }

              xPoints = [];

              return dataSeries;
        };
    };
    return Algo;
})();
/*
    WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

    Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.AveragingWindowAlgo = (function () {

    var Algo = function () {

        var xStep = 5, yStep = 5;

        this.getParamList = function(axes) {
            return [['ΔX', 'Px', 10], ['ΔY', 'Px', 10]];
        };

        this.setParam = function (index, val) {
            if(index === 0) {
                xStep = val;
            } else if(index === 1) {
                yStep = val;
            }
        };

        this.run = function (autoDetector, dataSeries, axes) {
            var algoCore = new wpd.AveragingWindowCore(autoDetector.binaryData, autoDetector.imageHeight, autoDetector.imageWidth, xStep, yStep, dataSeries);
            algoCore.run();
        };

    };
    return Algo;
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.AveragingWindowWithStepSizeAlgo = (function () {
    var Algo = function () {

        var param_xmin, param_delx, param_xmax,
            param_linewidth, param_ymin, param_ymax;

        this.getParamList = function (axes) {
            if(axes != null && axes instanceof wpd.XYAxes) {
                var bounds = axes.getBounds();
                return [["X_min","Units", bounds.x1],["ΔX Step","Units", 0.1],["X_max","Units", bounds.x2],["Y_min","Units", bounds.y3],["Y_max","Units", bounds.y4],["Line width","Px",30]];
            }
            return [["X_min","Units", 0],["ΔX Step","Units", 0.1],["X_max","Units", 0],["Y_min","Units", 0],["Y_max","Units", 0],["Line width","Px",30]];
        };

        this.setParam = function (index, val) {
            if (index === 0) {
                param_xmin = val;
            } else if (index === 1) {
                param_delx = val;
            } else if (index === 2) {
                param_xmax = val;
            } else if (index === 3) {
                param_ymin = val;
            } else if (index === 4) {
                param_ymax = val;
            } else if (index === 5) {
                param_linewidth = val;
            }
        };

        this.run = function (autoDetector, dataSeries, axes) {
            var pointsPicked = 0,
                dw = autoDetector.imageWidth,
                dh = autoDetector.imageHeight,
                blobx = [],
                bloby = [],
                xi, xmin_pix, xmax_pix, ymin_pix, ymax_pix, dpix, r_unit_per_pix, step_pix,
                blobActive, blobEntry, blobExit,
                blobExitLocked,
                ii, yi,
                mean_ii,
                mean_yi,
                pdata;

            dataSeries.clearAll();

            for (xi = param_xmin; xi <= param_xmax; xi+= param_delx) {
                step_pix = 1;

                pdata = axes.dataToPixel(xi, param_ymin);
                xmin_pix = pdata.x;
                ymin_pix = pdata.y;

                pdata = axes.dataToPixel(xi, param_ymax);
                xmax_pix = pdata.x;
                ymax_pix = pdata.y;

                dpix = Math.sqrt((ymax_pix-ymin_pix)*(ymax_pix-ymin_pix) + (xmax_pix-xmin_pix)*(xmax_pix-xmin_pix));
                r_unit_per_pix = (param_ymax-param_ymin)/dpix;

                blobActive = false;
                blobEntry = 0;
                blobExit = 0;
                // To account for noise or if actual thickness is less than specified thickness.
				// This flag helps to set blobExit at the end of the thin part or account for noise.
				blobExitLocked = false;

                for (ii = 0; ii <= dpix; ii++) {
                    yi = -ii*step_pix*r_unit_per_pix + param_ymax;
                    pdata = axes.dataToPixel(xi, yi);
                    xi_pix = pdata.x;
                    yi_pix = pdata.y;

                    if(xi_pix >= 0 && xi_pix < dw && yi_pix >=0 && yi_pix < dh)	{
                        if (autoDetector.binaryData[parseInt(yi_pix, 10)*dw + parseInt(xi_pix, 10)] === true) {
                            if(blobActive === false) {
								blobEntry = ii;
								blobExit = blobEntry;
								blobActive = true;
								blobExitLocked = false;
							}
                            // Resume collection, it was just noise
							if(blobExitLocked === true) {
								blobExit = ii;
								blobExitLocked = false;
							}
                        } else	{

							// collection ended before line thickness was hit. It could just be noise
							// or it could be the actual end.
							if(blobExitLocked === false) {
								blobExit = ii;
								blobExitLocked = true;
							}					
						}

                        if(blobActive === true)	{

							if((ii > blobEntry + param_linewidth) || (ii == dpix-1)) {
								blobActive = false;

								if(blobEntry > blobExit) {
									blobExit = ii;							
								}

								mean_ii = (blobEntry + blobExit)/2.0;
								mean_yi = -mean_ii*step_pix*r_unit_per_pix + param_ymax;

								pdata = axes.dataToPixel(xi, mean_yi);
								dataSeries.addPixel(parseFloat(pdata.x), parseFloat(pdata.y));
								pointsPicked = pointsPicked + 1;
							}
						}
                    }
                }
            }

        };

    };
    return Algo;
})();

/*
    WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

    Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.BarValue = function () {
    this.npoints = 0;

    this.avgValTop = 0;

    this.avgValBot = 0;

    this.avgX = 0;

    this.append = function(x, valTop, valBot) {
        this.avgX = (this.npoints*this.avgX + x)/(this.npoints + 1.0);
        this.avgValTop = (this.npoints*this.avgValTop + valTop)/(this.npoints + 1.0);
        this.avgValBot = (this.npoints*this.avgValBot + valBot)/(this.npoints + 1.0);
        this.npoints++;
    };

    this.isPointInGroup = function(x, valTop, valBot, del_x, del_val) {
        if(this.npoints === 0) {
            return true;
        }

        if(Math.abs(this.avgX - x) <= del_x && Math.abs(this.avgValTop - valTop) <= del_val && Math.abs(this.avgValBot - valBot) <= del_val) {
            return true;
        }

        return false;
    };
};


wpd.BarExtractionAlgo = function() {

    var delX, delVal;
    
    this.getParamList = function(axes) {
        var orientationAxes = axes.getOrientation().axes;
        if(orientationAxes === 'Y') {
            return [['ΔX', 'Px', 30], ['ΔVal', 'Px', 10]];
        } else {
            return [['ΔY', 'Px', 30], ['ΔVal', 'Px', 10]];
        }
    };

    this.setParam = function (index, val) {
        if (index === 0) {
            delX = parseFloat(val);
        } else if (index === 1) {
            delVal = parseFloat(val);
        }
    };

    this.run = function(autoDetector, dataSeries, axes) {
        var orientation = axes.getOrientation(),                
            barValueColl = [],
            valTop, valBot, valCount, val,
            px, py,
            width = autoDetector.imageWidth,
            height = autoDetector.imageHeight,
            pixelAdded,
            barValuei,
            bv,
            dataVal,
            pxVal,
            mkeys,
            topVal,
            botVal,
            
            appendData = function (x, valTop, valBot) {                
                pixelAdded = false;
                for(barValuei = 0; barValuei < barValueColl.length; barValuei++) {
                    bv = barValueColl[barValuei];

                    if(bv.isPointInGroup(x, valTop, valBot, delX, delVal)) {
                        bv.append(x, valTop, valBot);
                        pixelAdded = true;
                        break;
                    }
                }
                if(!pixelAdded) {
                    bv = new wpd.BarValue();
                    bv.append(x, valTop, valBot);
                    barValueColl.push(bv);
                }
            };

        dataSeries.clearAll();

        // Switch directions based on axes orientation and direction of data along that axes:
        // For each direction, look for both top and bottom side of the bar to account for cases where some bars are oriented
        // in the increasing direction, while others are in a decreasing direction
        if(orientation.axes === 'Y') {
            for (px = 0; px < width; px++) {                
                valTop = 0;
                valBot = height - 1;
                valCount = 0;

                for(py = 0; py < height; py++) {
                    if(autoDetector.binaryData[py*width + px]) {
                        valTop = py;
                        valCount++;
                        break;
                    }
                }
                for(py = height-1; py >= 0; py--) {
                    if(autoDetector.binaryData[py*width + px]) {
                        valBot = py;
                        valCount++;
                        break;
                    }
                }
                if(valCount === 2) { // found both top and bottom ends
                    appendData(px, valTop, valBot);
                }
            }
        } else {
            for (py = 0; py < height; py++) {
                valTop = width - 1;
                valBot = 0;
                valCount = 0;

                for(px = width-1; px >= 0; px--) {
                    if(autoDetector.binaryData[py*width + px]) {
                        valTop = px;
                        valCount++;
                        break;
                    }
                }
                for(px = 0; px < width; px++) {
                    if(autoDetector.binaryData[py*width + px]) {
                        valBot = px;
                        valCount++;
                        break;
                    }
                }
                if(valCount === 2) {
                    appendData(py, valTop, valBot);
                }
            }
        }
        
        if(axes.dataPointsHaveLabels) {
            mkeys = dataSeries.getMetadataKeys();
            if(mkeys == null || mkeys[0] !== 'Label') {
                dataSeries.setMetadataKeys(['Label']);
            }
        }

        for(barValuei = 0; barValuei < barValueColl.length; barValuei++) {
            
            bv = barValueColl[barValuei];
            
            if(orientation.axes === 'Y') {
                valTop = axes.pixelToData(bv.avgX, bv.avgValTop)[0];
                valBot = axes.pixelToData(bv.avgX, bv.avgValBot)[0];
            } else {
                valTop = axes.pixelToData(bv.avgValTop, bv.avgX)[0];
                valBot = axes.pixelToData(bv.avgValBot, bv.avgX)[0];
            }
                
            if(valTop + valBot < 0) {
                val = orientation.direction === 'increasing' ? bv.avgValBot : bv.avgValTop;
            } else {
                val = orientation.direction === 'increasing' ? bv.avgValTop : bv.avgValBot;
            }

            if(axes.dataPointsHaveLabels) {
               
                if(orientation.axes === 'Y') {
                    dataSeries.addPixel(bv.avgX + 0.5, val + 0.5, ["Bar" + barValuei]);
                } else {
                    dataSeries.addPixel(val + 0.5, bv.avgX + 0.5, ["Bar" + barValuei]);
                }

            } else {

                if(orientation.axes === 'Y') {
                    dataSeries.addPixel(bv.avgX + 0.5, val + 0.5);
                } else {
                    dataSeries.addPixel(val + 0.5, bv.avgX + 0.5);
                }

            }            
        }
    };
};
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.BlobDetectorAlgo = (function () {

    var Algo = function () {
        var min_dia, max_dia;

        this.getParamList = function(axes) {
            if (axes != null && axes instanceof wpd.MapAxes) {
			    return [['Min Diameter', 'Units', 0], ['Max Diameter', 'Units', 5000]];
            }
			return [['Min Diameter', 'Px', 0], ['Max Diameter', 'Px', 5000]];
        };

        this.setParam = function (index, val) {
            if (index === 0) {
                min_dia = parseFloat(val);
            } else if (index === 1) {
                max_dia = parseFloat(val);
            }
        };

        this.run = function (autoDetector, dataSeries, axes) {
            var dw = autoDetector.imageWidth,
                dh = autoDetector.imageHeight,
                pixelVisited = [],
                blobCount = 0,
                blobs = [],
                xi, yi,
                blobPtIndex,
                bIndex,
                nxi, nyi,
                bxi, byi,
                pcount,
                dia;

            if (dw <= 0 || dh <= 0 || autoDetector.binaryData == null
                || autoDetector.binaryData.length === 0) {
                return;
            }

            dataSeries.clearAll();
            dataSeries.setMetadataKeys(["area", "moment"]);

            for (xi = 0; xi < dw; xi++) {
                for (yi = 0; yi < dh; yi++) {
                    if (autoDetector.binaryData[yi*dw + xi] === true && !(pixelVisited[yi*dw + xi] === true)) {

                        pixelVisited[yi*dw + xi] = true;

                        bIndex = blobs.length;

                        blobs[bIndex] = {
                            pixels: [{x: xi, y: yi}],
                            centroid: {x: xi, y: yi},
                            area: 1.0,
                            moment: 0.0
                        };

                        blobPtIndex = 0;
                        while (blobPtIndex < blobs[bIndex].pixels.length) {
                            bxi = blobs[bIndex].pixels[blobPtIndex].x;
                            byi = blobs[bIndex].pixels[blobPtIndex].y;

                            for (nxi = bxi - 1; nxi <= bxi + 1; nxi++) {
                                for(nyi = byi - 1; nyi <= byi + 1; nyi++) {
                                    if (nxi >= 0 && nyi >= 0 && nxi < dw && nyi < dh) {
                                        if (!(pixelVisited[nyi*dw + nxi] === true) && autoDetector.binaryData[nyi*dw + nxi] === true) {

                                            pixelVisited[nyi*dw + nxi] = true;

                                            pcount = blobs[bIndex].pixels.length;

                                            blobs[bIndex].pixels[pcount] = {
                                                x: nxi,
                                                y: nyi
                                            };

                                            blobs[bIndex].centroid.x = (blobs[bIndex].centroid.x*pcount + nxi)/(pcount + 1.0);
                                            blobs[bIndex].centroid.y = (blobs[bIndex].centroid.y*pcount + nyi)/(pcount + 1.0);
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
                    blobs[bIndex].moment = blobs[bIndex].moment
                        + (blobs[bIndex].pixels[blobPtIndex].x - blobs[bIndex].centroid.x)*(blobs[bIndex].pixels[blobPtIndex].x - blobs[bIndex].centroid.x)
                        + (blobs[bIndex].pixels[blobPtIndex].y - blobs[bIndex].centroid.y)*(blobs[bIndex].pixels[blobPtIndex].y - blobs[bIndex].centroid.y);

                }
                if (axes instanceof wpd.MapAxes) {
                    blobs[bIndex].area = plotData.axes.pixelToDataArea(blobs[bIndex].area);
                }

                dia = 2.0*Math.sqrt(blobs[bIndex].area/Math.PI);
                if (dia <= max_dia && dia >= min_dia) {
                    // add 0.5 pixel offset to shift to the center of the pixels.
                    dataSeries.addPixel(blobs[bIndex].centroid.x + 0.5, blobs[bIndex].centroid.y + 0.5, [blobs[bIndex].area, blobs[bIndex].moment]);
                }
            }
        };
    };

    return Algo;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.XStepWithInterpolationAlgo = (function () {
    var Algo = function () {
        var param_xmin, param_delx, param_xmax, 
            param_smoothing, param_ymin, param_ymax;

        this.getParamList = function(axes) {
            if(axes != null && axes instanceof wpd.XYAxes) {
                var bounds = axes.getBounds();
                return [["X_min","Units", bounds.x1],["ΔX Step","Units", (bounds.x2 - bounds.x1)/50.0], 
                        ["X_max","Units", bounds.x2],["Y_min","Units", bounds.y3],
                        ["Y_max","Units", bounds.y4],["Smoothing","% of ΔX", 0]];

            }
            return [["X_min","Units", 0],["ΔX Step","Units", 0.1],
                    ["X_max","Units", 0],["Y_min","Units", 0],
                    ["Y_max","Units", 0],["Smoothing","% of ΔX", 0]];
        };
        
        this.setParam = function (index, val) {
            if (index === 0) {
                param_xmin = val;
            } else if (index === 1) {
                param_delx = val;
            } else if (index === 2) {
                param_xmax = val;
            } else if (index === 3) {
                param_ymin = val;
            } else if (index === 4) {
                param_ymax = val;
            } else if (index === 5) {
                param_smoothing = val;
            }
        };

        this.run = function (autoDetector, dataSeries, axes) {
            var pointsPicked = 0,
                dw = autoDetector.imageWidth,
                dh = autoDetector.imageHeight,
                xi,
                dist_y_px,
                dist_x_px,
                ii, yi, jj, 
                mean_yi,
                y_count,
                pdata,
                pdata0,
                pdata1,
                xpoints = [],
                ypoints = [],
                xpoints_mean = [],
                ypoints_mean = [],
                mean_x, mean_y,
                delx,
                dely,
                xinterp,
                yinterp,
                param_width = Math.abs(param_delx*(param_smoothing/100.0)),
                cs;

            dataSeries.clearAll();

            // Calculate pixel distance between y_min and y_max:
            pdata0 = axes.dataToPixel(param_xmin, param_ymin);
            pdata1 = axes.dataToPixel(param_xmin, param_ymax);
            dist_y_px = Math.sqrt((pdata0.x - pdata1.x)*(pdata0.x - pdata1.x) + (pdata0.y - pdata1.y)*(pdata0.y - pdata1.y));
            dely = (param_ymax - param_ymin)/dist_y_px;

            // Calculate pixel distance between x_min and x_max:
            pdata1 = axes.dataToPixel(param_xmax, param_ymin);
            dist_x_px = Math.sqrt((pdata0.x - pdata1.x)*(pdata0.x - pdata1.x) + (pdata0.y - pdata1.y)*(pdata0.y - pdata1.y));
            delx = (param_xmax - param_xmin)/dist_x_px;

            if(Math.abs(param_width/delx) > 0 && Math.abs(param_width/delx) < 1) {
                param_width = delx;
            }

            xi = param_xmin;
            while( ( delx > 0 && xi <= param_xmax ) || ( delx < 0 && xi >= param_xmax ) ) {

                mean_yi = 0; y_count = 0;
                yi = param_ymin;
                while ( ( dely > 0 && yi <= param_ymax ) || ( dely < 0 && yi >= param_ymax ) ) {
                    pdata = axes.dataToPixel(xi, yi);
                    if (pdata.x > 0 && pdata.y > 0 && pdata.x < dw && pdata.y < dh) {
                        if (autoDetector.binaryData[parseInt(pdata.y, 10)*dw + parseInt(pdata.x, 10)] === true) {
                            mean_yi = (mean_yi*y_count + yi)/(parseFloat(y_count+1));
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

            if (param_width > 0) {
                xpoints_mean = [];
                ypoints_mean = [];

                xi = xpoints[0];
                while ( (delx > 0 && xi <= xpoints[xpoints.length-1]) || (delx < 0 && xi >= xpoints[xpoints.length-1]) ) {
                    mean_x = 0;
                    mean_y = 0;
                    y_count = 0;
                    for (ii = 0; ii < xpoints.length; ii++) {
                        if (xpoints[ii] <= xi + param_width && xpoints[ii] >= xi - param_width) {
                            mean_x = (mean_x*y_count + xpoints[ii])/parseFloat(y_count + 1);
                            mean_y = (mean_y*y_count + ypoints[ii])/parseFloat(y_count + 1);
                            y_count++;
                        }
                    }

                    if (y_count > 0) {
                        xpoints_mean[xpoints_mean.length] = mean_x;
                        ypoints_mean[ypoints_mean.length] = mean_y;
                    }

                    if(delx > 0) {
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
            xi = param_xmin;

            if (( delx < 0 && param_delx > 0) || (delx > 0 && param_delx < 0)) {
                return;
            }
            
            while ( (delx > 0 && xi <= param_xmax) || (delx < 0 && xi >= param_xmax) ) {
                xinterp[ii] = xi;
                ii++;
                xi = xi + param_delx;
            }

            if(delx < 0) {
                xpoints_mean = xpoints_mean.reverse();
                ypoints_mean = ypoints_mean.reverse();
            }

            // Cubic spline interpolation:
            cs = wpd.cspline(xpoints_mean, ypoints_mean);
            if(cs != null) {
                yinterp = [];
                for(ii = 0; ii < xinterp.length; ++ii) {
                    if(!isNaN(xinterp[ii])) {
                        yinterp[ii] = wpd.cspline_interp(cs, xinterp[ii]);
                        if(yinterp[ii] !== null) {
                            pdata = axes.dataToPixel(xinterp[ii], yinterp[ii]);
                            dataSeries.addPixel(pdata.x, pdata.y);
                        }
                    }            
                }
            }

         };
            
    };
    return Algo;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.BarAxes = (function () {

    var AxesObj = function () {
        // Throughout this code, it is assumed that "y" is the continuous axes and "x" is
        // the discrete axes. In practice, this shouldn't matter even if the orientation
        // is different.
        var isCalibrated = false,
            isLogScale = false,
            isRotatedAxes = false,
            x1, y1, x2, y2, p1, p2,
            orientation;

        this.isCalibrated = function () {
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

            if(isLog) {
                isLogScale = true;
                p1 = Math.log(p1)/Math.log(10);
                p2 = Math.log(p2)/Math.log(10);
            } else {
                isLogScale = false;
            }

            orientation = this.calculateOrientation();
            isRotatedAxes = isRotated;
            
            if(!isRotated) {
                // ignore rotation and assume axes is precisely vertical or horizontal
                if(orientation.axes == 'Y') {
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

        this.pixelToData = function (pxi, pyi) {
            var data = [],
                c_c2 = ((pyi-y1)*(y2-y1) + (x2-x1)*(pxi-x1))/((y2-y1)*(y2-y1) + (x2-x1)*(x2-x1));
            // We could return X pixel value (or Y, depending on orientation) but that's not very useful.
            // For now, just return the bar value. That's it.
            data[0] = (p2 - p1)*c_c2 + p1;
            if(isLogScale) {
                data[0] = Math.pow(10, data[0]);
            }
            return data;
        };

        this.dataToPixel = function (x, y) {
            // not implemented yet
            return {
                x: 0,
                y: 0
            };
        };

        this.pixelToLiveString = function (pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4);
        };

        this.isLog = function () {
            return isLogScale;
        };

        this.isRotated = function() {
            return isRotatedAxes;
        }

        this.getTransformationEquations = function () {
            return {
                pixelToData: ['This will be available in a future release.']
            };
        };

        this.dataPointsHaveLabels = true;

        this.dataPointsLabelPrefix = 'Bar';

        this.calculateOrientation = function () { // Used by auto-extract algo to switch orientation.
        
            var orientationAngle = wpd.taninverse(-(y2-y1), x2-x1)*180/Math.PI,
                orientation = {
                    axes: 'Y',
                    direction: 'increasing',
                    angle: orientationAngle
                },
                tol = 30; // degrees.
            
            if(Math.abs(orientationAngle - 90) < tol) {
                orientation.axes = 'Y';
                orientation.direction = 'increasing';
            } else if(Math.abs(orientationAngle - 270) < tol) {
                orientation.axes = 'Y';
                orientation.direction = 'decreasing';
            } else if(Math.abs(orientationAngle - 0) < tol || Math.abs(orientationAngle - 360) < tol) {
                orientation.axes = 'X';
                orientation.direction = 'increasing';
            } else if(Math.abs(orientationAngle - 180) < tol) {
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

    AxesObj.prototype.numCalibrationPointsRequired = function () {
        return 2;
    };

    AxesObj.prototype.getDimensions = function () {
        return 2;
    };

    AxesObj.prototype.getAxesLabels = function () {
        return ['Label', 'Y'];
    };

    return AxesObj;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.ImageAxes = (function () {
    var AxesObj = function () {

        this.isCalibrated = function() {
            return true;
        };

        this.calibrate = function () {
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

        this.pixelToLiveString = function (pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toFixed(2) + ', ' + dataVal[1].toFixed(2);
        };

        this.getTransformationEquations = function () {
            return {
                pixelToData: ['x_data = x_pixel','y_data = y_pixel'],
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
})();



/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.MapAxes = (function () {
    var AxesObj = function () {
        var isCalibrated = false,
            scaleLength,
            scaleUnits,
            dist,
            processCalibration = function(cal, scale_length, scale_units) {                
                var cp0 = cal.getPoint(0),
                    cp1 = cal.getPoint(1);
                dist = Math.sqrt((cp0.px-cp1.px)*(cp0.px-cp1.px) + (cp0.py-cp1.py)*(cp0.py-cp1.py));
                scaleLength = parseFloat(scale_length);
                scaleUnits = scale_units;
                return true;
            };

        this.calibration = null;

        this.isCalibrated = function() {
            return isCalibrated;
        };

        this.calibrate = function (calib, scale_length, scale_units) {
            this.calibration = calib;
            isCalibrated = processCalibration(calib, scale_length, scale_units);
            return isCalibrated;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [];
            data[0] = pxi*scaleLength/dist;
            data[1] = pyi*scaleLength/dist;
            return data;
        };

        this.pixelToDataDistance = function(distancePx) {
            return distancePx*scaleLength/dist;
        };

        this.pixelToDataArea = function (areaPx) {
            return areaPx*scaleLength*scaleLength/(dist*dist);
        };

        this.dataToPixel = function(a, b, c) {
            return {
                x: 0,
                y: 0
            };
        };

        this.pixelToLiveString = function (pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4) + ', ' + dataVal[1].toExponential(4);
        };

        this.getScaleLength = function () {
            return scaleLength;
        };

        this.getUnits = function () {
            return scaleUnits;
        };

        this.getTransformationEquations = function () {
            return {
                pixelToData:[
                                'x_data = ' + scaleLength/dist + '*x_pixel',
                                'y_data = ' + scaleLength/dist + '*y_pixel'
                            ],
                dataToPixel:[
                                'x_pixel = ' + dist/scaleLength + '*x_data', 
                                'y_pixel = ' + dist/scaleLength + '*y_data'
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
})();


/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.PolarAxes = (function () {
    var AxesObj = function () {
        var isCalibrated = false,
            isDegrees = false,
            isClockwise = false,
            isLog = false,

            x0, y0, x1, y1, x2, y2, r1, theta1, r2, theta2,
            dist10, dist20, dist12, phi0, alpha0;

            processCalibration = function(cal, is_degrees, is_clockwise, is_log_r) {  
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
                
                if (isDegrees === true) {// if degrees
    		        theta1 = (Math.PI/180.0)*theta1;
        			theta2 = (Math.PI/180.0)*theta2;
		        }
		    	
                if(is_log_r) {
                    isLog = true;
                    r1 = Math.log(r1)/Math.log(10);
                    r2 = Math.log(r2)/Math.log(10);
                }
                		    
		        // Distance between 1 and 0.
		        dist10 = Math.sqrt((x1-x0)*(x1-x0) + (y1-y0)*(y1-y0)); 
		    
		        // Distance between 2 and 0
		        dist20 = Math.sqrt((x2-x0)*(x2-x0) + (y2-y0)*(y2-y0)); 
		    
		        // Radial Distance between 1 and 2.
		        dist12 = dist20 - dist10;
		    
		        phi0 = wpd.taninverse(-(y1-y0),x1-x0);
                
                if(isClockwise) {
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

        this.calibrate = function (calib, is_degrees, is_clockwise, is_log_r) {
            this.calibration = calib;
            isCalibrated = processCalibration(calib, is_degrees, is_clockwise, is_log_r);
            return isCalibrated;
        };

        this.isThetaDegrees = function () {
            return isDegrees;
        };

        this.isThetaClockwise = function () {
            return isClockwise;
        };

        this.isRadialLog = function() {
            return isLog;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [],
                rp,
                thetap;

            xp = parseFloat(pxi);
            yp = parseFloat(pyi);

            rp = ((r2-r1)/dist12)*(Math.sqrt((xp-x0)*(xp-x0)+(yp-y0)*(yp-y0))-dist10) + r1;
			
            if(isClockwise) {
                thetap = alpha0 - wpd.taninverse(-(yp-y0), xp-x0);
            } else {
                thetap = wpd.taninverse(-(yp-y0),xp-x0) - alpha0;
            }

            if(thetap < 0) {
                thetap = thetap + 2*Math.PI;
            }
			
		    if(isDegrees === true) {
		        thetap = 180.0*thetap/Math.PI;
            }

            if(isLog) {
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

        this.pixelToLiveString = function (pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4) + ', ' + dataVal[1].toExponential(4);
        };

        this.getTransformationEquations = function () {
            var rEqn = 'r = (' + (r2 - r1)/dist12 + ')*sqrt((x_pixel - ' + x0 + ')^2 + (y_pixel - ' + y0 + ')^2) + ('
                        + (r1-dist10*(r2-r1)/dist12) + ')',
                thetaEqn;

            if(isClockwise) {
                thetaEqn = alpha0 + '- atan2((' + y0 + ' - y_pixel), (x_pixel - ' + x0 + '))';
            } else {
                thetaEqn = 'atan2((' + y0 + ' - y_pixel), (x_pixel - ' + x0 + ')) - (' + alpha0 + ')';
            }

            if(isDegrees) {
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
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.TernaryAxes = (function () {
    var AxesObj = function () {
        var isCalibrated = false,
            
            x0, y0, x1, y1, x2, y2, L,
            phi0, root3, isRange0to100,
            isOrientationNormal,

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

                L = Math.sqrt((x0-x1)*(x0-x1) + (y0-y1)*(y0-y1));

                phi0 = wpd.taninverse(-(y1-y0),x1-x0);

                root3 = Math.sqrt(3);

                isRange0to100 = range100;

                isOrientationNormal = is_normal;

                return true;
            };

        this.isCalibrated = function() {
            return isCalibrated;
        };

        this.calibration = null;

        this.calibrate = function (calib, range100, is_normal) {
            this.calibration = calib;
            isCalibrated = processCalibration(calib, range100, is_normal);            
            return isCalibrated;
        };

        this.isRange100 = function () {
            return isRange0to100;
        };

        this.isNormalOrientation = function () {
            return isOrientationNormal;
        };

        this.pixelToData = function(pxi, pyi) {
            var data = [],
                rp,
                thetap,
                xx,
                yy,
                ap, bp, cp, bpt;

            xp = parseFloat(pxi);
            yp = parseFloat(pyi);

            rp = Math.sqrt((xp-x0)*(xp-x0)+(yp-y0)*(yp-y0));

            thetap = wpd.taninverse(-(yp-y0),xp-x0) - phi0;

            xx = (rp*Math.cos(thetap))/L;
		    yy = (rp*Math.sin(thetap))/L;
			
			ap = 1.0 - xx - yy/root3;
			bp = xx - yy/root3;
			cp = 2.0*yy/root3;
			
			if(isOrientationNormal == false) {
                // reverse axes orientation
			    bpt = bp;
			    bp = ap;
			    ap = cp;
			    cp = bpt;
			      				  
			}
			
			if (isRange0to100 == true) {
			    ap = ap*100; bp = bp*100; cp = cp*100;
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

        this.pixelToLiveString = function (pxi, pyi) {
            var dataVal = this.pixelToData(pxi, pyi);
            return dataVal[0].toExponential(4) + ', ' + dataVal[1].toExponential(4) + ', ' + dataVal[2].toExponential(4);
        };

        this.getTransformationEquations = function () {
            var rpEqn = 'rp = sqrt((x_pixel - ' + x0 + ')^2 + (y_pixel - ' + y0 + ')^2)/(' + L + ')',
                thetapEqn = 'thetap = atan2(('+y0+' -  y_pixel), (x_pixel - ' + x0 + ')) - (' + Math.atan2(-(y1-y0),x1-x0) + ')',
                apEqn = '1 - rp*(cos(thetap) - sin(thetap)/sqrt(3))', 
                bpEqn = 'rp*(cos(thetap) - sin(thetap)/sqrt(3))', 
                cpEqn = '2*rp*sin(thetap)/sqrt(3)',bpEqnt;

            if(isRange0to100) {
                apEqn = '100*(' + apEqn + ')'; 
                bpEqn = '100*(' + bpEqn + ')'; 
                cpEqn = '100*(' + cpEqn + ')';
            }

            apEqn = 'a_data = ' + apEqn;
            bpEqn = 'b_data = ' + bpEqn;
            cpEqn = 'c_data = ' + cpEqn;

            if(!isOrientationNormal) {
                bpEqnt = bpEqn;
			    bpEqn = apEqn;
			    apEqn = cpEqn;
			    cpEqn = bpEqnt;
            }

            return {
                pixelToData: [
                                rpEqn,
                                thetapEqn,
                                apEqn,
                                bpEqn,
                                cpEqn
                             ]
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
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.XYAxes = (function () {

    var AxesObj = function () {
        var calibration,
            isCalibrated = false,
            isLogScaleX = false,
            isLogScaleY = false,

            isXDate = false, isYDate = false,

            initialFormattingX, initialFormattingY,

            x1, x2, x3, x4, y1, y2, y3, y4,
            xmin, xmax, ymin, ymax, 
            a_mat = [0, 0, 0, 0], a_inv_mat = [0, 0, 0, 0],
            c_vec = [0, 0],

            processCalibration = function(cal, isLogX, isLogY) {

                if(cal.getCount() < 4) {
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
                if(!ip.isValid) { return false; }
                isXDate = ip.isDate;
                xmax = ip.parse(xmax);
                if(!ip.isValid || (ip.isDate != isXDate)) { return false; }
                initialFormattingX = ip.formatting; 

                // Validate Y-Axes:
                ymin = ip.parse(ymin);
                if(!ip.isValid) { return false; }
                isYDate = ip.isDate;
                ymax = ip.parse(ymax);
                if(!ip.isValid || (ip.isDate != isYDate)) { return false; }
                initialFormattingY = ip.formatting; 

                isLogScaleX = isLogX;
                isLogScaleY = isLogY;

                // If x-axis is log scale
                if (isLogScaleX === true)
                {
                    xmin = Math.log(xmin)/Math.log(10);
                    xmax = Math.log(xmax)/Math.log(10);
                }

                // If y-axis is log scale
                if (isLogScaleY === true)
                {
                     ymin = Math.log(ymin)/Math.log(10);
                     ymax = Math.log(ymax)/Math.log(10);
                }

                dat_mat = [xmin-xmax, 0, 0, ymin - ymax];
                pix_mat = [x1 - x2, x3 - x4, y1 - y2, y3 - y4];

                a_mat = wpd.mat.mult2x2(dat_mat, wpd.mat.inv2x2(pix_mat));
                a_inv_mat = wpd.mat.inv2x2(a_mat);
                c_vec[0] = xmin - a_mat[0]*x1 - a_mat[1]*y1;
                c_vec[1] = ymin - a_mat[2]*x3 - a_mat[3]*y3;

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
                xf = Math.pow(10,xf);

            // if y-axis is log scale
            if (isLogScaleY === true)
                yf = Math.pow(10,yf);

            data[0] = xf;
            data[1] = yf;

            return data;
        };

        this.dataToPixel = function(x, y) {
            var xf, yf, dat_vec, rtnPix;

            if(isLogScaleX) {
                x = Math.log(x)/Math.log(10);
            }
            if(isLogScaleY) {
                y = Math.log(y)/Math.log(10);
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
            if(isXDate) {
                rtnString += wpd.dateConverter.formatDateNumber(dataVal[0], initialFormattingX);
            } else {
                rtnString += dataVal[0].toExponential(4);
            }
            rtnString += ', ';

            if(isYDate) {
                rtnString += wpd.dateConverter.formatDateNumber(dataVal[1], initialFormattingY);
            } else {
                rtnString += dataVal[1].toExponential(4);
            }
            return rtnString;
        };

        this.isDate = function (varIndex) {
            if(varIndex === 0) {
                return isXDate;
            } else {
                return isYDate;
            }
        };

        this.getInitialDateFormat = function (varIndex) {
            if(varIndex === 0) {
                return initialFormattingX;
            } else {
                return initialFormattingY;
            }
        };

        this.isLogX = function () {
            return isLogScaleX;
        };

        this.isLogY = function () {
            return isLogScaleY;
        };

        this.getTransformationEquations = function() {
            var xdEqn = '(' + a_mat[0] + ')*x_pixel + (' + a_mat[1] + ')*y_pixel + (' + c_vec[0] + ')',
                ydEqn = '(' + a_mat[2] + ')*x_pixel + (' + a_mat[3] + ')*y_pixel + (' + c_vec[1] + ')',
                xpEqn = 'x_pixel = (' + a_inv_mat[0] + ')*x_data + (' + a_inv_mat[1] + ')*y_data + (' + (-a_inv_mat[0]*c_vec[0]-a_inv_mat[1]*c_vec[1]) + ')',
                ypEqn = 'y_pixel = (' + a_inv_mat[2] + ')*x_data + (' + a_inv_mat[3] + ')*y_data + (' + (-a_inv_mat[2]*c_vec[0]-a_inv_mat[3]*c_vec[1]) + ')';

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

            if(isLogScaleX || isLogScaleY) {
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
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.dataTable = (function () {

    var dataProvider,
        dataCache,
        sortedData,
        tableText,
        selectedDataset,
        selectedMeasurement;

    var decSeparator = 1.1.toLocaleString().replace(/\d/g,'');
        
    function showPlotData() {
        dataProvider = wpd.plotDataProvider;
        selectedDataset = wpd.tree.getActiveDataset();
        selectedMeasurement = null;
        dataProvider.setDataSource(selectedDataset);
        show();
    }

    function showAngleData() {
        dataProvider = wpd.measurementDataProvider;
        selectedMeasurement = wpd.appData.getPlotData().getMeasurementsByType(wpd.AngleMeasurement)[0];
        selectedDataset = null;
        dataProvider.setDataSource(selectedMeasurement);
        show();
    }

    function showDistanceData() {
        dataProvider = wpd.measurementDataProvider;
        selectedMeasurement = wpd.appData.getPlotData().getMeasurementsByType(wpd.DistanceMeasurement)[0];
        selectedDataset = null;
        dataProvider.setDataSource(selectedMeasurement);        
        show();
    }

    function showAreaData() {
        dataProvider = wpd.measurementDataProvider;
        selectedMeasurement = wpd.appData.getPlotData().getMeasurementsByType(wpd.AreaMeasurement)[0];
        selectedDataset = null;
        dataProvider.setDataSource(selectedMeasurement);        
        show();
    }

    function show() {
        wpd.graphicsWidget.removeTool();
        wpd.popup.show('csvWindow');
        initializeColSeparator();
        refresh();
    }

    function initializeColSeparator(){
        // avoid colSeparator === decSeparator
        if(document.getElementById('data-number-format-separator').value.trim() === decSeparator) {
            document.getElementById('data-number-format-separator').value = decSeparator === "," ? "; " : ", ";
        }
    }

    function refresh() {
        dataCache = dataProvider.getData();
        setupControls();
        sortRawData();
        makeTable();
    }

    function setupControls() {

        var $datasetControl = document.getElementById('data-table-dataset-control'),
            $datasetList = document.getElementById('data-table-dataset-list'),            
            $sortingVariables = document.getElementById('data-sort-variables'),
            $variableNames = document.getElementById('dataVariables'),
            $dateFormattingContainer = document.getElementById('data-date-formatting-container'),
            $dateFormatting = document.getElementById('data-date-formatting'),
            i,
            datasetHTML = '',
            sortingHTML = '',
            dateFormattingHTML = '',
            isAnyVariableDate = false,
            showDatasets = selectedDataset != null,
            showMeasurements = selectedMeasurement != null;

        // gather names
        let selIdx = 0;
        if(showDatasets) {
            let datasetNames = wpd.appData.getPlotData().getDatasetNames();            
            datasetNames.forEach((name) => { datasetHTML += "<option value=\""+name+"\">"+name+"</option>"; });
            $datasetList.innerHTML = datasetHTML;
            $datasetList.value = selectedDataset.name;
        } else if(showMeasurements) {
            if(wpd.appData.getPlotData().getMeasurementsByType(wpd.AreaMeasurement).length > 0) {
                datasetHTML += "<option value=\"area\">" + wpd.gettext("area-measurements") + "</option>";
            }
            if(wpd.appData.getPlotData().getMeasurementsByType(wpd.AngleMeasurement).length > 0) {
                datasetHTML += "<option value=\"angle\">" + wpd.gettext("angle-measurements") + "</option>";
            }
            if(wpd.appData.getPlotData().getMeasurementsByType(wpd.DistanceMeasurement).length > 0) {
                datasetHTML += "<option value=\"distance\">" + wpd.gettext("distance-measurements") + "</option>";
            }
            $datasetList.innerHTML = datasetHTML;
            if(selectedMeasurement instanceof wpd.AngleMeasurement) {
                $datasetList.value = "angle";
            } else if(selectedMeasurement instanceof wpd.DistanceMeasurement) {
                $datasetList.value = "distance";
            } else if(selectedMeasurement instanceof wpd.AreaMeasurement) {
                $datasetList.value = "area";
            }
        }

        // Variable Names
        $variableNames.innerHTML = dataCache.fields.join(', ');

        $dateFormattingContainer.style.display = 'none';
        sortingHTML += '<option value="raw">' + wpd.gettext('raw') + '</option>';
        for(i = 0; i < dataCache.fields.length; i++) {

            // Sorting
            if(dataCache.isFieldSortable[i]) {
                sortingHTML += '<option value="' + dataCache.fields[i] + '">' + dataCache.fields[i] + '</option>';
            }

            // Date formatting
            if(dataCache.fieldDateFormat[i] != null) {
                dateFormattingHTML += '<p>' + dataCache.fields[i] + ' <input type="text" length="15" value="' + dataCache.fieldDateFormat[i] + '" id="data-format-string-' + i + '"/></p>';
                isAnyVariableDate = true;
            }
        }
        if(dataCache.allowConnectivity) {
            sortingHTML += '<option value="NearestNeighbor">' + wpd.gettext('nearest-neighbor') + '</option>';
        }
        $sortingVariables.innerHTML = sortingHTML;
        updateSortingControls();

        if(isAnyVariableDate) {
            $dateFormattingContainer.style.display = 'inline-block';
            $dateFormatting.innerHTML = dateFormattingHTML;
        } else {
            $dateFormattingContainer.style.display = 'hidden';
        }
    }

    function changeDataset() {
        var $datasetList = document.getElementById('data-table-dataset-list');
        if(selectedDataset != null) {
            selectedDataset = wpd.appData.getPlotData().getDatasets()[$datasetList.selectedIndex];
            dataProvider.setDataSource(selectedDataset);
        } else if(selectedMeasurement != null) {
            if($datasetList.value === "angle") {
                selectedMeasurement = wpd.appData.getPlotData().getMeasurementsByType(wpd.AngleMeasurement)[0];
            } else if($datasetList.value === "distance") {
                selectedMeasurement = wpd.appData.getPlotData().getMeasurementsByType(wpd.DistanceMeasurement)[0];
            } else if($datasetList.value === "area") {
                selectedMeasurement = wpd.appData.getPlotData().getMeasurementsByType(wpd.AreaMeasurement)[0];
            }
            dataProvider.setDataSource(selectedMeasurement);
        }        
        refresh();
    }

    function updateSortingControls() {
        var sortingKey = document.getElementById('data-sort-variables').value,
            $sortingOrder = document.getElementById('data-sort-order'),
            isConnectivity = sortingKey === 'NearestNeighbor',
            isRaw = sortingKey === 'raw';
        
        if(isConnectivity || isRaw) {
            $sortingOrder.setAttribute('disabled', true);
        } else {
            $sortingOrder.removeAttribute('disabled');
        }
    }

    function reSort() {
        updateSortingControls();
        sortRawData();
        makeTable();
    }

    function sortRawData() {

        if(dataCache == null || dataCache.rawData == null) {
            return;
        }

        sortedData = dataCache.rawData.slice(0);
        var sortingKey = document.getElementById('data-sort-variables').value,
            sortingOrder = document.getElementById('data-sort-order').value,
            isAscending = sortingOrder === 'ascending',
            isRaw = sortingKey === 'raw',
            isConnectivity = sortingKey === 'NearestNeighbor',
            dataIndex,
            fieldCount = dataCache.fields.length;

        if(isRaw) {
            return;
        }

        if(!isConnectivity) {
            dataIndex = dataCache.fields.indexOf(sortingKey);
            if(dataIndex < 0) {
                return;
            }
            sortedData.sort(function(a, b) {
                if(a[dataIndex] > b[dataIndex]) {
                    return isAscending ? 1: -1;
                } else if (a[dataIndex] < b[dataIndex]) {
                    return isAscending ? -1 : 1;
                }
                return 0;
            });
            return;
        }

        if(isConnectivity) {
            var mindist, compdist, minindex,
                rowi, rowcompi,
                rowCount = sortedData.length,
                connFieldIndices = dataCache.connectivityFieldIndices,
                fi, cfi,
                swp;

            for(rowi = 0; rowi < rowCount - 1; rowi++) {
                minindex = -1;
                
                // loop through all other points and find the nearest next neighbor
                for(rowcompi = rowi + 1; rowcompi < rowCount; rowcompi++) {
                    compdist = 0;
                    for(fi = 0; fi < connFieldIndices.length; fi++) {
                        cfi = connFieldIndices[fi];       
                        compdist += (sortedData[rowi][cfi] - sortedData[rowcompi][cfi])*(sortedData[rowi][cfi] - sortedData[rowcompi][cfi]);
                    }

                    if((compdist < mindist) || (minindex === -1)) {
                        mindist = compdist;
                        minindex = rowcompi;
                    }
                }
                
                // swap (minindex) and (rowi+1) rows
                for(fi = 0; fi < dataCache.fields.length; fi++) {
                    swp = sortedData[minindex][fi];
                    sortedData[minindex][fi] = sortedData[rowi+1][fi];
                    sortedData[rowi+1][fi] = swp;
                }
            }

        }
    }

    function makeTable() {
        if(sortedData == null) { return; }

        var $digitizedDataTable = document.getElementById('digitizedDataTable'),
            numFormattingDigits = parseInt(document.getElementById('data-number-format-digits').value, 10),
            numFormattingStyle = document.getElementById('data-number-format-style').value,
            colSeparator = document.getElementById('data-number-format-separator').value,
            rowi,
            coli,
            rowValues,
            dateFormattingStrings = [];

        // "\t" in the column separator should translate to a tab:
        colSeparator = colSeparator.replace(/[^\\]\\t/, "\t").replace(/^\\t/, "\t");

        tableText = '';
        for(rowi = 0; rowi < sortedData.length; rowi++) {
            rowValues = [];
            for(coli = 0; coli < dataCache.fields.length; coli++) {
                if(dataCache.fieldDateFormat[coli] != null) { // Date
                    if(dateFormattingStrings[coli] === undefined) {
                        dateFormattingStrings[coli] = document.getElementById('data-format-string-'+ coli).value;
                    }
                    rowValues[coli] = wpd.dateConverter.formatDateNumber(sortedData[rowi][coli], dateFormattingStrings[coli]);
                } else { // Non-date values
                    if(typeof sortedData[rowi][coli] === 'string') {
                        rowValues[coli] = sortedData[rowi][coli];
                    } else {
                        if(numFormattingStyle === 'fixed' && numFormattingDigits >= 0) {
                            rowValues[coli] = sortedData[rowi][coli].toFixed(numFormattingDigits);
                        } else if(numFormattingStyle === 'precision' && numFormattingDigits >= 0) {
                            rowValues[coli] = sortedData[rowi][coli].toPrecision(numFormattingDigits);
                        } else if(numFormattingStyle === 'exponential' && numFormattingDigits >= 0) {
                            rowValues[coli] = sortedData[rowi][coli].toExponential(numFormattingDigits);
                        } else {
                            rowValues[coli] = sortedData[rowi][coli];
                        }
                    }
                    rowValues[coli] = rowValues[coli].toString().replace('.', decSeparator);
                }
            }
            tableText += rowValues.join(colSeparator);
            tableText += '\n';
        }
        $digitizedDataTable.value = tableText;
    }


    function copyToClipboard() {
        var $digitizedDataTable = document.getElementById('digitizedDataTable');
        $digitizedDataTable.focus();
        $digitizedDataTable.select();
        try {
            document.execCommand('copy');
        } catch(ex) {
            console.log('copyToClipboard', ex.message);
        }        
    }

    function generateCSV() {
        var datasetName = selectedDataset != null ? selectedDataset.name : ((selectedMeasurement instanceof wpd.AngleMeasurement) ? "angles" : "distances");
        wpd.download.csv(tableText, datasetName + ".csv");
    }

    function exportToPlotly() {
        if (sortedData == null) { return; }
        var plotlyData = { "data": [] },
            rowi,
            coli,
            fieldName;

        plotlyData.data[0] = {};

        for (rowi = 0; rowi < sortedData.length; rowi++) {
            for (coli = 0; coli < dataCache.fields.length; coli++) {

                fieldName = dataCache.fields[coli];
                // Replace first two to keep plotly happy:
                if(coli === 0) {
                    fieldName = 'x';
                } else if(coli === 1) {
                    fieldName = 'y';
                }

                if (rowi === 0) {
                    plotlyData.data[0][fieldName] = [];
                }

                if (dataCache.fieldDateFormat[coli] != null) {
                    plotlyData.data[0][fieldName][rowi] = wpd.dateConverter.formatDateNumber(sortedData[rowi][coli], 'yyyy-mm-dd hh:ii:ss');
                } else {
                    plotlyData.data[0][fieldName][rowi] = sortedData[rowi][coli];
                }
            }
        }

        wpd.plotly.send(plotlyData);
    }

    return {
        showTable: showPlotData,
        showAngleData: showAngleData,
        showAreaData: showAreaData,
        showDistanceData: showDistanceData,
        updateSortingControls: updateSortingControls,
        reSort: reSort,
        copyToClipboard: copyToClipboard,
        generateCSV: generateCSV,
        exportToPlotly: exportToPlotly,
        changeDataset: changeDataset
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

/* Multi-layered canvas widget to display plot, data, graphics etc. */
var wpd = wpd || {};
wpd.graphicsWidget = (function () {

    var $mainCanvas, // original picture is displayed here
        $dataCanvas, // data points
        $drawCanvas, // selection region graphics etc
        $hoverCanvas, // temp graphics while drawing
        $topCanvas, // top level, handles mouse events

        $oriImageCanvas,
        $oriDataCanvas,

        $canvasDiv,

        mainCtx,
        dataCtx,
        drawCtx,
        hoverCtx,
        topCtx,

        oriImageCtx,
        oriDataCtx,

        width,
        height,
        originalWidth,
        originalHeight,
        
        aspectRatio,
        displayAspectRatio,
        
        originalImageData,
        scaledImage,
        zoomRatio,
        extendedCrosshair = false,
        hoverTimer,
        
        activeTool,
        repaintHandler,
        
        isCanvasInFocus = false,
        
        firstLoad = true;
        

    function posn(ev) { // get screen pixel from event
        var mainCanvasPosition = $mainCanvas.getBoundingClientRect();
        return {
            x: parseInt(ev.pageX - (mainCanvasPosition.left + window.pageXOffset), 10),
            y: parseInt(ev.pageY - (mainCanvasPosition.top + window.pageYOffset), 10)
        };
    }

    // get image pixel when screen pixel is provided
    function imagePx(screenX, screenY) {
        return {
            x: screenX/zoomRatio,
            y: screenY/zoomRatio
        };
    }

    // get screen pixel when image pixel is provided
    function screenPx(imageX, imageY) {
        return {
            x: imageX*zoomRatio,
            y: imageY*zoomRatio
        };
    }

    function getDisplaySize() {
        return {
            width: width,
            height: height
        };
    }

    function getImageSize() {
        return {
            width: originalWidth,
            height: originalHeight
        };
    }

    function getAllContexts() {
        return {
            mainCtx: mainCtx,
            dataCtx: dataCtx,
            drawCtx: drawCtx,
            hoverCtx: hoverCtx,
            topCtx: topCtx,
            oriImageCtx: oriImageCtx,
            oriDataCtx: oriDataCtx
        };
    }
 
    function resize(cwidth, cheight) {

        cwidth = parseInt(cwidth, 10);
        cheight = parseInt(cheight, 10);

        $canvasDiv.style.width = cwidth + 'px';
        $canvasDiv.style.height = cheight + 'px';

        $mainCanvas.width = cwidth;
        $dataCanvas.width = cwidth;
        $drawCanvas.width = cwidth;
        $hoverCanvas.width = cwidth;
        $topCanvas.width = cwidth;

        $mainCanvas.height = cheight;
        $dataCanvas.height = cheight;
        $drawCanvas.height = cheight;
        $hoverCanvas.height = cheight;
        $topCanvas.height = cheight;

        displayAspectRatio = cwidth/(cheight*1.0);

        width = cwidth;
        height = cheight;

        drawImage();
    }

    function resetAllLayers() {
        $mainCanvas.width = $mainCanvas.width;
        resetDrawingLayers();
    }

    function resetDrawingLayers() {
        $dataCanvas.width = $dataCanvas.width;
        $drawCanvas.width = $drawCanvas.width;
        $hoverCanvas.width = $hoverCanvas.width;
        $topCanvas.width = $topCanvas.width;
        $oriDataCanvas.width = $oriDataCanvas.width;
    }

    function drawImage() {
        if(originalImageData == null) return;
        
        mainCtx.fillStyle = "rgb(255, 255, 255)";
        mainCtx.fillRect(0, 0, width, height);
        mainCtx.drawImage($oriImageCanvas, 0, 0, width, height);

        if(repaintHandler != null && repaintHandler.onRedraw != undefined) {
            repaintHandler.onRedraw();
        }

        if(activeTool != null && activeTool.onRedraw != undefined) {
            activeTool.onRedraw();
        }
                
    }

    function forceHandlerRepaint() {
        if(repaintHandler != null && repaintHandler.onForcedRedraw != undefined) {
            repaintHandler.onForcedRedraw();
        }
    }

    function setRepainter(fhandle) {               
        if(repaintHandler != null && repaintHandler.onRemove != undefined) {
            repaintHandler.onRemove();
        }
        repaintHandler = fhandle;
        if(repaintHandler != null && repaintHandler.onAttach != undefined) {
            repaintHandler.onAttach();
        }
    }

    function getRepainter() {
        return repaintHandler;
    }

    function removeRepainter() {
        if(repaintHandler != null && repaintHandler.onRemove != undefined) {
            repaintHandler.onRemove();
        }
        repaintHandler = null;
    }

    function copyImageDataLayerToScreen() {
        dataCtx.drawImage($oriDataCanvas, 0, 0, width, height); 
    }

    function zoomIn() {
        setZoomRatio(zoomRatio*1.2);
    }

    function zoomOut() {
        setZoomRatio(zoomRatio/1.2);
    }

    function zoomFit() {
        var viewportSize = wpd.layoutManager.getGraphicsViewportSize(),
            newAspectRatio = viewportSize.width/(viewportSize.height*1.0);
        
        if(newAspectRatio > aspectRatio) {
            zoomRatio = viewportSize.height/(originalHeight*1.0);
            resize(viewportSize.height*aspectRatio, viewportSize.height);
        } else {
            zoomRatio = viewportSize.width/(originalWidth*1.0);
            resize(viewportSize.width, viewportSize.width/aspectRatio);
        }
    }

    function zoom100perc() {
        setZoomRatio(1.0);
    }

    function setZoomRatio(zratio) {
        zoomRatio = zratio;
        resize(originalWidth*zoomRatio, originalHeight*zoomRatio);
    }

    function getZoomRatio() {
        return zoomRatio;
    }

    function resetData() {
        $oriDataCanvas.width = $oriDataCanvas.width;
        $dataCanvas.width = $dataCanvas.width;
    }

    function resetHover() {
        $hoverCanvas.width = $hoverCanvas.width;
    }

    function toggleExtendedCrosshair(ev) { // called when backslash is hit
        if (ev.keyCode === 220) {
            ev.preventDefault();
            toggleExtendedCrosshairBtn(); 
        }
    }

    function toggleExtendedCrosshairBtn() { // called directly when toolbar button is hit
        extendedCrosshair = !(extendedCrosshair);
        var $crosshairBtn = document.getElementById('extended-crosshair-btn');
        if(extendedCrosshair) {
            $crosshairBtn.classList.add('pressed-button');
        } else {
            $crosshairBtn.classList.remove('pressed-button');
        }
        $hoverCanvas.width = $hoverCanvas.width;
    }

    function hoverOverCanvas(ev) {
        var pos = posn(ev),
            xpos = pos.x,
            ypos = pos.y,
            imagePos = imagePx(xpos, ypos);

        if(extendedCrosshair) {
            $hoverCanvas.width = $hoverCanvas.width;
            hoverCtx.strokeStyle = "rgba(0,0,0, 0.5)";
            hoverCtx.beginPath();
            hoverCtx.moveTo(xpos, 0);
            hoverCtx.lineTo(xpos, height);
            hoverCtx.moveTo(0, ypos);
            hoverCtx.lineTo(width, ypos);
            hoverCtx.stroke();
        }

        setZoomImage(imagePos.x, imagePos.y);
        wpd.zoomView.setCoords(imagePos.x, imagePos.y);
    }

    function setZoomImage(ix, iy) {
        var zsize = wpd.zoomView.getSize(),
            zratio = wpd.zoomView.getZoomRatio(),
            ix0, iy0,
            zw, zh,
            iw, ih,
            idata, ddata,
            ixmin, iymin, ixmax, iymax,
            zxmin = 0, zymin = 0, zxmax = zsize.width, zymax = zsize.height,
            xcorr, ycorr,
            alpha;

        iw = zsize.width/zratio;
        ih = zsize.height/zratio;
        
        ix0 = ix - iw/2.0; iy0 = iy - ih/2.0;
        
        ixmin = ix0; iymin = iy0;
        ixmax = ix0 + iw; iymax = iy0 + ih;

        if(ix0 < 0) {
            ixmin = 0;
            zxmin = -ix0*zratio;
        }
        if(iy0 < 0) {
            iymin = 0;
            zymin = -iy0*zratio;
        }
        if(ix0 + iw >= originalWidth) {
            ixmax = originalWidth;
            zxmax = zxmax - zratio*(originalWidth - (ix0 + iw));
        }
        if(iy0 + ih >= originalHeight) {
            iymax = originalHeight;
            zymax = zymax - zratio*(originalHeight - (iy0 + ih));
        }
        idata = oriImageCtx.getImageData(parseInt(ixmin, 10), 
                                         parseInt(iymin, 10), 
                                         parseInt(ixmax-ixmin, 10), 
                                         parseInt(iymax-iymin, 10));

        ddata = oriDataCtx.getImageData(parseInt(ixmin, 10), 
                                         parseInt(iymin, 10), 
                                         parseInt(ixmax-ixmin, 10), 
                                         parseInt(iymax-iymin, 10));

        for(var index = 0; index < ddata.data.length; index+=4) {
            if(ddata.data[index] != 0 || ddata.data[index+1] !=0 || ddata.data[index+2] != 0) {
                alpha = ddata.data[index+3]/255;
                idata.data[index] = (1-alpha)*idata.data[index] + alpha*ddata.data[index];
                idata.data[index+1] = (1-alpha)*idata.data[index+1] + alpha*ddata.data[index+1];
                idata.data[index+2] = (1-alpha)*idata.data[index+2] + alpha*ddata.data[index+2];
            }
        }

        // Make this accurate to subpixel level
        xcorr = zratio*(parseInt(ixmin,10) - ixmin);
        ycorr = zratio*(parseInt(iymin,10) - iymin);

        wpd.zoomView.setZoomImage(idata, parseInt(zxmin + xcorr, 10), 
                                     parseInt(zymin + ycorr, 10), 
                                     parseInt(zxmax - zxmin, 10), 
                                     parseInt(zymax - zymin, 10));
    }

    function updateZoomOnEvent(ev) {
        var pos = posn(ev),
            xpos = pos.x,
            ypos = pos.y,
            imagePos = imagePx(xpos, ypos);
        setZoomImage(imagePos.x, imagePos.y);
        wpd.zoomView.setCoords(imagePos.x, imagePos.y);
    }

    function updateZoomToImagePosn(x, y) {
        setZoomImage(x, y);
        wpd.zoomView.setCoords(x, y);
    }

    function hoverOverCanvasHandler(ev) {
        clearTimeout(hoverTimer);
        hoverTimer = setTimeout(hoverOverCanvas(ev), 10);
    }

    function dropHandler(ev) {
        wpd.busyNote.show();
        var allDrop = ev.dataTransfer.files;
        if (allDrop.length === 1) {
            wpd.imageManager.loadFromFile(allDrop[0]);
        }
    }

    function pasteHandler(ev) {
        if(ev.clipboardData !== undefined) {
            var items = ev.clipboardData.items;
            if(items !== undefined) {
                for(var i = 0; i < items.length; i++) {
                    if(items[i].type.indexOf("image") !== -1) {
                        wpd.busyNote.show();
                        var imageFile = items[i].getAsFile();
                        wpd.imageManager.loadFromFile(imageFile);
                    }
                }
            }
        }
    }


    function init() {
        $mainCanvas = document.getElementById('mainCanvas');
        $dataCanvas = document.getElementById('dataCanvas');
        $drawCanvas = document.getElementById('drawCanvas');
        $hoverCanvas = document.getElementById('hoverCanvas');
        $topCanvas = document.getElementById('topCanvas');

        $oriImageCanvas = document.createElement('canvas');
        $oriDataCanvas = document.createElement('canvas');

        mainCtx = $mainCanvas.getContext('2d');
        dataCtx = $dataCanvas.getContext('2d');
        hoverCtx = $hoverCanvas.getContext('2d');
        topCtx = $topCanvas.getContext('2d');
        drawCtx = $drawCanvas.getContext('2d');

        oriImageCtx = $oriImageCanvas.getContext('2d');
        oriDataCtx = $oriDataCanvas.getContext('2d');

        $canvasDiv = document.getElementById('canvasDiv');

        // Extended crosshair
        document.addEventListener('keydown', function(ev) {
            if(isCanvasInFocus) {
                toggleExtendedCrosshair(ev);
            }
        }, false);

        // hovering over canvas
        $topCanvas.addEventListener('mousemove', hoverOverCanvasHandler, false);

        // drag over canvas
        $topCanvas.addEventListener('dragover', function(evt) {
                evt.preventDefault();
            }, true);
        $topCanvas.addEventListener("drop", function(evt) { 
                evt.preventDefault(); 
                dropHandler(evt);
            }, true);

        $topCanvas.addEventListener("mousemove", onMouseMove, false);
        $topCanvas.addEventListener("click", onMouseClick, false);
        $topCanvas.addEventListener("mouseup", onMouseUp, false);
        $topCanvas.addEventListener("mousedown", onMouseDown, false);
        $topCanvas.addEventListener("mouseout", onMouseOut, true);
        document.addEventListener("mouseup", onDocumentMouseUp, false);

        document.addEventListener("mousedown", function(ev) {
            if(ev.target === $topCanvas) {
                isCanvasInFocus = true;
            } else {
                isCanvasInFocus = false;
            }
        }, false);
        document.addEventListener("keydown", function (ev) {
            if(isCanvasInFocus) {
                onKeyDown(ev);
            }
        }, true);
        
        wpd.zoomView.initZoom();
        
        // Paste image from clipboard
        window.addEventListener('paste', function(event) {pasteHandler(event);}, false);
    }

    function loadImage(originalImage) {        
        if($mainCanvas == null) {
            init();
        }        
        removeTool();
        removeRepainter();
        originalWidth = originalImage.width;
        originalHeight = originalImage.height;
        aspectRatio = originalWidth/(originalHeight*1.0);
        $oriImageCanvas.width = originalWidth;
        $oriImageCanvas.height = originalHeight;
        $oriDataCanvas.width = originalWidth;
        $oriDataCanvas.height = originalHeight;
        oriImageCtx.drawImage(originalImage, 0, 0, originalWidth, originalHeight);
        originalImageData = oriImageCtx.getImageData(0, 0, originalWidth, originalHeight);
        resetAllLayers();
        zoomFit();        
        return originalImageData;
    }

    function loadImageFromData(idata, iwidth, iheight, keepZoom) {        
        removeTool();
        removeRepainter();
        originalWidth = iwidth;
        originalHeight = iheight;
        aspectRatio = originalWidth/(originalHeight*1.0);
        $oriImageCanvas.width = originalWidth;
        $oriImageCanvas.height = originalHeight;
        $oriDataCanvas.width = originalWidth;
        $oriDataCanvas.height = originalHeight;
        oriImageCtx.putImageData(idata, 0, 0);
        originalImageData = idata;
        resetAllLayers();
        
        if(!keepZoom) {
            zoomFit();
        } else {
            setZoomRatio(zoomRatio);
        }
    }

    function saveImage() {
        var exportCanvas = document.createElement('canvas'),
            exportCtx = exportCanvas.getContext('2d'),
            exportData,
            di,
            dLayer,
            alpha;
        exportCanvas.width = originalWidth;
        exportCanvas.height = originalHeight;
        exportCtx.drawImage($oriImageCanvas, 0, 0, originalWidth, originalHeight);
        exportData = exportCtx.getImageData(0, 0, originalWidth, originalHeight);
        dLayer = oriDataCtx.getImageData(0, 0, originalWidth, originalHeight);
        for(di = 0; di < exportData.data.length; di+=4) {
            if(dLayer.data[di] != 0 || dLayer.data[di+1] != 0 || dLayer.data[di+2] != 0) {
                alpha = dLayer.data[di+3]/255;
                exportData.data[di] = (1 - alpha)*exportData.data[di] + alpha*dLayer.data[di];
                exportData.data[di+1] = (1 - alpha)*exportData.data[di + 1] + alpha*dLayer.data[di+1];
                exportData.data[di+2] = (1 - alpha)*exportData.data[di + 2] + alpha*dLayer.data[di+2];
            }
        }
        exportCtx.putImageData(exportData, 0, 0);
        window.open(exportCanvas.toDataURL(), "_blank");
    }

    // run an external operation on the image data. this would normally mean a reset.
    function runImageOp(operFn) {
       var opResult = operFn(originalImageData, originalWidth, originalHeight);
       loadImageFromData(opResult.imageData, opResult.width, opResult.height, opResult.keepZoom);
    }

    function getImageData() {
        return originalImageData;
    }

    function setTool(tool) {
        if(activeTool != null && activeTool.onRemove != undefined) {
            activeTool.onRemove();
        }
        activeTool = tool;
        if(activeTool != null && activeTool.onAttach != undefined) {
            activeTool.onAttach();
        }
    }

    function removeTool() {
        if(activeTool != null && activeTool.onRemove != undefined) {
            activeTool.onRemove();
        }
        activeTool = null;
    }

    function onMouseMove(ev) {
        if(activeTool != null && activeTool.onMouseMove != undefined) {
            var pos = posn(ev),
                xpos = pos.x,
                ypos = pos.y,
                imagePos = imagePx(xpos, ypos);
            activeTool.onMouseMove(ev, pos, imagePos);
        }
    }

    function onMouseClick(ev) {
        if(activeTool != null && activeTool.onMouseClick != undefined) {
            var pos = posn(ev),
                xpos = pos.x,
                ypos = pos.y,
                imagePos = imagePx(xpos, ypos);
            activeTool.onMouseClick(ev, pos, imagePos);
        }
    }

    function onDocumentMouseUp(ev) {
        if(activeTool != null && activeTool.onDocumentMouseUp != undefined) {
            var pos = posn(ev),
                xpos = pos.x,
                ypos = pos.y,
                imagePos = imagePx(xpos, ypos);
            activeTool.onDocumentMouseUp(ev, pos, imagePos);
        }
    }

    function onMouseUp(ev) {
        if(activeTool != null && activeTool.onMouseUp != undefined) {
            var pos = posn(ev),
                xpos = pos.x,
                ypos = pos.y,
                imagePos = imagePx(xpos, ypos);
            activeTool.onMouseUp(ev, pos, imagePos);
        }
    }

    function onMouseDown(ev) {
        if(activeTool != null && activeTool.onMouseDown != undefined) {
            var pos = posn(ev),
                xpos = pos.x,
                ypos = pos.y,
                imagePos = imagePx(xpos, ypos);
            activeTool.onMouseDown(ev, pos, imagePos);
        }
    }

    function onMouseOut(ev) {
        if(activeTool != null && activeTool.onMouseOut != undefined) {
            var pos = posn(ev),
                xpos = pos.x,
                ypos = pos.y,
                imagePos = imagePx(xpos, ypos);
            activeTool.onMouseOut(ev, pos, imagePos);
        }
    }

    function onKeyDown(ev) {
        if(activeTool != null && activeTool.onKeyDown != undefined) {
            activeTool.onKeyDown(ev);
        }
    }

    function getImagePNG() {
        let imageURL = $oriImageCanvas.toDataURL("image/png");                
        let bstr = atob(imageURL.split(',')[1]);
        let n = bstr.length;
        let u8arr = new Uint8Array(n);
        while(n--) {
            u8arr[n] = bstr.charCodeAt(n);
        }
        imageFile = new Blob([u8arr], {type:"image/png", encoding:'utf-8'});
        return imageFile;
    }

    return {
        zoomIn: zoomIn,
        zoomOut: zoomOut,
        zoomFit: zoomFit,
        zoom100perc: zoom100perc,
        toggleExtendedCrosshairBtn: toggleExtendedCrosshairBtn,
        setZoomRatio: setZoomRatio,
        getZoomRatio: getZoomRatio,
        
        runImageOp: runImageOp,

        setTool: setTool,
        removeTool: removeTool,

        getAllContexts: getAllContexts,
        resetData: resetData,
        resetHover: resetHover,
        imagePx: imagePx,
        screenPx: screenPx,

        updateZoomOnEvent: updateZoomOnEvent,
        updateZoomToImagePosn: updateZoomToImagePosn,

        getDisplaySize: getDisplaySize,
        getImageSize: getImageSize,

        copyImageDataLayerToScreen: copyImageDataLayerToScreen,
        setRepainter: setRepainter,
        removeRepainter: removeRepainter,
        forceHandlerRepaint: forceHandlerRepaint,
        getRepainter: getRepainter,

        saveImage: saveImage,
        loadImage: loadImage,

        getImagePNG: getImagePNG
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

// layoutManager.js - manage layout of main sections on the screen.
var wpd = wpd || {};
wpd.layoutManager = (function () {
    var layoutTimer,
        $graphicsContainer,
        $sidebarContainer,
        $sidebarControlsContainer,
        $mainContainer,
        $treeContainer;

    // Redo layout when window is resized
    function adjustLayout() {
        var windowWidth = parseInt(document.body.offsetWidth,10),
            windowHeight = parseInt(document.body.offsetHeight,10);

        $sidebarContainer.style.height = windowHeight + 'px';
        $sidebarControlsContainer.style.height = windowHeight - 280 + 'px';
        $mainContainer.style.width = windowWidth - $sidebarContainer.offsetWidth - 5 + 'px';
        $mainContainer.style.height = windowHeight + 'px';
        $graphicsContainer.style.height = windowHeight - 45 + 'px';
        $treeContainer.style.height = windowHeight - 45 + 'px';
        wpd.sidebar.resize();
    }

    function getGraphicsViewportSize() {
        return {
            width: $graphicsContainer.offsetWidth,
            height: $graphicsContainer.offsetHeight
        };
    }

    // event handler
    function adjustLayoutOnResize(ev) {
        clearTimeout(layoutTimer);
        layoutTimer = setTimeout(adjustLayout, 80);
    }
 
    // Set initial layout. Called right when the app is loaded.
    function initialLayout() {
        // do initial layout and also bind to the window resize event
        $graphicsContainer = document.getElementById('graphicsContainer');
        $sidebarContainer = document.getElementById('sidebarContainer');
        $sidebarControlsContainer = document.getElementById('sidebarControlsContainer');
        $mainContainer = document.getElementById('mainContainer');
        $treeContainer = document.getElementById('left-side-container');
        adjustLayout();
         
        window.addEventListener('resize', adjustLayoutOnResize, false);

        wpd.tree.init();
    }

    return {
        initialLayout: initialLayout,
        getGraphicsViewportSize: getGraphicsViewportSize
    };

})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

// Handle popup windows
var wpd = wpd || {};
wpd.popup = (function () {

    var dragInfo = null,
        $activeWindow = null;

    function show(popupid) {

        // Dim lights to make it obvious that these are modal dialog boxes.
        var shadowDiv = document.getElementById('shadow');
        shadowDiv.style.visibility = "visible";
        
        // Display the popup
        var pWindow = document.getElementById(popupid);
        var screenWidth = parseInt(window.innerWidth, 10);
        var screenHeight = parseInt(window.innerHeight, 10);
        var pWidth = parseInt(pWindow.offsetWidth, 10);
        var pHeight = parseInt(pWindow.offsetHeight, 10);
        var xPos = (screenWidth - pWidth)/2;
        var yPos = (screenHeight - pHeight)/2;
        yPos = yPos > 60 ? 60 : yPos;
        pWindow.style.left = xPos + 'px';
        pWindow.style.top = yPos + 'px';
        pWindow.style.visibility = "visible";

        // Attach drag events to the header
        for(var i = 0; i < pWindow.childNodes.length; i++) {
            if(pWindow.childNodes[i].className === 'popupheading') {
                pWindow.childNodes[i].addEventListener("mousedown", startDragging, false);
                break;
            }
        }

        $activeWindow = pWindow;
    }

    function close(popupid) {

        var shadowDiv = document.getElementById('shadow');
        shadowDiv.style.visibility = "hidden";

        var pWindow = document.getElementById(popupid);
        pWindow.style.visibility = "hidden";

        removeDragMask();
        $activeWindow = null;
    }

    function startDragging(ev) {
        // Create a drag mask that will react to mouse action after this point
        var $dragMask = document.createElement('div');
        $dragMask.className = 'popup-drag-mask';
        $dragMask.style.display = 'inline-block';
        $dragMask.addEventListener('mousemove', dragMouseMove, false);
        $dragMask.addEventListener('mouseup', dragMouseUp, false);
        $dragMask.addEventListener('mouseout', dragMouseOut, false);
        document.body.appendChild($dragMask);

        dragInfo = {
            dragMaskDiv: $dragMask,
            initialMouseX: ev.pageX,
            initialMouseY: ev.pageY,
            initialWindowX: $activeWindow.offsetLeft,
            initialWindowY: $activeWindow.offsetTop
        };

        ev.preventDefault();
        ev.stopPropagation();
    }

    function dragMouseMove(ev) {
        moveWindow(ev);
        ev.stopPropagation();
        ev.preventDefault();
    }

    function dragMouseUp(ev) {
        moveWindow(ev);
        removeDragMask(); 
        ev.stopPropagation();
        ev.preventDefault();
    }

    function moveWindow(ev) {
        var newWindowX = (dragInfo.initialWindowX + ev.pageX - dragInfo.initialMouseX),
            newWindowY = (dragInfo.initialWindowY + ev.pageY - dragInfo.initialMouseY),
            appWidth =  parseInt(document.body.offsetWidth, 10),
            appHeight =  parseInt(document.body.offsetHeight, 10),
            windowWidth = parseInt($activeWindow.offsetWidth, 10),
            windowHeight = parseInt($activeWindow.offsetHeight, 10);

        // move only up to a reasonable bound:
        if(newWindowX + 0.7*windowWidth < appWidth && newWindowX > 0 && newWindowY > 0
            && newWindowY + 0.5*windowHeight < appHeight) {
            $activeWindow.style.top = newWindowY + 'px';
            $activeWindow.style.left = newWindowX + 'px';
        }
    }

    function dragMouseOut(ev) {
        removeDragMask();
    }

    function removeDragMask() {
        if(dragInfo != null && dragInfo.dragMaskDiv != null) {
            dragInfo.dragMaskDiv.removeEventListener('mouseout', dragMouseOut, false);
            dragInfo.dragMaskDiv.removeEventListener('mouseup', dragMouseUp, false);
            dragInfo.dragMaskDiv.removeEventListener('mousemove', dragMouseMove, false);
            dragInfo.dragMaskDiv.style.display = 'none';
            document.body.removeChild(dragInfo.dragMaskDiv);
            dragInfo = null;
        }
    }

    return {
        show: show,
        close: close
    };

})();

wpd.busyNote = (function () {
    var noteDiv, isVisible = false;
    
    function show() {
        if(isVisible) {
            return;
        }
        if(noteDiv == null) {
            noteDiv = document.createElement('div');
            noteDiv.id = 'wait';
            noteDiv.innerHTML = '<p align="center">' + wpd.gettext('processing') + '...</p>';
        }
        document.body.appendChild(noteDiv);
        isVisible = true;
    }

    function close() {
        if (noteDiv != null && isVisible === true) {
            document.body.removeChild(noteDiv);
            isVisible = false;
        }
    }

    return {
        show: show,
        close: close
    };
})();

wpd.messagePopup = (function () {
    var close_callback;

    function show(title, msg, callback) {
        wpd.popup.show('messagePopup');
        document.getElementById('message-popup-heading').innerHTML = title;
        document.getElementById('message-popup-text').innerHTML = msg;
        close_callback = callback;
    }

    function close() {
        wpd.popup.close('messagePopup');
        if(close_callback != null) {
            close_callback();
        }
    }

    return {
        show: show,
        close: close
    };
})();

wpd.okCancelPopup = (function () {
    var okCallback, cancelCallback;

    function show(title, msg, ok_callback, cancel_callback) {
        wpd.popup.show('okCancelPopup');
        document.getElementById('ok-cancel-popup-heading').innerHTML = title;
        document.getElementById('ok-cancel-popup-text').innerHTML = msg;
        okCallback = ok_callback;
        cancelCallback = cancel_callback;
    }

    function ok() {
        wpd.popup.close('okCancelPopup');
        okCallback();
    }

    function cancel() {
        wpd.popup.close('okCancelPopup');
        cancelCallback();
    }

    return {
        show: show,
        ok: ok,
        cancel: cancel
    };
})();

wpd.unsupported = function () {
    wpd.messagePopup.show(wpd.gettext('unsupported'), wpd.gettext('unsupported-text'));
};

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
wpd.sidebar = (function () {

    function show(sbid) { // Shows a specific sidebar
        clear();
        var sb = document.getElementById(sbid);
        sb.style.display = "inline-block";
        sb.style.height = parseInt(document.body.offsetHeight,10) - 280 + 'px';
    }

    function clear() { // Clears all open sidebars
        var sidebarList = document.getElementsByClassName('sidebar'),
            ii;

        for (ii = 0; ii < sidebarList.length; ii++) {
            sidebarList[ii].style.display="none";

        }
    }

    function resize() {
        var sidebarList = document.getElementsByClassName('sidebar'),
            ii;

        for (ii = 0; ii < sidebarList.length; ii++) {
            if (sidebarList[ii].style.display === "inline-block") {
                sidebarList[ii].style.height = parseInt(document.body.offsetHeight,10) - 280 + 'px';
            }
        }
    }

    return {
        show: show,
        clear: clear,
        resize: resize
    };

})();


/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
wpd.toolbar = (function () {

    function show(tbid) { // Shows a specific toolbar
        clear();
        var tb = document.getElementById(tbid);
        tb.style.visibility = "visible";
    }

    function clear() { // Clears all open toolbars
        var toolbarList = document.getElementsByClassName('toolbar'),
            ii;

        for (ii = 0; ii < toolbarList.length; ii++) {
             toolbarList[ii].style.visibility="hidden";
        }        
    }

    return {
        show: show,
        clear: clear
    };
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.transformationEquations = (function () {
    function show() {        
        wpd.popup.show('axes-transformation-equations-window');
        var $list = document.getElementById('axes-transformation-equation-list'),
            listHTML = '',
            axes = wpd.tree.getActiveAxes(),
            eqns = axes.getTransformationEquations(),
            i,
            axesType;

        listHTML += '<p><b>Axes Type</b>: ';
        if(axes instanceof wpd.XYAxes) {
            listHTML += 'XY</p>';
        } else if(axes instanceof wpd.PolarAxes) {
            listHTML += 'Polar</p>';
        } else if(axes instanceof wpd.TernaryAxes) {
            listHTML += 'Ternary</p>';
        } else if(axes instanceof wpd.MapAxes) {
            listHTML += 'Map</p>';
        } else if(axes instanceof wpd.ImageAxes) {
            listHTML += 'Image</p>';
        }

        if(eqns.pixelToData != null) {
            listHTML += '<p><b>Pixel to Data</b></p><ol>';
            for(i = 0; i < eqns.pixelToData.length; i++) {
                listHTML += '<li><p class="footnote">'+eqns.pixelToData[i]+"</p></li>";
            }
            listHTML += '</ol>';
        }
        
        listHTML += '<p>&nbsp;</p>';

        if(eqns.dataToPixel != null) {
            listHTML += '<p><b>Data to Pixel</b></p><ol>';
            for(i = 0; i < eqns.dataToPixel.length; i++) {
                listHTML += '<li><p class="footnote">'+eqns.dataToPixel[i]+"</p></li>";
            }
            listHTML += '</ol>';
        }
        
        $list.innerHTML = listHTML;
    }
    return {
        show: show
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.TreeWidget = class {
    constructor($elem) {
        this.$mainElem = $elem;
        this.treeData = null;
        this.$mainElem.addEventListener("click", e => this._onclick(e));
        this.$mainElem.addEventListener("keydown", e => this._onkeydown(e));
        this.$mainElem.addEventListener("dblclick", e => this._ondblclick(e));
        this.idmap = [];
        this.itemCount = 0;
        this.selectedPath = null;
    }

    _renderFolder(data, basePath, isInnerFolder) {
        if(data == null) return;

        let htmlStr = "";
        
        if(isInnerFolder) {
            htmlStr = "<ul class=\"tree-list\">";
        } else {
            htmlStr = "<ul class=\"tree-list-root\">";
        }
        
        for(let i = 0; i < data.length; i++) {
            let item = data[i];
            this.itemCount++;
            if(typeof(item) === "string") {
                htmlStr += "<li title=\"" + item + "\">";
                htmlStr += "<span class=\"tree-item\" id=\"tree-item-id-" + this.itemCount + "\">" + item + "</span>";
                this.idmap[this.itemCount] = basePath + "/" + item;
            } else if(typeof(item) === "object") {
                htmlStr += "<li>";
                let labelKey = Object.keys(item)[0];
                htmlStr += "<span class=\"tree-folder\" id=\"tree-item-id-" + this.itemCount + "\">" + labelKey + "</span>";
                this.idmap[this.itemCount] = basePath + "/" + labelKey;
                htmlStr += this._renderFolder(item[labelKey], basePath + "/" + labelKey, true);
            }
            htmlStr += "</li>";
        }
        htmlStr += "</ul>";
        return(htmlStr);
    }
    
    render(treeData) {
        this.idmap = [];
        this.itemCount = 0;
        this.treeData = treeData;
        this.$mainElem.innerHTML = this._renderFolder(this.treeData, "", false);
        this.selectedPath = null;
    }

    _unselectAll() {
        const $folders = this.$mainElem.querySelectorAll(".tree-folder");
        const $items = this.$mainElem.querySelectorAll(".tree-item");
        $folders.forEach(function($e) {
            $e.classList.remove("tree-selected");
        });
        $items.forEach(function($e) {
            $e.classList.remove("tree-selected");
        });
        this.selectedPath = null;
    }

    selectPath(itemPath, suppressSecondaryActions) {
        const itemId = this.idmap.indexOf(itemPath);
        if(itemId >= 0) {
            this._unselectAll();
            this.selectedPath = itemPath;
            const $item = document.getElementById("tree-item-id-" + itemId);
            $item.classList.add("tree-selected");
            if(this.itemSelectionCallback != null) {
                this.itemSelectionCallback($item, itemPath, suppressSecondaryActions);
            }
        }
    }

    _onclick(e) {
        const isItem = e.target.classList.contains("tree-item");
        const isFolder = e.target.classList.contains("tree-folder");
        if(isItem || isFolder) {
            this._unselectAll();
            e.target.classList.add("tree-selected");
            if(this.itemSelectionCallback != null) {
                let itemId = parseInt(e.target.id.replace("tree-item-id-",""),10);
                if(!isNaN(itemId)) {
                    this.selectedPath = this.idmap[itemId];
                    this.itemSelectionCallback(e.target, this.idmap[itemId], false);
                }
            }
        }
    }

    _onkeydown(e) {        
        // allow either F2 or Meta+R to trigger rename
        if(e.key === "F2" || (e.key.toLowerCase() === "r" && e.metaKey))
        {
            if(this.itemRenameCallback) {                                
                this.itemRenameCallback(e.target, this.selectedPath, false);
                e.preventDefault();
            }
        }
    }

    _ondblclick(e) {        
        if(this.itemRenameCallback) {
            this.itemRenameCallback(e.target, this.selectedPath, false);
            e.preventDefault();
            e.stopPropagation();            
        }                
    }

    onItemSelection(callback) {
        this.itemSelectionCallback = callback;
    }

    onItemRename(callback) {
        this.itemRenameCallback = callback;
    }

    getSelectedPath() {
        return this.selectedPath;
    }
};

wpd.tree = (function() {

    let treeWidget = null;
    let activeDataset = null;
    let activeAxes = null;

    // polyfill for IE11/Microsoft Edge
    if (window.NodeList && !NodeList.prototype.forEach) {
        NodeList.prototype.forEach = function (callback, thisArg) {
            thisArg = thisArg || window;
            for (var i = 0; i < this.length; i++) {
                callback.call(thisArg, this[i], i, this);
            }
        };
    }

    function buildTree() {
        if(treeWidget == null) {
            return;
        }
        let treeData = [];
        
        const plotData = wpd.appData.getPlotData();
                
        let axesFolder = {};
        axesFolder[wpd.gettext("axes")] = plotData.getAxesNames();        
        treeData.push(axesFolder);

        const datasetNames = plotData.getDatasetNames();
        let datasetsFolder = {};
        datasetsFolder[wpd.gettext("datasets")] = datasetNames;
        treeData.push(datasetsFolder);

        let measurementItems = [];
        let distMeasures = plotData.getMeasurementsByType(wpd.DistanceMeasurement);
        let angleMeasures = plotData.getMeasurementsByType(wpd.AngleMeasurement);
        let areaMeasures = plotData.getMeasurementsByType(wpd.AreaMeasurement);
        if(areaMeasures.length > 0) {
            measurementItems.push(wpd.gettext("area"));
        }
        if(angleMeasures.length > 0) {
            measurementItems.push(wpd.gettext("angle"));
        }
        if(distMeasures.length > 0) {
            measurementItems.push(wpd.gettext("distance"));
        }
        let measurementFolder = {};
        measurementFolder[wpd.gettext("measurements")] = measurementItems;
        treeData.push(measurementFolder);

        treeWidget.render(treeData);

        showTreeItemWidget(null);
    }

    function showTreeItemWidget(id) {
        const $treeWidgets = document.querySelectorAll(".tree-widget");
        $treeWidgets.forEach(function($e) {
            if($e.id === id) {
                $e.style.display = "inline";
            } else {
                $e.style.display = "none";
            }
        });
    }

    function resetGraphics() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.resetData();
        wpd.sidebar.clear();
    }

    function onDatasetSelection(elem, path, suppressSecondaryActions) {
        // get dataset index
        const plotData = wpd.appData.getPlotData();
        const dsNamesColl = plotData.getDatasetNames();
        const dsIdx = dsNamesColl.indexOf(path.replace("/"+ wpd.gettext("datasets") +"/",""));
        if(dsIdx >= 0) {
            activeDataset = plotData.getDatasets()[dsIdx];            
            // refresh UI
            if(!suppressSecondaryActions) {
                resetGraphics();
                wpd.acquireData.load();    
            }            
        }        
        showTreeItemWidget('dataset-item-tree-widget');
        renderDatasetAxesSelection();
    }

    function renderDatasetAxesSelection() {
        if(activeDataset == null) return;
        const plotData = wpd.appData.getPlotData();
        const axesNames = plotData.getAxesNames();
        const dsaxes = plotData.getAxesForDataset(activeDataset);
        const $selection = document.getElementById("dataset-item-axes-select");
        let innerHTML = "<option value='-1'>None</option>";
        for(let axIdx = 0; axIdx < axesNames.length; axIdx++) {
            innerHTML += "<option value='" + axIdx + "'>" + axesNames[axIdx] + "</option>";
        }
        $selection.innerHTML = innerHTML;
        if(dsaxes == null) {
            $selection.value = "-1";
        } else {
            $selection.value = axesNames.indexOf(dsaxes.name);
        }
        activeAxes = dsaxes;
    }

    function renderAreaAxesSelection() {
        renderAxesSelectionForMeasurement(wpd.measurementModes.area);
    }

    function renderDistanceAxesSelection() {
        renderAxesSelectionForMeasurement(wpd.measurementModes.distance);
    }
    
    function renderAxesSelectionForMeasurement(mode) {
        const isDist = mode == wpd.measurementModes.distance;
        const plotData = wpd.appData.getPlotData();
        const msColl = isDist ? plotData.getMeasurementsByType(wpd.DistanceMeasurement) : 
                                plotData.getMeasurementsByType(wpd.AreaMeasurement);
        if(msColl.length != 1) return; // only 1 distance or area object is supported right now
        const ms = msColl[0];
        const $selection = isDist ? document.getElementById("distance-item-axes-select") :
                                    document.getElementById("area-item-axes-select");;
        const axesColl = plotData.getAxesColl();
        const axes = plotData.getAxesForMeasurement(ms);
        let innerHTML = "<option value='-1'>None</option>";
        for(let axIdx = 0; axIdx < axesColl.length; axIdx++) {
            if(axesColl[axIdx] instanceof wpd.ImageAxes || axesColl[axIdx] instanceof wpd.MapAxes) {
                innerHTML += "<option value='" + axIdx + "'>" + axesColl[axIdx].name + "</option>";
            }            
        }
        $selection.innerHTML = innerHTML;
        if(axes == null) {
            $selection.value = "-1";    
        } else {
            $selection.value = axesColl.indexOf(axes);
        }
        activeAxes = axes;        
    }

    function onAxesSelection(elem, path, suppressSecondaryActions) {
        resetGraphics();
        showTreeItemWidget("axes-item-tree-widget");
        const axName = path.replace("/"+wpd.gettext("axes")+"/", "");
        const plotData = wpd.appData.getPlotData();
        const axIdx = plotData.getAxesNames().indexOf(axName);
        activeAxes = plotData.getAxesColl()[axIdx];
        const $tweakButton = document.getElementById("tweak-axes-calibration-button");        
        $tweakButton.disabled = activeAxes instanceof wpd.ImageAxes ? true : false;        
    }

    function onSelection(elem, path, suppressSecondaryActions) {
        if(path === "/" + wpd.gettext("datasets")) {
            resetGraphics();
            showTreeItemWidget("dataset-group-tree-widget");
            activeAxes = null;
        } else if(path === "/" + wpd.gettext("axes")) {
            resetGraphics();
            showTreeItemWidget("axes-group-tree-widget");
            activeAxes = null;
        } else if(path === "/" + wpd.gettext("measurements")) {
            resetGraphics();
            showTreeItemWidget("measurement-group-tree-widget");
            activeAxes = null;
        } else if(path === '/'+wpd.gettext('measurements')+'/'+wpd.gettext('distance')) {
            if(!suppressSecondaryActions) {
                wpd.measurement.start(wpd.measurementModes.distance);
            }
            showTreeItemWidget('distance-item-tree-widget');
            renderDistanceAxesSelection();            
        } else if(path === '/'+wpd.gettext('measurements')+'/'+wpd.gettext('angle')) {
            if(!suppressSecondaryActions) {
                wpd.measurement.start(wpd.measurementModes.angle);
            }
            showTreeItemWidget('angle-item-tree-widget');
            activeAxes = null;
        } else if(path === '/'+wpd.gettext('measurements')+'/'+wpd.gettext('area')) {
            if(!suppressSecondaryActions) {
                wpd.measurement.start(wpd.measurementModes.area);
            }
            showTreeItemWidget('area-item-tree-widget');
            renderAreaAxesSelection();
        } else if(path.startsWith("/"+ wpd.gettext("datasets") +"/")) {
            onDatasetSelection(elem, path, suppressSecondaryActions);
        } else if(path.startsWith("/" + wpd.gettext("axes") + "/")) {
            onAxesSelection(elem, path, suppressSecondaryActions);            
        } else {
            resetGraphics();
            showTreeItemWidget(null);
            activeAxes = null;
        }
    }

    function onRename(elem, path, suppressSecondaryActions) {
        if(path.startsWith("/"+ wpd.gettext("datasets") +"/")) {
            wpd.dataSeriesManagement.showRenameDataset();
        } else if(path.startsWith("/" + wpd.gettext("axes") + "/")) {
            wpd.alignAxes.showRenameAxes();
        }
    }

    function init() {
        const $treeElem = document.getElementById("tree-container");        
        treeWidget = new wpd.TreeWidget($treeElem);
        treeWidget.onItemSelection(onSelection)
        treeWidget.onItemRename(onRename);
        buildTree();
    }

    function refresh() {
        buildTree();
    }

    function refreshPreservingSelection(forceRefresh) {
        if(treeWidget != null) {
            const selectedPath = treeWidget.getSelectedPath();
            refresh();
            treeWidget.selectPath(selectedPath, !forceRefresh);
        } else {
            refresh();
        }
    }

    function selectPath(path, suppressSecondaryActions) {
        treeWidget.selectPath(path, suppressSecondaryActions);
    }

    function addMeasurement(mode) {
        wpd.measurement.start(mode);
        refresh();
        if(mode === wpd.measurementModes.distance) { 
            wpd.tree.selectPath("/"+wpd.gettext("measurements")+"/"+wpd.gettext("distance"), true);
        } else if(mode === wpd.measurementModes.angle) {
            wpd.tree.selectPath("/"+wpd.gettext("measurements")+"/"+wpd.gettext("angle"), true);
        } else if(mode === wpd.measurementModes.area) {
            wpd.tree.selectPath("/"+wpd.gettext("measurements")+"/"+wpd.gettext("area"), true);
        }
    }

    function getActiveDataset() {
        return activeDataset;
    }

    function getActiveAxes() {
        return activeAxes;
    }

    return {
        init: init,
        refresh: refresh,
        refreshPreservingSelection: refreshPreservingSelection,
        selectPath: selectPath,
        addMeasurement: addMeasurement,
        getActiveDataset: getActiveDataset,
        getActiveAxes: getActiveAxes        
    };
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.webcamCapture = (function () {

    var cameraStream;

    function isSupported() {
        return !(getUserMedia() == null);
    }

    function unsupportedBrowser() {
        wpd.messagePopup.show(wpd.gettext('webcam-capture'), wpd.gettext('webcam-capture-text'));
    }

    function getUserMedia() {
        return navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
    }

    function start() {
        if(!isSupported()) {
            unsupportedBrowser();
            return;
        }
        wpd.popup.show('webcamCapture'); 
        var $camVideo = document.getElementById('webcamVideo');
        navigator.getUserMedia = getUserMedia();
        navigator.getUserMedia({video: true}, function(stream) {
            cameraStream = stream;
            $camVideo.src = window.URL.createObjectURL(stream);
  		}, function() {}); 
    }

    function capture() {
        var $webcamCanvas = document.createElement('canvas'),
            $camVideo = document.getElementById('webcamVideo'),
            webcamCtx = $webcamCanvas.getContext('2d'),
            imageData;
        $webcamCanvas.width = $camVideo.videoWidth;
        $webcamCanvas.height = $camVideo.videoHeight;
        webcamCtx.drawImage($camVideo, 0, 0);
        imageData = webcamCtx.getImageData(0, 0, $webcamCanvas.width, $webcamCanvas.height);
        cameraOff();
        wpd.graphicsWidget.runImageOp(function() {
            return {
                imageData: imageData,
                width: $webcamCanvas.width,
                height: $webcamCanvas.height
            };
        });
    }

    function cameraOff() {
        if(cameraStream != undefined) {
            cameraStream.stop();
        }
        wpd.popup.close('webcamCapture'); 
    }

    function cancel() {
        cameraOff();
    }

    return {
        start: start,
        cancel: cancel,
        capture: capture
    };

})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

/* Zoomed-in view */
var wpd = wpd || {};
wpd.zoomView = (function() {
    var zCanvas, 
        zctx,
        tempCanvas,
        tctx,
        zWindowWidth = 250,
        zWindowHeight = 250,
        $mPosn,
        extendedCrosshair = false,
        pix = [],
        zoomTimeout,
        zoomRatio,
        crosshairColorText = 'black';

    pix[0] = [];

    function init() {

        zCanvas = document.getElementById('zoomCanvas');
    	zctx = zCanvas.getContext('2d');
	    tempCanvas = document.createElement('canvas');
        tctx = tempCanvas.getContext('2d');

        $mPosn = document.getElementById('mousePosition');

        zoomRatio = 5;

        drawCrosshair();
    }

    function drawCrosshair() {
        var zCrossHair = document.getElementById("zoomCrossHair");
        var zchCtx = zCrossHair.getContext("2d");
        
        zCrossHair.width = zCrossHair.width;

        if(crosshairColorText === 'black') {
            zchCtx.strokeStyle = "rgba(0,0,0,1)";
        } else if(crosshairColorText === 'red') {
            zchCtx.strokeStyle = "rgba(255,0,0,1)";
        } else if(crosshairColorText === 'yellow') {
            zchCtx.strokeStyle = "rgba(255,255,0,1)";
        } else {
            zchCtx.strokeStyle = "rgba(0,0,0,1)";
        }

        zchCtx.beginPath();
        zchCtx.moveTo(zWindowWidth/2, 0);
        zchCtx.lineTo(zWindowWidth/2, zWindowHeight);
        zchCtx.moveTo(0, zWindowHeight/2);
        zchCtx.lineTo(zWindowWidth, zWindowHeight/2);
        zchCtx.stroke();
    }
 
    function setZoomRatio(zratio) {
        zoomRatio = zratio;
    }

    function getZoomRatio() {
        return zoomRatio;
    }

    function getSize() {
         return {
            width: zWindowWidth,
            height: zWindowHeight
        };

    }

    function setZoomImage(imgData, x0, y0, zwidth, zheight) {
        tempCanvas.width = zwidth/zoomRatio;
        tempCanvas.height = zheight/zoomRatio;
        tctx.putImageData(imgData, 0, 0);
        zCanvas.width = zCanvas.width;
        zctx.drawImage(tempCanvas, x0, y0, zwidth, zheight);
    }

    function setCoords(imageX, imageY) {
        const axes = wpd.tree.getActiveAxes();        
        if(axes != null) {            
            $mPosn.innerHTML = axes.pixelToLiveString(imageX, imageY);
        } else {
            $mPosn.innerHTML = imageX.toFixed(2) + ', ' + imageY.toFixed(2);
        }
    }

    function showSettingsWindow() {
        document.getElementById('zoom-magnification-value').value = zoomRatio;
        document.getElementById('zoom-crosshair-color-value').value = crosshairColorText;
        wpd.popup.show('zoom-settings-popup');
    }

    function applySettings() {
        zoomRatio = document.getElementById('zoom-magnification-value').value;
        crosshairColorText = document.getElementById('zoom-crosshair-color-value').value;
        drawCrosshair();
        wpd.popup.close('zoom-settings-popup');
    }

    return {
        initZoom: init,
        setZoomImage: setZoomImage,
        setCoords: setCoords,
        setZoomRatio: setZoomRatio,
        getZoomRatio: getZoomRatio,
        getSize: getSize,
        showSettingsWindow: showSettingsWindow,
        applySettings: applySettings
    };
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.AxesCornersTool = (function () {

    var Tool = function(calibration, reloadTool) {
        var pointCount = 0,
            _calibration = calibration,
            isCapturingCorners = true; 

        if(reloadTool) {
            pointCount = _calibration.maxPointCount;            
            isCapturingCorners = false;
        } else {
            pointCount = 0;            
            isCapturingCorners = true;            
            wpd.graphicsWidget.resetData();
        }

        this.onMouseClick = function(ev, pos, imagePos) {

            if(isCapturingCorners) {
                pointCount = pointCount + 1;
                                
                _calibration.addPoint(imagePos.x, imagePos.y, 0, 0);
                _calibration.unselectAll();
                _calibration.selectPoint(pointCount-1);
                wpd.graphicsWidget.forceHandlerRepaint(); 

                if(pointCount === _calibration.maxPointCount) {
                    isCapturingCorners = false;
                    wpd.alignAxes.calibrationCompleted();
                }

                wpd.graphicsWidget.updateZoomOnEvent(ev);
            } else {                
                _calibration.unselectAll();
                //cal.selectNearestPoint(imagePos.x, imagePos.y, 15.0/wpd.graphicsWidget.getZoomRatio());
                _calibration.selectNearestPoint(imagePos.x, imagePos.y);
                wpd.graphicsWidget.forceHandlerRepaint();
                wpd.graphicsWidget.updateZoomOnEvent(ev);

            }
        };

        this.onKeyDown = function(ev) {
            
            if(_calibration.getSelectedPoints().length === 0) {
                return;
            }

            var selPoint = _calibration.getPoint(_calibration.getSelectedPoints()[0]),
                pointPx = selPoint.px,
                pointPy = selPoint.py,
                stepSize = ev.shiftKey === true ? 5/wpd.graphicsWidget.getZoomRatio() : 0.5/wpd.graphicsWidget.getZoomRatio();

            if(wpd.keyCodes.isUp(ev.keyCode)) {
                pointPy = pointPy - stepSize;
            } else if(wpd.keyCodes.isDown(ev.keyCode)) {
                pointPy = pointPy + stepSize;
            } else if(wpd.keyCodes.isLeft(ev.keyCode)) {
                pointPx = pointPx - stepSize;
            } else if(wpd.keyCodes.isRight(ev.keyCode)) {
                pointPx = pointPx + stepSize;
            } else {
                return;
            }
            
            _calibration.changePointPx(_calibration.getSelectedPoints()[0], pointPx, pointPy);
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomToImagePosn(pointPx, pointPy);
            ev.preventDefault();
            ev.stopPropagation();
        };

    };

    return Tool;
})();


wpd.AlignmentCornersRepainter = (function () {
    var Tool = function (calibration) {
        var _calibration = calibration;

        this.painterName = 'AlignmentCornersReptainer';

        this.onForcedRedraw = function () {
            wpd.graphicsWidget.resetData();
            this.onRedraw();
        };

        this.onRedraw = function () {
            
            if (_calibration == null) { return; }

            var i, imagePos, imagePx, fillStyle;

            for(i = 0; i < _calibration.getCount(); i++) {
                imagePos = _calibration.getPoint(i);
                imagePx = { x: imagePos.px, y: imagePos.py };

                if(_calibration.isPointSelected(i)) {
                    fillStyle = "rgba(0,200,0,1)";
                } else {
        		    fillStyle = "rgba(200,0,0,1)";
                }

                wpd.graphicsHelper.drawPoint(imagePx, fillStyle, _calibration.labels[i], _calibration.labelPositions[i]);
            }
        };
    };
    return Tool;
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.ColorPickerTool = (function () {
    var Tool = function () {
        var ctx = wpd.graphicsWidget.getAllContexts();

        this.onMouseClick = function(ev, pos, imagePos) {
            var ir, ig, ib, ia, pixData;
            
            pixData = ctx.oriImageCtx.getImageData(imagePos.x, imagePos.y, 1, 1);
            ir = pixData.data[0];
            ig = pixData.data[1];
            ib = pixData.data[2];
            ia = pixData.data[3];
            if(ia === 0) { // for transparent color, assume white RGB
                ir = 255; ig = 255; ib = 255;
            }
            this.onComplete([ir, ig, ib]);
        };

        this.onComplete = function(col) {};
    };
    return Tool;
})();


wpd.ColorFilterRepainter = (function () {
    var Painter = function () {
        this.painterName = 'colorFilterRepainter';

        this.onRedraw = function () {
            var autoDetector = wpd.appData.getPlotData().getAutoDetector();
            wpd.colorSelectionWidget.paintFilteredColor(autoDetector.binaryData, autoDetector.mask);
        };
    };
    return Painter;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.graphicsHelper = (function () {

    // imagePx - relative to original image
    // fillStyle - e.g. "rgb(200,0,0)"
    // label - e.g. "Bar 0"
    // position - "N", "E", "S" (default), or "W"
    function drawPoint(imagePx, fillStyle, label, position) {
        var screenPx = wpd.graphicsWidget.screenPx(imagePx.x, imagePx.y),
            ctx = wpd.graphicsWidget.getAllContexts(),
            labelWidth,
            imageHeight = wpd.graphicsWidget.getImageSize().height;

        if(label != null) {
            // Display Data Canvas Layer
            ctx.dataCtx.font = "15px sans-serif";
            labelWidth = ctx.dataCtx.measureText(label).width;
            ctx.dataCtx.fillStyle = "rgba(255, 255, 255, 0.7)";

            // Original Image Data Canvas Layer
            // No translucent background for text here.
            ctx.oriDataCtx.font = "15px sans-serif";
            ctx.oriDataCtx.fillStyle = fillStyle;

            // Switch for both canvases
            switch(position){
                case "N":
                case "n":
                    ctx.dataCtx.fillRect(screenPx.x - 13, screenPx.y - 24, labelWidth + 5, 35);
                    ctx.dataCtx.fillStyle = fillStyle;
                    ctx.dataCtx.fillText(label, screenPx.x - 10, screenPx.y - 7);
                    ctx.oriDataCtx.fillText(label, imagePx.x - 10, imagePx.y - 7);
                    break;
                case "E":
                case "e":
                    ctx.dataCtx.fillRect(screenPx.x - 7, screenPx.y - 16, labelWidth + 17, 26);
                    ctx.dataCtx.fillStyle = fillStyle;
                    ctx.dataCtx.fillText(label, screenPx.x + 7, screenPx.y + 5);
                    ctx.oriDataCtx.fillText(label, imagePx.x + 7, imagePx.y + 5);
                    break;
                case "W":
                case "w":
                    ctx.dataCtx.fillRect(screenPx.x - labelWidth - 10, screenPx.y - 16, labelWidth + 17, 26);
                    ctx.dataCtx.fillStyle = fillStyle;
                    ctx.dataCtx.fillText(label, screenPx.x - labelWidth - 7, screenPx.y + 5);
                    ctx.oriDataCtx.fillText(label, imagePx.x - labelWidth - 7, imagePx.y + 5);
                    break;
                default:
                    ctx.dataCtx.fillRect(screenPx.x - 13, screenPx.y - 8, labelWidth + 5, 35);
                    ctx.dataCtx.fillStyle = fillStyle;
                    ctx.dataCtx.fillText(label, screenPx.x - 10, screenPx.y + 18);
                    ctx.oriDataCtx.fillText(label, imagePx.x - 10, imagePx.y + 18);
            }
        }

        // Display Data Canvas Layer
        ctx.dataCtx.beginPath();
        ctx.dataCtx.fillStyle = fillStyle;
        ctx.dataCtx.strokeStyle = "rgb(255, 255, 255)";
        ctx.dataCtx.arc(screenPx.x, screenPx.y, 4, 0, 2.0*Math.PI, true);
        ctx.dataCtx.fill();
        ctx.dataCtx.stroke();

        // Original Image Data Canvas Layer
        ctx.oriDataCtx.beginPath();
        ctx.oriDataCtx.fillStyle = fillStyle;
        ctx.oriDataCtx.strokeStyle = "rgb(255, 255, 255)";
        ctx.oriDataCtx.arc(imagePx.x, imagePx.y, imageHeight > 1500 ? 4 : 2, 0, 2.0*Math.PI, true);
        ctx.oriDataCtx.fill();
        ctx.oriDataCtx.stroke();
    }

    return {
        drawPoint : drawPoint
    };

})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.GridColorFilterRepainter = (function () {
    var Painter = function () {
        this.painterName = 'gridColorFilterRepainter';

        this.onRedraw = function () {
            var autoDetector = wpd.appData.getPlotData().getAutoDetector();
            wpd.colorSelectionWidget.paintFilteredColor(autoDetector.gridBinaryData, autoDetector.gridMask.pixels);
        };
    }
    return Painter;
})();


// TODO: Think of reusing mask.js code here
wpd.GridBoxTool = (function () {
    var Tool = function () {
        var isDrawing = false,
            topImageCorner,
            topScreenCorner,
            ctx = wpd.graphicsWidget.getAllContexts(),
            moveTimer,
            screen_pos,

            mouseMoveHandler = function () {
                wpd.graphicsWidget.resetHover();
                ctx.hoverCtx.strokeStyle = "rgb(0,0,0)";
    		    ctx.hoverCtx.strokeRect(topScreenCorner.x, topScreenCorner.y, screen_pos.x - topScreenCorner.x, screen_pos.y - topScreenCorner.y);
            },

            mouseUpHandler = function (ev, pos, imagePos) {
                if(isDrawing === false) {
                    return;
                }
                clearTimeout(moveTimer);
                isDrawing = false;
                wpd.graphicsWidget.resetHover();
                ctx.dataCtx.fillStyle = "rgba(255,255,0,0.8)";
                ctx.dataCtx.fillRect(topScreenCorner.x, topScreenCorner.y, pos.x-topScreenCorner.x, pos.y-topScreenCorner.y);
                ctx.oriDataCtx.fillStyle = "rgba(255,255,0,0.8)";
                ctx.oriDataCtx.fillRect(topImageCorner.x, topImageCorner.y, imagePos.x - topImageCorner.x, imagePos.y - topImageCorner.y);
            },

            mouseOutPos = null,
            mouseOutImagePos = null;

        this.onAttach = function () {
            wpd.graphicsWidget.setRepainter(new wpd.GridMaskPainter());
            document.getElementById('grid-mask-box').classList.add('pressed-button');
            document.getElementById('grid-mask-view').classList.add('pressed-button');
        };

        this.onMouseDown = function (ev, pos, imagePos) {
            if(isDrawing === true) return;
            isDrawing = true;
            topImageCorner = imagePos;
            topScreenCorner = pos;
        };

        this.onMouseMove = function (ev, pos, imagePos) {
            if(isDrawing === false) return;
            screen_pos = pos;
            clearTimeout(moveTimer);
            moveTimer = setTimeout(mouseMoveHandler, 2);
        };

        this.onMouseOut = function (ev, pos, imagePos) {
            if(isDrawing === true) {
                clearTimeout(moveTimer);
                mouseOutPos = pos;
                mouseOutImagePos = imagePos;
            }
        };

        this.onDocumentMouseUp = function (ev, pos, imagePos) {
            if (mouseOutPos != null && mouseOutImagePos != null) {
                mouseUpHandler(ev, mouseOutPos, mouseOutImagePos);
            } else {
                mouseUpHandler(ev, pos, imagePos);
            }
            mouseOutPos = null;
            mouseOutImagePos = null;
        };

        this.onMouseUp = function (ev, pos, imagePos) {
            mouseUpHandler(ev, pos, imagePos);
        };

        this.onRemove = function () {
            document.getElementById('grid-mask-box').classList.remove('pressed-button');
            document.getElementById('grid-mask-view').classList.remove('pressed-button');
            wpd.gridDetection.grabMask();
        };
    };
    return Tool;
})();


wpd.GridViewMaskTool = (function () {
    var Tool = function() {

        this.onAttach = function () {
            wpd.graphicsWidget.setRepainter(new wpd.GridMaskPainter());
            document.getElementById('grid-mask-view').classList.add('pressed-button');
        };

        this.onRemove = function () {
            document.getElementById('grid-mask-view').classList.remove('pressed-button');
            wpd.gridDetection.grabMask();
        };
    };

    return Tool;
})();


wpd.GridMaskPainter = (function () {
    var Painter = function () {

        var ctx = wpd.graphicsWidget.getAllContexts(),
            autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            painter = function () {
                if(autoDetector.gridMask.pixels == null || autoDetector.gridMask.pixels.length === 0) {
                    return;
                }
                var maski, img_index,
                    imageSize = wpd.graphicsWidget.getImageSize();
                    imgData = ctx.oriDataCtx.getImageData(0, 0, imageSize.width, imageSize.height);

                for(maski = 0; maski < autoDetector.gridMask.pixels.length; maski++) {
                    img_index = autoDetector.gridMask.pixels[maski];
                    imgData.data[img_index*4] = 255;
                    imgData.data[img_index*4+1] = 255;
                    imgData.data[img_index*4+2] = 0;
                    imgData.data[img_index*4+3] = 200;
                }

                ctx.oriDataCtx.putImageData(imgData, 0, 0);
                wpd.graphicsWidget.copyImageDataLayerToScreen();
            };

        this.painterName = 'gridMaskPainter';

        this.onRedraw = function () {
            wpd.gridDetection.grabMask();
            painter();
        };

        this.onAttach = function () {
            wpd.graphicsWidget.resetData();
            painter();
        };
    };
    return Painter;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.imageOps = (function () {

    function hflipOp(idata, iwidth, iheight) {
        var rowi, coli, index, mindex, tval, p;
        for(rowi = 0; rowi < iheight; rowi++) {
            for(coli = 0; coli < iwidth/2; coli++) {
                index = 4*(rowi*iwidth + coli);
                mindex = 4*((rowi+1)*iwidth - (coli+1));
                for(p = 0; p < 4; p++) {
                    tval = idata.data[index + p];
                    idata.data[index + p] = idata.data[mindex + p];
                    idata.data[mindex + p] = tval;
                }
            }
        }
        return {
            imageData: idata,
            width: iwidth,
            height: iheight
        };
    }

    function vflipOp(idata, iwidth, iheight) {
        var rowi, coli, index, mindex, tval, p;
        for(rowi = 0; rowi < iheight/2; rowi++) {
            for(coli = 0; coli < iwidth; coli++) {
                index = 4*(rowi*iwidth + coli);
                mindex = 4*((iheight - (rowi+2))*iwidth + coli);
                for(p = 0; p < 4; p++) {
                    tval = idata.data[index + p];
                    idata.data[index + p] = idata.data[mindex + p];
                    idata.data[mindex + p] = tval;
                }
            }
        }
        return {
            imageData: idata,
            width: iwidth,
            height: iheight
        };
    }

    function hflip() {
        wpd.graphicsWidget.runImageOp(hflipOp);
    }

    function vflip() {
        wpd.graphicsWidget.runImageOp(vflipOp);
    }

    return {
        hflip: hflip,
        vflip: vflip
    };
})();

/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.keyCodes = (function () {
    return {
        isUp: function(code) {
            return code === 38;
        },
        isDown: function(code) {
            return code === 40;
        },
        isLeft: function(code) {
            return code === 37;
        },
        isRight: function(code) {
            return code === 39;
        },
        isTab: function(code) {
            return code === 9;
        },
        isDel: function(code) {
            return code === 46;
        },
        isBackspace: function(code) {
            return code === 8;
        },
        isAlphabet: function(code, alpha) {
            if (code > 90 || code < 65) {
                return false;
            }
            return String.fromCharCode(code).toLowerCase() === alpha;
        },
        isEnter: function(code) {
            return code === 13;
        },
        isEsc: function(code) {
            return code === 27;
        }
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.ManualSelectionTool = (function () {
    var Tool = function (axes, dataset) {
        
        this.onAttach = function () {
            document.getElementById('manual-select-button').classList.add('pressed-button');
            wpd.graphicsWidget.setRepainter(new wpd.DataPointsRepainter(axes, dataset));
        };

       
        this.onMouseClick = function (ev, pos, imagePos) {
            var pointLabel,
                mkeys;
            
            if(axes.dataPointsHaveLabels) { // e.g. Bar charts

                // This isn't the cleanest approach, but should do for now:
                mkeys = dataset.getMetadataKeys();
                if(mkeys == null || mkeys[0] !== 'Label') {
                    dataset.setMetadataKeys(['Label']);
                }
                pointLabel = axes.dataPointsLabelPrefix + dataset.getCount();
                dataset.addPixel(imagePos.x, imagePos.y, [pointLabel]);
                wpd.graphicsHelper.drawPoint(imagePos, "rgb(200,0,0)", pointLabel);

            } else {

                dataset.addPixel(imagePos.x, imagePos.y);
                wpd.graphicsHelper.drawPoint(imagePos, "rgb(200,0,0)");

            }

            wpd.graphicsWidget.updateZoomOnEvent(ev);
            wpd.dataPointCounter.setCount(dataset.getCount());

            // If shiftkey was pressed while clicking on a point that has a label (e.g. bar charts),
            // then show a popup to edit the label
            if(axes.dataPointsHaveLabels && ev.shiftKey) {
                wpd.dataPointLabelEditor.show(dataset, dataset.getCount() - 1, this);
            }
        };

        this.onRemove = function () {
            document.getElementById('manual-select-button').classList.remove('pressed-button');
        };

        this.onKeyDown = function (ev) {
            var lastPtIndex = dataset.getCount() - 1,
                lastPt = dataset.getPixel(lastPtIndex),
                stepSize = 0.5/wpd.graphicsWidget.getZoomRatio();

            if(wpd.keyCodes.isUp(ev.keyCode)) {
                lastPt.y = lastPt.y - stepSize;
            } else if(wpd.keyCodes.isDown(ev.keyCode)) {
                lastPt.y = lastPt.y + stepSize;
            } else if(wpd.keyCodes.isLeft(ev.keyCode)) {
                lastPt.x = lastPt.x - stepSize;
            } else if(wpd.keyCodes.isRight(ev.keyCode)) {
                lastPt.x = lastPt.x + stepSize;
            } else if(wpd.acquireData.isToolSwitchKey(ev.keyCode)) {
                wpd.acquireData.switchToolOnKeyPress(String.fromCharCode(ev.keyCode).toLowerCase());
                return;
            } else {
                return;
            }

            dataset.setPixelAt(lastPtIndex, lastPt.x, lastPt.y);
            wpd.graphicsWidget.resetData();
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomToImagePosn(lastPt.x, lastPt.y);
            ev.preventDefault();
        };
    };
    return Tool;
})();


wpd.DeleteDataPointTool = (function () {
    var Tool = function (axes, dataset) {

        var ctx = wpd.graphicsWidget.getAllContexts();

        this.onAttach = function () {
            document.getElementById('delete-point-button').classList.add('pressed-button');
            wpd.graphicsWidget.setRepainter(new wpd.DataPointsRepainter(axes, dataset));
        };

        this.onMouseClick = function(ev, pos, imagePos) {
            
            dataset.removeNearestPixel(imagePos.x, imagePos.y);
            wpd.graphicsWidget.resetData();
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomOnEvent(ev);
            wpd.dataPointCounter.setCount(dataset.getCount());
        };

        this.onKeyDown = function (ev) {
            if(wpd.acquireData.isToolSwitchKey(ev.keyCode)) {
                wpd.acquireData.switchToolOnKeyPress(String.fromCharCode(ev.keyCode).toLowerCase());
            }
        };

        this.onRemove = function () {
            document.getElementById('delete-point-button').classList.remove('pressed-button');
        };
    };
    return Tool;
})();


wpd.DataPointsRepainter = (function () {
    var Painter = function (axes, dataset) {

        var drawPoints = function () {
            var dindex,
                imagePos,
                fillStyle,
                isSelected,
                mkeys = dataset.getMetadataKeys(),
                hasLabels = false,
                pointLabel;

            if(axes == null) {
                return; // this can happen when removing widgets when a new file is loaded:
            }

            if(axes.dataPointsHaveLabels && mkeys != null && mkeys[0] === 'Label') {
                hasLabels = true;
            }

            for(dindex = 0; dindex < dataset.getCount(); dindex++) {
                imagePos = dataset.getPixel(dindex);
                isSelected = dataset.getSelectedPixels().indexOf(dindex) >= 0;

                if(isSelected) {
                    fillStyle = "rgb(0,200,0)";
                } else {
                    fillStyle = "rgb(200,0,0)";
                }

                if (hasLabels) {
                    pointLabel = imagePos.metadata[0];
                    if(pointLabel == null) {
                        pointLabel = axes.dataPointsLabelPrefix + dindex;
                    }
                    wpd.graphicsHelper.drawPoint(imagePos, fillStyle, pointLabel);
                } else {
                    wpd.graphicsHelper.drawPoint(imagePos, fillStyle);
                }
            }
        };
        
        this.painterName = 'dataPointsRepainter';

        this.onAttach = function () {
            wpd.graphicsWidget.resetData();
            drawPoints();
        };

        this.onRedraw = function () {
            drawPoints();
        };

        this.onForcedRedraw = function () {
            wpd.graphicsWidget.resetData();
            drawPoints();
        };
    };
    return Painter;
})();


wpd.AdjustDataPointTool = (function () {
    var Tool = function (axes, dataset) {
        
        this.onAttach = function () {
            document.getElementById('manual-adjust-button').classList.add('pressed-button');
            wpd.graphicsWidget.setRepainter(new wpd.DataPointsRepainter(axes, dataset));
            wpd.toolbar.show('adjustDataPointsToolbar');
        }; 
        
        this.onRemove = function () {            
            dataset.unselectAll();
            wpd.graphicsWidget.forceHandlerRepaint();
            document.getElementById('manual-adjust-button').classList.remove('pressed-button');
            wpd.toolbar.clear();
        };

        this.onMouseClick = function (ev, pos, imagePos) {            
            dataset.unselectAll();
            dataset.selectNearestPixel(imagePos.x, imagePos.y);
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomOnEvent(ev);
        };

        this.onKeyDown = function (ev) {

            if (wpd.acquireData.isToolSwitchKey(ev.keyCode)) {
                wpd.acquireData.switchToolOnKeyPress(String.fromCharCode(ev.keyCode).toLowerCase());
                return;
            }

            var selIndex = dataset.getSelectedPixels()[0];

            if(selIndex == null) { return; }

            var selPoint = dataset.getPixel(selIndex),
                pointPx = selPoint.x,
                pointPy = selPoint.y,
                stepSize = ev.shiftKey === true ? 5/wpd.graphicsWidget.getZoomRatio() : 0.5/wpd.graphicsWidget.getZoomRatio();

            if(wpd.keyCodes.isUp(ev.keyCode)) {
                pointPy = pointPy - stepSize;
            } else if(wpd.keyCodes.isDown(ev.keyCode)) {
                pointPy = pointPy + stepSize;
            } else if(wpd.keyCodes.isLeft(ev.keyCode)) {
                pointPx = pointPx - stepSize;
            } else if(wpd.keyCodes.isRight(ev.keyCode)) {
                pointPx = pointPx + stepSize;
            } else if(wpd.keyCodes.isAlphabet(ev.keyCode, 'q')) {
                dataset.selectPreviousPixel();
                selIndex = dataset.getSelectedPixels()[0];
                selPoint = dataset.getPixel(selIndex);
                pointPx = selPoint.x;
                pointPy = selPoint.y;
            } else if(wpd.keyCodes.isAlphabet(ev.keyCode, 'w')) {
                dataset.selectNextPixel();
                selIndex = dataset.getSelectedPixels()[0];
                selPoint = dataset.getPixel(selIndex);
                pointPx = selPoint.x;
                pointPy = selPoint.y;
            } else if(wpd.keyCodes.isAlphabet(ev.keyCode, 'e')) {
                if(axes.dataPointsHaveLabels) {
                    selIndex = dataset.getSelectedPixels()[0];
                    ev.preventDefault();
                    ev.stopPropagation();
                    wpd.dataPointLabelEditor.show(dataset, selIndex, this);
                    return;
                }
            } else if(wpd.keyCodes.isDel(ev.keyCode) || wpd.keyCodes.isBackspace(ev.keyCode)) {
                dataset.removePixelAtIndex(selIndex);
                dataset.unselectAll();
                if(dataset.findNearestPixel(pointPx, pointPy) >= 0) {
                    dataset.selectNearestPixel(pointPx, pointPy);
                    selIndex = dataset.getSelectedPixels()[0];
                    selPoint = dataset.getPixel(selIndex);
                    pointPx = selPoint.x;
                    pointPy = selPoint.y;
                }
                wpd.graphicsWidget.resetData();
                wpd.graphicsWidget.forceHandlerRepaint();
                wpd.graphicsWidget.updateZoomToImagePosn(pointPx, pointPy);
                wpd.dataPointCounter.setCount();
                ev.preventDefault();
                ev.stopPropagation();
                return;
            } else {
                return;
            }
            
            dataset.setPixelAt(selIndex, pointPx, pointPy);
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomToImagePosn(pointPx, pointPy);
            ev.preventDefault();
            ev.stopPropagation(); 
        };
    };
    return Tool;
})();

wpd.EditLabelsTool = function(axes, dataset) {
    
    this.onAttach = function () {
        document.getElementById('edit-data-labels').classList.add('pressed-button');
        wpd.graphicsWidget.setRepainter(new wpd.DataPointsRepainter(axes, dataset));
    };

    this.onRemove = function () {
        document.getElementById('edit-data-labels').classList.remove('pressed-button');
        dataset.unselectAll();
    };

    this.onMouseClick = function (ev, pos, imagePos) {
        var dataSeries = dataset,
            pixelIndex;
        dataSeries.unselectAll();
        pixelIndex = dataSeries.selectNearestPixel(imagePos.x, imagePos.y);
        if(pixelIndex >= 0) { 
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomOnEvent(ev);
            wpd.dataPointLabelEditor.show(dataSeries, pixelIndex, this);
        }
    };

    this.onKeyDown = function (ev) {
        if(wpd.acquireData.isToolSwitchKey(ev.keyCode)) {
            wpd.acquireData.switchToolOnKeyPress(String.fromCharCode(ev.keyCode).toLowerCase());
        }
    };
};

wpd.dataPointCounter = {
    setCount: function (count) {    
        let $counters = document.getElementsByClassName('data-point-counter');        
        for(let ci = 0; ci < $counters.length; ci++) {
            $counters[ci].innerHTML = count;
        }
    }
};
    
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.BoxMaskTool = (function () {
    var Tool = function () {
        var isDrawing = false,
            topImageCorner,
            topScreenCorner,
            ctx = wpd.graphicsWidget.getAllContexts(),
            moveTimer,
            screen_pos,

            mouseMoveHandler = function() {
                wpd.graphicsWidget.resetHover();
                ctx.hoverCtx.strokeStyle = "rgb(0,0,0)";
    		ctx.hoverCtx.strokeRect(topScreenCorner.x, topScreenCorner.y, screen_pos.x - topScreenCorner.x, screen_pos.y - topScreenCorner.y);
            },
            
            mouseUpHandler = function (ev, pos, imagePos) {
                if(isDrawing === false) {
                    return;
                }
                clearTimeout(moveTimer);
                isDrawing = false;
                wpd.graphicsWidget.resetHover();
                ctx.dataCtx.fillStyle = "rgba(255,255,0,1)";
                ctx.dataCtx.fillRect(topScreenCorner.x, topScreenCorner.y, pos.x-topScreenCorner.x, pos.y-topScreenCorner.y);
                ctx.oriDataCtx.fillStyle = "rgba(255,255,0,1)";
                ctx.oriDataCtx.fillRect(topImageCorner.x, topImageCorner.y, imagePos.x - topImageCorner.x, imagePos.y - topImageCorner.y);
            },
            
            mouseOutPos = null,
            mouseOutImagePos = null;

        this.onAttach = function () {
            wpd.graphicsWidget.setRepainter(new wpd.MaskPainter());
            document.getElementById('box-mask').classList.add('pressed-button');
            document.getElementById('view-mask').classList.add('pressed-button');
        };

        this.onMouseDown = function(ev, pos, imagePos) {
            if(isDrawing === true) return;
            isDrawing = true;
            topImageCorner = imagePos;
            topScreenCorner = pos;
        };

        this.onMouseMove = function(ev, pos, imagePos) {
            if(isDrawing === false) return;
            screen_pos = pos;
            clearTimeout(moveTimer);
            moveTimer = setTimeout(mouseMoveHandler, 2);
        };

        this.onMouseOut = function (ev, pos, imagePos) {
            if(isDrawing === true) {
                clearTimeout(moveTimer);
                mouseOutPos = pos;
                mouseOutImagePos = imagePos;
            }
        };

        this.onDocumentMouseUp = function(ev, pos, imagePos) {
            if (mouseOutPos != null && mouseOutImagePos != null) {
                mouseUpHandler(ev, mouseOutPos, mouseOutImagePos);
            } else {
                mouseUpHandler(ev, pos, imagePos);
            }
            mouseOutPos = null;
            mouseOutImagePos = null;
        };

        this.onMouseUp = function(ev, pos, imagePos) {
            mouseUpHandler(ev, pos, imagePos);
        };

        this.onRemove = function () {
            document.getElementById('box-mask').classList.remove('pressed-button');
            document.getElementById('view-mask').classList.remove('pressed-button');
            wpd.dataMask.grabMask();
        };
    };
    return Tool;
})();

wpd.PenMaskTool = (function () {
    var Tool = function () {
        var strokeWidth,
            ctx = wpd.graphicsWidget.getAllContexts(),
            isDrawing = false,
            moveTimer,
            screen_pos, image_pos,
            mouseMoveHandler = function() {
                ctx.dataCtx.strokeStyle = "rgba(255,255,0,1)";
        	ctx.dataCtx.lineTo(screen_pos.x,screen_pos.y);
                ctx.dataCtx.stroke();

                ctx.oriDataCtx.strokeStyle = "rgba(255,255,0,1)";
        	ctx.oriDataCtx.lineTo(image_pos.x,image_pos.y);
                ctx.oriDataCtx.stroke();
            };

        this.onAttach = function () {
            wpd.graphicsWidget.setRepainter(new wpd.MaskPainter());
            document.getElementById('pen-mask').classList.add('pressed-button');
            document.getElementById('view-mask').classList.add('pressed-button');
            wpd.toolbar.show('paintToolbar');
        };

        this.onMouseDown = function(ev, pos, imagePos) {
            if(isDrawing === true) return;
            var lwidth = parseInt(document.getElementById('paintThickness').value, 10);
            isDrawing = true;
            ctx.dataCtx.strokeStyle = "rgba(255,255,0,1)";
            ctx.dataCtx.lineWidth = lwidth*wpd.graphicsWidget.getZoomRatio();
	    ctx.dataCtx.beginPath();
            ctx.dataCtx.moveTo(pos.x,pos.y);

            ctx.oriDataCtx.strokeStyle = "rgba(255,255,0,1)";
            ctx.oriDataCtx.lineWidth = lwidth;
	    ctx.oriDataCtx.beginPath();
            ctx.oriDataCtx.moveTo(imagePos.x,imagePos.y);
        };

        this.onMouseMove = function(ev, pos, imagePos) {
            if(isDrawing === false) return;
            screen_pos = pos;
            image_pos = imagePos;
            clearTimeout(moveTimer);
            moveTimer = setTimeout(mouseMoveHandler, 2);
        };

        this.onMouseUp = function(ev, pos, imagePos) {
            clearTimeout(moveTimer);
            ctx.dataCtx.closePath();
            ctx.dataCtx.lineWidth = 1;
            ctx.oriDataCtx.closePath();
            ctx.oriDataCtx.lineWidth = 1;
            isDrawing = false;
        };
        
        this.onMouseOut = function(ev, pos, imagePos) {
            this.onMouseUp(ev, pos, imagePos);
        };

        this.onRemove = function() {
            document.getElementById('pen-mask').classList.remove('pressed-button');
            document.getElementById('view-mask').classList.remove('pressed-button');
            wpd.dataMask.grabMask();
            wpd.toolbar.clear();
        };

    };
    return Tool;
})();

wpd.EraseMaskTool = (function () {
    var Tool = function() {
        var strokeWidth,
            ctx = wpd.graphicsWidget.getAllContexts(),
            isDrawing = false,
            moveTimer,
            screen_pos, image_pos,
            mouseMoveHandler = function() {

                ctx.dataCtx.globalCompositeOperation = "destination-out";
                ctx.oriDataCtx.globalCompositeOperation = "destination-out";
                
                ctx.dataCtx.strokeStyle = "rgba(255,255,0,1)";
                ctx.dataCtx.lineTo(screen_pos.x,screen_pos.y);
                ctx.dataCtx.stroke();
                
                ctx.oriDataCtx.strokeStyle = "rgba(255,255,0,1)";
                ctx.oriDataCtx.lineTo(image_pos.x,image_pos.y);
                ctx.oriDataCtx.stroke();
            };

        this.onAttach = function() {
             wpd.graphicsWidget.setRepainter(new wpd.MaskPainter());
             document.getElementById('erase-mask').classList.add('pressed-button');
             document.getElementById('view-mask').classList.add('pressed-button');
             wpd.toolbar.show('eraseToolbar');
        };

        this.onMouseDown = function(ev, pos, imagePos) {
            if(isDrawing === true) return;
            var lwidth = parseInt(document.getElementById('eraseThickness').value, 10);
            isDrawing = true;
            ctx.dataCtx.globalCompositeOperation = "destination-out";
            ctx.oriDataCtx.globalCompositeOperation = "destination-out";

            ctx.dataCtx.strokeStyle = "rgba(0,0,0,1)";
            ctx.dataCtx.lineWidth = lwidth*wpd.graphicsWidget.getZoomRatio();
            ctx.dataCtx.beginPath();
            ctx.dataCtx.moveTo(pos.x,pos.y);

            ctx.oriDataCtx.strokeStyle = "rgba(0,0,0,1)";
            ctx.oriDataCtx.lineWidth = lwidth;
            ctx.oriDataCtx.beginPath();
            ctx.oriDataCtx.moveTo(imagePos.x,imagePos.y);
        };

        this.onMouseMove = function(ev, pos, imagePos) {
            if(isDrawing === false) return;
            screen_pos = pos;
            image_pos = imagePos;
            clearTimeout(moveTimer);
            moveTimer = setTimeout(mouseMoveHandler, 2);
        };

        this.onMouseOut = function(ev, pos, imagePos) {
            this.onMouseUp(ev, pos, imagePos);
        };

        this.onMouseUp = function(ev, pos, imagePos) {
            clearTimeout(moveTimer);
            ctx.dataCtx.closePath();
            ctx.dataCtx.lineWidth = 1;
            ctx.oriDataCtx.closePath();
            ctx.oriDataCtx.lineWidth = 1;

            ctx.dataCtx.globalCompositeOperation = "source-over";
            ctx.oriDataCtx.globalCompositeOperation = "source-over";

            isDrawing = false;
        };

        this.onRemove = function() {
            document.getElementById('erase-mask').classList.remove('pressed-button');
            document.getElementById('view-mask').classList.remove('pressed-button');
            wpd.dataMask.grabMask();
            wpd.toolbar.clear();
        };
       
    };
    return Tool;
})();

wpd.ViewMaskTool = (function() {

    var Tool = function() {

        this.onAttach = function () {
            wpd.graphicsWidget.setRepainter(new wpd.MaskPainter());
            document.getElementById('view-mask').classList.add('pressed-button');
        };

        this.onRemove = function () {
            document.getElementById('view-mask').classList.remove('pressed-button');
            wpd.dataMask.grabMask();
        };
    };

    return Tool;
})();

wpd.MaskPainter = (function() {
    var Painter = function () {

        var ctx = wpd.graphicsWidget.getAllContexts(),
            autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            painter = function () {
                if(autoDetector.mask == null || autoDetector.mask.length === 0) {
                    return;
                }
                var maski, img_index,
                    imageSize = wpd.graphicsWidget.getImageSize();
                    imgData = ctx.oriDataCtx.getImageData(0, 0, imageSize.width, imageSize.height);

                for(maski = 0; maski < autoDetector.mask.length; maski++) {
                    img_index = autoDetector.mask[maski];
                    imgData.data[img_index*4] = 255;
                    imgData.data[img_index*4+1] = 255;
                    imgData.data[img_index*4+2] = 0;
                    imgData.data[img_index*4+3] = 255;
                }

                ctx.oriDataCtx.putImageData(imgData, 0, 0);
                wpd.graphicsWidget.copyImageDataLayerToScreen();
            };

        this.painterName = 'dataMaskPainter';

        this.onRedraw = function () {
            wpd.dataMask.grabMask();
            painter();
        };

        this.onAttach = function () {
            wpd.graphicsWidget.resetData();
            painter();
        };
    };
    return Painter;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.AddMeasurementTool = (function () {
    var Tool = function (mode) {
        var ctx = wpd.graphicsWidget.getAllContexts(),
            pointsCaptured = 0,
            isCapturing = true,
            plist = [];

        this.onAttach = function () {
            document.getElementById(mode.addButtonId).classList.add('pressed-button');
            if(mode.connectivity < 0) { // area/perimeter
                document.getElementById("add-polygon-info").style.display = "block";
            }            
        };

        this.onRemove = function () {
            document.getElementById(mode.addButtonId).classList.remove('pressed-button');
            if(mode.connectivity < 0) { // area/perimeter
                document.getElementById("add-polygon-info").style.display = "none";
            }
        };

        this.onKeyDown = function (ev) {
            // move the selected point or switch tools
            if(wpd.keyCodes.isAlphabet(ev.keyCode, 'a')) {
                wpd.graphicsWidget.resetHover();
                wpd.graphicsWidget.setTool(new wpd.AddMeasurementTool(mode));
                return;
            } else if (wpd.keyCodes.isAlphabet(ev.keyCode, 'd')) {
                wpd.graphicsWidget.resetHover();
                wpd.graphicsWidget.setTool(new wpd.DeleteMeasurementTool(mode));
                return;
            } else if ((wpd.keyCodes.isEnter(ev.keyCode) || wpd.keyCodes.isEsc(ev.keyCode)) 
                        && isCapturing === true && mode.connectivity < 0) {
                isCapturing = false;
                mode.getData().addConnection(plist);
                wpd.graphicsWidget.resetHover();
                wpd.graphicsWidget.forceHandlerRepaint();
                wpd.graphicsWidget.setTool(new wpd.AdjustMeasurementTool(mode));
                return;
            }
        };


        this.onMouseClick = function (ev, pos, imagePos) {
            if(isCapturing) {

                wpd.graphicsWidget.resetHover();

                plist[pointsCaptured*2] = imagePos.x;
                plist[pointsCaptured*2 + 1] = imagePos.y;
                pointsCaptured = pointsCaptured + 1;

                if(pointsCaptured === mode.connectivity) {
                    isCapturing = false;
                    mode.getData().addConnection(plist);
                    wpd.graphicsWidget.resetHover();
                    wpd.graphicsWidget.forceHandlerRepaint();
                    wpd.graphicsWidget.setTool(new wpd.AdjustMeasurementTool(mode));
                    return;
                }

                if(pointsCaptured > 1) {
                    // draw line from previous point to current
                    var prevScreenPx = wpd.graphicsWidget.screenPx(plist[(pointsCaptured-2)*2], plist[(pointsCaptured-2)*2 + 1]);
                    ctx.dataCtx.beginPath();
                    ctx.dataCtx.strokeStyle = "rgb(0,0,10)";
                    ctx.dataCtx.moveTo(prevScreenPx.x, prevScreenPx.y);
                    ctx.dataCtx.lineTo(pos.x, pos.y);
                    ctx.dataCtx.stroke();

                    ctx.oriDataCtx.beginPath();
                    ctx.oriDataCtx.strokeStyle = "rgb(0,0,10)";
                    ctx.oriDataCtx.moveTo(plist[(pointsCaptured-2)*2], plist[(pointsCaptured-2)*2 + 1]);
                    ctx.oriDataCtx.lineTo(imagePos.x, imagePos.y);
                    ctx.oriDataCtx.stroke();
                }

                // draw current point
                ctx.dataCtx.beginPath();
                ctx.dataCtx.fillStyle = "rgb(200, 0, 0)";
                ctx.dataCtx.arc(pos.x, pos.y, 3, 0, 2.0*Math.PI, true);
                ctx.dataCtx.fill();

                ctx.oriDataCtx.beginPath();
    	    	ctx.oriDataCtx.fillStyle = "rgb(200,0,0)";
	        	ctx.oriDataCtx.arc(imagePos.x, imagePos.y, 3, 0, 2.0*Math.PI, true);
	    	    ctx.oriDataCtx.fill();

            }
            wpd.graphicsWidget.updateZoomOnEvent(ev); 
        };

        this.onMouseMove = function (ev, pos, imagePos) {
            if(isCapturing && pointsCaptured >= 1) {
                wpd.graphicsWidget.resetHover();
                var prevScreenPx = wpd.graphicsWidget.screenPx(plist[(pointsCaptured-1)*2], plist[(pointsCaptured-1)*2 + 1]);

                ctx.hoverCtx.beginPath();
                ctx.hoverCtx.strokeStyle = "rgb(0,0,0)";
                ctx.hoverCtx.moveTo(prevScreenPx.x, prevScreenPx.y);
                ctx.hoverCtx.lineTo(pos.x, pos.y);
                ctx.hoverCtx.stroke();
            }
        };

    };
    return Tool;
})();

wpd.DeleteMeasurementTool = (function () {
    var Tool = function (mode) {
        var ctx = wpd.graphicsWidget.getAllContexts();

        this.onAttach = function () {
            document.getElementById(mode.deleteButtonId).classList.add('pressed-button');            
        };

        this.onRemove = function () {
            document.getElementById(mode.deleteButtonId).classList.remove('pressed-button');
        };
        
        this.onKeyDown = function (ev) {
            // move the selected point or switch tools
            if(wpd.keyCodes.isAlphabet(ev.keyCode, 'a')) {
                wpd.graphicsWidget.setTool(new wpd.AddMeasurementTool(mode));
                return;
            } else if (wpd.keyCodes.isAlphabet(ev.keyCode, 'd')) {
                wpd.graphicsWidget.setTool(new wpd.DeleteMeasurementTool(mode));
                return;
            }
        };

        this.onMouseClick = function (ev, pos, imagePos) {
            mode.getData().deleteNearestConnection(imagePos.x, imagePos.y);
            wpd.graphicsWidget.setTool(new wpd.AdjustMeasurementTool(mode));
            wpd.graphicsWidget.resetData();
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomOnEvent(ev);
        };

    };
    return Tool;
})();

wpd.AdjustMeasurementTool = (function () {
    var Tool = function (mode) {
        this.onAttach = function () {            
        };

        this.onMouseClick = function (ev, pos, imagePos) {
            // select the nearest point
            mode.getData().selectNearestPoint(imagePos.x, imagePos.y);
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.graphicsWidget.updateZoomOnEvent(ev);
        };

        this.onKeyDown = function (ev) {
            // move the selected point or switch tools
            if(wpd.keyCodes.isAlphabet(ev.keyCode, 'a')) {
                wpd.graphicsWidget.setTool(new wpd.AddMeasurementTool(mode));
                return;
            } else if (wpd.keyCodes.isAlphabet(ev.keyCode, 'd')) {
                wpd.graphicsWidget.setTool(new wpd.DeleteMeasurementTool(mode));
                return;
            }

            var measurementData = mode.getData(),
                selectedPt = measurementData.getSelectedConnectionAndPoint();

            if(selectedPt.connectionIndex >= 0 && selectedPt.pointIndex >= 0) {

                var stepSize = ev.shiftKey === true ? 5/wpd.graphicsWidget.getZoomRatio() : 0.5/wpd.graphicsWidget.getZoomRatio(),
                    pointPx = measurementData.getPointAt(selectedPt.connectionIndex, selectedPt.pointIndex);

                if(wpd.keyCodes.isUp(ev.keyCode)) {
                    pointPx.y = pointPx.y - stepSize;
                } else if(wpd.keyCodes.isDown(ev.keyCode)) {
                    pointPx.y = pointPx.y + stepSize;
                } else if(wpd.keyCodes.isLeft(ev.keyCode)) {
                    pointPx.x = pointPx.x - stepSize;
                } else if(wpd.keyCodes.isRight(ev.keyCode)) {
                    pointPx.x = pointPx.x + stepSize;
                } else {
                    return;
                }
                
                measurementData.setPointAt(selectedPt.connectionIndex, selectedPt.pointIndex, pointPx.x, pointPx.y);
                wpd.graphicsWidget.forceHandlerRepaint();
                wpd.graphicsWidget.updateZoomToImagePosn(pointPx.x, pointPx.y);
                ev.preventDefault();
                ev.stopPropagation();
            }
        };
    };
    return Tool;
})();

wpd.MeasurementRepainter = (function () {
    var Painter = function (mode) {
        var ctx = wpd.graphicsWidget.getAllContexts(),

            drawLine = function(sx0, sy0, sx1, sy1, ix0, iy0, ix1, iy1) {

                ctx.dataCtx.beginPath();
                ctx.dataCtx.strokeStyle = "rgb(0,0,10)";
                ctx.dataCtx.moveTo(sx0, sy0);
                ctx.dataCtx.lineTo(sx1, sy1);
                ctx.dataCtx.stroke();

                ctx.oriDataCtx.beginPath();
                ctx.oriDataCtx.strokeStyle = "rgb(0,0,10)";
                ctx.oriDataCtx.moveTo(ix0, iy0);
                ctx.oriDataCtx.lineTo(ix1, iy1);
                ctx.oriDataCtx.stroke();

            },

            drawPoint = function(sx, sy, ix, iy, isSelected) {

                ctx.dataCtx.beginPath();
                if(isSelected) {
                    ctx.dataCtx.fillStyle = "rgb(0, 200, 0)";
                } else {
                    ctx.dataCtx.fillStyle = "rgb(200, 0, 0)";
                }
                ctx.dataCtx.arc(sx, sy, 3, 0, 2.0*Math.PI, true);
                ctx.dataCtx.fill();

                ctx.oriDataCtx.beginPath();
                if(isSelected) {
                    ctx.oriDataCtx.fillStyle = "rgb(0,200,0)";
                } else {
                    ctx.oriDataCtx.fillStyle = "rgb(200,0,0)";
                }
                ctx.oriDataCtx.arc(ix, iy, 3, 0, 2.0*Math.PI, true);
                ctx.oriDataCtx.fill();

            },

            drawArc = function(sx, sy, ix, iy, theta1, theta2) {
                ctx.dataCtx.beginPath();
                ctx.dataCtx.strokeStyle = "rgb(0,0,10)";
                ctx.dataCtx.arc(sx, sy, 15, theta1, theta2, true);
                ctx.dataCtx.stroke();

                ctx.oriDataCtx.beginPath();
                ctx.oriDataCtx.strokeStyle = "rgb(0,0,10)";
                ctx.oriDataCtx.arc(ix, iy, 15, theta1, theta2, true);
                ctx.oriDataCtx.stroke();
            },

            drawLabel = function(sx, sy, ix, iy, lab) {
                var labelWidth;
                
                sx = parseInt(sx, 10);
                sy = parseInt(sy, 10);
                ix = parseInt(ix, 10);
                iy = parseInt(iy, 10);

                ctx.dataCtx.font="14px sans-serif";
                labelWidth = ctx.dataCtx.measureText(lab).width;
                ctx.dataCtx.fillStyle = "rgba(255, 255, 255, 0.7)";
                ctx.dataCtx.fillRect(sx - 5, sy - 15, labelWidth + 10, 25);
                ctx.dataCtx.fillStyle = "rgb(200, 0, 0)";
                ctx.dataCtx.fillText(lab, sx, sy);

                ctx.oriDataCtx.font="14px sans-serif";
                labelWidth = ctx.oriDataCtx.measureText(lab).width;
                ctx.oriDataCtx.fillStyle = "rgba(255, 255, 255, 0.7)";
                ctx.oriDataCtx.fillRect(ix - 5, iy - 15, labelWidth + 10, 25);
                ctx.oriDataCtx.fillStyle = "rgb(200, 0, 0)";
                ctx.oriDataCtx.fillText(lab, ix, iy);
            },
            
            drawDistances = function () {
                var distData = mode.getData(),
                    conn_count = distData.connectionCount(),
                    conni,
                    plist,
                    x0, y0,
                    x1, y1,
                    spx0, spx1,
                    dist,
                    isSelected0, isSelected1,
                    axes = mode.getAxes();

                for(conni = 0; conni < conn_count; conni++) {
                    plist = distData.getConnectionAt(conni);
                    x0 = plist[0]; y0 = plist[1]; x1 = plist[2]; y1 = plist[3];
                    isSelected0 = distData.isPointSelected(conni, 0);
                    isSelected1 = distData.isPointSelected(conni, 1);
                    if(wpd.appData.isAligned() === true && axes instanceof wpd.MapAxes) {
                        dist = 'Dist' + conni.toString() + ': ' + axes.pixelToDataDistance(distData.getDistance(conni)).toFixed(2) + ' ' + axes.getUnits();
                    } else {
                        dist = 'Dist' + conni.toString() + ': ' + distData.getDistance(conni).toFixed(2) + ' px';
                    }
                    spx0 = wpd.graphicsWidget.screenPx(x0, y0);
                    spx1 = wpd.graphicsWidget.screenPx(x1, y1);

                    // draw connecting lines:
                    drawLine(spx0.x, spx0.y, spx1.x, spx1.y, x0, y0, x1, y1);
                    
                    // draw data points:
                    drawPoint(spx0.x, spx0.y, x0, y0, isSelected0);
                    drawPoint(spx1.x, spx1.y, x1, y1, isSelected1);
                    
                    // distance label
                    drawLabel(0.5*(spx0.x + spx1.x), 0.5*(spx0.y + spx1.y), 0.5*(x0 + x1), 0.5*(y0 + y1), dist);
                }
            },
            
            drawAngles = function () {
                var angleData = mode.getData(),
                    conn_count = angleData.connectionCount(),
                    conni,
                    plist,
                    x0, y0, x1, y1, x2, y2,
                    spx0, spx1, spx2,
                    theta1, theta2, theta,
                    isSelected0, isSelected1, isSelected2;
                for(conni = 0; conni < conn_count; conni++) {
                    plist = angleData.getConnectionAt(conni);
                    x0 = plist[0]; y0 = plist[1]; x1 = plist[2]; y1 = plist[3]; x2 = plist[4]; y2 = plist[5];
                    isSelected0 = angleData.isPointSelected(conni, 0);
                    isSelected1 = angleData.isPointSelected(conni, 1);
                    isSelected2 = angleData.isPointSelected(conni, 2);
                    theta = 'Theta' + conni.toString() + ': ' + angleData.getAngle(conni).toFixed(2) + '°';
                    theta1 = Math.atan2((y0 - y1), x0 - x1);
                    theta2 = Math.atan2((y2 - y1), x2 - x1);
                    spx0 = wpd.graphicsWidget.screenPx(x0, y0);
                    spx1 = wpd.graphicsWidget.screenPx(x1, y1);
                    spx2 = wpd.graphicsWidget.screenPx(x2, y2);

                    // draw connecting lines:
                    drawLine(spx0.x, spx0.y, spx1.x, spx1.y, x0, y0, x1, y1);
                    drawLine(spx1.x, spx1.y, spx2.x, spx2.y, x1, y1, x2, y2);

                    // draw data points:
                    drawPoint(spx0.x, spx0.y, x0, y0, isSelected0);
                    drawPoint(spx1.x, spx1.y, x1, y1, isSelected1);
                    drawPoint(spx2.x, spx2.y, x2, y2, isSelected2);

                    // draw angle arc:
                    drawArc(spx1.x, spx1.y, x1, y1, theta1, theta2);

                    // angle label
                    drawLabel(spx1.x + 10, spx1.y + 15, x1 + 10, y1 + 15, theta);
                    
                }
            },
            
            drawPolygons = function() {
                let connData = mode.getData();
                let connCount = connData.connectionCount();
                let axes = mode.getAxes();
                for(let connIdx = 0; connIdx < connCount; connIdx++) {
                    let conn = connData.getConnectionAt(connIdx);
                    let labelx = 0.0, labely = 0.0;

                    let px_prev = 0, py_prev = 0, spx_prev = {x:0, y:0};
                    for(let pi = 0; pi < conn.length; pi += 2) {
                        let px = conn[pi];
                        let py = conn[pi+1];
                        let spx = wpd.graphicsWidget.screenPx(px, py);
                        
                        if(pi >= 2) {
                            drawLine(spx_prev.x, spx_prev.y, spx.x, spx.y, px_prev, py_prev, px, py);
                        } 
                        
                        if(pi == conn.length-2) {
                            let px0 = conn[0];
                            let py0 = conn[1];
                            let spx0 = wpd.graphicsWidget.screenPx(px0, py0);
                            drawLine(spx0.x, spx0.y, spx.x, spx.y, px0, py0, px, py);
                        }
                        
                        px_prev = px;
                        py_prev = py;
                        spx_prev = spx;
                    }

                    for(let pi = 0; pi < conn.length; pi += 2) {
                        let px = conn[pi];
                        let py = conn[pi+1];
                        let spx = wpd.graphicsWidget.screenPx(px, py);
                        let isSelected = connData.isPointSelected(connIdx, pi/2);
                        drawPoint(spx.x, spx.y, px, py, isSelected);
                        labelx += px;
                        labely += py;
                    }
                    labelx /= conn.length/2;
                    labely /= conn.length/2;
                    let labelspx = wpd.graphicsWidget.screenPx(labelx, labely);
                    let areaStr = "";
                    let periStr = "";
                    if(wpd.appData.isAligned() === true && axes instanceof wpd.MapAxes) {
                        areaStr = "Area" + connIdx + ": " + axes.pixelToDataArea(connData.getArea(connIdx)).toFixed(2) + ' ' + axes.getUnits() + '^2';
                        periStr = "Perimeter" + connIdx + ": " + axes.pixelToDataDistance(connData.getPerimeter(connIdx)).toFixed(2) + ' ' + axes.getUnits();
                    } else {
                        areaStr = "Area" + connIdx + ": " + connData.getArea(connIdx).toFixed(2) + ' px^2';
                        periStr = "Perimeter" + connIdx + ": " + connData.getPerimeter(connIdx).toFixed(2) + ' px';
                    }
                    let label = areaStr + ", " + periStr;
                    drawLabel(labelspx.x, labelspx.y, labelx, labely, label);
                }
            };

        this.painterName = 'measurementRepainter-'+mode.name;

        this.onAttach = function () {            
        };

        this.onRedraw = function () {
            if(mode.name === wpd.measurementModes.distance.name) {
                drawDistances();
            } else if(mode.name === wpd.measurementModes.angle.name) {
                drawAngles();
            } else if(mode.name === wpd.measurementModes.area.name) {
                drawPolygons();
            }
        };

        this.onForcedRedraw = function () {
            wpd.graphicsWidget.resetData();
            this.onRedraw();
        };
    };
    return Painter;
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.args = (function() {

    // Simple argument parser
    // e.g. 
    // if WPD is launched as http://localhost:8000/index.html?q=1
    // then getValue('q') should return '1'
    // and getValue('nonexistent') should return null
    function getValue(arg) {

        var searchString = window.location.search.substring(1),
            i,
            val,
            params = searchString.split("&");

        for(i = 0; i < params.length; i++) {
            val = params[i].split("=");
            if(val[0] === arg) {
                return unescape(val[1]);
            }
        }
        return null;

    }

    return {
        getValue: getValue
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.dataExport = (function () {

    function show() {
        // open dialog box explaining data format
    }

    function getValueAtPixel(ptIndex, axes, pixel) {
        var val = axes.pixelToData(pixel.x, pixel.y);
        if(axes instanceof wpd.XYAxes) {
            for(var i = 0; i <= 1; i++) {
                if(axes.isDate(i)) {
                    var dformat = axes.getInitialDateFormat(i);                
                    val[i] = wpd.dateConverter.formatDateNumber(val[i], dformat);
                }
            }
        } else if(axes instanceof wpd.BarAxes) {
            val = ['', val[0]];
            if(pixel.metadata == null) {
                val[0] = "Bar" + ptIndex;
            } else {
                val[0] = pixel.metadata[0];
            }            
        }
        return val;
    }

    function generateCSV() {
        wpd.popup.close('export-all-data-popup');
        // generate file and trigger download

        // loop over all datasets
        let plotData = wpd.appData.getPlotData();
        let dsColl = plotData.getDatasets();

        if(dsColl == null || dsColl.length === 0) {
            // axes is not aligned, show an error message?
            wpd.messagePopup.show(wpd.gettext('no-datasets-to-export-error'), wpd.gettext('no-datasets-to-export'));
            return;
        }

        let maxDatapts = 0;        
        let header = [];
        let varheader = [];
        let valData = [];
        let numCols = 0;
        
        for(let i = 0; i < dsColl.length; i++) {
            let axes = plotData.getAxesForDataset(dsColl[i]);
            if(axes == null) continue;
            let axLab = axes.getAxesLabels();
            let axdims = axLab.length;            
            numCols += axdims;
            let pts = dsColl[i].getCount();
            if(pts > maxDatapts) {
                maxDatapts = pts;
            }
            header.push(dsColl[i].name);
            for(let j = 0; j < axdims; j++) {
                if(j !== 0) {
                    header.push('');
                }
                varheader.push(axLab[j]);
            }
        }
        for(let i = 0; i < maxDatapts; i++) {
            var valRow = [];
            for(let j = 0; j < numCols; j++) {
                valRow.push('');
            }
            valData.push(valRow);
        }

        let colIdx = 0;
        for(let i = 0; i < dsColl.length; i++) {
            let axes = plotData.getAxesForDataset(dsColl[i]);
            if(axes == null) continue;
            let axLab = axes.getAxesLabels();
            let axdims = axLab.length;            
            let pts = dsColl[i].getCount();
            for(let j = 0; j < pts; j++) {
                let px = dsColl[i].getPixel(j);
                let val = getValueAtPixel(j, axes, px);                
                for(let di = 0; di < axdims; di++) {
                    valData[j][colIdx + di] = val[di];
                }
            }
            colIdx += axdims;
        }

        let csvText = header.join(',') + '\n' + varheader.join(',') + '\n';
        for(let i = 0; i < maxDatapts; i++) {
            csvText += valData[i].join(',') + '\n';
        }
        
        // download
        wpd.download.csv(csvText, "wpd_datasets.csv");
    }

    function exportToPlotly() {
        wpd.popup.close('export-all-data-popup');

        // loop over all datasets
        var plotData = wpd.appData.getPlotData(),            
            dsColl = plotData.getDatasets(),
            i, coli, rowi,
            dataProvider = wpd.plotDataProvider,
            pdata,
            plotlyData = { "data": [] },
            colName;

        if(dsColl == null || dsColl.length === 0) {
            // axes is not aligned, show an error message?
            wpd.messagePopup.show(wpd.gettext('no-datasets-to-export-error'), wpd.gettext('no-datasets-to-export'));
            return;
        }

        for(i = 0; i < dsColl.length; i++) {
            dataProvider.setDataSource(dsColl[i]);
            pdata = dataProvider.getData();
            plotlyData.data[i] = {};

            // loop over columns
            for(coli = 0; coli < 2; coli++) {
                colName = (coli === 0) ? 'x' : 'y';
                plotlyData.data[i][colName] = [];
                for(rowi = 0; rowi < pdata.rawData.length; rowi++) {
                    if(pdata.fieldDateFormat[coli] != null) {
                        plotlyData.data[i][colName][rowi] = wpd.dateConverter.formatDateNumber(pdata.rawData[rowi][coli], "yyyy-mm-dd hh:ii:ss");
                    } else {
                        plotlyData.data[i][colName][rowi] = pdata.rawData[rowi][coli];
                    }
                }
            }
        }

        wpd.plotly.send(plotlyData);
    }

    return {
        show: show,
        generateCSV: generateCSV,
        exportToPlotly: exportToPlotly
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.download = (function() {
    
    function textFile(data, filename) {
        if(wpd.browserInfo.downloadAttributeSupported) {
            textFileLocal(data, filename);
        } else {
            textFileServer(data, filename);
        }
    }

    function textFileLocal(data, filename) {
        let $downloadElem = document.createElement('a');
        $downloadElem.href = URL.createObjectURL(new Blob([data]), {type:"text/plain"});
        $downloadElem.download = stripIllegalCharacters(filename);
        $downloadElem.style.display = "none";
        document.body.appendChild($downloadElem);
        $downloadElem.click();
        document.body.removeChild($downloadElem);
    }

    function textFileServer(data, filename) {
        var formContainer,
            formElement,
            formData,
            formFilename,
            jsonData = data;
        
        // Create a hidden form and submit
        formContainer = document.createElement('div');
        formElement = document.createElement('form');
        formData = document.createElement('textarea');
        formFilename = document.createElement('input');
        formFilename.type = 'hidden';

        formElement.setAttribute('method', 'post');
        formElement.setAttribute('action', 'download/text');

        formData.setAttribute('name', "data");
        formData.setAttribute('id', "data");
        formFilename.setAttribute('name', 'filename');
        formFilename.setAttribute('id', 'filename');
        formFilename.value = stripIllegalCharacters(filename);

        formElement.appendChild(formData);
        formElement.appendChild(formFilename);
        formContainer.appendChild(formElement);
        document.body.appendChild(formContainer);
        formContainer.style.display = 'none';

        formData.innerHTML = jsonData;
        formElement.submit();
        document.body.removeChild(formContainer);
    }

    function json(jsonData, filename) {
        if(filename == null) {
            filename = 'wpd_plot_data.json';
        }
        textFile(jsonData, filename);
    }

    function csv(csvData, filename) {
        if(filename == null) {
            filename = 'data.csv';
        }
        textFile(csvData, filename);
    }

    function stripIllegalCharacters(filename) {
        return filename.replace(/[^a-zA-Z\d+\.\-_\s]/g,"_");
    }

    return {
        json: json,
        csv: csv
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.log = function() {
    // Capture some basic info that helps WPD development.
    // Never capture anything about the data here!

    // if we're running inside electron, then skip
    if(wpd.browserInfo.isElectronBrowser()) {
        return;
    }

    // if server has disabled logging, then skip
    fetch("log").then(function(response) { 
        return response.text();
    }).then(function(text) {
        if(text=="true") {
            // logging is enabled
            let data = {};
            data["screen-size"] = window.screen.width + "x" + window.screen.height;
            data["document-location"] = document.location.href;
            data["document-referrer"] = document.referrer;
            data["platform"] = window.navigator.platform;
            data["userAgent"] = window.navigator.userAgent;
            data["language"] = window.navigator.language;
            fetch("log", {
                method: 'post',
                headers: {
                  'Accept': 'application/json, text/plain, */*',
                  'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
              });
        }
    });
};/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.plotly = (function() {
    
    function send(dataObject) {
        var formContainer = document.createElement('div'),
            formElement = document.createElement('form'),
            formData = document.createElement('textarea'),
            jsonString;

        formElement.setAttribute('method', 'post');
        formElement.setAttribute('action', 'https://plot.ly/external');
        formElement.setAttribute('target', '_blank');
        
        formData.setAttribute('name', 'data');
        formData.setAttribute('id', 'data');

        formElement.appendChild(formData);
        formContainer.appendChild(formElement);
        document.body.appendChild(formContainer);
        formContainer.style.display = 'none';

        jsonString = JSON.stringify(dataObject);
        
        formData.innerHTML = jsonString;
        formElement.submit();
        document.body.removeChild(formContainer);
    }

    return {
        send: send
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.saveResume = (function () {

    function save() {
        wpd.popup.show('export-json-window');
    }

    function load() {
        wpd.popup.show('import-json-window');
    }

    function resumeFromJSON(json_data) {
        const plotData = wpd.appData.getPlotData();
        plotData.deserialize(json_data);
        wpd.tree.refresh();
    }

    function generateJSON() {
        const plotData = wpd.appData.getPlotData();
        return JSON.stringify(plotData.serialize());
    }

    function stripIllegalCharacters(filename) {
        return filename.replace(/[^a-zA-Z\d+\.\-_\s]/g,"_");
    }

    function downloadJSON() {
        // get project name
        let projectName = stripIllegalCharacters(document.getElementById("project-name-input").value) + ".json";

        wpd.download.json(generateJSON(), projectName); 
        wpd.popup.close('export-json-window');
    }

    function downloadProject() {        
        // get project name
        let projectName = stripIllegalCharacters(document.getElementById("project-name-input").value);

        // get JSON
        let json = generateJSON();

        // get Image
        let imageFile = wpd.graphicsWidget.getImagePNG();

        // projectInfo
        let projectInfo = JSON.stringify({"version": [4,0], "json": "wpd.json", "image": "image.png"});

        // generate project file
        let tarWriter = new tarball.TarWriter();
        tarWriter.addFolder(projectName + "/");
        tarWriter.addTextFile(projectName + "/info.json", projectInfo);
        tarWriter.addTextFile(projectName + "/wpd.json", json);
        tarWriter.addFile(projectName + "/image.png", imageFile);
        tarWriter.download(projectName + ".tar");
        wpd.popup.close('export-json-window');
    }

    function readJSONFileOnly(jsonFile) {
        var fileReader = new FileReader();
        fileReader.onload = function () {
            var json_data = JSON.parse(fileReader.result);
            resumeFromJSON(json_data); 
            
            wpd.graphicsWidget.resetData();
            wpd.graphicsWidget.removeTool();
            wpd.graphicsWidget.removeRepainter();            
            wpd.tree.refresh();
            wpd.messagePopup.show(wpd.gettext('import-json'), wpd.gettext("json-data-loaded"));
        };
        fileReader.readAsText(jsonFile);
    }

    function readProjectFile(file) {
        wpd.busyNote.show();
        var tarReader = new tarball.TarReader();
        tarReader.readFile(file).then(function(fileInfo) {
            wpd.busyNote.close();
            let infoIndex = fileInfo.findIndex(info => info.name.endsWith("/info.json"));
            if(infoIndex >= 0) {
                let projectName = fileInfo[infoIndex].name.replace("/info.json","");
                let wpdimage = tarReader.getFileBlob(projectName + "/image.png", "image/png");
                wpdimage.name = "image.png";                
                let wpdjson = JSON.parse(tarReader.getTextFile(projectName + "/wpd.json"));
                wpd.imageManager.loadFromFile(wpdimage, true).then(() => {
                    resumeFromJSON(wpdjson);
                    wpd.tree.refresh();
                    wpd.messagePopup.show(wpd.gettext('import-json'), wpd.gettext("json-data-loaded"));
                });
            }
        }, function(err) {
            console.log(err);
        });
    }   

    function read() {
        const $fileInput = document.getElementById('import-json-file');
        wpd.popup.close('import-json-window');
        if($fileInput.files.length === 1) {
            let file = $fileInput.files[0];
            let fileType = file.type;
            if(fileType == "" || fileType == null) {
                // Chrome on Windows
                if(file.name.endsWith(".json")) {
                    fileType = "application/json";
                } else if(file.name.endsWith(".tar")) {
                    fileType = "application/x-tar";
                }
            }
            if(fileType == "application/json") {
                readJSONFileOnly(file);
            } else if(fileType == "application/x-tar") {
                readProjectFile(file);
            } else {
                wpd.messagePopup.show(wpd.gettext("invalid-project"), wpd.gettext("invalid-project-msg"));
            }
        }
    }

    return {
        save: save,
        load: load,
        downloadJSON: downloadJSON,
        downloadProject: downloadProject,
        read: read
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.scriptInjector = (function () {
    
    function start() {
        wpd.popup.show('runScriptPopup');
    }

    function cancel() {
        wpd.popup.close('runScriptPopup');
    }

    function load() {
        var $scriptFileInput = document.getElementById('runScriptFileInput');
        wpd.popup.close('runScriptPopup');
        if($scriptFileInput.files.length == 1) {
            var fileReader = new FileReader();
            fileReader.onload = function() {
                if(typeof wpdscript !== "undefined") {
                    wpdscript = null;
                }
                eval(fileReader.result);
                if(typeof wpdscript !== "wpdscript") {
                    window["wpdscript"] = wpdscript;
                    wpdscript.run();
                }
            };
            fileReader.readAsText($scriptFileInput.files[0]);
        }
    }

    function injectHTML() {
    }

    function injectCSS() {
    }

    return {
        start: start,
        cancel: cancel,
        load: load
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
// maintain and manage current state of the application
wpd.appData = (function () {
    let plotData;
    let backupImageData = null;

    function reset() {
        isAligned = false;
        plotData = null;
        backupImageData = null;
    }

    function getPlotData() {
        if(plotData == null) {
            plotData = new wpd.PlotData();
        }
        return plotData;
    }

    function isAligned() {
        return getPlotData().getAxesCount() > 0;
    }

    function plotLoaded(imageData) {
        getPlotData().getAutoDetector().topColors = wpd.colorAnalyzer.getTopColors(imageData);
    }

    return {
        isAligned: isAligned,
        getPlotData: getPlotData,
        reset: reset,
        plotLoaded: plotLoaded,
        backupImageData: backupImageData       
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
wpd.autoExtraction = (function () {

    function start() {
        wpd.colorPicker.init();
        wpd.algoManager.updateAlgoList();
    }     

    return {
        start: start        
    };
})();


// Manage auto extract algorithms
wpd.algoManager = (function() {

    var axes, dataset;

    function updateAlgoList() {
        
        dataset = wpd.tree.getActiveDataset();
        axes = wpd.appData.getPlotData().getAxesForDataset(dataset);

        var innerHTML = '',
            $algoOptions = document.getElementById('auto-extract-algo-name');

        // Averaging Window
        if(!(axes instanceof wpd.BarAxes)) {
            innerHTML += '<option value="averagingWindow">' + wpd.gettext('averaging-window') + '</option>';
        }

        // X Step w/ Interpolation and X Step
        if(axes instanceof wpd.XYAxes) {
            innerHTML += '<option value="XStepWithInterpolation">' + wpd.gettext('x-step-with-interpolation') + '</option>';
            innerHTML += '<option value="XStep">' + wpd.gettext('x-step') + '</option>';
        }

        // Blob Detector
        if(!(axes instanceof wpd.BarAxes)) {
            innerHTML += '<option value="blobDetector">' + wpd.gettext('blob-detector') + '</option>';
        }

        // Bar Extraction
        if(axes instanceof wpd.BarAxes) {
            innerHTML += '<option value="barExtraction">' + wpd.gettext('bar-extraction') + '</option>';
        }

        // Histogram
        if(axes instanceof wpd.XYAxes) {
            innerHTML += '<option value="histogram">' + wpd.gettext('histogram') + '</option>';
        }

        $algoOptions.innerHTML = innerHTML;

        applyAlgoSelection();
    }

    function applyAlgoSelection() {
        var $algoOptions = document.getElementById('auto-extract-algo-name'),
            selectedValue = $algoOptions.value,
            autoDetector = wpd.appData.getPlotData().getAutoDetector();

        if (selectedValue === 'averagingWindow') {
            autoDetector.algorithm = new wpd.AveragingWindowAlgo();
        } else if (selectedValue === 'XStepWithInterpolation') {
            autoDetector.algorithm = new wpd.XStepWithInterpolationAlgo();
        } else if (selectedValue === 'XStep') {
            autoDetector.algorithm = new wpd.AveragingWindowWithStepSizeAlgo();
        } else if (selectedValue === 'blobDetector') {
            autoDetector.algorithm = new wpd.BlobDetectorAlgo();
        } else if (selectedValue === 'barExtraction' || selectedValue === 'histogram') {
            autoDetector.algorithm = new wpd.BarExtractionAlgo();
        } else {
            autoDetector.algorithm = new wpd.AveragingWindowAlgo();
        }

        renderParameters(autoDetector.algorithm);
    }

    function renderParameters(algo) {
        var $paramContainer = document.getElementById('algo-parameter-container'),
            algoParams = algo.getParamList(axes),
            pi,
            tableString = "<table>";

        
        for(pi = 0; pi < algoParams.length; pi++) {
            tableString += '<tr><td>' + algoParams[pi][0] + 
                '</td><td><input type="text" size=3 id="algo-param-' + pi + 
                '" class="algo-params" value="'+ algoParams[pi][2] + '"/></td><td>' 
                + algoParams[pi][1] + '</td></tr>';
        }

        tableString += "</table>";
        $paramContainer.innerHTML = tableString;
    }

    function run() {
        wpd.busyNote.show();
        var autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            algo = autoDetector.algorithm,
            repainter = new wpd.DataPointsRepainter(axes, dataset),
            $paramFields = document.getElementsByClassName('algo-params'),
            pi,
            paramId, paramIndex,
            ctx = wpd.graphicsWidget.getAllContexts(),
            imageSize = wpd.graphicsWidget.getImageSize();

        for(pi = 0; pi < $paramFields.length; pi++) {
            paramId = $paramFields[pi].id;
            paramIndex = parseInt(paramId.replace('algo-param-', ''), 10);
            algo.setParam(paramIndex, parseFloat($paramFields[pi].value));
        }

        wpd.graphicsWidget.removeTool();

        autoDetector.imageData = ctx.oriImageCtx.getImageData(0, 0, imageSize.width, imageSize.height);
        autoDetector.generateBinaryData();
        wpd.graphicsWidget.setRepainter(repainter);            
        algo.run(autoDetector, dataset, axes);
        wpd.graphicsWidget.forceHandlerRepaint();
        wpd.dataPointCounter.setCount(dataset.getCount());
        wpd.busyNote.close();
        return true;    
    }

    return {
        updateAlgoList: updateAlgoList,
        applyAlgoSelection: applyAlgoSelection,
        run: run
    };
})();

wpd.dataMask = (function () {

    function grabMask() {
        // Mask is just a list of pixels with the yellow color in the data layer
        var ctx = wpd.graphicsWidget.getAllContexts(),
            imageSize = wpd.graphicsWidget.getImageSize(),
            maskDataPx = ctx.oriDataCtx.getImageData(0, 0, imageSize.width, imageSize.height),
            maskData = [],
            i,
            mi = 0,
            autoDetector = wpd.appData.getPlotData().getAutoDetector();
        for(i = 0; i < maskDataPx.data.length; i+=4) {
            if (maskDataPx.data[i] === 255 && maskDataPx.data[i+1] === 255 && maskDataPx.data[i+2] === 0) {
                maskData[mi] = i/4; mi++;
            }
        }
        autoDetector.mask = maskData;
    }

    function markBox() {
        var tool = new wpd.BoxMaskTool();
        wpd.graphicsWidget.setTool(tool);
    }

    function markPen() {
        var tool = new wpd.PenMaskTool();
        wpd.graphicsWidget.setTool(tool);
    }

    function eraseMarks() {
        var tool = new wpd.EraseMaskTool();
        wpd.graphicsWidget.setTool(tool);
    }

    function viewMask() {
        var tool = new wpd.ViewMaskTool();
        wpd.graphicsWidget.setTool(tool);
    }

    function clearMask() {
        wpd.graphicsWidget.resetData();
        grabMask();
    }

    return {
        grabMask: grabMask,
        markBox: markBox,
        markPen: markPen,
        eraseMarks: eraseMarks,
        viewMask: viewMask,
        clearMask: clearMask
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.AxesCalibrator = class {
    constructor(calibration, isEditing) {
        this._calibration = calibration;
        this._isEditing = isEditing;
    }
};

wpd.XYAxesCalibrator = class extends wpd.AxesCalibrator {

    start() {        
        wpd.popup.show('xyAxesInfo');
    }

    reload() {
        let tool = new wpd.AxesCornersTool(this._calibration, true);
        wpd.graphicsWidget.setTool(tool);
    }

    pickCorners() {
        wpd.popup.close('xyAxesInfo');
        let tool = new wpd.AxesCornersTool(this._calibration, false);
        wpd.graphicsWidget.setTool(tool);
    }

    getCornerValues() {        
        wpd.popup.show('xyAlignment');
        if(this._isEditing) {
            let axes = wpd.tree.getActiveAxes();
            let prevCal = axes.calibration;
            if(prevCal.getCount() == 4) {
                document.getElementById('xmin').value = prevCal.getPoint(0).dx;
                document.getElementById('xmax').value = prevCal.getPoint(1).dx;
                document.getElementById('ymin').value = prevCal.getPoint(2).dy;
                document.getElementById('ymax').value = prevCal.getPoint(3).dy;
                document.getElementById('xlog').checked = axes.isLogX();
                document.getElementById('ylog').checked = axes.isLogY();
            }
        }
    }

    align() {
        var xmin = document.getElementById('xmin').value,
	        xmax = document.getElementById('xmax').value,
	        ymin = document.getElementById('ymin').value,
	        ymax = document.getElementById('ymax').value,
	        xlog = document.getElementById('xlog').checked,
            ylog = document.getElementById('ylog').checked,            
            axes = this._isEditing ? wpd.tree.getActiveAxes() : new wpd.XYAxes();
                
        // validate log scale values
        if((xlog && (parseFloat(xmin) == 0 || parseFloat(xmax) == 0)) || (ylog && (parseFloat(ymin) == 0 || parseFloat(ymax) == 0))) {
            wpd.popup.close('xyAlignment');
            wpd.messagePopup.show(wpd.gettext('calibration-invalid-log-inputs'), wpd.gettext('calibration-enter-valid-log'), wpd.alignAxes.getCornerValues);
            return false;            
        }

        this._calibration.setDataAt(0, xmin, ymin);
        this._calibration.setDataAt(1, xmax, ymin);
        this._calibration.setDataAt(2, xmin, ymin);
        this._calibration.setDataAt(3, xmax, ymax);
        if(!axes.calibrate(this._calibration, xlog, ylog)) {
            wpd.popup.close('xyAlignment');
            wpd.messagePopup.show(wpd.gettext('calibration-invalid-inputs'), wpd.gettext('calibration-enter-valid'), wpd.alignAxes.getCornerValues);
            return false;
        }

        if(!this._isEditing) {
            axes.name = wpd.alignAxes.makeAxesName(wpd.XYAxes);
            let plot = wpd.appData.getPlotData();
            plot.addAxes(axes);
        }                
        wpd.popup.close('xyAlignment');
        return true;
    }
};

wpd.BarAxesCalibrator = class extends wpd.AxesCalibrator {
    start() {        
        wpd.popup.show('barAxesInfo');
    }
    reload() {
        var tool = new wpd.AxesCornersTool(this._calibration, true);
        wpd.graphicsWidget.setTool(tool);
    }
    pickCorners() {
        wpd.popup.close('barAxesInfo');
        var tool = new wpd.AxesCornersTool(this._calibration, false);
        wpd.graphicsWidget.setTool(tool);
    }
    getCornerValues() {
        wpd.popup.show('barAlignment');
        if(this._isEditing) {
            let axes = wpd.tree.getActiveAxes();
            let prevCal = axes.calibration;
            if(prevCal.getCount() == 2) {
                document.getElementById('bar-axes-p1').value = prevCal.getPoint(0).dy;
                document.getElementById('bar-axes-p2').value = prevCal.getPoint(1).dy;
                document.getElementById('bar-axes-log-scale').checked = axes.isLog();
                document.getElementById('bar-axes-rotated').checked = axes.isRotated();
            }
        }
    }
    align() {
        var p1 = document.getElementById('bar-axes-p1').value,
            p2 = document.getElementById('bar-axes-p2').value,
            isLogScale = document.getElementById('bar-axes-log-scale').checked,
            isRotated = document.getElementById('bar-axes-rotated').checked,
            axes = this._isEditing ? wpd.tree.getActiveAxes() : new wpd.BarAxes();

        this._calibration.setDataAt(0, 0, p1);
        this._calibration.setDataAt(1, 0, p2);
        if(!axes.calibrate(this._calibration, isLogScale, isRotated)) {
            wpd.popup.close('barAlignment');
            wpd.messagePopup.show(wpd.gettext('calibration-invalid-inputs'), wpd.gettext('calibration-enter-valid'), wpd.alignAxes.getCornerValues);
            return false;
        }
        if(!this._isEditing) {
            axes.name = wpd.alignAxes.makeAxesName(wpd.BarAxes);
            let plot = wpd.appData.getPlotData();
            plot.addAxes(axes);   
        }     
        wpd.popup.close('barAlignment');
        return true;
    }
};

wpd.PolarAxesCalibrator = class extends wpd.AxesCalibrator {
    
    start() {        
        wpd.popup.show('polarAxesInfo');
    }
    reload() {
        var tool = new wpd.AxesCornersTool(this._calibration, true);
        wpd.graphicsWidget.setTool(tool);
    }
    pickCorners() {
        wpd.popup.close('polarAxesInfo');
        var tool = new wpd.AxesCornersTool(this._calibration, false);
        wpd.graphicsWidget.setTool(tool);
    }

    getCornerValues() {
        wpd.popup.show('polarAlignment');
        if(this._isEditing) {
            let axes = wpd.tree.getActiveAxes();
            let prevCal = axes.calibration;
            if(prevCal.getCount() == 3) {
                document.getElementById('polar-r1').value = prevCal.getPoint(1).dx;
                document.getElementById('polar-theta1').value = prevCal.getPoint(1).dy;
                document.getElementById('polar-r2').value = prevCal.getPoint(2).dx;
                document.getElementById('polar-theta2').value = prevCal.getPoint(2).dy;
                document.getElementById('polar-degrees').checked = axes.isThetaDegrees();
                document.getElementById('polar-radians').checked = !axes.isThetaDegrees();
                document.getElementById('polar-clockwise').checked = axes.isThetaClockwise();
                document.getElementById('polar-log-scale').checked = axes.isRadialLog();
            }
        }
    }

    align() {
        var r1 = parseFloat(document.getElementById('polar-r1').value),
            theta1 = parseFloat(document.getElementById('polar-theta1').value),
            r2 = parseFloat(document.getElementById('polar-r2').value),
            theta2 = parseFloat(document.getElementById('polar-theta2').value),
            degrees = document.getElementById('polar-degrees').checked,            
            orientation = document.getElementById('polar-clockwise').checked,
            rlog = document.getElementById('polar-log-scale').checked,
            axes = this._isEditing ? wpd.tree.getActiveAxes() : new wpd.PolarAxes(),            
            isDegrees = degrees;

        this._calibration.setDataAt(1, r1, theta1);
        this._calibration.setDataAt(2, r2, theta2);
        axes.calibrate(this._calibration, isDegrees, orientation, rlog);
        if(!this._isEditing) {
            axes.name = wpd.alignAxes.makeAxesName(wpd.PolarAxes);
            let plot = wpd.appData.getPlotData();
            plot.addAxes(axes);   
        }     
        wpd.popup.close('polarAlignment');
        return true;
    }
};
        
wpd.TernaryAxesCalibrator = class extends wpd.AxesCalibrator {

    start() {        
        wpd.popup.show('ternaryAxesInfo');
    }

    reload() {
        var tool = new wpd.AxesCornersTool(this._calibration, true);
        wpd.graphicsWidget.setTool(tool);
    }

    pickCorners() {
        wpd.popup.close('ternaryAxesInfo');
        var tool = new wpd.AxesCornersTool(this._calibration, false);
        wpd.graphicsWidget.setTool(tool);
    }

    getCornerValues() {
        wpd.popup.show('ternaryAlignment');

        if(this._isEditing) {
            let axes = wpd.tree.getActiveAxes();            
            if(prevCal.getCount() == 3) {
                document.getElementById('range0to1').checked = !axes.isRange100();                
                document.getElementById('range0to100').checked = axes.isRange100();
                document.getElementById('ternarynormal').checked = axes.isNormalOrientation();
            }
        }
    }

    align() {
        var range100 = document.getElementById('range0to100').checked,
            ternaryNormal = document.getElementById('ternarynormal').checked,
            axes = this._isEditing ? wpd.tree.getActiveAxes() : new wpd.TernaryAxes();

        axes.calibrate(this._calibration, range100, ternaryNormal);
        if(!this._isEditing) {
            axes.name = wpd.alignAxes.makeAxesName(wpd.TernaryAxes);
            let plot = wpd.appData.getPlotData();
            plot.addAxes(axes);
        }
        wpd.popup.close('ternaryAlignment');
        return true;
    }
};
        
wpd.MapAxesCalibrator = class extends wpd.AxesCalibrator {

    start() {        
        wpd.popup.show('mapAxesInfo');
    }
    reload() {
        var tool = new wpd.AxesCornersTool(this._calibration, true);
        wpd.graphicsWidget.setTool(tool);
    }
    pickCorners() {
        wpd.popup.close('mapAxesInfo');
        var tool = new wpd.AxesCornersTool(this._calibration, false);
        wpd.graphicsWidget.setTool(tool);
    }
    getCornerValues() {
        wpd.popup.show('mapAlignment');
        if(this._isEditing) {
            let axes = wpd.tree.getActiveAxes();            
            if(prevCal.getCount() == 2) {
                document.getElementById('scaleLength').checked = axes.getScaleLength();
                document.getElementById('scaleUnits').checked = axes.getUnits();
            }
        }
    }
    align() {
        var scaleLength = parseFloat(document.getElementById('scaleLength').value),
            scaleUnits = document.getElementById('scaleUnits').value,
            axes = this._isEditing ? wpd.tree.getActiveAxes() : new wpd.MapAxes();

        axes.calibrate(this._calibration, scaleLength, scaleUnits);
        if(!this._isEditing) {
            axes.name = wpd.alignAxes.makeAxesName(wpd.MapAxes);
            let plot = wpd.appData.getPlotData();
            plot.addAxes(axes);
        }      
        wpd.popup.close('mapAlignment');
        return true;
    }
};

wpd.alignAxes = (function () {
    
    var calibration, calibrator;
    
    function initiatePlotAlignment() {
        xyEl = document.getElementById('r_xy');
        polarEl = document.getElementById('r_polar');
        ternaryEl = document.getElementById('r_ternary');
        mapEl = document.getElementById('r_map');
        imageEl = document.getElementById('r_image');
        barEl = document.getElementById('r_bar');

        wpd.popup.close('axesList');

        if (xyEl.checked === true) {
            calibration = new wpd.Calibration(2);
            calibration.labels = ['X1', 'X2', 'Y1', 'Y2'];
            calibration.labelPositions = ['N', 'N', 'E', 'E'];
            calibration.maxPointCount = 4;
            calibrator = new wpd.XYAxesCalibrator(calibration);
        } else if(barEl.checked === true) {
            calibration = new wpd.Calibration(2);
            calibration.labels = ['P1', 'P2'];
            calibration.labelPositions = ['S', 'S'];
            calibration.maxPointCount = 2;
            calibrator = new wpd.BarAxesCalibrator(calibration);
        } else if(polarEl.checked === true) {
            calibration = new wpd.Calibration(2);
            calibration.labels = ['Origin', 'P1', 'P2'];
            calibration.labelPositions = ['E', 'S', 'S'];
            calibration.maxPointCount = 3;
            calibrator = new wpd.PolarAxesCalibrator(calibration);
        } else if(ternaryEl.checked === true) {
            calibration = new wpd.Calibration(2);
            calibration.labels = ['A', 'B', 'C'];
            calibration.labelPositions = ['S', 'S', 'E'];
            calibration.maxPointCount = 3;
            calibrator = new wpd.TernaryAxesCalibrator(calibration);
        } else if(mapEl.checked === true) {
            calibration = new wpd.Calibration(2);
            calibration.labels = ['P1', 'P2'];
            calibration.labelPositions = ['S', 'S'];
            calibration.maxPointCount = 2;
            calibrator = new wpd.MapAxesCalibrator(calibration);
        } else if(imageEl.checked === true) {
            calibration = null;
            calibrator = null;
            var imageAxes = new wpd.ImageAxes();            
            imageAxes.name = wpd.alignAxes.makeAxesName(wpd.ImageAxes);
            imageAxes.calibrate();
            wpd.appData.getPlotData().addAxes(imageAxes);
            wpd.tree.refresh();
            let dsNameColl = wpd.appData.getPlotData().getDatasetNames();
            if(dsNameColl.length > 0) {
                let dsName = dsNameColl[0];
                wpd.tree.selectPath("/"+ wpd.gettext("datasets") +"/" + dsName, true);
            }
            wpd.acquireData.load();
        }

        if(calibrator != null) {
            calibrator.start();
            wpd.graphicsWidget.setRepainter(new wpd.AlignmentCornersRepainter(calibration));
        }
    }

    function calibrationCompleted() {
        wpd.sidebar.show('axes-calibration-sidebar');
    }

    function zoomCalPoint(i){
        var point = calibration.getPoint(i);
        wpd.graphicsWidget.updateZoomToImagePosn(point.px, point.py);
    }

    function getCornerValues() {
        calibrator.getCornerValues();
    }

    function pickCorners() {
        calibrator.pickCorners();
    }

    function align() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.removeRepainter();
        wpd.graphicsWidget.resetData();
        if(!calibrator.align()) {
            return;
        }        
        wpd.tree.refresh();
        let dsNameColl = wpd.appData.getPlotData().getDatasetNames();
        if(dsNameColl.length > 0) {
            let dsName = dsNameColl[0];
            wpd.tree.selectPath("/"+wpd.gettext("datasets")+"/"+dsName);
        }        
    }

    function editAlignment() {
        var hasAlignment = wpd.appData.isAligned() && calibrator != null;
        if(hasAlignment) {
            wpd.popup.show('edit-or-reset-calibration-popup');
        } else {
            wpd.popup.show('axesList');
        }
    }

    function addCalibration() {
        wpd.popup.show("axesList");
    }

    function reloadCalibrationForEditing() {
        wpd.popup.close('edit-or-reset-calibration-popup');
        calibrator = null;
        const axes = wpd.tree.getActiveAxes();
        calibration = axes.calibration;
        if(axes instanceof wpd.XYAxes) {
            calibrator = new wpd.XYAxesCalibrator(calibration, true);
        } else if(axes instanceof wpd.BarAxes) {
            calibrator = new wpd.BarAxesCalibrator(calibration, true);
        } else if(axes instanceof wpd.PolarAxes) {
            calibrator = new wpd.PolarAxesCalibrator(calibration, true);
        } else if(axes instanceof wpd.TernaryAxes) {
            calibrator = new wpd.TernaryAxesCalibrator(calibration, true);
        } else if(axes instanceof wpd.MapAxes) {
            calibrator = new wpd.MapAxesCalibrator(calibration, true);
        }
        if(calibrator == null) return;        
        calibrator.reload();
        wpd.graphicsWidget.setRepainter(new wpd.AlignmentCornersRepainter(calibration));
        wpd.graphicsWidget.forceHandlerRepaint();
        wpd.sidebar.show('axes-calibration-sidebar');
    }

    function deleteCalibration() {
        wpd.okCancelPopup.show(wpd.gettext("delete-axes"), wpd.gettext("delete-axes-text"), function() {
            const plotData = wpd.appData.getPlotData();
            const axes = wpd.tree.getActiveAxes();
            plotData.deleteAxes(axes);
            wpd.tree.refresh();
            wpd.tree.selectPath("/"+wpd.gettext("axes"));
        });
    }

    function showRenameAxes() {
        const axes = wpd.tree.getActiveAxes();        
        const $axName = document.getElementById("rename-axes-name-input");
        $axName.value = axes.name;
        wpd.popup.show('rename-axes-popup');
    }

    function renameAxes() {        
        const $axName = document.getElementById("rename-axes-name-input");
        wpd.popup.close('rename-axes-popup');        
        // check if this name already exists
        const name = $axName.value.trim();
        const plotData = wpd.appData.getPlotData();        
        if(plotData.getAxesNames().indexOf(name) >= 0 || name.length === 0) {
            wpd.messagePopup.show(wpd.gettext("rename-axes-error"), wpd.gettext("axes-exists-error"), showRenameAxes);
            return;
        }        
        const axes = wpd.tree.getActiveAxes();
        axes.name = name;
        wpd.tree.refresh();
        wpd.tree.selectPath("/"+wpd.gettext("axes")+"/"+name, true);
    }

    function renameKeypress(e) {
        if(e.key === "Enter") {
            renameAxes();
        }
    }

    function makeAxesName(axType) {
        const plotData = wpd.appData.getPlotData();
        let name = "";
        const existingAxesNames = plotData.getAxesNames();
        if(axType === wpd.XYAxes) {
            name = wpd.gettext("axes-name-xy");
        } else if(axType === wpd.PolarAxes) {
            name = wpd.gettext("axes-name-polar");
        } else if(axType === wpd.MapAxes) {
            name = wpd.gettext("axes-name-map");
        } else if(axType === wpd.TernaryAxes) {
            name = wpd.gettext("axes-name-ternary");
        } else if(axType === wpd.BarAxes) {
            name = wpd.gettext("axes-name-bar");
        } else if(axType === wpd.ImageAxes) {
            name = wpd.gettext("axes-name-image");
        }
        // avoid conflict with an existing name
        let idx = 2;
        let fullName = name;
        while(existingAxesNames.indexOf(fullName) >= 0) {
            fullName = name + " " + idx;
            idx++;
        }
        return fullName;
    }

    return {
        start: initiatePlotAlignment,
        calibrationCompleted: calibrationCompleted,
        zoomCalPoint: zoomCalPoint,
        getCornerValues: getCornerValues,
        pickCorners: pickCorners,
        align: align,        
        editAlignment: editAlignment,
        reloadCalibrationForEditing: reloadCalibrationForEditing,
        addCalibration: addCalibration,
        deleteCalibration: deleteCalibration,
        showRenameAxes: showRenameAxes,
        makeAxesName: makeAxesName,
        renameAxes: renameAxes,
        renameKeypress: renameKeypress 
    };

})();/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

// browserInfo.js - browser and available HTML5 feature detection
var wpd = wpd || {};
wpd.browserInfo = (function () {

    function checkBrowser() {
        if(!window.FileReader) {
            alert('\tWARNING!\nYour web browser is not supported. This program might not behave as intended. Please use a recent version of Google Chrome, Firefox or Safari browser.');
        }
    }

    let downloadAttributeSupported = ("download" in document.createElement("a"));

    function isElectronBrowser() {
        if(typeof process === 'undefined') { // there's probably a much better way to do this!
            return false;
        }
        return true;
    }

    return {
        checkBrowser : checkBrowser,
        downloadAttributeSupported: downloadAttributeSupported,
        isElectronBrowser: isElectronBrowser
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.colorSelectionWidget = (function () {

    var color,
        triggerElementId,
        title,
        setColorDelegate;
    
    function setParams(params) {
        color = params.color;
        triggerElementId = params.triggerElementId;
        title = params.title;
        setColorDelegate = params.setColorDelegate;

        var $widgetTitle = document.getElementById('color-selection-title');
        $widgetTitle.innerHTML = title;
    }

    function apply() {
        var $triggerBtn = document.getElementById(triggerElementId);
        $triggerBtn.style.backgroundColor = 'rgb('+color[0]+','+color[1]+','+color[2]+')';
        if(color[0] + color[1] + color[2] < 200) {
            $triggerBtn.style.color = 'rgb(255,255,255)';
        } else {
            $triggerBtn.style.color = 'rgb(0,0,0)';
        }
    }

    function startPicker() {
        var $selectedColor = document.getElementById('color-selection-selected-color-box');
        
        $selectedColor.style.backgroundColor = 'rgb('+color[0]+','+color[1]+','+color[2]+')';
        document.getElementById('color-selection-red').value = color[0];
        document.getElementById('color-selection-green').value = color[1];
        document.getElementById('color-selection-blue').value = color[2];
        renderColorOptions();
        wpd.popup.show('color-selection-widget');
    }

    function renderColorOptions() {
        var $container = document.getElementById('color-selection-options'),
            topColors = wpd.appData.getPlotData().getAutoDetector().topColors,
            colorCount = topColors.length > 10 ? 10 : topColors.length,
            colori,
            containerHtml = "",
            perc,
            colorString;

        for (colori = 0; colori < colorCount; colori++) {            
            colorString = 'rgb(' + topColors[colori].r + ',' + topColors[colori].g + ',' + topColors[colori].b + ');';
            perc = topColors[colori].percentage.toFixed(3) + "%";
            containerHtml += '<div class="colorOptionBox" style="background-color: ' + colorString + '\" title=\"' + perc +  '" onclick="wpd.colorSelectionWidget.selectTopColor('+ colori +');"></div>';
        }

        $container.innerHTML = containerHtml;
    }

    function pickColor() {
        wpd.popup.close('color-selection-widget');
        var tool = new wpd.ColorPickerTool();
        tool.onComplete = function (col) {
            color = col;
            setColorDelegate(col);
            wpd.graphicsWidget.removeTool();
            startPicker();
        };
        wpd.graphicsWidget.setTool(tool);
    }

    function setColor() {
        var gui_color = [];
        gui_color[0] = parseInt(document.getElementById('color-selection-red').value, 10);
        gui_color[1] = parseInt(document.getElementById('color-selection-green').value, 10);
        gui_color[2] = parseInt(document.getElementById('color-selection-blue').value, 10);
        color = gui_color;
        setColorDelegate(gui_color);
        wpd.popup.close('color-selection-widget');
        apply();
    }

    function selectTopColor(colorIndex) {
        var gui_color = [],
            topColors = wpd.appData.getPlotData().getAutoDetector().topColors;

        gui_color[0] = topColors[colorIndex].r;
        gui_color[1] = topColors[colorIndex].g;
        gui_color[2] = topColors[colorIndex].b;

        color = gui_color;
        setColorDelegate(gui_color);
        startPicker();
    }

    function paintFilteredColor(binaryData, maskPixels) {
         var ctx = wpd.graphicsWidget.getAllContexts(),
            autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            imageSize = wpd.graphicsWidget.getImageSize(),
            maski,
            img_index,
            imgx, imgy,
            dataLayer;

        dataLayer = ctx.oriDataCtx.getImageData(0, 0, imageSize.width, imageSize.height);

        if(maskPixels == null || maskPixels.length === 0) {
            return;
        }

        for(maski = 0; maski < maskPixels.length; maski++) {
            img_index = maskPixels[maski];
            if(binaryData[img_index] === true) {
                imgx = img_index % imageSize.width;
                imgy = parseInt(img_index/imageSize.width, 10);
                dataLayer.data[img_index*4] = 255;
                dataLayer.data[img_index*4+1] = 255;
                dataLayer.data[img_index*4+2] = 0;
                dataLayer.data[img_index*4+3] = 255;                
            } else {
                dataLayer.data[img_index*4] = 0;
                dataLayer.data[img_index*4+1] = 0;
                dataLayer.data[img_index*4+2] = 0;
                dataLayer.data[img_index*4+3] = 150;   
            }
        }

        ctx.oriDataCtx.putImageData(dataLayer, 0, 0);
        wpd.graphicsWidget.copyImageDataLayerToScreen();
    }

    return {
        setParams: setParams,
        startPicker: startPicker,
        pickColor: pickColor,
        setColor: setColor,
        selectTopColor: selectTopColor,
        paintFilteredColor: paintFilteredColor
    };

})();

wpd.colorPicker = (function () {

    function getFGPickerParams() {
        return {
            color: wpd.appData.getPlotData().getAutoDetector().fgColor,
            triggerElementId: 'color-button',
            title: wpd.gettext('specify-foreground-color'),
            setColorDelegate: function(col) {
                wpd.appData.getPlotData().getAutoDetector().fgColor = col;
            }
        };
    }

    function getBGPickerParams() {
        return {
            color: wpd.appData.getPlotData().getAutoDetector().bgColor,
            triggerElementId: 'color-button',
            title: wpd.gettext('specify-background-color'),
            setColorDelegate: function(col) {
                wpd.appData.getPlotData().getAutoDetector().bgColor = col;
            }
        };
    }
    
    function init() {
        var $colorBtn = document.getElementById('color-button'),
            $colorDistance = document.getElementById('color-distance-value'),
            autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            $modeSelector = document.getElementById('color-detection-mode-select'),
            color;
        
        if(autoDetector.colorDetectionMode === 'fg') {
            color = autoDetector.fgColor;
        } else {
            color = autoDetector.bgColor;
        }
        color_distance = autoDetector.colorDistance;

        $colorBtn.style.backgroundColor = 'rgb('+color[0]+','+color[1]+','+color[2]+')';
        $colorDistance.value = color_distance;
        $modeSelector.value = autoDetector.colorDetectionMode;
    }

    function changeColorDistance() {
        var color_distance = parseFloat(document.getElementById('color-distance-value').value);
        wpd.appData.getPlotData().getAutoDetector().colorDistance = color_distance;
    }

    function testColorDetection() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.resetData();
        wpd.graphicsWidget.setRepainter(new wpd.ColorFilterRepainter());

        var ctx = wpd.graphicsWidget.getAllContexts(),
            autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            imageSize = wpd.graphicsWidget.getImageSize();

        autoDetector.imageData = ctx.oriImageCtx.getImageData(0, 0, imageSize.width, imageSize.height);
        autoDetector.generateBinaryData();
        wpd.colorSelectionWidget.paintFilteredColor(autoDetector.binaryData, autoDetector.mask); 
    }
    
    function startPicker() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.removeRepainter();
        wpd.graphicsWidget.resetData();
        if(wpd.appData.getPlotData().getAutoDetector().colorDetectionMode === 'fg') {
            wpd.colorSelectionWidget.setParams(getFGPickerParams());
        } else {
            wpd.colorSelectionWidget.setParams(getBGPickerParams());
        }
        wpd.colorSelectionWidget.startPicker();
    }

    function changeDetectionMode() {
        var $modeSelector = document.getElementById('color-detection-mode-select');
        wpd.appData.getPlotData().getAutoDetector().colorDetectionMode = $modeSelector.value;
        init();
    }

    return {
        startPicker: startPicker,
        changeDetectionMode: changeDetectionMode,
        changeColorDistance: changeColorDistance,
        init: init,
        testColorDetection: testColorDetection
    };
})();/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.dataSeriesManagement = (function () {

    function datasetWithNameExists(name) {
        const plotData = wpd.appData.getPlotData();
        const dsNameColl = plotData.getDatasetNames();
        if(dsNameColl.indexOf(name) >= 0) {
            return true;
        }
        return false;
    }

    function getDatasetCount() {
        const plotData = wpd.appData.getPlotData();
        return plotData.getDatasetCount();
    }

    function showAddDataset() {         
        const $singleDatasetName = document.getElementById('add-single-dataset-name-input');
        let suffix = getDatasetCount();
        let dsName = wpd.gettext("dataset") + " " + suffix;
        while(datasetWithNameExists(dsName)) {
            suffix++;
            dsName = wpd.gettext("dataset") + " " + suffix;
        }
        $singleDatasetName.value = dsName;
        wpd.popup.show('add-dataset-popup');
    }

    function showRenameDataset() {        
        const ds = wpd.tree.getActiveDataset();
        const $dsName = document.getElementById('rename-dataset-name-input');
        $dsName.value = ds.name;
        wpd.popup.show('rename-dataset-popup');
    }

    function renameDataset() {
        const $dsName = document.getElementById('rename-dataset-name-input');
        wpd.popup.close('rename-dataset-popup');
        
        if(datasetWithNameExists($dsName.value.trim())) {
            wpd.messagePopup.show(wpd.gettext("rename-dataset-error"), wpd.gettext("dataset-exists-error"), showRenameDataset);
            return;
        }
        const ds = wpd.tree.getActiveDataset();
        ds.name = $dsName.value.trim();
        wpd.tree.refresh();
        wpd.tree.selectPath("/"+wpd.gettext("datasets")+"/" + ds.name, true);
    }

    function renameKeypress(e) {        
        if(e.key === "Enter") {
            renameDataset();
        }
    }
    
    function addSingleDataset() {
        const $singleDatasetName = document.getElementById('add-single-dataset-name-input');

        wpd.popup.close('add-dataset-popup');

        // do not add if this name already exists
        if(datasetWithNameExists($singleDatasetName.value.trim())) {
            wpd.messagePopup.show(wpd.gettext("add-dataset-error"), wpd.gettext("dataset-exists-error"), function() {
                wpd.popup.show('add-dataset-popup');
            });
            return;
        }

        const plotData = wpd.appData.getPlotData();
        let ds = new wpd.Dataset();
        ds.name = $singleDatasetName.value.trim();
        plotData.addDataset(ds);        
        wpd.tree.refreshPreservingSelection();                
    }

    function addMultipleDatasets() {
        const $dsCount = document.getElementById('add-multiple-datasets-count-input');
        const dsCount = parseInt($dsCount.value,0);
        wpd.popup.close('add-dataset-popup');
        if(dsCount > 0) {
            const plotData = wpd.appData.getPlotData();
            let idx = getDatasetCount();
            const prefix = wpd.gettext("dataset") + " ";
            let i = 0;
            while(i < dsCount) {
                let dsName = prefix + idx;
                if(!datasetWithNameExists(dsName)) {
                    let ds = new wpd.Dataset();
                    ds.name = dsName;
                    plotData.addDataset(ds);
                    i++;
                }
                idx++;
            }
            wpd.tree.refreshPreservingSelection();
        } else {
            wpd.messagePopup(wpd.gettext("add-dataset-error"), wpd.gettext("add-dataset-count-error"), function() { wpd.popup.show('add-dataset-popup'); });
        }
    }

    function deleteDataset() {
        wpd.okCancelPopup.show(wpd.gettext("delete-dataset"), wpd.gettext("delete-dataset-text"), function() {
            const plotData = wpd.appData.getPlotData();
            const ds = wpd.tree.getActiveDataset();
            plotData.deleteDataset(ds);
            wpd.tree.refresh();
            wpd.tree.selectPath("/"+wpd.gettext("datasets"));            
        });
    }

    function changeAxes(axIdx) {
        const plotData = wpd.appData.getPlotData();
        const axesColl = plotData.getAxesColl();
        const ds = wpd.tree.getActiveDataset();
        axIdx = parseInt(axIdx, 10);
        if(axIdx === -1) {
            plotData.setAxesForDataset(ds, null);            
        } else if(axIdx >= 0 && axIdx < axesColl.length) {
            plotData.setAxesForDataset(ds, axesColl[axIdx]);            
        }
        wpd.tree.refreshPreservingSelection(true);
    }

    return {
        showAddDataset: showAddDataset,
        showRenameDataset: showRenameDataset,
        renameDataset: renameDataset,
        renameKeypress: renameKeypress,
        addSingleDataset: addSingleDataset,
        addMultipleDatasets: addMultipleDatasets,
        deleteDataset: deleteDataset,
        changeAxes: changeAxes
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.gridDetection = (function () {
    
    function start() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.removeRepainter();
        wpd.graphicsWidget.resetData();
        wpd.sidebar.show('grid-detection-sidebar');
        sidebarInit();
    }

    function sidebarInit() {
        var $colorPickerBtn = document.getElementById('grid-color-picker-button'),
            $backgroundMode = document.getElementById('grid-background-mode'),
            autodetector = wpd.appData.getPlotData().getAutoDetector(),
            color = autodetector.gridLineColor,
            backgroundMode = autodetector.gridBackgroundMode;

        if(color != null) {
            $colorPickerBtn.style.backgroundColor = 'rgb('+color[0]+','+color[1]+','+color[2]+')';
            if(color[0] + color[1] + color[2] < 200) {
                $colorPickerBtn.style.color = 'rgb(255,255,255)';
            } else {
                $colorPickerBtn.style.color = 'rgb(0,0,0)';
            }
        }

        $backgroundMode.checked = backgroundMode;

        var autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            ctx = wpd.graphicsWidget.getAllContexts(),
            imageSize = wpd.graphicsWidget.getImageSize();
        autoDetector.imageData = ctx.oriImageCtx.getImageData(0, 0, imageSize.width, imageSize.height);
    }

    function markBox() {
        var tool = new wpd.GridBoxTool();
        wpd.graphicsWidget.setTool(tool);
    }

    function viewMask() {
        var tool = new wpd.GridViewMaskTool();
        wpd.graphicsWidget.setTool(tool);
    }

    function clearMask() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.removeRepainter();
        wpd.appData.getPlotData().getAutoDetector().gridMask = {
                xmin: null,
                xmax: null,
                ymin: null,
                ymax: null,
                pixels: []
            };
        wpd.graphicsWidget.resetData();
    }

    function grabMask() {
        // Mask is just a list of pixels with the yellow color in the data layer
        var ctx = wpd.graphicsWidget.getAllContexts(),
            imageSize = wpd.graphicsWidget.getImageSize(),
            maskDataPx = ctx.oriDataCtx.getImageData(0, 0, imageSize.width, imageSize.height),
            maskData = [],
            i,
            mi = 0,
            autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            x, y;
        for(i = 0; i < maskDataPx.data.length; i+=4) {
            if (maskDataPx.data[i] === 255 && maskDataPx.data[i+1] === 255 && maskDataPx.data[i+2] === 0) {
                
                maskData[mi] = i/4; mi++;

                x = parseInt((i/4)%imageSize.width, 10);
                y = parseInt((i/4)/imageSize.width, 10);

                if (mi === 1) {
                    autoDetector.gridMask.xmin = x;
                    autoDetector.gridMask.xmax = x;
                    autoDetector.gridMask.ymin = y;
                    autoDetector.gridMask.ymax = y;
                } else {
                    if (x < autoDetector.gridMask.xmin) {
                        autoDetector.gridMask.xmin = x;
                    }
                    if (x > autoDetector.gridMask.xmax) {
                        autoDetector.gridMask.xmax = x;
                    }
                    if (y < autoDetector.gridMask.ymin) {
                        autoDetector.gridMask.ymin = y;
                    }
                    if (y > autoDetector.gridMask.ymax) {
                        autoDetector.gridMask.ymax = y;
                    }
                }
            }
        }
        autoDetector.gridMask.pixels = maskData;
    }

    function run() {

        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.removeRepainter();
        wpd.graphicsWidget.resetData();

        // For now, just reset before detecting, otherwise users will get confused:
        reset();

        var autoDetector = wpd.appData.getPlotData().getAutoDetector(),
            ctx = wpd.graphicsWidget.getAllContexts(),
            imageSize = wpd.graphicsWidget.getImageSize(),
            $xperc = document.getElementById('grid-horiz-perc'),
            $yperc = document.getElementById('grid-vert-perc'),
            horizEnable = document.getElementById('grid-horiz-enable').checked,
            vertEnable = document.getElementById('grid-vert-enable').checked,
            backgroundMode = document.getElementById('grid-background-mode').checked,
            plotData = wpd.appData.getPlotData();
        
        if(autoDetector.backupImageData == null) {
            autoDetector.backupImageData = ctx.oriImageCtx.getImageData(0, 0, imageSize.width, imageSize.height);
        }

        autoDetector.imageData = ctx.oriImageCtx.getImageData(0, 0, imageSize.width, imageSize.height);

        autoDetector.generateGridBinaryData();

        // gather detection parameters from GUI

        wpd.gridDetectionCore.setHorizontalParameters(horizEnable, $xperc.value);
        wpd.gridDetectionCore.setVerticalParameters(vertEnable, $yperc.value);
        wpd.appData.getPlotData().getAutoDetector().gridData = wpd.gridDetectionCore.run(autoDetector);

        // edit image
        wpd.graphicsWidget.runImageOp(removeGridLinesOp);

        // cleanup memory
        wpd.appData.getPlotData().getAutoDetector().gridData = null;
    }

    function resetImageOp(idata, width, height) {
        var bkImg = wpd.appData.getPlotData().getAutoDetector().backupImageData,
            i;

        for(i = 0; i < bkImg.data.length; i++) {
            idata.data[i] = bkImg.data[i];
        }

        return {
            imageData: idata,
            width: width,
            height: height,
            keepZoom: true
        };
    }

    function reset() {
        wpd.graphicsWidget.removeTool();
        wpd.appData.getPlotData().getAutoDetector().gridData = null;
        wpd.graphicsWidget.removeRepainter();
        wpd.graphicsWidget.resetData();

        var plotData = wpd.appData.getPlotData();
        if(plotData.getAutoDetector().backupImageData != null) {
            wpd.graphicsWidget.runImageOp(resetImageOp);
        }
    }

    function removeGridLinesOp(idata, width, height) {
        /* image op to remove grid lines */
        var gridData = wpd.appData.getPlotData().getAutoDetector().gridData,
            bgColor = wpd.appData.getPlotData().getAutoDetector().topColors[0],
            rowi,
            coli,
            pindex;

        if(bgColor == null) { 
            bgColor = { r: 255, g: 0, b: 0 }; 
        }
        
        if(gridData != null) {
            for(rowi = 0; rowi < height; rowi++) {
                for(coli = 0; coli < width; coli++) {
                    pindex = 4*(rowi*width + coli);
                    if(gridData[pindex/4] === true) {
                        idata.data[pindex] = bgColor.r;
                        idata.data[pindex + 1] = bgColor.g;
                        idata.data[pindex + 2] = bgColor.b;
                        idata.data[pindex + 3] = 255;
                    }
                }
            }
        }

        return {
            imageData: idata,
            width: width,
            height: height
        };
    }

    function startColorPicker() {
        wpd.colorSelectionWidget.setParams({
            color: wpd.appData.getPlotData().getAutoDetector().gridLineColor,
            triggerElementId: 'grid-color-picker-button',
            title: 'Specify Grid Line Color',
            setColorDelegate: function(col) {
                wpd.appData.getPlotData().getAutoDetector().gridLineColor = col;
            }
        });
        wpd.colorSelectionWidget.startPicker();
    }

    function testColor() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.resetData();
        wpd.graphicsWidget.setRepainter(new wpd.GridColorFilterRepainter());

        var autoDetector = wpd.appData.getPlotData().getAutoDetector();

        changeColorDistance();
        autoDetector.generateGridBinaryData();

        wpd.colorSelectionWidget.paintFilteredColor(autoDetector.gridBinaryData, autoDetector.gridMask.pixels);
    }

    function changeColorDistance() {
        var color_distance = parseFloat(document.getElementById('grid-color-distance').value);
        wpd.appData.getPlotData().getAutoDetector().gridColorDistance = color_distance;
    }

    function changeBackgroundMode() {
        var backgroundMode = document.getElementById('grid-background-mode').checked;
        wpd.appData.getPlotData().getAutoDetector().gridBackgroundMode = backgroundMode;
    }
     
    return {
        start: start,
        markBox: markBox,
        clearMask: clearMask,
        viewMask: viewMask,
        grabMask: grabMask,
        startColorPicker: startColorPicker,
        changeColorDistance: changeColorDistance,
        changeBackgroundMode: changeBackgroundMode,
        testColor: testColor,
        run: run,
        reset: reset
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.gettext = function(stringId) {
    var $str = document.getElementById('i18n-string-' + stringId);
    if($str) {
        return $str.innerHTML;
    }
    return 'i18n string';
};
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotdigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.imageManager = (function () {

    let _firstLoad = true;

    function saveImage() {
        wpd.graphicsWidget.saveImage();
    }

    function load() {
        let $input = document.getElementById('fileLoadBox');
        if($input.files.length == 1) {
            var imageFile = $input.files[0];
            loadFromFile(imageFile);
        }
        wpd.popup.close('loadNewImage');
    }

    function loadFromFile(imageFile, resumedProject) {
        return new Promise((resolve, reject) => {
            if(imageFile.type.match("image.*")) {
                wpd.busyNote.show();
                let reader = new FileReader();
                reader.onload = function() {
                    let url = reader.result;
                    loadFromURL(url, resumedProject).then(resolve);
                };
                reader.readAsDataURL(imageFile);
            } else if(imageFile.type == "application/pdf") {
                wpd.busyNote.show();
                let reader = new FileReader();
                reader.onload = function() {
                    let pdfurl = reader.result;
                    //PDFJS.disableWorker = true;
                    PDFJS.getDocument(pdfurl).then(function(pdf) {
                        pdf.getPage(1).then(function (page) {                        
                            let scale = 3;
                            let viewport = page.getViewport(scale);
                            let $canvas = document.createElement('canvas');
                            let ctx = $canvas.getContext('2d');
                            $canvas.width = viewport.width;
                            $canvas.height = viewport.height;
                            page.render({ canvasContext: ctx, viewport: viewport }).promise.then(function() {
                                let url = $canvas.toDataURL();
                                loadFromURL(url, resumedProject).then(resolve);
                            }, function(err) {
                                console.log(err);
                                wpd.busyNote.close();
                                reject(err);
                            });
                        });
                    });
                };
                reader.readAsDataURL(imageFile);
            } else {
                console.log(imageFile.type);
                wpd.messagePopup.show(wpd.gettext('invalid-file'), wpd.gettext('invalid-file-text'));            
            }
        });        
    }

    function loadFromURL(url, resumedProject) {
        return new Promise((resolve, reject) => {
            let image = new Image();
            image.onload = function() {
                _setImage(image, resumedProject);
                resolve();
            };
            image.src = url;
        });
    }

    function _setImage(image, resumedProject) {
        wpd.appData.reset();
        wpd.sidebar.clear();
        let imageData = wpd.graphicsWidget.loadImage(image);
        wpd.appData.plotLoaded(imageData);
        wpd.busyNote.close();
        wpd.tree.refresh();

        if (_firstLoad) {
            wpd.sidebar.show('start-sidebar');
        } else if(!resumedProject) {
            wpd.popup.show('axesList');
        }
        _firstLoad = false;
    }

    return {
        saveImage: saveImage,
        loadFromURL: loadFromURL,
        loadFromFile: loadFromFile,
        load: load
    };
})();
/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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
wpd.acquireData = (function () {

    var dataset, axes;

    function load() {
        dataset = getActiveDataset();
        axes = getAxes();

        if(axes == null) {
            wpd.messagePopup.show(wpd.gettext('dataset-no-calibration'), wpd.gettext('calibrate-dataset'));
        } else {            
            wpd.graphicsWidget.removeTool();
            wpd.graphicsWidget.resetData();
            showSidebar();
            wpd.autoExtraction.start();
            wpd.dataPointCounter.setCount();
            wpd.graphicsWidget.removeTool();
            wpd.graphicsWidget.setRepainter(new wpd.DataPointsRepainter(axes, dataset));

            manualSelection();
            
            wpd.graphicsWidget.forceHandlerRepaint();
            wpd.dataPointCounter.setCount(dataset.getCount());
        }
    }

    function getActiveDataset() {
        return wpd.tree.getActiveDataset();
    }

    function getAxes() {
        return wpd.appData.getPlotData().getAxesForDataset(getActiveDataset());
    }

    function manualSelection() {
        var tool = new wpd.ManualSelectionTool(axes, dataset);
        wpd.graphicsWidget.setTool(tool);
    }

    function deletePoint() {
        var tool = new wpd.DeleteDataPointTool(axes, dataset);
        wpd.graphicsWidget.setTool(tool);
    }

    function confirmedClearAll() {
        dataset.clearAll();
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.resetData();
        wpd.dataPointCounter.setCount(dataset.getCount());
        wpd.graphicsWidget.removeRepainter();
    }

    function clearAll() {
        if(dataset.getCount() <= 0) {
            return;
        }
        wpd.okCancelPopup.show(wpd.gettext('clear-data-points'), wpd.gettext('clear-data-points-text'), confirmedClearAll, function() {});
    }

    function undo() {
        dataset.removeLastPixel();
        wpd.graphicsWidget.resetData();
        wpd.graphicsWidget.forceHandlerRepaint();
        wpd.dataPointCounter.setCount(dataset.getCount());
    }
 
    function showSidebar() {
        wpd.sidebar.show('acquireDataSidebar');
        updateControlVisibility();
        wpd.dataPointCounter.setCount(dataset.getCount());
    }

    function updateControlVisibility() {
        var $editLabelsBtn = document.getElementById('edit-data-labels');
        if(axes instanceof wpd.BarAxes) {
            $editLabelsBtn.style.display = 'inline-block';
        } else {
            $editLabelsBtn.style.display = 'none';
        }
    }

    function adjustPoints() {
        wpd.graphicsWidget.setTool(new wpd.AdjustDataPointTool(axes, dataset));
    }

    function editLabels() {
        wpd.graphicsWidget.setTool(new wpd.EditLabelsTool(axes, dataset));
    }

    function switchToolOnKeyPress(alphaKey) {
        switch(alphaKey) {
            case 'd': 
                deletePoint();
                break;
            case 'a': 
                manualSelection();
                break;
            case 's': 
                adjustPoints();
                break;
            case 'e':
                editLabels();
                break;
            default: 
                break;
        }
    }

    function isToolSwitchKey(keyCode) {
        if(wpd.keyCodes.isAlphabet(keyCode, 'a')
            || wpd.keyCodes.isAlphabet(keyCode, 's')
            || wpd.keyCodes.isAlphabet(keyCode, 'd')
            || wpd.keyCodes.isAlphabet(keyCode, 'e')) {
            return true;
        }
        return false;
    }

    return {
        load: load,
        manualSelection: manualSelection,
        adjustPoints: adjustPoints,
        deletePoint: deletePoint,
        clearAll: clearAll,
        undo: undo,
        showSidebar: showSidebar,
        switchToolOnKeyPress: switchToolOnKeyPress,
        isToolSwitchKey: isToolSwitchKey,        
        editLabels: editLabels
    };
})();

wpd.dataPointLabelEditor = (function() {

    var ds, ptIndex, tool;
    
    function show(dataset, pointIndex, initTool) {
        var pixel = dataset.getPixel(pointIndex),
            originalLabel = pixel.metadata[0],
            $labelField;
        
        ds = dataset;
        ptIndex = pointIndex;
        tool = initTool;

        wpd.graphicsWidget.removeTool();

        // show popup window with originalLabel in the input field.
        wpd.popup.show('data-point-label-editor');
        $labelField = document.getElementById('data-point-label-field');
        $labelField.value = originalLabel;
        $labelField.focus();
    }

    function ok() {
        var newLabel = document.getElementById('data-point-label-field').value;

        if(newLabel != null && newLabel.length > 0) {
            // set label 
            ds.setMetadataAt(ptIndex, [newLabel]);
            // refresh graphics
            wpd.graphicsWidget.resetData();
            wpd.graphicsWidget.forceHandlerRepaint();
        }

        wpd.popup.close('data-point-label-editor');
        wpd.graphicsWidget.setTool(tool);
    }

    function cancel() {
        // just close the popup
        wpd.popup.close('data-point-label-editor');
        wpd.graphicsWidget.setTool(tool);
    }

    function keydown(ev) {
        if(wpd.keyCodes.isEnter(ev.keyCode)) {
            ok();
        } else if(wpd.keyCodes.isEsc(ev.keyCode)) {
            cancel();
        }
        ev.stopPropagation();
    }

    return {
        show: show,
        ok: ok,
        cancel: cancel,
        keydown: keydown
    };
})();/*
	WebPlotDigitizer - http://arohatgi.info/WebPlotDigitizer

	Copyright 2010-2017 Ankit Rohatgi <ankitrohatgi@hotmail.com>

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

wpd.measurementModes = {
    distance: {
        name: 'distance',
        connectivity: 2,
        addButtonId: 'add-pair-button',
        deleteButtonId: 'delete-pair-button',
        sidebarId: 'measure-distances-sidebar',
        init: function() {
            let plotData = wpd.appData.getPlotData();
            if(plotData.getMeasurementsByType(wpd.DistanceMeasurement).length == 0) {
                plotData.addMeasurement(new wpd.DistanceMeasurement());
            }
        },
        clear: function() {
            let plotData = wpd.appData.getPlotData();
            let distMeasures = plotData.getMeasurementsByType(wpd.DistanceMeasurement);
            distMeasures.forEach(m => {
                m.clearAll();
            });
        },
        getData: function() {
            let plotData = wpd.appData.getPlotData();
            let distMeasures = plotData.getMeasurementsByType(wpd.DistanceMeasurement);
            return distMeasures[0];
        },
        getAxes: function() {
            let plotData = wpd.appData.getPlotData();
            let distMeasures = plotData.getMeasurementsByType(wpd.DistanceMeasurement);
            return plotData.getAxesForMeasurement(distMeasures[0]);
        },
        changeAxes: function(axIdx) {
            let plotData = wpd.appData.getPlotData();
            let ms = plotData.getMeasurementsByType(wpd.DistanceMeasurement)[0];
            let axesColl = plotData.getAxesColl();
            if(axIdx == -1) {
                plotData.setAxesForMeasurement(ms, null);
            } else {
                plotData.setAxesForMeasurement(ms, axesColl[axIdx]);
            }
            wpd.tree.refreshPreservingSelection(true);
        }
    },
    angle: {
        name: 'angle',
        connectivity: 3,
        addButtonId: 'add-angle-button',
        deleteButtonId: 'delete-angle-button',
        sidebarId: 'measure-angles-sidebar',
        init: function() {
            let plotData = wpd.appData.getPlotData();
            if(plotData.getMeasurementsByType(wpd.AngleMeasurement).length == 0) {
                plotData.addMeasurement(new wpd.AngleMeasurement());
            }
        },
        clear: function() {
            let plotData = wpd.appData.getPlotData();
            let angleMeasures = plotData.getMeasurementsByType(wpd.AngleMeasurement);
            angleMeasures.forEach(m => {
                m.clearAll();
            });
        },
        getData: function() {
            let plotData = wpd.appData.getPlotData();
            let angleMeasures = plotData.getMeasurementsByType(wpd.AngleMeasurement);
            return angleMeasures[0];
        }
    },
    area: {
        name: 'area',
        connectivity: -1,
        addButtonId: 'add-polygon-button',
        deleteButtonId: 'delete-polygon-button',
        sidebarId: 'measure-area-sidebar',
        init: function() {
            let plotData = wpd.appData.getPlotData();
            if(plotData.getMeasurementsByType(wpd.AreaMeasurement).length == 0) {
                plotData.addMeasurement(new wpd.AreaMeasurement());
            }
        },
        clear: function() {
            let plotData = wpd.appData.getPlotData();
            let areaMeasures = plotData.getMeasurementsByType(wpd.AreaMeasurement);
            areaMeasures.forEach(m => {
                m.clearAll();
            });
        },
        getData: function() {
            let plotData = wpd.appData.getPlotData();
            let areaMeasures = plotData.getMeasurementsByType(wpd.AreaMeasurement);
            return areaMeasures[0];
        },
        getAxes: function() {
            let plotData = wpd.appData.getPlotData();
            let areaMeasures = plotData.getMeasurementsByType(wpd.AreaMeasurement);
            return plotData.getAxesForMeasurement(areaMeasures[0]);
        },
        changeAxes: function(axIdx) {
            let plotData = wpd.appData.getPlotData();
            let ms = plotData.getMeasurementsByType(wpd.AreaMeasurement)[0];
            let axesColl = plotData.getAxesColl();
            if(axIdx == -1) {
                plotData.setAxesForMeasurement(ms, null);
            } else {
                plotData.setAxesForMeasurement(ms, axesColl[axIdx]);
            }
            wpd.tree.refreshPreservingSelection(true);
        }
    }
};

wpd.measurement = (function () {

    var activeMode;

    function start(mode) {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.resetData();
        mode.init();
        wpd.sidebar.show(mode.sidebarId);
        wpd.graphicsWidget.setTool(new wpd.AddMeasurementTool(mode));
        wpd.graphicsWidget.setRepainter(new wpd.MeasurementRepainter(mode));
        wpd.graphicsWidget.forceHandlerRepaint();
        activeMode = mode;
    }

    function addItem() {
        wpd.graphicsWidget.setRepainter(new wpd.MeasurementRepainter(activeMode));
        wpd.graphicsWidget.setTool(new wpd.AddMeasurementTool(activeMode));        
    }

    function deleteItem() {
        wpd.graphicsWidget.setRepainter(new wpd.MeasurementRepainter(activeMode));
        wpd.graphicsWidget.setTool(new wpd.DeleteMeasurementTool(activeMode));        
    }

    function clearAll() {
        wpd.graphicsWidget.removeTool();
        wpd.graphicsWidget.resetData();
        activeMode.clear();
    }

    function changeAxes(axIdx) {
        activeMode.changeAxes(parseInt(axIdx, 10));
    }

    return {
        start: start,
        addItem: addItem,
        deleteItem: deleteItem,
        clearAll: clearAll,
        changeAxes: changeAxes
    };
})();