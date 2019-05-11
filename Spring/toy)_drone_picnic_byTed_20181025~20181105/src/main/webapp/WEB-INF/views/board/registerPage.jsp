<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
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
<div class="col-lg-8 col-md-10 mx-auto">	<!-- col-lg -->

<div class="box">
	<div class="box-header">
		<h3 class="box-title">REGISTER BOARD!!</h3>
	</div> <!-- /.box-header -->

<form id='registerForm' role="form" method="post">
	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label> 
			<input type="text" name='title' class="form-control" placeholder="Enter Title">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
		
		
	<textarea id='test' class="form-control" name="content" rows="3" placeholder="Enter content"></textarea>
	
<style>
.btn{
    padding: 0 !important;
}
</style>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.js"></script>
  
  <script>
    $(document).ready(function() {
   	 	$('#test').summernote({
   	        placeholder: 'Hello',
   	        tabsize: 2,
   	        height: 100
   	      });
    });
  </script>

		
		
		
		
		
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Writer</label> 
			<input type="text" class="form-control" name="writer" value="${login.uid}" readonly/>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">File Drop Here</label>
			<div class="fileDrop"></div>
		</div>
	</div>
	<!-- /.box-body -->

	<div class="box-footer">
		<ul class="mailbox-attachments clearfix uploadedList"></ul> 		
		<button type="submit" class="btn btn-primary">Submit</button>
	</div>
	
</form>
</div> <!-- box -->

</div> <!-- container -->
</div> <!-- row -->
</div> <!--col-md-12-->

<style>
.fileDrop{
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
			<a href ="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
				<i class="fa fa-fw fa-remove"></i>
			</a>
		</div>
	</li>		
</script>

<script>
	var template = Handlebars.compile($("#template").html());
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
			url: '/board/uploadAjax.bo',
			data: formData,
			dataType:'text',
			processData: false,
			contentType: false,
			type:'POST',
			success: function(data){
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);

				$(".uploadedList").append(html);
			}
		}); 
	});
	
	$("#registerForm").submit(function(event){
		event.preventDefault();
		var str = "";
	 	$(".uploadedList .delbtn").each(function(index){
			str += "<input type='hidden' name='files[" + index + "]' value='" +
				$(this).attr("href") + "'> ";
		});
	 	$(this).append(str);
	 	$(this).get(0).submit();
	}); 
	
	$(".uploadedList").on("click", ".delbtn" ,function(event){
		event.preventDefault();
		var that = $(this);
		alert("DELETE FILE");
		
		$.ajax({
			url:"/deleteFile.bo",
			type:"post",
			data: {fileName:$(this).attr("href")},
			dataType:"text",
			success:function(result){
				console.log("RESULT: " + result);
				if(result == 'deleted'){
					that.closest("li").remove();
				}
			}
		});
	});
</script>

<%@include file="../include/footer.jsp"%>
