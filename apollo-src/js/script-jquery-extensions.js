// Note: If EXTDEBUG is false, all if clauses using it will be removed
// by uglify.js during Apollo JS processing as unreachable code
var EXTDEBUG = false;

// this is taken straight from the jQuery docs:
// http://api.jquery.com/jQuery.getScript/
jQuery.loadScript = function( url, options ) {

    if (EXTDEBUG) console.info("Apollo loading script from url: " + url);

    // Allow user to set any option except for dataType, cache, and url
    options = jQuery.extend( options || {}, {
        dataType: "script",
        cache: true,
        url: url
    });

    // Use jQuery.ajax() since it is more flexible than jQuery.getScript
    // Return the jqXHR object so we can chain callbacks
    return jQuery.ajax( options );
};


jQuery.fn.visible = function( partial ) {

    var $t = jQuery(this);
    var $w = jQuery(window);
    var viewTop = $w.scrollTop();
    var viewBottom = viewTop + $w.height();
    var _top = $t.offset().top;
    var _bottom = _top + $t.height();
    var compareTop = partial === true ? _bottom : _top;
    var compareBottom = partial === true ? _top : _bottom;

    return ((compareBottom - 100 <= viewBottom) && (compareTop >= viewTop));
};



// Acessing object path by String value
// see: http://stackoverflow.com/questions/6491463/accessing-nested-javascript-objects-with-string-key
Object.byString = function(o, s) {
    s = s.replace(/\[(\w+)\]/g, '.$1'); // convert indexes to properties
    s = s.replace(/^\./, '');           // strip a leading dot
    var a = s.split('.');
    for (var i = 0, n = a.length; i < n; ++i) {
        var k = a[i];
        if (k in o) {
            o = o[k];
        } else {
            return;
        }
    }
    return o;
}