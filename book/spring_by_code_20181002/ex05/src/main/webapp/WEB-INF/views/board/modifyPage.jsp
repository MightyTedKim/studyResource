<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<script type="text/javascript" src="/resources/dist/js/upload.js"></script>

<style>
.fileDrop {
  width: 80%;
  height: 100px;
  border: 1px dotted gray;
  background-color: lightslategrey;
  margin: auto;
  
}
</style>

<!-- Main content -->
<section class="content">
<div class="row">
<div class="col-lg-4 col-md-6 mx-auto">

<div class="box">
	<div class="box-header">
		<h3 class="box-title">MODIFY BOARD</h3>
	</div> <!-- /.box-header -->

<form role="form" action="modifyPage" method="post">
	<input type='hidden' name='page' value="${cri.page}"> 
	<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
	<input type='hidden' name='searchType' value="${cri.searchType}">
	<input type='hidden' name='keyword' value="${cri.keyword}">

	<div class="box-body">

		<div class="form-group">
			<label for="exampleInputEmail1">BNO</label> <input type="text"
				name='bno' class="form-control" value="${boardVO.bno}"
				readonly="readonly">
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
			<div class="fileDrop"></div>
		</div>		
	</div> <!-- /.box-body -->

	<div class="box-footer">
		<ul class="mailbox-attachments clearfix uploadedList"></ul>	
		<button type="submit" class="btn btn-primary btnSave">SAVE</button>
		<button type="submit" class="btn btn-warning btnCancel">CANCEL</button>
	</div> <!-- /.box-footer -->
</form>

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
		  self.location = "/board/listPage?page=${cri.page}&perPageNum=${cri.perPageNum}"+
				  "&searchType=${cri.searchType}&keyword=${cri.keyword}";
	});	
});
</script>


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

$(".fileDrop").on("dragenter dragover", function(event){
	event.preventDefault();
});

$(".fileDrop").on("drop", function(event){
	event.preventDefault();
	var files = event.originalEvent.dataTransfer.files;
	var file = files[0];
	
	var formData = new FormData();
	formData.append("file", file);
	console.log("formData=" + formData);
	$.ajax({
		  url: '/uploadAjax',
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
	   url:"/deleteFile",
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

$.getJSON("/board/getAttach/"+bno,function(list){
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
				
		$(".popup").show('slow');
		imgTag.addClass("show");		
	}	
});

$("#popup_img").on("click", function(){
	$(".popup").hide('slow');
});	
</script>


</div><!-- /.box -->
</div><!--/.col (left) -->


</div><!-- /.row -->
</section><!-- /.content -->

<%@include file="../include/footer.jsp"%>
