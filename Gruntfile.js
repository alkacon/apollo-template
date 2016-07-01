module.exports = function(grunt) {

	oc = require('./grunt-opencms-modules.js');
	oc.initGrunt(grunt, 'build/grunt/');
	
	oc.loadModule('./org.opencms.apollo.template/jquery');
	oc.loadModule('./org.opencms.apollo.template/bootstrap');
	oc.loadModule('./org.opencms.apollo.template/font-awesome');
	oc.loadModule('./org.opencms.apollo.template/unify');
	oc.loadModule('./org.opencms.apollo.template/scss');
	oc.loadModule('./org.opencms.apollo.template/js');
	oc.loadModule('./org.opencms.apollo.template.basics');
	
	oc.registerGruntTasks();
};

/**
 * Available grunt targets:
 *
 * clean:        Clean up the working directory.
 * template:     Build the minified template CSS from Sass.
 * pluginCss:    Build the minified CSS from the plugins.
 * pluginJs:     Build the uglified JavaScript from the plugins.
 * plugins:      Build both the minified CSS and JavaScript from the plugins.
 * deploy:       Copy created CSS and JavaScript as well as static resources to the configured deploy folder.
 * watch:        Watch for changes and rebuild output.
 * 
 */
