
var modules = [];

var templates = [];
var sassSrc = [];
var cssSrc = [];
var jsSrc = [];
var resources = [];

var templateSassSrc = [];
var templateCssSrc = [];
var templateConcatTasks = [];

var baseTemplateCssSrc;

exports.loadModule = function(moduleName) {
	
	var f = moduleName + '/Gruntparts.js';
	try {
		var m = require(f);
		
		modules.push(m);

		exports.templates = templates = jsSrc.concat(m.templates);
		exports.sassSrc = sassSrc = sassSrc.concat(m.sassSrc);
		exports.cssSrc = cssSrc = cssSrc.concat(m.cssSrc);
		exports.jsSrc = jsSrc = jsSrc.concat(m.jsSrc);
		exports.resources = resources = resources.concat(m.resources);
		exports.baseTemplateCssSrc = baseTemplateCssSrc = m.baseTemplateCssSrc;

		return m;
	} catch (err) {
		console.error('Error: ' + err.message);
	}
},

exports.showImports = function() {
	
	console.log('\nLoaded path elements from OpenCms modules:');
	console.log('- Sass');
	for (var i in sassSrc) { console.log("    " + sassSrc[i]) };
	
	console.log('\n- Css');
	for (var i in cssSrc) { console.log("    " + cssSrc[i]) };

	console.log('\n- Js');
	for (var i in jsSrc) { console.log("    " + jsSrc[i]) };

	console.log('\n- Resources');
	for (var i in resources) { console.log("    " + resources[i]) };
	console.log();

},

exports.templateSassSrc = function () {
	for (i=0; i<templates.length; i++) {
		templateSassSrc[i] = '**/' + templates[i] + '.scss';
	}
	return templateSassSrc;
}

exports.templateCssSrc = function () {
	for (i=0; i<templates.length; i++) {
		templateCssSrc[i] = templates[i] + '.css';
	}
	return templateCssSrc;
}

exports.templateConcatTasks = function () {
	for (i=0; i<templates.length; i++) {
		templateConcatTasks[i] = 'concat:template:' + templates[i];
	}
	return templateConcatTasks;
}

