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
	// grunt.loadNpmTasks('grunt-markdown');
	
	// Postcss modules required:
	// ('perfectionist');
	// ('autoprefixer');
	// ('postcss-import');
	// ('postcss-banner');
	
	var copynote = '\n\n' +
		'OpenCms Apollo Template CSS\n\n' +
		'(c) Alkacon Software GmbH\n' +
		'http://alkacon.com - http://opencms.org\n\n' +
		'Apache License 2.0 - http://www.apache.org/licenses/LICENSE-2.0 \n\n';

	var templates = [ 'style-blue', 'style-red' ];
	
	var deployTarget = process.env.OCMOUNT + '/system/modules/org.opencms.apollo.template.basics/resources/';
	
	var templateSassSrc = new Array(templates.length);
	var templateCssSrc = new Array(templates.length);
	var templateConcatTasks = new Array(templates.length);
	for (i=0; i<templates.length; i++) {
		templateSassSrc[i] = '**/' + templates[i] + '.scss';
		templateCssSrc[i] = templates[i] + '.css';
		templateConcatTasks[i] = 'concat:template:' + templates[i];
	}

	// Project configuration.
	grunt.initConfig({
			
		clean : {
			all : [ 'build/**' ]
		},
		
		copy : {
			pluginDeps : {
				files : [ {
						expand : true,
						src : [ '<%= pluginDeps %>' ],
						dest : 'build/04_final',
						flatten : true,
						filter : 'isFile'
				} ],
			},
			deploy : {
				files : [ {
					expand : true,
					src : [ 'build/04_final/*', '!*.js'],
					dest : process.env.OCMOUNT + 'css',
					flatten: true
				},{
					expand : true,
					src : [ 'build/04_final/*.js' ],
					dest : process.env.OCMOUNT + 'js',
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
					src : templateSassSrc,
					dest : 'build/01_pre',
					ext : '.css',
					flatten: true
				} ]
			}
		},
		
		postcss : {
			importBaseCss : {
				options : {
					processors : [ 
						require('postcss-import')(), // resolve all css imports
						require('postcss-banner')({banner : '! ' + copynote}), // add copyright banner						
					]
				},
				src : '<%= baseTemplateCssSrc %>',
				dest : 'build/01_pre/base-template.css',
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
					src : [ 'build/01_pre/plugins.css', 'build/01_pre/base-template.css'],
					dest : 'build/02_post',
					flatten: true
				}]
			},
			template : {
				options : {
					processors : [ 
						require('autoprefixer')({browsers: 'last 2 versions'}), // add vendor prefixes
						require('perfectionist')(), // pretty-print the output
					]
				},				
				files : [{
					expand : true,
					cwd : 'build/01_pre',
					src : templateCssSrc,
					dest : 'build/02_post',
					ext : '.css'
				}]
			}
		},

		concat : {
			pluginCss : {
				src : [ '<%= pluginCssSrc %>' ],
				dest : 'build/01_pre/plugins.css',
			},
			pluginJs : {
				src : [ '<%= pluginJsSrc %>' ],
				dest : 'build/01_pre/scripts-all.js',
			},	
			template : {
				src: [ 
					'build/03_minified/base-template.min.css',
					'build/03_minified/plugins.min.css', 
					'build/03_minified/<%= grunt.task.current.args[0] %>.min.css' 
				], 
				dest: 'build/04_final/<%= grunt.task.current.args[0] %>.min.css' 
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
					cwd : 'build/02_post',
					src : templateCssSrc,
					dest : 'build/03_minified',
					ext : '.min.css'
				}]
			},
			plugins : {
				files : [{
					expand : true,
					src : [ 'build/02_post/plugins.css', 'build/02_post/base-template.css'],
					dest : 'build/03_minified',
					flatten: true,
					ext : '.min.css'
				}]
			}
		},
		
		uglify : {
			pluginJsMinified : {
				options : {
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
				src : 'build/01_pre/scripts-all.js',
				dest : 'build/04_final/scripts-all.min.js',
			},
		},
		
		watch: {
			scss : {
				files : '*/scss/*.scss',
				tasks : [ 'template', 'combine', 'deploy' ],
			},	
			plugins : {
				files : [ ['<%= pluginCssSrc %>'], ['<%= pluginJsSrc %>'] ],
				tasks : [ 'plugins', 'combine', 'deploy' ],
			},
		},
		
		// Plugin dependencies, i.e. resources required by the plugins.
		// These must be copied without processing.
		pluginDeps : [
			'*/plugins/photoswipe/default-skin/*.svg', 
			'*/plugins/photoswipe/default-skin/*.png', 
			'*/plugins/photoswipe/default-skin/*.gif'
		],
		
		// Base CSS template source file.
		baseTemplateCssSrc : '*/plugins//unify/css/style.css',
		
		// Plugin CSS source files.
		// These must be combined with our SASS generated CSS and minified.
		pluginCssSrc : [
			'*/plugins/unify/css/fonts.css',
			'*/plugins/unify/css/headers/header-default.css',
			'*/plugins/unify/css/footers/footer-default.css',
			'*/plugins/bootstrap/css/bootstrap.min.css',
			'*/plugins/line-icons/line-icons.css',
			'*/plugins/animate.css',
			'*/plugins/font-awesome/css/font-awesome.min.css',
			'*/plugins/parallax-slider/css/parallax-slider.css',
			'*/plugins/owl-carousel/owl-carousel/owl.carousel.css',
			'*/plugins/sky-forms-pro/skyforms/css/sky-forms.css',
			'*/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css',
			'*/plugins/photoswipe/photoswipe.css',
			'*/plugins/photoswipe/default-skin/default-skin.css' 
		],
		
		// Plugin JavaScript source files.
		// These must be combined and compressed.
		pluginJsSrc : [		
			'*/plugins/jquery/jquery.min.js',
			'*/plugins/jquery/jquery-migrate.min.js',
			'*/plugins/bootstrap/js/bootstrap.min.js',
			'*/plugins/bootstrap-paginator/bootstrap-paginator.min.js',
			'*/plugins/back-to-top.js',
			'*/plugins/smoothScroll.js',
			'*/plugins/parallax-slider/js/modernizr.js',
			'*/plugins/parallax-slider/js/jquery.cslider.js',
			'*/plugins/owl-carousel/owl-carousel/owl.carousel.js',
			'*/plugins/unify/js/app.js',
			'*/plugins/photoswipe/photoswipe.min.js',
			'*/plugins/photoswipe/photoswipe-ui-default.js',
			'*/plugins/unify/js/apollo.js'
		]
	});		
		
	// Project tasks.
	grunt.registerTask('default', [ 
		'clean',
		'template',
		'plugins',
		'combine'
	]);
	
	grunt.registerTask('template', [ 
		'sass',
		'postcss:template',
		'cssmin:template',
	]);
	
	grunt.registerTask('plugins', [ 
		'postcss:importBaseCss',
		'concat:pluginCss',
		'postcss:pluginCss', 
		'cssmin:plugins',
		'concat:pluginJs',
		'uglify:pluginJsMinified',
		'copy:pluginDeps'
	]);
	
	grunt.registerTask('combine', templateConcatTasks);
	
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
