$.fn.visible = function(partial) {

	var $t = $(this), $w = $(window), viewTop = $w.scrollTop(), viewBottom = viewTop
			+ $w.height(), _top = $t.offset().top, _bottom = _top + $t.height(), compareTop = partial === true ? _bottom
			: _top, compareBottom = partial === true ? _top : _bottom;

	return ((compareBottom - 500 <= viewBottom) && (compareTop >= viewTop));
};

var list_lock = new Array();

function reloadInnerList(searchStateParameters, elem) {
	if(typeof list_lock[elem.attr("id")] === "undefined" || !list_lock[elem.attr("id")]){
		list_lock[elem.attr("id")] = true;
		if(typeof elem === 'undefined'){
			elem = $('.ap-list-content').first();
		}
		elem.find('.spinner').show();
		elem.find(".entrylist_box").empty();
		elem.find(".pagination_box").empty();
		var listOptionBox = $('#listoption_box-' + elem.data('id'));
		listOptionBox.find(".listOptions").remove();
		$.get(buildAjaxLink(elem) + "&".concat(searchStateParameters), 
				function(resultList) {
					$(resultList).filter(".list-entry").appendTo(elem.find('.entrylist_box'));
					$(resultList).filter('.paginationWrapper').appendTo(elem.find('.pagination_box'));
					$(resultList).filter(".listOptions").appendTo(listOptionBox);
					if(list_lock && $(resultList).filter(".list-entry").length == 0){
						showEmpty(elem);
					}
					elem.find('.spinner').hide();
					showEditButtons();
					list_lock[elem.attr("id")] = false;
				});
		
		$('html, body').animate( { scrollTop : elem.offset().top - 100 }, 1000 );
	}
}

function appendInnerList(searchStateParameters, elem) {
	if(typeof list_lock[elem.attr("id")] === "undefined" || !list_lock[elem.attr("id")]){
		list_lock[elem.attr("id")] = true;
		elem.find('.spinner').show();
		console.log("append");
		$.get(buildAjaxLink(elem) + "&hideOptions=true&".concat(searchStateParameters),
				function(resultList) {
					elem.find('.pagination').remove();
					$(resultList).filter(".list-entry").appendTo(elem.find('.entrylist_box'));
					$(resultList).filter(".pagination").appendTo(elem.find('.pagination_box'));
					elem.find('.spinner').hide();
					showEditButtons();
					list_lock[elem.attr("id")] = false;
				});
	}
}

function buildAjaxLink(elem){
	var params = "?contentpath=" + elem.data("path") + "&teaserlength=" + elem.data("teaser") 
						+ "&buttoncolor=" + elem.data("color") + "&showexpired=" + elem.data("expired")
						+ "&sitepath=" + elem.data("sitepath");
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
	$(".ap-list-content").each(function(){
		reloadInnerList("", $(this));
		var list = $(this);
		if(list.data("dynamic") === true){
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

function showEmpty(elem){
	elem.find(".editbox").show();
}

function showEditButtons(){
	if (typeof opencms != 'undefined' && typeof opencms.reinitializeEditButtons === 'function'){
		opencms.reinitializeEditButtons();
	} 
}

$(document).ready(function(){
	initList();
});