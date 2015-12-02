(function($) {

	/**
	 * Copyright 2012, Digital Fusion Licensed under the MIT license.
	 * http://teamdf.com/jquery-plugins/license/
	 * 
	 * @author Sam Sehnert
	 * @desc A small plugin that checks whether elements are within the user
	 *       visible viewport of a web browser. only accounts for vertical
	 *       position, not horizontal.
	 */

	$.fn.visible = function(partial) {

		var $t = $(this), $w = $(window), viewTop = $w.scrollTop(), viewBottom = viewTop
				+ $w.height(), _top = $t.offset().top, _bottom = _top
				+ $t.height(), compareTop = partial === true ? _bottom : _top, compareBottom = partial === true ? _top
				: _bottom;

		return ((compareBottom - 500 <= viewBottom) && (compareTop >= viewTop));
	};

})(jQuery);

$(document)
		.ready(
				function() {

					$(window)
							.load(
									function() {
										var openPhotoSwipe = function(index) {

											var items = new Array();
											$("a[data-gallery]")
													.each(
															function(i) {
																console
																		.log($(
																				this)
																				.data(
																						'gallery'));
																
																if ($(this)
																		.data(
																				'gallery') == true
																		|| i == index) {
																	if ($(this)
																			.data(
																					'size')
																			.indexOf(
																					',') >= 0
																			&& $(
																					this)
																					.data(
																							'size')
																					.indexOf(
																							':') >= 0) {
																		var size = $(
																				this)
																				.data(
																						'size')
																				.split(
																						',');
																		var item = {
																			src : $(
																					this)
																					.attr(
																							'href'),
																			w : size[0]
																					.split(':')[1],
																			h : size[1]
																					.split(':')[1]
																		};
																		items
																				.push(item);
																	}
																}
															});

											var pswpElement = document
													.querySelectorAll('.pswp')[0];

											var options = {
												history : true,
												focus : true,
												showAnimationDuration : 0,
												hideAnimationDuration : 0,
												index : index
											};
											new PhotoSwipe(pswpElement,
													PhotoSwipeUI_Default,
													items, options).init();
										};

										$("body").removeClass("no-trans");
										if ($('a[data-gallery]').length > 0) {
											$
													.get(
															'/system/modules/org.opencms.apollo.template.basics/elements/photoswipe.html',
															function(data) {
																$('body')
																		.append(
																				data);
																$(
																		"a[data-gallery]")
																		.each(
																				function(
																						index) {
																					$(
																							this)
																							.click(
																									function(
																											e) {
																										e
																												.preventDefault();
																										openPhotoSwipe(index);
																									});
																				});
															});
										}
									});
				});

//$('.dropdown').click(function() {
//	if ($(this).hasClass('active')) {
//		$(this).removeClass('active');
//	} else {
//		$('.dropdown.active').removeClass('active');
//		$(this).addClass('active');
//		$('html, body').animate({
//			scrollTop : $(this).offset().top - 100
//		}, 1000);
//	}
//});