/*
 * This program is part of the OpenCms Apollo Template.
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

module.exports = function(grunt) {

    oc = require('./grunt-opencms-modules.js');
    oc.initGrunt(grunt, 'build/');

    oc.loadModule('./apollo-src/jquery');
    oc.loadModule('./apollo-src/bootstrap');
    oc.loadModule('./apollo-src/font-awesome');
    oc.loadModule('./apollo-src/plugins');    
    oc.loadModule('./apollo-src/js');
    oc.loadModule('./apollo-src/scss');
    oc.loadModule('./apollo-src/scss-themes');

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
