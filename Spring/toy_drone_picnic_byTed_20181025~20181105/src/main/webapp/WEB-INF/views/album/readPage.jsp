<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

<link href="/resources/css/AdminLTE.css" rel="stylesheet">
<link href="/resources/css/album.css" rel="stylesheet">

<script src="/resources/js/place.js"></script>
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
			formObj.attr("action", "/album/modifyPage.al");
			formObj.attr("method", "get");
			formObj.submit();
		});
		$(".btnDelete").on("click", function() {
			formObj.attr("action", "/album/removePage.al");
			formObj.submit();
		});
		$(".btnListPage").on("click", function() {
			formObj.attr("method", "get"); //passing down attributes since it's a get
			formObj.attr("action", "/album/listPage.al");
			formObj.submit();
		});
	});

	var ano = ${vo.ano}; // indicating specific board# for the reply
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


<div class="row">
<div class="col-md-6 mx-auto">
<!-- album header -->
<div class="album_header">
	<div class="row">  
	
	<div class="col-sm-6">
		<div class="album_header_left" style="border: 1px black solid; width:100%; height:auto;">   	
	        <div class="row">
				<div class="col-sm-6">
			 		<img src="https://www.offthegridnews.com/wp-content/uploads/2016/04/dji-phantom-vision-2-plus-djiDOTcom.jpg"
			 	 		style="max-height: 100px; max-width: 100px;"  />
	 	 		</div><!-- col -->
	 	 		<div class="col-sm-6">
			 	 	<div>${vo.pname}</div>
					<div>by <strong>${vo.uid}</strong></div>   
				</div><!-- col -->
			</div>		
   		</div>
   	</div> <!--col-->    
   	
    <div class="col-sm-6">
	    <div class="album_header_right" style="border: 1px black solid; width:100%; height:auto;">
			<div>조회수 [${vo.viewcnt}]</div>
			<div>${vo.uid}</div>
	    </div>
	</div> <!--col-->
	
	</div><!-- row -->
	<div class="row">
		<div class="col-md-8 mx-auto">
		</div>
	</div>
</div><!--header -->

<!-- carousel -->
<div id="albumCarousel" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
  <c:forEach items="${attach}" var="attach" varStatus="status">
  	  <c:if test="${status.index == 0}">
 	 	 <li data-target="albumCarousel" data-slide-to="${status.index}" class="active"></li>  	<!-- 1개는 active 필요 -->
	  </c:if>
	  <c:if test="${status.index != 0}">
	  	<li data-target="albumCarousel" data-slide-to="${status.index}"></li>
  	  </c:if>
   </c:forEach>
  </ol>
  
  <div class="carousel-inner" role="listbox">
  	<c:forEach items="${attach}" var="attach" varStatus="status">
  	  	<c:if test="${status.index == 0}">
			<div class="carousel-item active">	<!-- 1개는 active 필요 -->
	  	</c:if>
	  	<c:if test="${status.index != 0}">
	     	<div class="carousel-item">
    	</c:if>
      		<img class="slide" id="img_thumb_${status.index}" src="" alt="slide_${status.index}">
    	</div>
   		<script>   		
			var full_img_link = thumb_to_full_img('${attach}', "album");
			document.getElementById('img_thumb_${status.index}').src = full_img_link;
		</script>	
    </c:forEach>    
  </div>
  
  <a class="carousel-control-prev" href="#albumCarousel" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#albumCarousel" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

</div><!-- col-md -->
</div><!-- row -->


<div class="contatiner">
<div class="row">
<div class="col-lg-6 col-md-8 mx-auto">	<!-- col-lg -->

<br/>
<!-- album_content -->
<div class="album_content">
	<div class="row">	
		<!-- map -->
		<div class="col-md-6">		
			<div class="map" style="height: 400px; width: 400px;">
				<img id="thumbnail_map" src="" alt="thumbnmail_map">
			</div>
		</div>
		<script>
		document.getElementById('thumbnail_map').src 
				= img_src('${vo.pco_x}','${vo.pco_y}',380,380);
		</script>
		
		<!-- description -->
		<div class="col-md-6">			
			<table class="table table-hover">
			    <tr>
			      <th>DATE</th>
			      <td><fmt:formatDate pattern="yy-MM-dd" value="${vo.regdate}" /></td>
			    </tr>
			    <tr>
			      <th>DRONE</th>
			      <td>${vo.adrone}</td>
			    </tr>
			    <tr>
			      <th>PLACE</th>
			      <td>${vo.padd}</td>
			    </tr>
			    <tr>
			      <th>CATEGORY</th>
			      <td>${vo.acate}</td>
			    </tr>
			</table>			
			<br/>			
			<div>   
			    <textarea class="form-control" style="font-size:20px;" rows=3 readonly>
			    	${vo.pdesc}
			    </textarea>
			</div>
					
		</div>			
	</div> <!-- row -->			
</div>

<script>
var full_img_link = thumb_to_full_img('${vo.fullname}', "album");
$("#img").attr("href", full_img_link);
</script>		

<div class="board-content-footer">
		<form role="form" action="modifyPage.al" method="post">
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
</div>

</div><!-- col-md -->
</div><!-- row -->
	
<%@include file="../album/readPage_reply.jsp"%>

<%@include file="../include/footer.jsp"%>
