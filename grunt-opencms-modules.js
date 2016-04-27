
var modules = {};

var templates = [];
var sassSrc = [];
var cssSrc = [];
var jsSrc = [];
var resources = [];

var templateSassSrc = [];
var templateCssSrc = [];
var templateConcatTasks = [];

var baseTemplateCssSrc;
var deployTarget;

var grunt;
var buildBase;

exports.loadModule = function(moduleName) {
	
	var f = moduleName + '/Gruntparts.js';
	try {
		var m = require(f);
		
		modules[m.module] = m;

		sassSrc = sassSrc.concat(m.sassSrc);
		cssSrc = cssSrc.concat(m.cssSrc);
		jsSrc = jsSrc.concat(m.jsSrc);
		resources = resources.concat(m.resources);
		templates = templates.concat(m.templates);
		
		exports.baseTemplateCssSrc = baseTemplateCssSrc = m.baseTemplateCssSrc;
		exports.deployTarget = deployTarget = m.deployTarget;

		return m;
	} catch (err) {
		console.error('Error: ' + err.message);
	}
}

exports.initGrunt = function(_grunt, _buildBase) {
	
	grunt = _grunt;
	buildBase = _buildBase;
	
	_gruntLoadNpmTasks();
	_gruntInitConfig();
	_gruntRegisterTasks();
		
	if (grunt.option('verbose')) {
		_showImports();
	}	
}

_gruntLoadNpmTasks = function() {

	// These plugins provide necessary tasks
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-contrib-concat');
}

_gruntInitConfig = function() {

	// Project configuration
	grunt.initConfig({
			
		clean : {
			all : [ buildBase + '**' ],
			template : {
				files : [ {
					expand : true,
					src : [ '*.css', '*.css.map' ],
					filter : 'isFile',
				} ],
			},
		},
		
		copy : {
			pluginDeps : {
				files : [ {
					expand : true,
					src : oc.resources(),
					dest : buildBase + '03_final/css',
					flatten : true,
					filter : 'isFile'
				} ],
			},
			template : {
				files : [ {
					expand : true,
					src : [ '*.css', '*.css.map' ],
					dest : buildBase + '02_minified',
					filter : 'isFile',
				} ],
			},
			deploy : {
				files : [ {
					expand : true,
					cwd : buildBase + '03_final/',
					src : [ '**' ],
					dest : oc.deployTarget,
				} ]
			}
		},
		
		sass : {
			template : {
				options : {
					sourcemap : 'auto',
					lineNumbers : true,
					style : 'nested',
				},
				files : [ {
					expand : true,
					cwd : './',
					src : oc.templateSassSrc(),
					dest : buildBase + '01_processed',
					ext : '.css',
					flatten: true
				} ]
			}
		},

		concat : {
			template : {
			    options: {
					sourceMap: true,
					sourceMapStyle: 'embed',
				},
				src: [ 
					'./plugins.min.css', 
					'<%= grunt.task.current.args[0] %>.min.css' 
				], 
				dest: buildBase + '03_final/css/<%= grunt.task.current.args[0] %>.min.css' 
			},
		},
		
		cssmin : {
			options : {
				processImport: true,
				sourceMap: true,
				sourceMapInlineSources: true,
				roundingPrecision : -1,
			},
			//
			// Important note regarding the source map handling:
			//   The source map is inlined and also referenced to the original file.
			//   If we use different src / dest folders the path information 
			//   to the original source maps gets lost in the cssmin task. 
			//   The workaround is to write to the './' folder, in which case the relative path information 
			//   remains intact. We clean up later in separate 'copy:template' and 'clean:template' tasks.
			//
			template : {
				files : [{
					expand : true,
					cwd : buildBase + '01_processed',
					src : oc.templateCssSrc(),
					dest : './',
					ext : '.min.css'
				}]
			},
			pluginCss : {
				src : oc.cssSrc(),
				dest : './plugins.min.css',
			},
		},
		
		uglify : {
			options : {
				sourceMap: true,
				sourceMapIncludeSources: true,
				mangleProperties: false,
				mangle : {
					except : [ 
						'jQuery', 
						'fancybox',
						'bootstrapPaginator', 
						'revolution',
					],
				},
			},
			pluginJs : {
				src : oc.jsSrc(),
				dest : buildBase + '03_final/js/scripts-all.min.js',
			},
		},
		
		watch: {
			scss : {
				files : [ '*/scss/*.scss' ],
				tasks : [ 'template', 'combine', 'deploy' ],
			},	
			plugins : {
				files : [ oc.cssSrc(), oc.jsSrc() ],
				tasks : [ 'plugins', 'combine', 'deploy' ],
			},
		},
	});
}

_gruntRegisterTasks = function() {

	grunt.registerTask('default', [ 
		'clean',
		'template',
		'plugins',
		'combine',
		'deploy',
	]);
	
	grunt.registerTask('template', [ 
		'sass',
		'cssmin:template',
	]);
	
	grunt.registerTask('plugins', [ 
		'cssmin:pluginCss',
		'uglify:pluginJs',
		
	]);
	
	grunt.registerTask('combine', oc.templateConcatTasks().concat(['copy:template', 'clean:template']));
	
	grunt.registerTask('deploy', function() {
		if (grunt.file.expand(oc.deployTarget + '*').length) { 
			grunt.task.run( [
				'copy:pluginDeps',
				'copy:deploy',
			] );
		} else {
			grunt.log.errorlns('Deploy target CSS folder ' + oc.deployTarget + ' not found, skipping deploy!');
		}
	});	
}	

_showImports = function() {
	
	console.log('\nLoaded path elements from OpenCms modules');
	console.log('- Sass');
	for (var i in sassSrc) { console.log("    " + sassSrc[i]) };
	
	console.log('\n- Css');
	for (var i in cssSrc) { console.log("    " + cssSrc[i]) };

	console.log('\n- Js');
	for (var i in jsSrc) { console.log("    " + jsSrc[i]) };

	console.log('\n- Resources');
	for (var i in resources) { console.log("    " + resources[i]) };
	console.log();
	
	console.log('\n- Deploy target folder: ' + deployTarget + "\n");	

}

exports.sassSrc = function () {
	return sassSrc;
}

exports.cssSrc = function () {
	return cssSrc;
}

exports.jsSrc = function () {
	return jsSrc;
}

exports.resources = function () {
	return resources;
}

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