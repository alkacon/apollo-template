module.exports = function(grunt) {

	// Project configuration.
	grunt
			.initConfig({
				sass : {
					dist : {
						options : {
							sourcemap : 'none',
							lineNumbers : false,
							style : 'nested',
						},
						files : [ {
							expand : true,
							cwd : 'components/scss',
							src : [ 'style-*.scss' ],
							dest : 'output/resources/css',
							ext : '.css'
						} ]
					}
				},

				concat : {
					options : {},
					plugins : {
						src : [
								'components/css/fonts.css',
								'components/css/headers/header-default.css',
								'components/css/footers/footer-default.css',
								'components/plugins/bootstrap/css/bootstrap.min.css',
								'components/plugins/line-icons/line-icons.css',
								'components/plugins/animate.css',
								'components/plugins/font-awesome/css/font-awesome.min.css',
								'components/plugins/parallax-slider/css/parallax-slider.css',
								'components/plugins/owl-carousel/owl-carousel/owl.carousel.css',
								'components/plugins/sky-forms-pro/skyforms/css/sky-forms.css',
								'components/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css',
								'components/plugins/PhotoSwipe/photoswipe.css',
								'components/plugins/PhotoSwipe/default-skin/default-skin.css' ],
						dest : 'output/resources/css/plugins.css',
					},
					apollo_red : {
						src : [ 'output/resources/css/min/plugins.min.css',
								'output/resources/css/min/style-red.min.css' ],
						dest : 'output/resources/css/min/style-red.min.css',
					},
					apollo_blue : {
						src : [ 'output/resources/css/min/plugins.min.css',
								'output/resources/css/min/style-blue.min.css' ],
						dest : 'output/resources/css/min/style-blue.min.css',
					},
					apollo_bluegold : {
						src : [ 'output/resources/css/min/plugins.min.css',
								'output/resources/css/min/style-bluegold.min.css' ],
						dest : 'output/resources/css/min/style-bluegold.min.css',
					},
					apollo_goldblue : {
						src : [ 'output/resources/css/min/plugins.min.css',
								'output/resources/css/min/style-goldblue.min.css' ],
						dest : 'output/resources/css/min/style-goldblue.min.css',
					}
				},
				cssmin : {
					options : {
						shorthandCompacting : true,
						roundingPrecision : -1
					},
					plugins : {
						files : [
								{
									'output/resources/css/min/plugins.min.css' : [
											'output/resources/css/plugins.css',
											'components/css/style.css', ]
								}, ]
					},
					apollo : {
						options : {
							banner : '/*! Alkacon Apollo Demo Template for OpenCms | GNU Lesser General Public License */\n',
						},
						files : [ {
							expand : true,
							cwd : 'output/resources/css',
							src : [ 'style-*.css', '!*.min.css' ],
							dest : 'output/resources/css/min',
							ext : '.min.css'
						} ]

					}
				},

				uglify : {
					options : {
						banner : '/*! Alkacon Apollo Demo Template for OpenCms | GNU Lesser General Public License */\n',
						mangle : {
							except : [ 'jQuery', 'fancybox',
									'bootstrapPaginator', 'revolution' ]
						},
						mangleProperties : false
					},
					my_target : {
						files : {
							'output/resources/js/scripts-all.min.js' : [
									'components/plugins/jquery/jquery.min.js',
									'components/plugins/jquery/jquery-migrate.min.js',
									'components/plugins/bootstrap/js/bootstrap.min.js',
									'components/plugins/bootstrap-paginator/bootstrap-paginator.min.js',
									'components/plugins/back-to-top.js',
									'components/plugins/smoothScroll.js',
									'components/plugins/parallax-slider/js/modernizr.js',
									'components/plugins/parallax-slider/js/jquery.cslider.js',
									'components/plugins/owl-carousel/owl-carousel/owl.carousel.js',
									'components/js/app.js',
									'components/plugins/PhotoSwipe/photoswipe.min.js',
									'components/plugins/PhotoSwipe/photoswipe-ui-default.js',
									'components/js/apollo.js' ]
						}
					}
				},
				copy : {
					main : {
						files : [
								{
									expand : true,
									flatten : true,
									src : [ 'output/resources/css/min/style-*.min.css', 'components/plugins/PhotoSwipe/default-skin/*.svg', 'components/plugins/PhotoSwipe/default-skin/*.png', 'components/plugins/PhotoSwipe/default-skin/*.gif' ],
									dest : process.env.OCMOUNT + '/system/modules/org.opencms.apollo.template.basics/resources/css/',
									filter : 'isFile'
								},
								{
									expand : true,
									flatten : true,
									src : [ 'output/resources/js/*.min.js' ],
									dest : process.env.OCMOUNT + '/system/modules/org.opencms.apollo.template.basics/resources/js/',
									filter : 'isFile'
								} ],
					},
				},
				markdown : {
					all : {
						files : [ {
							expand : true,
							src : 'components/*.md',
							dest : 'output/resources/docs/html/',
							ext : '.html'
						} ]
					}
				},
				postcss : {
					options : {
						processors : [ require('autoprefixer')({
							browsers : 'last 2 versions'
						}), // add vendor prefixes
						]
					},
					dist : {
						src : 'output/resources/css/*.css'
					}
				},
				watch : {
					scss : {
						files : '**/*.scss',
						tasks : [ 'apollo', 'copy' ]
					},
					uglify : {
						files : 'components/**/*.js',
						tasks : [ 'uglify', 'copy' ]
					},
					markdown : {
						files : 'components//*.md',
						tasks : [ 'markdown' ]
					}
				}
			});

	// These plugins provide necessary tasks.
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-sass');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-markdown');
	grunt.loadNpmTasks('grunt-postcss');

	// Default task.
	// By default, lint and run all tests.
	grunt.registerTask('default', [ 'plugins', 'apollo', 'uglify' ]);
	grunt.registerTask('plugins', [ 'concat:plugins', 'cssmin:plugins' ]);
	grunt.registerTask('apollo', [ 
		'sass', 
		'cssmin:apollo',
		'concat:apollo_red',
		'concat:apollo_blue',
		'concat:apollo_bluegold',
		'concat:apollo_goldblue' ]);

};
