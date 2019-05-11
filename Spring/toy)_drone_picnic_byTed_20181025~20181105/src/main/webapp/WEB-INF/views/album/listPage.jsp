<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../include/header.jsp"%>

<link href="/resources/css/AdminLTE.css" rel="stylesheet">
<script src="/resources/js/place.js"></script>
<script src="/resources/js/upload.js"></script>


<style>
.bg-red { background-color: var(--red) }
</style>


<!-- lightbox-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.2.0/ekko-lightbox.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.2.0/ekko-lightbox.min.js"></script>

<script>
$(document).on("click", '[data-toggle="lightbox"]', function(event) {
     event.preventDefault();
     $(this).ekkoLightbox();
   });
   
</script>

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
<div class="col-lg-8 col-md-10 mx-auto"><!-- col-lg-8 -->

<!-- general form elements -->
<div class='box'>
	<div class="box-header with-border">
		<h3 class="box-title">앨범</h3>
	</div>
	<div class='box-body'>
	<select name="searchType">
		<option value="all"
			<c:out value="${cri.searchType eq 'all'?'selected':''}"/>>
			전체</option>
		<option value="adrone"
			<c:out value="${cri.searchType eq 'adrone'?'selected':''}"/>>
			드론</option>
		<option value="acate"
			<c:out value="${cri.searchType eq 'acate'?'selected':''}"/>>
			유형</option>
		<option value="uid"
			<c:out value="${cri.searchType eq 'uid'?'selected':''}"/>>
			촬영자</option>
	</select>
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
		<button id='btnSearch'>검색</button>
		<button id='btnRegister'>글 등록</button>
		
		<span onclick="album_list_to_grid_change()"> <i class="fas fa-th-large"></i> </span>
		<span onclick="album_grid_to_list_change()"> <i class="fas fa-list-ul"></i> </span>
		
	</div>
</div>
	

<div class="content">
<div id="album_grid" >
	<div class="container">
		<div class="row">
			<c:forEach items="${list}" var="vo" varStatus="status">
		  	<div class="col-lg-3 col-md-4 col-xs-6">
		  		<div class="img_wrap">
			  		<a id="img_${status.index}" href="" data-toggle="lightbox" data-gallery="gallery" class="col-md-4">
			           	<img class="img-thumbnail" id="img_thumb_${status.index}"  style="height:200px !important" src="" alt="">
		           	</a>
		           	<div style="text-align:center;"> 
					<a href='/album/readPage.al${pageMaker.makeSearch(pageMaker.cri.page) }&ano=${vo.ano}'>
					${vo.ano} || ${vo.pname} <strong> [ ${vo.replycnt} ]</strong>
					</a>
					<div>photo by <strong>${vo.uid}</strong> </div>
					<div>with <strong>${vo.adrone}</strong> </div>
					<div>at <strong>${vo.acate}</strong> </div>
	           		<div><fmt:formatDate pattern="yy-MM-dd" value="${vo.regdate}" /></div>
		        	</div>
	        	</div>
       		</div>
       		<script>
				var full_img_link = thumb_to_full_img('${vo.fullName}', "album");
				document.getElementById('img_thumb_${status.index}').src = full_img_link;
				$("#img_${status.index}").attr("href", full_img_link);
			</script>	
			</c:forEach>	
			<hr/>

		</div>
	</div>
</div>

<hr/>

<div id="album_list" style="display:none">
	<div class="box-body" >
		<table class="table table-bordered">
			<tr>
				<th style="width: 10px">번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>드론</th>
				<th>유형</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
			<c:forEach items="${list}" var="vo" varStatus="status">
			<tr>				
				<td>${vo.ano} </td>				
				<td>
					<a href='/album/readPage.al${pageMaker.makeSearch(pageMaker.cri.page) }&ano=${vo.ano}'>
						${vo.pname} <strong> [ ${vo.replycnt} ]</strong>
					</a>
				</td>
				<td>${vo.uid}</td>
				<td>${vo.adrone}</td>
				<td>${vo.acate}</td>
				<td><fmt:formatDate pattern="yy-MM-dd HH:mm"
						value="${vo.regdate}" /></td>
				<td><span class="badge bg-red">${vo.viewcnt }</span></td>
			</tr>
			</c:forEach>
		</table>
	</div><!-- /box-body -->
</div>

<script>
//button
function album_list_to_grid_change() {
    var x = document.getElementById("album_grid");
    var y = document.getElementById("album_list");
    x.style.display = "block";
    y.style.display = "none";
}
function album_grid_to_list_change() {
    var x = document.getElementById("album_grid");
    var y = document.getElementById("album_list");
    x.style.display = "none";
    y.style.display = "block";
}
</script>

	<div class="box-footer">
		<div class="text-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination col-md-6 mx-auto">
				<c:if test="${pageMaker.prev}">
				<li class="page-item">
					<a class="page-link" aria-label="Previous" href="listPage.al${pageMaker.makeSearch(pageMaker.startPage - 1) }">
						<span aria-hidden="true">&laquo;</span>
				        <span class="sr-only">Previous</span>
			        </a>
		        </li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">
				<li class="page-item <c:out value="${pageMaker.cri.page == idx ? 'active':''}"/> ">
					<a class="page-link" href="listPage.al${pageMaker.makeSearch(idx)}">${idx}</a>
				</li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class="page-item" aria-label="Next">
						<a class="page-link" href="listPage.al${pageMaker.makeSearch(pageMaker.endPage +1) }">
						    <span aria-hidden="true">&raquo;</span>
     						<span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>
		</div>

	</div>	<!-- /.alx-footer-->
</div>

</div> <!-- container -->
</div> <!-- row -->
</div> <!--col-md-12-->

<%@include file="../include/footer.jsp"%>

<script>
$(document).ready(function() {
	$('#btnSearch').on("click", function(event) {
		self.location = "listPage.al"
			+ '${pageMaker.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keywordInput').val();
	});

	$('#btnRegister').on("click", function(event) {
		self.location = "registerPage.al";
	});
});
</script>