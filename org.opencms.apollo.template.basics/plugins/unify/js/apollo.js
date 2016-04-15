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
															$('body')
																		.append(
																				'<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">'+
																				'<div class="pswp__bg"></div>'+
																				'<div class="pswp__scroll-wrap">'+
																				'	<div class="pswp__container">'+
																				'		<div class="pswp__item"></div>'+
																				'		<div class="pswp__item"></div>'+
																				'		<div class="pswp__item"></div>'+
																				'	</div>'+
																				'	<div class="pswp__ui pswp__ui--hidden">'+
																				'		<div class="pswp__top-bar">'+
																				'			<div class="pswp__counter"></div>'+
																				'			<button class="pswp__button pswp__button--close" title="Close (Esc)"></button>'+
																				'			<button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>'+
																				'			<div class="pswp__preloader">'+
																				'				<div class="pswp__preloader__icn">'+
																				'					<div class="pswp__preloader__cut">'+
																				'						<div class="pswp__preloader__donut"></div>'+
																				'					</div>'+
																				'				</div>'+
																				'			</div>'+
																				'		</div>'+
																				'		<div'+
																				'			class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">'+
																				'			<div class="pswp__share-tooltip"></div>'+
																				'		</div>'+
																				'		<button class="pswp__button pswp__button--arrow--left"'+
																				'			title="Previous (arrow left)"></button>'+
																				'		<button class="pswp__button pswp__button--arrow--right"'+
																				'			title="Next (arrow right)"></button>'+
																				'		<div class="pswp__caption">'+
																				'			<div class="pswp__caption__center"></div>'+
																				'		</div>'+
																				'	</div>'+
																				'</div>'+
																			'</div>');
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
										}
									});
				});

$('.dropdown').click(function() {
	if ($(this).hasClass('active')) {
		$(this).removeClass('active');
	} else {
		$('.dropdown.active').removeClass('active');
		$(this).addClass('active');
		$('html, body').animate({
			scrollTop : $(this).offset().top - 100
		}, 1000);
	}
});