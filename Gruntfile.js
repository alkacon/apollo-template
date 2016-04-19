module.exports = function(grunt) {

	// These plugins provide necessary tasks.
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-postcss');
	grunt.loadNpmTasks('grunt-banner');
	
	const oc = require('./grunt-opencms-modules.js');
	
	oc.loadModule('./org.opencms.apollo.template.basics');
	oc.loadModule('./org.opencms.apollo.template.webform');
	
	oc.showImports();
	
	// Postcss modules required:
	// ('perfectionist');
	// ('autoprefixer');
	// ('postcss-import');
	
	var copynote = '/*!\n\n' +
		'The OpenCms Apollo Template\n\n' +
		'(c) Alkacon Software GmbH\n' +
		'http://alkacon.com - http://opencms.org\n\n' +
		'The Apollo Template is available under the MIT License - http://opensource.org/licenses/MIT.\n' +
		'All plugins used herein retain the original copyright of their creators.\n\n*/';

	var deployTarget = process.env.OCMOUNT + '/system/modules/org.opencms.apollo.template.basics/resources/';

	var buildBase = 'build/grunt/';

	// Project configuration.
	grunt.initConfig({
			
		clean : {
			all : [ buildBase + '**' ]
		},
		
		copy : {
			pluginDeps : {
				files : [ {
						expand : true,
						src : oc.resources,
						dest : buildBase + '04_final',
						flatten : true,
						filter : 'isFile'
				} ],
			},
			deploy : {
				files : [ {
					expand : true,
					cwd : buildBase + '04_final/',
					src : [ '*', '!*.js' ],
					dest : deployTarget + 'css',
					flatten: true
				},{
					expand : true,
					src : [ buildBase + '04_final/*.js' ],
					dest : deployTarget + 'js',
					flatten: true
				} ]
			}
		},
		
		sass : {
			template : {
				options : {
					sourcemap : 'none',
					lineNumbers : false,
					style : 'nested',
				},
				files : [ {
					expand : true,
					cwd : './',
					src : oc.templateSassSrc(),
					dest : buildBase + '01_pre',
					ext : '.css',
					flatten: true
				} ]
			}
		},
		
		postcss : {
			baseCss : {
				options : {
					processors : [ 
						require('postcss-import')(), // resolve all css imports
					]
				},
				src : oc.baseTemplateCssSrc,
				dest : buildBase + '01_pre/base-template.css',
			},
			pluginCss : {
				options : {
					processors : [ 
						require('autoprefixer')({browsers: 'last 2 versions'}), // add vendor prefixes
						require('perfectionist')(), // pretty-print the output
					]
				},
				files : [ {
					expand : true,
					src : [ 
						buildBase + '01_pre/plugins.css', 
						buildBase + '01_pre/base-template.css'
					],
					dest : buildBase + '02_post',
					flatten: true
				} ]
			},
			template : {
				options : {
					processors : [ 
						require('autoprefixer')({browsers: 'last 2 versions'}), // add vendor prefixes
						require('perfectionist')(), // pretty-print the output
					]
				},				
				files : [ {
					expand : true,
					cwd : buildBase + '01_pre',
					src : oc.templateCssSrc(),
					dest : buildBase + '02_post',
					ext : '.css'
				} ]
			}
		},
		
		usebanner: {
			pluginCss : {
				options : {
					banner: copynote,
				},
				src : buildBase + '02_post/plugins.css',
				dest : buildBase + '02_post/plugins.css',
			},
		},

		concat : {
			pluginCss : {
				src : oc.cssSrc,
				dest : buildBase + '01_pre/plugins.css',
			},
			template : {
				src: [ 
					buildBase + '03_minified/plugins.min.css', 
					buildBase + '03_minified/base-template.min.css',
					buildBase + '03_minified/<%= grunt.task.current.args[0] %>.min.css' 
				], 
				dest: buildBase + '04_final/<%= grunt.task.current.args[0] %>.min.css' 
			},
		},
		
		cssmin : {
			options : {
				shorthandCompacting : true,
				roundingPrecision : -1
			},
			template : {
				files : [{
					expand : true,
					cwd : buildBase + '02_post',
					src : oc.templateCssSrc(),
					dest : buildBase + '03_minified',
					ext : '.min.css'
				}]
			},
			pluginCss : {
				files : [{
					expand : true,
					src : [ 
						buildBase + '02_post/plugins.css', 
						buildBase + '02_post/base-template.css'
					],
					dest : buildBase + '03_minified',
					flatten: true,
					ext : '.min.css'
				}]
			}
		},
		
		uglify : {
			pluginJs : {
				options : {
					banner : copynote,
					mangleProperties : false,
					mangle : {
						except : [ 
							'jQuery', 
							'fancybox',
							'bootstrapPaginator', 
							'revolution' 
						],
					},
				},
				src : oc.jsSrc,
				dest : buildBase + '04_final/scripts-all.min.js',
			},
		},
		
		watch: {
			scss : {
				files : '*/scss/*.scss',
				tasks : [ 'template', 'combine', 'deploy' ],
			},	
			plugins : {
				files : [ oc.cssSrc, oc.jsSrc ],
				tasks : [ 'plugins', 'combine', 'deploy' ],
			},
		},
	});		
		
	// Project tasks.
	grunt.registerTask('default', [ 
		'clean',
		'template',
		'plugins',
		'combine',
		'deploy'
	]);
	
	grunt.registerTask('template', [ 
		'sass',
		'postcss:template',
		'cssmin:template',
	]);
	
	grunt.registerTask('plugins', [ 
		'postcss:baseCss',
		'concat:pluginCss',
		'postcss:pluginCss', 
		'usebanner:pluginCss', 
		'cssmin:pluginCss',
		'uglify:pluginJs',
		'copy:pluginDeps'
	]);
	
	grunt.registerTask('combine', oc.templateConcatTasks());
	
	grunt.registerTask('deploy', function() {
		if (grunt.file.expand(deployTarget + '*').length) { 
			grunt.task.run( [
				'copy:deploy',
			] );
		} else {
			grunt.log.errorlns('Deploy target folder ' + deployTarget + ' not found, skipping deploy!');
		}
	});	
	
};
