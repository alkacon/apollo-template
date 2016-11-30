/*
 * This program is part of the OpenCms Apollo Template.
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * Callbacks to update the OpenCms edito points when the screen element change. 
 */
 
function _OpenCmsReinitEditButtons(){
    if (typeof opencms != 'undefined' && typeof opencms.reinitializeEditButtons === 'function'){
        opencms.reinitializeEditButtons();
    } else {
        // console.warn("OpenCms edit button re-init function not available!");
        // console.trace()
    }
} 
 
// Bootsrap collabsibles, e.g. accordion
$('.panel').on('shown.bs.collapse', function () {
  _OpenCmsReinitEditButtons();
})

$('.panel').on('hidden.bs.collapse', function () {
  _OpenCmsReinitEditButtons();
})

// Bootstrap tabs
$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  _OpenCmsReinitEditButtons();
})

$('a[data-toggle="tab"]').on('hidden.bs.tab', function (e) {
  _OpenCmsReinitEditButtons();
})

