<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<!-- Main content -->
	<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
 	
 	<!-- BoardVO, title/content/writer -->
	<div class="box-header">
		<h3 class="box-title">READ BOARD</h3>
	</div><!-- /.box-header -->
	<!-- pagination hidden -->
	<form role="form" action="modifyPage" method="post">
		<input type='hidden' name='bno' value ="${boardVO.bno}">
		<input type='hidden' name='page' value ="${cri.page}">
		<input type='hidden' name='perPageNum' value ="${cri.perPageNum}">    
		
		<input type='hidden' name='searchType' value="${cri.searchType}">
		<input type='hidden' name='keyword' value="${cri.keyword}">
	</form>   	
	
	<div class="box-body">
	  <div class="form-group">
	    <label for="exampleInputEmail1">Title</label>
	    <input type="text" name='title' class="form-control" 
	       value="${boardVO.title}" readonly="readonly">
	  </div>
	  <div class="form-group">
	    <label for="exampleInputPassword1">Content</label>
	    <textarea class="form-control"  name="content" rows="3" 
	    readonly="readonly">${boardVO.content}</textarea>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputEmail1" >Writer</label>
	    <input type="text" name="writer" class="form-control" 
	      value="${boardVO.writer}" readonly="readonly">
	  </div>
	</div><!-- /.box-body -->
	
	<div class="box-footer">
	  <button type="submit" class="btn btn-warning btnModify">Modify</button>
	  <button type="submit" class="btn btn-danger btnDelete">REMOVE</button>
	  <button type="submit" class="btn btn-primary btnListPage">GO LIST </button>
	</div><!-- /.box-footer -->


	<!-- BoardVO, title/content/writer -->
	<div class="row">
		<div class="col-md-12">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				<div class="box-body">
					<label for="exampleInputEmail1">Writer</label> <input
						class="form-control" type="text" placeholder="USER ID"
						id="newReplyWriter"> <label for="exampleInputEmail1">Reply
						Text</label> <input class="form-control" type="text"
						placeholder="REPLY TEXT" id="newReplyText">

				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="button" class="btn btn-primary" id="replyAddBtn">ADD
						REPLY</button>
				</div>
			</div>

			<!-- The time line -->
			<ul class="timeline">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv"><span class="bg-green">
						Replies List </span></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>

		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->


<script>
$(document).ready(function(){
	
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	$(".btnModify").on("click", function(){
		formObj.attr("action", "/board/modifyPage");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	
	$(".btnDelete").on("click", function(){
		formObj.attr("action", "/board/removePage");
		formObj.submit();
	});
	
	$(".btnListPage").on("click", function(){
		formObj.attr("method", "get"); //passing down attributes since it's a get
		formObj.attr("action", "/board/listPage");
		formObj.submit();
	});
	
});
</script>

<!-- Modal -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body" data-rno>
        <p><input type="text" id="replytext" class="form-control"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
        <button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>      
	
	
</section> <!-- /.content -->

<!-- --------- -->
<!-- handlbars -->
<!-- --------- -->
<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}}>
<i class="fa fa-comments bg-blue"></i>
 <div class="timeline-item" >
  <span class="time">
    <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
  </span>
  <h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
  <div class="timeline-body">{{replytext}} </div>
    <div class="timeline-footer">
     <a class="btn btn-primary btn-xs" 
	    data-toggle="modal" data-target="#modifyModal">Modify</a>
    </div>
  </div>			
</li>
{{/each}}
</script>

<script>
/* ------------------------------- */
/* handlebar for date/ replyList   */
/* ------------------------------ */
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	var printData = function(replyArr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr);
		$(".replyLi").remove(); //remove existing replyLi
		target.after(html); // and add the new replyLi to the tag 

	}

/* ------------------- */
/* reply Pagination   */
/* ------------------ */

	var bno = ${boardVO.bno}; // indicating specific board# for the reply
	var replyPage = 1; // has to start with page 1 at first

	function getPage(pageInfo) { //int pageInfo
		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template')); // reply list
			printPaging(data.pageMaker, $(".pagination"));// reply pagination
			$("#modifyModal").modal('hide'); // hide modify modal
		});
	}

	var printPaging = function(pageMaker, target) { //reply list
		// pageMaker : prev, startPage, endPage, next
		// target : specific html tag where list goes in
		var str = "";
		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}
		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}
		target.html(str);
	};

	$("#repliesDiv").on("click", function() {
		//show reply list on click
		if ($(".timeline li").size() > 1) {
			return;
		}
		getPage("/replies/" + bno + "/1"); // should be first page among the existing list
	});
	
	$(".pagination").on("click", "li a", function(event){
		// show another pageList on reply pagination click
		event.preventDefault();
		replyPage = $(this).attr("href"); //fetching repltPage info of li a tag
		getPage("/replies/"+bno+"/"+replyPage);		
	});
	
	$("#replyAddBtn").on("click",function(){	 
		//adding reply on click
		 var replyerObj = $("#newReplyWriter");
		 var replytextObj = $("#newReplyText");
		 var replyer = replyerObj.val();
		 var replytext = replytextObj.val();
		  //use post to add
		  $.ajax({
				type:'post',
				url:'/replies/',
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "POST" },
				dataType:'text',
				data: JSON.stringify({bno:bno, replyer:replyer, replytext:replytext}),
				success:function(result){//returning results from server as a string
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						replyPage = 1;
						getPage("/replies/"+bno+"/"+replyPage ); //pagination and list
						replyerObj.val(""); //initiatlizing as a blank
						replytextObj.val("");
					}
			}});
	});

	$(".timeline").on("click", ".replyLi", function(event){
		// rno and replytext needs to be inserted into the modal 
		var reply = $(this); // bring object of replyLi
		$("#replytext").val(reply.find('.timeline-body').text()); //replytext to modal replytext
		$(".modal-title").html(reply.attr("data-rno")); // rno to modal-title
	});	

	$("#replyModBtn").on("click",function(){
		//fetch title and replytext
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
		//use put to modify  
		  $.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "PUT" },
				data:JSON.stringify({replytext:replytext}), 
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});

	$("#replyDelBtn").on("click",function(){
		    //fetch title and replytext
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
			//use put to delete  
		  $.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "DELETE" },
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
	});
	
</script>
 
        </div><!-- /.box -->
      </div><!--/.col (left) -->
 
      </div>   <!-- /.row -->
    </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
    
<%@include file="../include/footer.jsp" %>
  