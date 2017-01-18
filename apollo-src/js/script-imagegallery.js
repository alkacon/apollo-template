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

// Note: If GALLERYDEBUG is false, all if clauses using it will be removed
// by uglify.js during Apollo JS processing as unreachable code
var GALLERYDEBUG = false;

// Apollo OpenCms page information class
var ApolloImageGallery = function() {}

ApolloImageGallery.appendPhotoSwipeToBody = function() {

$('body').append(
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

ApolloImageGallery.openPhotoSwipe = function(index, id) {

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

    var images = AP.getData(id).images;
    new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, images, options).init();
}

ApolloImageGallery.handleAutoLoaders = function() {
    var galleries = AP.getElements("autoLoadGalleries");
    if (galleries != null) {
        for (i=0; i<galleries.length; i++) {
            var galleryData = galleries[i];
            // NOTE: $.visible() is defined in script-jquery-extensions.js
            if (!galleryData.loaded && (galleryData.page > 0) && galleryData.element.find("#more").visible()) {
                ApolloImageGallery.render(galleryData, galleryData.page + 1);
            }
        }
    }
}

ApolloImageGallery.render = function(galleryData, page) {

    // disable the gallery 'more' button
    var $moreButton = galleryData.element.find("#more");
    $moreButton.off("click");
    $moreButton.finish().hide();

    var images = galleryData.images;
    var count = parseInt(galleryData.count);
    var start = page * count;
    var end = start + count <= images.length ? start + count : images.length;

    if (GALLERYDEBUG) console.info("Rengering images for gallery:" + galleryData.id + ", start=" + start + ", end=" + end);

    var $appendElement = galleryData.element.find("#images");
    var $spinnerElement =  galleryData.element.find('.spinner');

    // show load indicator
    $spinnerElement.fadeIn(100);

    for (i=start; i<end; i++) {
        var image = images[i];
        // render the base markup for this element
        var imageHtml = galleryData.template.replace("%(index)", image.index);
        for (var property in image) {
            if (image.hasOwnProperty(property)) {
                imageHtml = imageHtml.split("%(" + property + ")").join(decodeURIComponent(image[property]));
            }
        }
        // create DOM object from String
        $imageElement = $('<div/>').html(imageHtml).contents();
        // add click handler
        $imageElement.click(image, function(event) {
            event.preventDefault();
            ApolloImageGallery.openPhotoSwipe(event.data.index, event.data.id);
        });
        // append the image html to the gallery
        $appendElement.append($imageElement);
    }

    // hide load indicator
    $spinnerElement.finish().fadeOut(1000);
    // set the gallery page
    galleryData.page = page;

    if (end < images.length) {
        // not all images have been rendered
        if (page == 0 || galleryData.autoload != "true") {
            // add click handlerto button if no autoload
            $moreButton.click(function() {
                ApolloImageGallery.render(galleryData, page + 1);
            });
        }
        $moreButton.finish().fadeIn(250);
        // call autoload once to ensure visible buttons are directly rendered without scrolling
        ApolloImageGallery.handleAutoLoaders();
    } else {
        // the gallery images are all rendered
        galleryData.loaded = true;
        $moreButton.finish().fadeOut(1000);
    }
}

ApolloImageGallery.collect = function(galleryData) {

    if (GALLERYDEBUG) console.info("HERE!" + typeof galleryData);
    if (typeof galleryData.element === "undefined") {
        return;
    }

    galleryData.template = decodeURIComponent(galleryData.template);
    var images = [];
    var $galleryItems = galleryData.element.find("li[data-image]");
    $galleryItems.each(function(index) {

        var imageData = $(this).data("image");
        imageData.id = galleryData.id;
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

    galleryData.images = images;

    if (GALLERYDEBUG) console.info("Image gallery collected " + images.length + " images:" + galleryData + ", path=" + galleryData.path + ", template=" + galleryData.template);

    ApolloImageGallery.render(galleryData, 0);
}

ApolloImageGallery.initGalleries = function($elements) {

    // initialize gallery with values from data attributes
    var needAutoLoad = false;

    $elements.each(function(){
        var $element = $(this);
        var $galleryElement = $element.find('.gallery');

        if (typeof $galleryElement.data("imagegallery") != 'undefined') {
            var galleryData = $galleryElement.data("imagegallery");
            galleryData.element = $galleryElement;
            AP.addData(galleryData.id, galleryData);
            if (galleryData.autoload == "true") {
                needAutoLoad = true;
                AP.addElement("autoLoadGalleries", galleryData);
            }
            if (GALLERYDEBUG) console.info("Image gallery data found:" + galleryData + ", path=" + galleryData.path + ", count=" + galleryData.count);
            ApolloImageGallery.collect(galleryData);
        }
    });

    if (needAutoLoad) {
        // only enable scroll listener if we have at least one autoloading gallery
        $(window).bind('scroll', ApolloImageGallery.handleAutoLoaders).resize(ApolloImageGallery.handleAutoLoaders);
    }
}

ApolloImageGallery.initZoomers = function($elements) {

    var images = [];
    $elements.each(function(index){

        var imageData = $(this).data("imagezoom");
        imageData.id = "imagezoom";
        imageData.src = $(this).attr('href');
        imageData.index = index;
        imageData.title = decodeURIComponent(imageData.caption);

        // calculate image width and height by parsing the property string
        if (imageData.size.indexOf(',') >= 0 && imageData.size.indexOf(':') >= 0) {
            var size = imageData.size.split(',');
            imageData.w = size[0].split(':')[1];
            imageData.h = size[1].split(':')[1];
        }
        images.push(imageData);
        $(this).click(function(e) {
            e.preventDefault();
            ApolloImageGallery.openPhotoSwipe(index, "imagezoom");
        });

        if (GALLERYDEBUG) console.info("Image zoom element found path=" + imageData.src + ", index=" + imageData.index);
    });

    var galleryData = {};
    galleryData.images = images;
    AP.addData("imagezoom", galleryData);
}

ApolloImageGallery.init = function() {

    if (GALLERYDEBUG) console.info("ApolloImageGallery.init()");
    // Note: Carousel sliders are initialized directly via Bootstrap data attributes

    var $imageGalleryElements = jQuery('.ap-image-gallery');
    var $imageZoomElements = jQuery('a[data-imagezoom]');

    if (GALLERYDEBUG) console.info(".ap-image-gallery elements found: " + $imageGalleryElements.length);
    if (GALLERYDEBUG) console.info("a[data-imagezoom] elements found: " + $imageZoomElements.length);

    if ($imageGalleryElements.length > 0 || $imageZoomElements.length > 0) {
        // We have found gallery images, append the PhotoSwipe markup
        ApolloImageGallery.appendPhotoSwipeToBody();
        if ($imageGalleryElements.length > 0) {
            ApolloImageGallery.initGalleries($imageGalleryElements);
        }
        if ($imageZoomElements.length > 0) {
            ApolloImageGallery.initZoomers($imageZoomElements);
        }
    }
}

function initApolloImageGalleries() {

    ApolloImageGallery.init();
}