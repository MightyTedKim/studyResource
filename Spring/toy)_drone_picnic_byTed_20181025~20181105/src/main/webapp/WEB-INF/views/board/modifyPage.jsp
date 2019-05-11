<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<link href="/resources/css/board.css" rel="stylesheet">    
<link href="/resources/css/AdminLTE.css" rel="stylesheet">    


<!-- Page Header -->
<header class="masthead" style="background-image: url('/resources/img/contact-bg.jpg')">
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
      	<div style="height: 60px;"></div>
      </div>
    </div>
  </div>
</header>

<div class="contatiner"><!-- container -->
<div class="row"><!-- row -->
<div class="col-lg-4 col-md-6 mx-auto">	<!-- col-lg -->
	<h3>MODIFY BOARD</h3>
	<div class="board">
	<div class="board-content">
		<div class="board-content-header"></div><!-- board-content-header -->
		<div class="board-content-body"><!-- pagination hidden -->
			<form role="form" action="modifyPage.bo" method="post">
				<input type='hidden' name='page' value="${cri.page}"> 
				<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
				<input type='hidden' name='searchType' value="${cri.searchType}">
				<input type='hidden' name='keyword' value="${cri.keyword}">
				
				<div class="form-group">
					<label for="exampleInputEmail1">BNO</label> <input type="text"
						name='bno' class="form-control" value="${boardVO.bno}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Title</label> <input type="text"
						name='title' class="form-control" value="${boardVO.title}">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">Content</label>
					<textarea class="form-control" name="content" rows="3">${boardVO.content}</textarea>
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Writer</label> <input
						type="text" name="writer" class="form-control"
						value="${boardVO.writer}">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">File Drop Here</label>
					<i class="fa fa-fw fa-remove"></i>
					<div class="fileDrop"></div>
				</div>
				<ul class="mailbox-attachments clearfix uploadedList"></ul>			
					<button type="submit" class="btn btn-primary btnSave">SAVE</button>
					<button type="submit" class="btn btn-warning btnCancel">CANCEL</button>	
			</form>
		</div>
	</div>	
			
	<div class="board-content-footer"></div> <!-- board-content-footer -->
</div> <!-- <!-- board-content -->

</div> <!-- col-md-8 -->
</div> <!-- row -->
</div> <!-- conatiner -->

<style>
.fileDrop {
  width: 80%;
  height: 100px;
  border: 1px dotted gray;
  background-color: lightslategrey;
  margin: auto; 
}
</style>

<script type="text/javascript" src="/resources/js/board-upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="template" type="text/x-handlebars-template">
	<li>
		<span class="mailbox-attachment-icon has-img">
			<img src="{{imgsrc}}" alt="Attachment">
		</span>
		<div class="mailbox-attachment-info">
			<a href ="{{getLink}}" class="mailbox-attachment-name">
				{{fileName}}
			</a>
			<a href ="{{fullName}}" class="btn-default btn-xs pull-right delbtn">
				<i class="far fa-times-circle"></i>
			</a>
		</div>
	</li>		
</script>

<script>
$(document).ready(function() {
	var formObj = $("form[role='form']");
	console.log(formObj);
	//submit
	formObj.submit(function(event){
		event.preventDefault();
		var that = $(this);
		var str = "";
		
		$(".uploadedList .delbtn").each(function(index){
			str += "<input type='hidden' name='files[" + index + "]' value='" 
			+ $(this).attr("href") + "'>";
		});
		
		that.append(str);
		that.get(0).submit();	
	});
	
	$(".btnCancel").on("click", function(){
		alert(".btnCancel")
		  self.location = "/listPage.bo?page=${cri.page}&perPageNum=${cri.perPageNum}"+
				  "&searchType=${cri.searchType}&keyword=${cri.keyword}";
	});	
	
	
});
</script>

<script>
var template = Handlebars.compile($("#template").html());

$(".fileDrop").on("dragenter dragover", function(event){
	event.preventDefault();
});

$(".fileDrop").on("drop", function(event){
	event.preventDefault();
	var files = event.originalEvent.dataTransfer.files;
	var file = files[0];
	console.log("file=" + file);

	var formData = new FormData();
	formData.append("file", file);
	console.log("formData=" + formData);
	$.ajax({
		  url: '/board/uploadAjax.bo',
		  data: formData,
		  dataType:'text',
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  success: function(data){			  
			  var fileInfo = getFileInfo(data);
			  var html = template(fileInfo);
			  $(".uploadedList").append(html);
		  }
		});	
});

$(".uploadedList").on("click", ".delbtn", function(event){
	event.preventDefault();	
	var that = $(this);
	 
	$.ajax({
	   url:"/deleteFile.bo",
	   type:"post",
	   data: {fileName:$(this).attr("href")},
	   dataType:"text",
	   success:function(result){
		   if(result == 'deleted'){
			   that.closest("li").remove();
		   }
	   }
   });
});

var bno = ${boardVO.bno};
var template = Handlebars.compile($("#template").html());

$.getJSON("/board/getAttach.bo/"+bno,function(list){
	$(list).each(function(){
		var fileInfo = getFileInfo(this);	
		var html = template(fileInfo);
		 $(".uploadedList").append(html);
		
	});
});

$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
	var fileLink = $(this).attr("href");	
	if(checkImageType(fileLink)){		
		event.preventDefault();
		var imgTag = $("#popup_img");
		imgTag.attr("src", fileLink);		
		console.log(imgTag.attr("src"));
		
		$(".popup").show('slow');
		imgTag.addClass("show");		
	}	
});

$("#popup_img").on("click", function(){
	$(".popup").hide('slow');
});	
</script>

<%@include file="../include/footer.jsp"%>
