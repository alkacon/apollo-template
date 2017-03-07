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
var ApolloAnalytics = function(jQ) {

    function addGoogleAnalytics(analyticsId) {

        if (DEBUG) console.info("addGoogleAnalytics() initializing Google analytics using id: " + analyticsId);

        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', analyticsId, 'auto');
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
    }


    function init() {

        if (DEBUG) console.info("ApolloAnalytics.init()");
        var googleAnalyticsId = null;
        if (Apollo.hasInfo("googleAnalyticsId")) {
            googleAnalyticsId = Apollo.getInfo("googleAnalyticsId");
            if (! googleAnalyticsId.toUpperCase().startsWith("UA-")) {
                googleAnalyticsId = "UA-" + googleAnalyticsId;
            }
        }
        if (DEBUG) {
            if (googleAnalyticsId != null) {
                // Goggle analytics ID is read in apollo:pageinfo tag and stored in JavaScript via Apollo.init()
                console.info("Google analytic ID is: " + googleAnalyticsId);
                if (! Apollo.isOnlineProject()) console.info("Google analytics NOT initialized because not in the ONLINE project!");
            } else {
                console.info("Google analytic ID (property 'google.analytics') not set in OpenCms VFS!");
            }
        }
        if (Apollo.isOnlineProject() && (googleAnalyticsId != null)) {
            // only enable google analytics in the online project when ID is set
            addGoogleAnalytics(googleAnalyticsId);
        }
    }

    // public available functions
    return {
        init: init
    }

}(jQuery);
