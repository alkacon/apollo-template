$.fn.visible = function(partial) {

	var $t = $(this), $w = $(window), viewTop = $w.scrollTop(), viewBottom = viewTop
			+ $w.height(), _top = $t.offset().top, _bottom = _top + $t.height(), compareTop = partial === true ? _bottom
			: _top, compareBottom = partial === true ? _top : _bottom;

	return ((compareBottom - 500 <= viewBottom) && (compareTop >= viewTop));
};

var list_lock = false;

function reloadInnerList(searchStateParameters, elem) {
	if(!list_lock){
		list_lock = true;
		if(typeof elem === 'undefined'){
			elem = $('.ap-list-content').first();
		}
		elem.find('.spinner').show();
		elem.find("#entrylist_box").empty();
		elem.find("#pagination_box").empty();
		$.get(buildAjaxLink(elem) + "&initialSearch=" + list_lock + "&".concat(searchStateParameters), 
				function(resultList) {
					$(resultList).filter(".list-entry").appendTo(elem.find('#entrylist_box'));
					$(resultList).filter('#pagination').appendTo(elem.find('#pagination_box'));
					if(elem.data("nofacets") === false){
						elem.find('#listoption_box').html($(resultList).filter("#listOptions"));
					}
					if(list_lock && $(resultList).filter(".list-entry").length == 0){
						showEmpty(elem);
					}
					elem.find('.spinner').hide();
					list_lock = false;
					showEditButtons();
					list_lock = false;
				});
		
		$('html, body').animate( { scrollTop : elem.offset().top - 100 }, 1000 );
	}
}

function appendInnerList(searchStateParameters, elem) {
	if (!list_lock) {
		list_lock = true;
		elem.find('.spinner').show();
		$.get(buildAjaxLink(elem) + "&nofacets=true&hideOptions=true&".concat(searchStateParameters),
				function(resultList) {
					elem.find('#pagination').remove();
					$(resultList).filter(".list-entry").appendTo(elem.find('#entrylist_box'));
					$(resultList).filter("#pagination").appendTo(elem.find('#pagination_box'));
					elem.find('.spinner').hide();
					showEditButtons();
					list_lock = false;
				});
	}
}

function buildAjaxLink(elem){
	var params = "?contentpath=" + elem.data("path") + "&teaserlength=" + elem.data("teaser") 
						+ "&buttoncolor=" + elem.data("color") + "&showexpired=" + elem.data("expired");
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
						var pag = list.find("#pagination");
						if (pag.length && pag.data("dynamic") && pag.visible(true)){
							appendInnerList($('#loadMore').attr('data-load'), list);
						}
					}
				);
		}
	});
}

function showEmpty(elem){
	elem.find("#editbox").show();
}

function showEditButtons(){
	if (typeof opencms != 'undefined' && typeof opencms.reinitializeEditButtons === 'function'){
		opencms.reinitializeEditButtons();
	} 
}