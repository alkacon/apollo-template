
var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);

var msegs = mf.split('/');
var module = msegs.slice(-1);
var repo = msegs.slice(-2, -1);
var rf = repo + '/' + module + '/';

exports.mf = mf;
exports.rf = rf;
exports.repo = repo;
exports.module = module;

_getTemplates = function() {
	if (process.env.TEMPLATES_APOLLO) {
		return [ process.env.TEMPLATES_APOLLO ];
	} 
	return [ 
		'style-blue', 
		'style-red'
	];
};

exports.templates = _getTemplates();
	
exports.deployTarget = process.env.OCMOUNT + '/system/modules/org.opencms.apollo.template.basics/resources/';

exports.sassSrc = [
	mf + 'scss/*.scss', 
];

exports.cssSrc = [		
	mf + 'plugins/line-icons/line-icons.css',
	mf + 'plugins/animate.css',
	mf + 'plugins/parallax-slider/css/parallax-slider.css',
	mf + 'plugins/owl-carousel/owl-carousel/owl.carousel.css',
	mf + 'plugins/sky-forms-pro/skyforms/css/sky-forms.css',
	mf + 'plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css',
	mf + 'plugins/photoswipe/photoswipe.css',
	mf + 'plugins/photoswipe/default-skin/default-skin.css',
];

exports.jsSrc = [		
	mf + 'plugins/bootstrap-paginator/bootstrap-paginator.js',
	mf + 'plugins/back-to-top.js',
	mf + 'plugins/smoothScroll.js',
	mf + 'plugins/parallax-slider/js/modernizr.js',
	mf + 'plugins/parallax-slider/js/jquery.cslider.js',
	mf + 'plugins/owl-carousel/owl-carousel/owl.carousel.js',
	mf + 'plugins/photoswipe/photoswipe.min.js',
	mf + 'plugins/photoswipe/photoswipe-ui-default.js',
];

exports.resources = [
	mf + 'plugins/photoswipe/default-skin/*.svg', 
	mf + 'plugins/photoswipe/default-skin/*.png', 
	mf + 'plugins/photoswipe/default-skin/*.gif',
];
