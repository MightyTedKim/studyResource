<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<link href="/resources/css/AdminLTE.css" rel="stylesheet">
<link href="/resources/css/board.css" rel="stylesheet">

<script type="text/javascript" src="/resources/js/board-upload.js"></script>
<script src="/resources/js/board_reply.js"></script>


<!-- lightbox-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.2.0/ekko-lightbox.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.2.0/ekko-lightbox.min.js"></script>

<script>
$(document).on("click", '[data-toggle="lightbox"]', function(event) {
     event.preventDefault();
     $(this).ekkoLightbox();
   });
</script>

<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		console.log(formObj);
		$(".btnModify").on("click", function() {
			formObj.attr("action", "/board/modifyPage.bo");
			formObj.attr("method", "get");
			formObj.submit();
		});
		$(".btnDelete").on("click", function() {
			formObj.attr("action", "/board/removePage.bo");
			formObj.submit();
		});
		$(".btnListPage").on("click", function() {
			formObj.attr("method", "get"); //passing down attributes since it's a get
			formObj.attr("action", "/board/listPage.bo");
			formObj.submit();
		});
	});

	var bno = ${boardVO.bno}; // indicating specific board# for the reply
	var replyPage = 1; // has to start with page 1 at first
</script>


<!-- Page Header -->
<header class="masthead"
	style="background-image: url('/resources/img/contact-bg.jpg')">
	<div class="overlay"></div>
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
				<div style="height: 60px;"></div>
			</div>
		</div>
	</div>
</header>

<div class="contatiner">
<div class="row">
<div class="col-lg-4 col-md-6 mx-auto">	<!-- col-lg -->
	<h3>READ BOARD</h3>
	<div class="board">
		<div class="board-content">
			<div class="board-content-header"></div><!-- board-content-header -->
			<div class="board-content-body"><!-- pagination hidden -->
				<form role="form" action="modifyPage.bo" method="post">
					<input type='hidden' name='bno' value="${boardVO.bno}"> <input
						type='hidden' name='page' value="${cri.page}"> <input
						type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">
				</form>

				<div class="form-group">
					<label for="exampleInputEmail1">Title</label> <input type="text"
						name='title' class="form-control" value="${boardVO.title}"
						readonly="readonly">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">Content</label>
					<textarea class="form-control" name="content" rows="3"
						readonly="readonly">${boardVO.content}</textarea>
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Writer</label> <input
						type="text" name="writer" class="form-control"
						value="${boardVO.writer}" readonly="readonly">
				</div>


				<div class="board-content-attach">
					<ul class="mailbox-attachments clearfix uploadedList"></ul>
				</div>

			</div>
			<!-- board-content-body -->
			<div class="board-content-footer">
				<c:if test="${login.uid == boardVO.writer}">
					<span class="board-btn-login-match">
						<button type="submit" class="btn btn-warning btnModify">Modify</button>
						<button type="submit" class="btn btn-danger btnDelete">REMOVE</button>
					</span>
				</c:if>
				<span class="board-btn-login-default">
					<button type="submit" class="btn btn-primary btnListPage">GO
						LIST</button>
				</span>
				<c:if test="${empty login}">
					<div class="board-btn-login-null">
						<a
							href="javascript:javascript:self.location ='/user/page_login';">Login
							Please</a>
					</div>
				</c:if>
			</div>
			<!-- board-content-footer -->
		</div>
		<!-- board-content -->
	</div>
	</div>
</div>
</div>
	
<%@include file="../board/readPage_reply.jsp"%>
<%@include file="../include/footer.jsp"%>
