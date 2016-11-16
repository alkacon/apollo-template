
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
