# The OpenCms Apollo Template #

## A responsive, modular template for OpenCms based on Bootstrap ##

> "Bootstrap is the most popular HTML, CSS, and JS framework for developing responsive, mobile first projects on the web."
> [getboostrap.com](http://getbootstrap.com)

Bootstrap is *the* framework to build mobile first web sites.
The OpenCms Apollo Template makes it easy to create Bootstrap based web sites with OpenCms.

Here are some highlights: 

 * Create simple or even complex Bootstrap grid-layouts via drag&drop.
 * Use predefined content types to realize the features you need.
 * Style your web site with individual CSS-themes using the template's [Sass](http://sass-lang.com) and [Grunt](http://gruntjs.com) infrastructure.
 * Get great performance serving the same single minified CSS and JavaScript file for each of your pages.
 * Keep the overview on your CSS and JavaScript via source maps.
 * Directly benefit from various popular CSS and JavaScript plugins:
 	* [Font Awesome - The iconic font and CSS toolkit](http://fontawesome.io)
 	* [jQuery](https://jquery.com)
 	* [Animate.css](https://daneden.github.io/animate.css/)
 	
## Building and Installation ##

**The Apollo Template is already installed in OpenCms 10.5. So you can directly start working with it.**

For a manual installation from the sources, checkout the repository.

### Building the template modules ###

The template's modules can be built using [Gradle](https://gradle.org). The interesting targets are:
* `dist_{module name}` to build a single module (includes building the module's JAR, if it has one)
* `jar_{module name}` to build only the JAR contained in the module
* `bindist` to build all modules

### Installing the template modules ###

Once built, install the modules in the following order:
* *org.opencms.apollo.theme*
* *org.opencms.apollo.template.core*
* optionally the other modules that contain additional features.

## Working with the template ##

The module *org.opencms.apollo.template.democontents* contains a complete web site built with the Apollo Template. It serves as documentation of the various content elements that are part of the template.
The demo contents also contain a set of layout rows. These are the elements you build the website's (grid) layout with. Last but not least it has many macro formatters for section's defined, which you may reuse, copy or adjust for your web site.

*General information on building pages with the Apollo Template are given in the [OpenCms Documentation](http://documentation.opencms.org/opencms-documentation/additional-documentation/the-apollo-template/).*

## Customizing the template ##

The template's static resources, i.e., CSS, JavaScript, fonts and images are all bundled in the module *org.opencms.apollo.theme*. The module's resources are mostly generated from the resources under `apollo-src`. Here you find all CSS and JavaScript sources combined in one minified CSS file (per theme) and one minified JavaScript file. Also part of the static resources that are included in the *org.opencms.apollo.theme* module are located here.

To customize the template, you add or change files under `apollo-src` and then use Sass and Grunt to compile the sources to the artifacts of *org.opencms.apollo.theme*. You may create your custom branch of the template repository before you add changes.

**To customize the template, install Sass and Grunt.**

### Grunt infrastructure ###

To compile the CSS and JavaScript resources, go to the repository's root folder and run

```shell
sudo npm install
```
to install all dependencies required to compile the template's sources.

Once all dependencies are installed, you can trigger the compilation by running

```shell
grunt
```
in the repository's root folder. To get more detailed output, you can use the option `-v`. To automatically recompile when you change a source, use `grunt watch`, optionally also with `-v`.

After running `grunt`, the repository will have a new folder `build/grunt/` with three sub-folders. The sub-folder `03_final/` contains the final CSS and JavaScript resources that you can copy to the *org.opencms.apollo.theme* module. The result has to be copied to `org.opencms.apollo.theme/resources/system/modules/org.opencms.apollo.theme/resources/`.

You can also set the environment variable `OCMOUNTS` to a folder where the compilation result should be copied to. The intention is to mount the VFS of the OpenCms installation you develop on and set `OCMOUNTS` to point to the mount point. Then the CSS and JavaScript sources are updated automatically in the installation and you can see your changes in action. 

The Grunt infrastructure of the template is special in the way that we have more than one Grunt file. The resources to process are added via `Gruntparts.js` files in the sub-folders of `apollo-src`. The top-level `Gruntfile.js` just includes `grunt-opencms-modules.js`, which contains the main scripts (that you may not even care about when using the infrastructure), and loads the `Gruntparts.js` files from the folders registered via `oc.loadModule({folder name})`. Keep that structure in mind when you adjust things.

### Adjusting CSS ###

The Apollo Template uses CSS themes. In OpenCms you can configure which theme to use by setting the property `apollo.theme`. By default, the themes *style-blue* and *style-red* are available. When Grunt is compiling CSS, it generates for each theme a separate style file, basically by compiling the respective theme's `.scss` file.
Both themes available by default are minimal in the way that they only define the mandatory variables `$main-theme`, `$main-theme-hover` and `$main-theme-additional`. Moreover, they import all common style files located under `apollo-src/scss/`. That's what you should do at least when writing your own theme as explained below.
 
To write your own theme, add an `.scss` file in the folder `apollo-src/scss-themes/`, e.g., `style-custom.scss`. You may copy `style-red.scss` and then edit it.

The simplest adjustment to do in your theme is to change the values of `$main-theme`, `$main-theme-hover` and `$main-theme-additional`, but you can overwrite any of the variables defined in one of the `.scss` files under `apollo-src/scss/`. Moreover, you can add your own variables and style definitions.

To get your theme compiled by Grunt, add it in the `apollo-src/css-themes/Gruntparts.js` in the `export.themes` array.

### Adding JavaScript ###

You can add JavaScript by adding a file `script-*.js` under `apollo-src/js`. If you do not care about the order in which the added JavaScript files are added to the single JavaScript file created by Grunt, you do not have to take any other action. If order matters, do not prefix your file with `script-` and add it manually in the `Gruntparts.js` under `apollo-src/js`.

## License ##

Copyright (c) Alkacon Software GmbH & Co. KG [http://www.alkacon.com](http://www.alkacon.com)

This template is free software: you can redistribute it and/or modify
it under the terms of the *GNU Affero General Public License* as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This template is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

See [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/) for the
full text of the GNU Affero General Public License.

