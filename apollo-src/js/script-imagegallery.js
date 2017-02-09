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

// Module implemented using the "revealing module pattern", see
// https://addyosmani.com/resources/essentialjsdesignpatterns/book/#revealingmodulepatternjavascript
// https://www.christianheilmann.com/2007/08/22/again-with-the-module-pattern-reveal-something-to-the-world/
var ApolloImageGallery = function(jQ) {

    // all auto loading image galleries as array for easy iteration
    this.m_autoLoadGalleries = [];

    // all image galleries that have been initialized as object
    this.m_galleries = {};

    function appendPhotoSwipeToBody() {

    jQ('body').append(
    '<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">' +
        '<div class="pswp__bg"></div>' +
        '<div class="pswp__scroll-wrap">' +
            '<div class="pswp__container">' +
                '<div class="pswp__item"></div>' +
                '<div class="pswp__item"></div>' +
                '<div class="pswp__item"></div>' +
            '</div>' +
            '<div class="pswp__ui pswp__ui--hidden">' +
                '<div class="pswp__top-bar">' +
                    '<div class="pswp__counter"></div>' +
                    '<button class="pswp__button pswp__button--close" title="Close (Esc)"></button>' +
                    '<button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>' +
                    '<button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>' +
                    '<div class="pswp__preloader">' +
                        '<div class="pswp__preloader__icn">' +
                            '<div class="pswp__preloader__cut">' +
                                '<div class="pswp__preloader__donut"></div>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">' +
                    '<div class="pswp__share-tooltip"></div>' +
                '</div>' +
                '<button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)"></button>' +
                '<button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)"></button>' +
                '<div class="pswp__caption">' +
                    '<div class="pswp__caption__center"></div>' +
                '</div>' +
            '</div>' +
        '</div>' +
    '</div>'
    );}


    function openPhotoSwipe(index, id) {

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

        var images = m_galleries[id].images;
        new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, images, options).init();
    }


    function handleAutoLoaders() {
        if (m_autoLoadGalleries != null) {
            for (i=0; i<m_autoLoadGalleries.length; i++) {
                var gallery = m_autoLoadGalleries[i];
                // NOTE: jQuery.visible() is defined in script-jquery-extensions.js
                if (!gallery.loaded && (gallery.page > 0) && gallery.element.find("#more").visible()) {
                    render(gallery, gallery.page + 1);
                }
            }
        }
    }


    function render(gallery, page) {

        // disable the gallery 'more' button
        var $moreButton = gallery.element.find("#more");
        $moreButton.off("click");
        $moreButton.finish().hide();

        var images = gallery.images;
        var count = parseInt(gallery.count);
        var start = page * count;
        var end = start + count <= images.length ? start + count : images.length;

        if (DEBUG) console.info("Rengering images for gallery:" + gallery.id + ", start=" + start + ", end=" + end);

        var $appendElement = gallery.element.find("#images");
        var $spinnerElement =  gallery.element.find('.spinner');

        // show load indicator
        $spinnerElement.fadeIn(100);

        for (i=start; i<end; i++) {
            var image = images[i];
            // render the base markup for this element
            var imageHtml = gallery.template.replace("%(index)", image.index);
            for (var property in image) {
                if (image.hasOwnProperty(property)) {
                    imageHtml = imageHtml.split("%(" + property + ")").join(decodeURIComponent(image[property]));
                }
            }
            // create DOM object from String
            $imageElement = jQ('<div/>').html(imageHtml).contents();
            // add click handler
            $imageElement.click(image, function(event) {
                event.preventDefault();
                openPhotoSwipe(event.data.index, event.data.id);
            });
            // append the image html to the gallery
            $appendElement.append($imageElement);
        }

        // hide load indicator
        $spinnerElement.finish().fadeOut(1000);
        // set the gallery page
        gallery.page = page;

        if (end < images.length) {
            // not all images have been rendered
            if (page == 0 || gallery.autoload != "true") {
                // add click handlerto button if no autoload
                $moreButton.click(function() {
                    render(gallery, page + 1);
                });
            }
            $moreButton.finish().fadeIn(250);
            // call autoload once to ensure visible buttons are directly rendered without scrolling
            handleAutoLoaders();
        } else {
            // the gallery images are all rendered
            gallery.loaded = true;
            $moreButton.finish().fadeOut(1000);
        }
    }


    function collect(gallery) {

        gallery.template = decodeURIComponent(gallery.template);
        var images = [];
        var $galleryItems = gallery.element.find("li[data-image]");
        $galleryItems.each(function(index) {

            var imageData = jQ(this).data("image");
            imageData.id = gallery.id;
            imageData.index = index;
            imageData.title = decodeURIComponent(imageData.caption);
            imageData.page = 0;

            // calculate image width and height by parsing the property string
            if (imageData.size.indexOf(',') >= 0 && imageData.size.indexOf(':') >= 0) {
                var size = imageData.size.split(',');
                imageData.w = size[0].split(':')[1];
                imageData.h = size[1].split(':')[1];
            }
            images.push(imageData);
        });

        if (DEBUG) console.info("Image gallery collected " + images.length + " images:" + gallery + ", path=" + gallery.path + ", template=" + gallery.template);
        gallery.images = images;
        render(gallery, 0);
    }


    function initGalleries($elements) {

        // initialize gallery with values from data attributes
        $elements.each(function(){
            var $element = $(this);
            var $gallery = $element.find('.gallery');

            if (typeof $gallery.data("imagegallery") != 'undefined') {
                var gallery = $gallery.data("imagegallery");
                gallery.id = $gallery.attr("id");
                gallery.element = $gallery;
                m_galleries[gallery.id] = gallery;
                if (gallery.autoload == "true") {
                    m_autoLoadGalleries.push(gallery);
                }
                if (DEBUG) console.info("Image gallery data found:" + gallery + ", path=" + gallery.path + ", count=" + gallery.count);
                collect(gallery);
            }
        });

        if (m_autoLoadGalleries.length > 0) {
            // only enable scroll listener if we have at least one autoloading gallery
            jQ(window).on('scroll', handleAutoLoaders).resize(handleAutoLoaders);
        }
    }


    function initZoomers($elements) {

        var images = [];
        $elements.each(function(index){

            var imageData = jQ(this).data("imagezoom");
            imageData.id = "imagezoom";
            imageData.src = jQ(this).attr('href');
            imageData.index = index;
            imageData.title = decodeURIComponent(imageData.caption);

            // calculate image width and height by parsing the property string
            if (imageData.size.indexOf(',') >= 0 && imageData.size.indexOf(':') >= 0) {
                var size = imageData.size.split(',');
                imageData.w = size[0].split(':')[1];
                imageData.h = size[1].split(':')[1];
            }
            images.push(imageData);
            jQ(this).click(function(e) {
                e.preventDefault();
                openPhotoSwipe(index, "imagezoom");
            });

            if (DEBUG) console.info("Image zoom element found path=" + imageData.src + ", index=" + imageData.index);
        });

        var gallery = {};
        gallery.id = "imagezoom";
        gallery.images = images;
        m_galleries[gallery.id]= gallery;
    }


    function init() {

        if (DEBUG) console.info("ApolloImageGallery.init()");

        var $imageGalleryElements = jQ('.ap-image-gallery');
        var $imageZoomElements = jQ('a[data-imagezoom]');

        if (DEBUG) console.info(".ap-image-gallery elements found: " + $imageGalleryElements.length);
        if (DEBUG) console.info("a[data-imagezoom] elements found: " + $imageZoomElements.length);

        if ($imageGalleryElements.length > 0 || $imageZoomElements.length > 0) {
            // We have found gallery images, append the PhotoSwipe markup
            appendPhotoSwipeToBody();
            if ($imageGalleryElements.length > 0) {
                initGalleries($imageGalleryElements);
            }
            if ($imageZoomElements.length > 0) {
                initZoomers($imageZoomElements);
            }
        }
    }


    // public available functions
    return {
        init: init
    }

}(jQuery);
