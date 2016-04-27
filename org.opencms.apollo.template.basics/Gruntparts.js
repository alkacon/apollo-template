
var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);

var msegs = mf.split('/');
var module = msegs.slice(-1);
var repo = msegs.slice(-2, -1);
var rf = repo + '/' + module + '/';

exports.mf = mf;
exports.rf = rf;
exports.repo = repo;
exports.module = module;

exports.templates = [ 
	'style-blue', 
	'style-red'
];
	
exports.deployTarget = process.env.OCMOUNT + '/system/modules/org.opencms.apollo.template.basics/resources/';

exports.sassSrc = [
	mf + 'scss/*.scss', 
];

exports.cssSrc = [		
	mf + 'plugins/bootstrap/css/bootstrap.css',
	mf + 'plugins/unify/css/style.css',	
	mf + 'plugins/unify/css/fonts.css',
	mf + 'plugins/unify/css/headers/header-default.css',
	mf + 'plugins/unify/css/footers/footer-default.css',
	mf + 'plugins/line-icons/line-icons.css',
	mf + 'plugins/animate.css',
	mf + 'plugins/font-awesome/css/font-awesome.css',
	mf + 'plugins/parallax-slider/css/parallax-slider.css',
	mf + 'plugins/owl-carousel/owl-carousel/owl.carousel.css',
	mf + 'plugins/sky-forms-pro/skyforms/css/sky-forms.css',
	mf + 'plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css',
	mf + 'plugins/photoswipe/photoswipe.css',
	mf + 'plugins/photoswipe/default-skin/default-skin.css',
],

exports.jsSrc = [		
	mf + 'plugins/jquery/jquery.js',
	mf + 'plugins/jquery/jquery-migrate.js',
	mf + 'plugins/bootstrap/js/bootstrap.js',
	mf + 'plugins/bootstrap-paginator/bootstrap-paginator.js',
	mf + 'plugins/back-to-top.js',
	mf + 'plugins/smoothScroll.js',
	mf + 'plugins/parallax-slider/js/modernizr.js',
	mf + 'plugins/parallax-slider/js/jquery.cslider.js',
	mf + 'plugins/owl-carousel/owl-carousel/owl.carousel.js',
	mf + 'plugins/unify/js/app.js',
	mf + 'plugins/photoswipe/photoswipe.min.js',
	mf + 'plugins/photoswipe/photoswipe-ui-default.js',
	mf + 'plugins/unify/js/apollo.js',
],

exports.resources = [
	mf + 'plugins/photoswipe/default-skin/*.svg', 
	mf + 'plugins/photoswipe/default-skin/*.png', 
	mf + 'plugins/photoswipe/default-skin/*.gif',
]
