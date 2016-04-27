module.exports = function(grunt) {

	oc = require('./grunt-opencms-modules.js');
	
	oc.loadModule('./org.opencms.apollo.template.basics');
	
	oc.initGrunt(grunt, 'build/grunt/');
};

/**
 * Available grunt targets:
 *
 * clean:        Clean up the working directory.
 * template:     Build the minified template CSS from Sass.
 * plugins:      Build the minified CSS and JavaScript from the plugins.
 * combine:      Combine the template and plugin CSS.
 * deploy:       Copy all created CSS and JavaScrip to the configured deploy target folder.
 * watch:        Watch for changes and rebuild output.
 * 
 */
