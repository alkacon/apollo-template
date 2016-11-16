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

