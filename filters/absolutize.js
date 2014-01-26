url = require('url');

module.exports = function(str, base) {
	return url.resolve(base, str);
	
	//if(str.substring(0, 7) == "http://") {
	//	return str;
	//} else {
	//	return base + str;
	//}

}