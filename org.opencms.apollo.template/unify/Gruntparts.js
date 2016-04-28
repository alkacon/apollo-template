
var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);
exports.mf = mf;

exports.cssSrc = [		
	mf + 'css/style.css',	
	mf + 'css/fonts.css',
	mf + 'css/headers/header-default.css',
	mf + 'css/footers/footer-default.css',
],

exports.jsSrc = [		
	mf + 'js/app.js',
	mf + 'js/apollo.js',
]
