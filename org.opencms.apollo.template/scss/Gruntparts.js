
var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);
exports.mf = mf;

exports.sassSrc = [
	mf + 'scss/*.scss', 
];