function checkImageType(fileName){ 
	var pattern = /jpg$|gif$|png$|jpeg$/i; // regular expression, i means Upper
	return fileName.match(pattern)
}

function getFileInfo(fullName, path){ 
	var fileName, imgsrc, getLink;
	var fileLink;
	if(checkImageType(fullName)){ 
		//if image
		var front = fullName.substr(0,12);
		var end = fullName.substr(14);
		imgsrc = "/" + path + "/displayFile?fileName=" + fullName; //2
		fileLink = fullName.substr(14); //3 
		getLink = "/" + path + "/displayFile?fileName=" + front + end; //4
	}else{
		//if not image
		imgsrc = "/" + path +"/resources/img/file.png"; //2
		fileLink = fullName.substr(12); //3 
		getLink = "/" + path + "/displayFile?fileName=" + fullName; //4
	}
	fileName = fileLink.substr(fileLink.indexOf("_") + 1); //1
	console.log("fileName= " + fileName);
	return {
		fileName: fileName, //1
		imgsrc: imgsrc, //2
		getLink: getLink, //3 
		fullName: fullName //4
	}
}

//album img_url
function thumb_to_full_img(fullName, path){
	var front = fullName.substr(0,12);
	var end = fullName.substr(14);
	full_img_link = "/" + path + "/displayFile?fileName=" + front + end; //4	
	return full_img_link;
}

