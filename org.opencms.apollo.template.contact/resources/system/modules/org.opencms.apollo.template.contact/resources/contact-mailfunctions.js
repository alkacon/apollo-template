function descrambleContactEmail(scramble) {
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
	window.location.href = "mailto:" + result;
}