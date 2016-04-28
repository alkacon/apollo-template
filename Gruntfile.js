module.exports = function(grunt) {

	oc = require('./grunt-opencms-modules.js');
	oc.initGrunt(grunt, 'build/grunt/');
	
	oc.loadModule('./org.opencms.apollo.template/jquery');
	oc.loadModule('./org.opencms.apollo.template/bootstrap');
	oc.loadModule('./org.opencms.apollo.template/font-awesome');
	oc.loadModule('./org.opencms.apollo.template/unify');
	oc.loadModule('./org.opencms.apollo.template.basics');
	
	oc.registerGruntTasks();
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
