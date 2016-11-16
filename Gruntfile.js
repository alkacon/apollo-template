module.exports = function(grunt) {

	oc = require('./grunt-opencms-modules.js');
	oc.initGrunt(grunt, 'build/grunt/');
	
	oc.loadModule('./apollo-src/jquery');
	oc.loadModule('./apollo-src/bootstrap');
	oc.loadModule('./apollo-src/font-awesome');
    oc.loadModule('./apollo-src/plugins');	
    oc.loadModule('./apollo-src/js');
    oc.loadModule('./apollo-src/scss');
    oc.loadModule('./apollo-src/scss-themes');
	// oc.loadModule('./apollo-src/csscheck');
	
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
