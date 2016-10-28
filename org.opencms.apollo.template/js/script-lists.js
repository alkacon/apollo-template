$.fn.visible = function(partial) {

    var $t = $(this);
    var $w = $(window);
    var viewTop = $w.scrollTop();
    var viewBottom = viewTop + $w.height();
    var _top = $t.offset().top;
    var _bottom = _top + $t.height();
    var compareTop = partial === true ? _bottom : _top;
    var compareBottom = partial === true ? _top : _bottom;

    return ((compareBottom - 100 <= viewBottom) && (compareTop >= viewTop));
};

var list_lock = new Array();

function reloadInnerList(searchStateParameters, elem, resetArchive) {
	if(arguments.length == 3 && resetArchive){
		archiveRemoveHighlight();
	}
	doReloadInnerList(searchStateParameters, elem);
}

function doReloadInnerList(searchStateParameters, elem) {
    if(typeof list_lock[elem.attr("id")] === "undefined" || !list_lock[elem.attr("id")]){
        list_lock[elem.attr("id")] = true;
        if(typeof elem === 'undefined'){
            elem = $('.ap-list-entries').first();
        }
        var entryBox = elem.find(".ap-list-box");
        var spinner = elem.find(".spinner");
        spinner.hide().removeClass("bounceOut").addClass("bounceIn").show();
        entryBox.find(".list-entry").each(function(){
            $(this).remove();
        });

        entryBox.css("min-height", elem.data("minheight"));
        elem.find(".ap-list-pagination").empty();
        var listOptionBox = $('#listoption_box-' + elem.data('id'));
        $.get(buildAjaxLink(elem) + "&".concat(searchStateParameters), 
                function(resultList) {
            		listOptionBox.find(".listOptions").remove();
                    $(resultList).filter(".list-entry").appendTo(entryBox);
                    $(resultList).filter('.paginationWrapper').appendTo(elem.find('.ap-list-pagination'));
                    $(resultList).filter(".listOptions").appendTo(listOptionBox);
                    if(list_lock && $(resultList).filter(".list-entry").length == 0){
                        showEmpty(elem);
                    }
                    spinner.removeClass("bounceIn").addClass("bounceOut");
                    entryBox.css("min-height", "0");
                    _OpenCmsReinitEditButtons();
                    list_lock[elem.attr("id")] = false;
                });
    }
}

function appendInnerList(searchStateParameters, elem) {
    if(typeof list_lock[elem.attr("id")] === "undefined" || !list_lock[elem.attr("id")]){
        list_lock[elem.attr("id")] = true;
        var spinner = elem.find(".spinner");
        var entryBox = elem.find(".ap-list-box");
        console.log("test: " + entryBox.height());
        spinner.hide().removeClass("bounceOut").addClass("bounceIn").css("top", entryBox.height() - 200).show();
        elem.find('.loadMore').addClass("fadeOut");
        $.get(buildAjaxLink(elem) + "&hideOptions=true&".concat(searchStateParameters),
                function(resultList) {
                    elem.find('.pagination').remove();
                    $(resultList).filter(".list-entry").appendTo(elem.find('.ap-list-box'));
                    $(resultList).filter(".pagination").appendTo(elem.find('.ap-list-pagination'));
                    if($(resultList).filter(".pagination").length == 0){
                        elem.find('.ap-list-pagination').css("min-height","0");
                    }
                    spinner.removeClass("bounceIn").addClass("bounceOut");
                    _OpenCmsReinitEditButtons();
                    list_lock[elem.attr("id")] = false;
                });
    }
}

function buildAjaxLink(elem){
    var params = "?contentpath=" + elem.data("path") 
        + "&id=" + elem.data("id")
        + "&sitepath=" + elem.data("sitepath")
        + "&subsite=" + elem.data("subsite")
        + "&__locale=" + elem.data("locale");

    var facets = $("#listoption_box-" + elem.data("id"));
    if(facets.length != 0){
        params = params + "&facets=" + facets.data("facets");
    }
    if(elem.data("dynamic") === true){
        params = params + "&dynamic=true";
    }
    return elem.data("ajax") + params;
}

function initList() {
    $(".ap-list-entries").each(function(){
        reloadInnerList("", $(this));
        var list = $(this);
        if(list.data("dynamic") === true){
            // load more from list if scrolled to last item
            $(window).scroll(
                function(event) {
                    var pag = list.find(".pagination");
                    if (pag.length && pag.data("dynamic") && pag.visible(true)){ 
                        appendInnerList(list.find('.loadMore').attr('data-load'), list);
                    }
                }
            );
        }
    });
}

function archiveHighlight(elem){
	archiveRemoveHighlight();
	elem.parent().addClass("active");
}

function archiveRemoveHighlight(){
	$(".ap-list-filters li.active").removeClass("active");
}

function showEmpty(elem){
    elem.find(".editbox").show();
}

$(document).ready(function(){
    initList();
});