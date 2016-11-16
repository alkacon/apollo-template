/**
 * Script to reveal / unobfuscate an Email that was obfuscated using the <apollo:obfuscate> tag.
 */

function unobfuscateString(scramble, mailto) {
    var del = scramble.lastIndexOf('/') + 1;
    scramble = scramble.substr(del, scramble.length - del - 1);
    var result='';
    var codes = scramble.split(';');
    for (var j = 0; j < codes.length; j++){
        if (codes[j].length > 1){
            var ch = String.fromCharCode(parseInt(codes[j],16));
            result = result + ch;
        }
    }
    result = result.replace(/\[SCRAMBLE\]/g,'.').replace(/\{SCRAMBLE\}/g,'@').split('').reverse().join('');
    if (mailto) {
        window.location.href = "mailto:" + result;
    } else {
        return result;
    }
}
