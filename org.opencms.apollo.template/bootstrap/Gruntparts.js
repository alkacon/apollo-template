
var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);
exports.mf = mf;

exports.cssSrc = [		
	mf + 'css/bootstrap.css',
],

exports.jsSrc = [		
	mf + 'js/bootstrap.js',
]