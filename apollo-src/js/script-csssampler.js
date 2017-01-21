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

// Module implemented using the "revealing module pattern", see
// https://addyosmani.com/resources/essentialjsdesignpatterns/book/#revealingmodulepatternjavascript
// https://www.christianheilmann.com/2007/08/22/again-with-the-module-pattern-reveal-something-to-the-world/
var ApolloCssSampler = function(jQ) {

    function replaceAll(template, key, value) {

        return template.split("$(" + key + ")").join(value);
    }

    function init() {

        if (DEBUG) console.info("ApolloCssSampler.init()");

        var $magicElements = jQ(".apollo-info.sample");
        if (DEBUG) console.info(".apollo-info.sample elements found: " + $magicElements.length);

        for (var i = 0; i < $magicElements.length; i++) {
            $element = jQ($magicElements[i]);
            var template = $element.html();
            $element.empty();

            data = Apollo.getCssData($element.attr('id'));

            for (var j = 0; j<data.length; j++) {

                var obj = data[j];
                if (obj.name) {
                    var html = template;
                    html = replaceAll(html, "name", obj.name);
                    html = replaceAll(html, "value", obj.value);
                    $element.append(jQ(html));
                }
            }
        }
    }

    // public available functions
    return {
        init: init
    }

}(jQuery);
