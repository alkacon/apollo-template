
var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);
exports.mf = mf;

exports.jsSrc = [		
	mf + 'script-*.js',
];