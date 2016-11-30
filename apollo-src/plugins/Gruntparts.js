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

var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);
exports.mf = mf;

exports.cssSrc = [		
	mf + 'line-icons/line-icons.css',
	mf + 'animate/animate.css',
	mf + 'parallax-slider/css/parallax-slider.css',
	mf + 'owl-carousel/owl.carousel.css',
	mf + 'sky-forms-pro/skyforms/css/sky-forms.css',
	mf + 'sky-forms-pro/skyforms/custom/custom-sky-forms.css',
	mf + 'photoswipe/photoswipe.css',
	mf + 'photoswipe/default-skin/default-skin.css',
];

exports.jsSrc = [		
	mf + 'bootstrap-paginator/bootstrap-paginator.js',
	mf + 'parallax-slider/js/modernizr.js',
	mf + 'parallax-slider/js/jquery.cslider.js',
	mf + 'owl-carousel/owl-carousel/owl.carousel.js',
	mf + 'photoswipe/photoswipe.min.js',
	mf + 'photoswipe/photoswipe-ui-default.js',
];

exports.resources = [
	mf + 'photoswipe/default-skin/*.svg', 
	mf + 'photoswipe/default-skin/*.png', 
	mf + 'photoswipe/default-skin/*.gif',
];
