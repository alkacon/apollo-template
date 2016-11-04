
function initMegamenu(){
	var menus = $("[data-menu]");
	for(var i = 0; i < menus.length; i++){
	  var menu = menus.eq(i);
	  insertMenu(menu.data("menu"), menu);
	}
	
	initMegamenuEditing();
}

function initMegamenuEditing(){
	var container = $(".container").eq(0);
	var content = container.html();
	var menu = $("<div></div>").addClass("dropdown-menu").addClass("dropdown-megamenu");
	menu.append(content);
	var listitem = $("<li></li>").addClass("dropdown").append(menu);
	var list = $("<ul></ul>").addClass("nav").addClass("navbar-nav").append(listitem);
	var megamenu = $("<div></div>").addClass("mega-menu").append(list);
	var wrapper = $("<div></div>").addClass("header")
					.append(megamenu);
	container.empty();
	container.append(wrapper);
	
}

function insertMenu(path, navElem){
  $.ajax({
    method: "POST",
    url: path + "?__disableDirectEdit=true&megamenu=true&ajaxreq=true"
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