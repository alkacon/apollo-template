
function initMegamenu(){
	var menus = $("[data-menu]");
	for(var i = 0; i < menus.length; i++){
	  var menu = menus.eq(i);
	  insertMenu(menu.data("menu"), menu);
	}
}

function insertMenu(path, navElem){
  $.ajax({
    method: "POST",
    url: path + "?__disableDirectEdit=true&ajaxreq=true"
  })
  .done(function (content){
    var dropdown = $("<div></div>").addClass("dropdown-menu").addClass("dropdown-megamenu");
    var row = $(content).find(".row").eq(0);
    dropdown.append(row);
    navElem.find("ul").remove();
    navElem.append(dropdown);
  });
}

$(document).ready(function(){
    initMegamenu();
});