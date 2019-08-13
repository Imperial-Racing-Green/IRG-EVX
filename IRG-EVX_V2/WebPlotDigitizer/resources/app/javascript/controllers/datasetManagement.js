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

wpd.dataSeriesManagement = (function() {
    function datasetWithNameExists(name) {
        const plotData = wpd.appData.getPlotData();
        const dsNameColl = plotData.getDatasetNames();
        if (dsNameColl.indexOf(name) >= 0) {
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
        while (datasetWithNameExists(dsName)) {
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

        if (datasetWithNameExists($dsName.value.trim())) {
            wpd.messagePopup.show(wpd.gettext("rename-dataset-error"),
                wpd.gettext("dataset-exists-error"), showRenameDataset);
            return;
        }
        const ds = wpd.tree.getActiveDataset();
        ds.name = $dsName.value.trim();
        wpd.tree.refresh();
        wpd.tree.selectPath("/" + wpd.gettext("datasets") + "/" + ds.name, true);
    }

    function renameKeypress(e) {
        if (e.key === "Enter") {
            renameDataset();
        }
    }

    function addSingleDataset() {
        const $singleDatasetName = document.getElementById('add-single-dataset-name-input');

        wpd.popup.close('add-dataset-popup');

        // do not add if this name already exists
        if (datasetWithNameExists($singleDatasetName.value.trim())) {
            wpd.messagePopup.show(wpd.gettext("add-dataset-error"),
                wpd.gettext("dataset-exists-error"),
                function() {
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
        const dsCount = parseInt($dsCount.value, 0);
        wpd.popup.close('add-dataset-popup');
        if (dsCount > 0) {
            const plotData = wpd.appData.getPlotData();
            let idx = getDatasetCount();
            const prefix = wpd.gettext("dataset") + " ";
            let i = 0;
            while (i < dsCount) {
                let dsName = prefix + idx;
                if (!datasetWithNameExists(dsName)) {
                    let ds = new wpd.Dataset();
                    ds.name = dsName;
                    plotData.addDataset(ds);
                    i++;
                }
                idx++;
            }
            wpd.tree.refreshPreservingSelection();
        } else {
            wpd.messagePopup(wpd.gettext("add-dataset-error"),
                wpd.gettext("add-dataset-count-error"),
                function() {
                    wpd.popup.show('add-dataset-popup');
                });
        }
    }

    function deleteDataset() {
        wpd.okCancelPopup.show(wpd.gettext("delete-dataset"), wpd.gettext("delete-dataset-text"),
            function() {
                const plotData = wpd.appData.getPlotData();
                const ds = wpd.tree.getActiveDataset();
                plotData.deleteDataset(ds);
                wpd.tree.refresh();
                wpd.tree.selectPath("/" + wpd.gettext("datasets"));
            });
    }

    function changeAxes(axIdx) {
        const plotData = wpd.appData.getPlotData();
        const axesColl = plotData.getAxesColl();
        const ds = wpd.tree.getActiveDataset();
        axIdx = parseInt(axIdx, 10);
        if (axIdx === -1) {
            plotData.setAxesForDataset(ds, null);
        } else if (axIdx >= 0 && axIdx < axesColl.length) {
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