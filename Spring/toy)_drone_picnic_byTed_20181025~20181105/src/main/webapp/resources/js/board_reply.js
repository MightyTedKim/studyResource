$(document).ready(function(){
	var formObj = $("form[role='form']");
	console.log(formObj);	
	$(".btnModify").on("click", function(){
		formObj.attr("action", "/board/modifyPage.bo");
		formObj.attr("method", "get");		
		formObj.submit();
	});	
	$(".btnDelete").on("click", function(){
		formObj.attr("action", "/board/removePage.bo");
		formObj.submit();
	});	
	$(".btnListPage").on("click", function(){
		formObj.attr("method", "get"); //passing down attributes since it's a get
		formObj.attr("action", "/board/listPage.bo");
		formObj.submit();
	});	
});

//image modal popup show
$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
	var fileLink = $(this).attr("href");
	if(checkImageType(fileLink)){
		event.preventDefault();
		var imgTag = $("#popup_img");
		imgTag.attr("src", fileLink);
		console.log('imgTag.attr("src") = ' + imgTag.attr("src"));
		
		$("#popup_img").show('slow');
		imgTag.addClass("show");
	}
});
//image modal popup hide
$("#popup_img").on("click", function(){
	$(".popup").hide('slow');
});

//image remove
$("#removeBtn").on("click", function(event){
	var replyCnt = $("#replycntSmall").html().replace(/[^0-9]/g,"");//global search which is not #
	alert("replyCnt= " + replyCnt);
	if (replyCnt > 0) {
		alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
		return;
	}
	var arr = [];
	$(".uploadedList li").each(function(index){
		arr.push($(this).attr("data-src"));
	});
	if(arr.length > 0) {
		$.post("/deleteAllFiles.bo", {files:arr}, function(){
			// doesn't wait for success nor failure 
		});
	}
	formObj.attr("action", "/board/removePage.bo");
	formObj.submit();		
});