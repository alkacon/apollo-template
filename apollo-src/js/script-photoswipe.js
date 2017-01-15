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

function initPhotoSwipe() {

    var openPhotoSwipe = function(index) {

        var items = new Array();

        $("a[data-gallery]").each(function(index) {

            if ($(this).data('size').indexOf(',') >= 0 && $(this).data('size').indexOf(':') >= 0) {
                var size = $(this).data('size').split(',');
                var item = {
                    src : $(this).attr('href'),
                    w : size[0].split(':')[1],
                    h : size[1].split(':')[1],
                    title : $(this).attr('data-title')
                };
                items.push(item);
            }
        });

        var pswpElement = document.querySelectorAll('.pswp')[0];

        var options = {
            history : false,
            focus : true,
            showHideOpacity : true,
            getThumbBoundsFn : false,
            showAnimationDuration : 0,
            index : index
        };

        new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options).init();
    };

    if ($('a[data-gallery]').length > 0) {
        appendPswpBody();

        $('a[data-gallery]').each(function(index) {

            $(this).click(function(e) {

                e.preventDefault();
                openPhotoSwipe(index);
            });
        });
    }
}

function appendPswpBody() {

    $('body')
        .append('<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">' + '<div class="pswp__bg"></div>'
            + '<div class="pswp__scroll-wrap">'
            + '	<div class="pswp__container">'
            + '		<div class="pswp__item"></div>'
            + '		<div class="pswp__item"></div>'
            + '		<div class="pswp__item"></div>'
            + '	</div>'
            + '	<div class="pswp__ui pswp__ui--hidden">'
            + '		<div class="pswp__top-bar">'
            + '			<div class="pswp__counter"></div>'
            + '			<button class="pswp__button pswp__button--close" title="Close (Esc)"></button>'
            + '			<button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>'
            + '			<button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>'
            + '			<div class="pswp__preloader">'
            + '				<div class="pswp__preloader__icn">'
            + '					<div class="pswp__preloader__cut">'
            + '						<div class="pswp__preloader__donut"></div>'
            + '					</div>'
            + '				</div>'
            + '			</div>'
            + '		</div>'
            + '		<div'
            + '			class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">'
            + '			<div class="pswp__share-tooltip"></div>'
            + '		</div>'
            + '		<button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)"></button>'
            + '		<button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)"></button>'
            + '		<div class="pswp__caption">'
            + '			<div class="pswp__caption__center"></div>'
            + '		</div>'
            + '	</div>'
            + '</div>'
            + '</div>');
}

// ########### Apollo ImageGallery code #######################

function initImageGallery() {

    loadImages(1);
    appendPswpBody();
    $('#more').click(function() {

        loadImages($('#more').data('page'));
    });
    $(window).scroll(function() {

        if ($('.hideMore').length == 0 && $('#more').visible()
            && $('#more').data('page') > 2
            && $('#galleryData').data('autoload')) {
            loadImages($('#more').data('page'));
        }
    });
}

function openGallery(e, index) {

    e.preventDefault();
    openPhotoSwipeGallery(index);
}

function openPhotoSwipeGallery(index) {

    var items = new Array();

    $("li[data-gallery]").each(function(index) {

        if ($(this).data('size').indexOf(',') >= 0 && $(this).data('size').indexOf(':') >= 0) {
            var size = $(this).data('size').split(',');
            var item = {
                src : $(this).attr('data-src'),
                w : size[0].split(':')[1],
                h : size[1].split(':')[1],
                title : $(this).attr('data-title')
            };
            items.push(item);
        }
    });

    var pswpElement = document.querySelectorAll('.pswp')[0];
    var options = {
        history : false,
        focus : true,
        showHideOpacity : true,
        getThumbBoundsFn : false,
        showAnimationDuration : 0,
        index : index,
        closeEl : true,
        counterEl : true
    };
    new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options).init();
}

function loadImages(page) {

    $('#more').removeClass('fadeIn').addClass('fadeOut');
    $('.spinner').removeClass('fadeOut').addClass('fadeIn');
    if (page > 1) {
        $('.spinner').addClass('spinnerBottom');
    }

    $.get($("#galleryData").data("ajax") + "?items="
        + $('#galleryData').data('count')
        + "&page=" + page
        + "&path=" + $("#galleryData").data("path")
        + "&title="+ $("#galleryData").data("showtitle")
        + "&copyright=" + $("#galleryData").data("showcopyright")
        + "&css=" + $("#galleryData").data("css"), function(images) {

        if (images.length == 0) {
            $('#more').remove();
        } else {
            $("#links").append(images);
            if ($('.hideMore').length == 0) {
                $('#more').removeClass('fadeOut').addClass('fadeIn');
            } else {
                $('#more').remove();
            }
        }
        $('.spinner').removeClass('fadeIn').addClass('fadeOut');
    });

    $('#more').data('page', page + 1);
}
