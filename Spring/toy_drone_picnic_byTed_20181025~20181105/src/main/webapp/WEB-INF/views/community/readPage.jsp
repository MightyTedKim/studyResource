<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
<link href="/resources/css/AdminLTE.css" rel="stylesheet">

<script src="/resources/js/board_reply.js"></script>
<script src="/resources/js/place.js"></script>

<link href="/resources/css/community.css">
<script src="/resources/js/upload.js"></script>


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
		$(".btnModify").on("click", function() {
			formObj.attr("action", "/community/modifyPage.co");
			formObj.attr("method", "get");
			formObj.submit();
		});
		$(".btnDelete").on("click", function() {
			formObj.attr("action", "/community/removePage.co");
			formObj.submit();
		});
		$(".btnListPage").on("click", function() {
			formObj.attr("method", "get"); //passing down attributes since it's a get
			formObj.attr("action", "/community/listPage.co");
			formObj.submit();
		});
	});

	var cno = ${vo.cno}; // indicating specific board# for the reply
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
<div class="col-lg-6 col-md-8 mx-auto">	<!-- col-lg -->

<div class="row mt-1 mb-1 pt-5" id="communityMainImg"
	style="background-size: cover; background-position: center; ">
	<div class="col-lg-12 line_color_yellow_b text_align_center mb-5">
		<p class="small_logo text_border">${vo.cname}</p>
		<p class="korean_center text_border">${vo.cdesc}</p>
	</div>
</div>
		
<script>
	var full_img_link = thumb_to_full_img('<c:out value="${attach[0]}" />', "community");
	document.getElementById("communityMainImg").style.backgroundImage
		= 'url(' + full_img_link + ')';
</script>	
<br/>
<!-- community header -->
<div class="community_header">
	<c:if test="${empty login}">
		<div class="board-btn-login-null">
			<a href="javascript:javascript:self.location ='/user/page_login';">
				Login Please
			</a>
		</div>
	</c:if>
	
	
	<div class="korean_center">
		<a href="/community/joinCommunity.co?cname=${vo.cname}&uid=${login.uid}">소모임 가입하기</a>
	</div>
	<div class="korean_center">
		<span>조회수 = ${vo.viewcnt}</span>&nbsp;
		<span>모임지기 = ${vo.uid}</span>
	</div>
</div><!--header -->

<!-- community -->
<div class="community_content">
	<div class="row">	
		<div class="col-md-6">
		1
		</div>
		
		<div class="col-md-6">
		2	
		</div>			
	</div> <!-- row -->			
</div>

<div class="board-content-footer">
	<form role="form" action="modifyPage.co" method="post">
			<input type='hidden' name='ano' value="${vo.ano}"> 
			<input type='hidden' name='page' value="${cri.page}">
			<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
			<input type='hidden' name='searchType' value="${cri.searchType}">
			<input type='hidden' name='keyword' value="${cri.keyword}">
	</form>		
	<c:if test="${login.uid == vo.uid}">
		<span class="board-btn-login-match">
			<button type="submit" class="btn btn-warning btnModify">Modify</button>
			<button type="submit" class="btn btn-danger btnDelete">REMOVE</button>
		</span>
	</c:if>
	<span class="board-btn-login-default">
		<button type="submit" class="btn btn-primary btnListPage">
			GO LIST
		</button>
	</span>
	<c:if test="${empty login}">
		<div class="board-btn-login-null">
			<a href="javascript:javascript:self.location ='/user/page_login';">
				Login Please
			</a>
		</div>
	</c:if>
</div><!-- board-content-footer -->

</div><!-- col-md -->
</div><!-- row -->
	
<%@include file="../community/readPage_reply.jsp"%>

<%@include file="../include/footer.jsp"%>
