<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML4.0 Transactional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

	.fileDrop{
		widt:100%;
		height:200px;
		border: 1px dotted blue;
	}
	small {
	margin-left : 3px;
	font-weight: bold;
	color: gray;
	}
	.pointer {
	cursor: pointer;
	}
</style>

</head>
<body>
<body>

	<h3>Ajax file upload</h3>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>
	
		
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
/*-------------*/
/*  functions   */
/*-------------*/
function checkImageType(fileName){
	var pattern = /jpg$|gif$|png$|jpeg$/i; // regular expression, i means Upper
	return fileName.match(pattern)
}

function getOriginalName(fileName){
	if(checkImageType(fileName)){ //if image pass
		return;
	}
	var idx = fileName.indexOf("_") + 1; //if not image trim.
	console.log("idx=" + idx);
	console.log("fileName.substr(idx)=" + fileName.substr(idx));
	return fileName.substr(idx);
}

function getImageLink(fileName){
	if(!checkImageType(fileName)){// if not image
		return;
	}
	//remove _s from link
	var front = fileName.substr(0,12);
	var end = fileName.substr(14);
	return front + end;
}

	
/*-------------*/
/*  fileDrop   */
/*-------------*/
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		
		var files= event.originalEvent.dataTransfer.files;
		var file = files[0];
		
		var formData = new FormData();
		formData.append("file", file);
		
		$.ajax({
			url: '/uploadAjax',
			data: formData,
			dataType:'text',
			processData: false,
			contentType: false,
			type:'POST',
			success: function(data){
				alert("data= " + data);
				var str="";
				if(checkImageType(data)){
					str="<div>"
						+ " <a href='displayFile?fileName=" + getImageLink(data) + "'>"
						+ "	 <img src='displayFile?fileName=" + data + "'/>"
						+ " </a>"
						+ " <small data-src='" + data + "' class='pointer'> X </small>"
						+ "</div>" 
				}else{ // if not image
					str="<div>" 
						+ "<a href='displayFile?fileName=" + data + "'>"
						+	getOriginalName(data)
						+ "	</a>"
						+ " <small data-src='" + data + "' class='pointer'> X </small>"
						+ "</div>"
				}
				$(".uploadedList").append(str);
			}
		}); 
	});
	
/*------------------*/
/*  upload Cancel   */
/*------------------*/
 	$(".uploadedList").on("click", "small", function(event){
 		var that = $(this);
 		
 		$.ajax({
	 		url:"deleteFile",
	 		type:"post",
	 		data:{fileName:$(this).attr("data-src")},
	 		dataType:"text",
	 		success:function(result){
	 			if(result == 'deleted'){
	 				alert("deleted");
	 				that.parent("div").remove();
	 			}
	 		}
	 	});
	});
	
</script>

</body>

</html>

