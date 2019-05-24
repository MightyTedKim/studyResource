<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../include/header.jsp"%>

<link href="/resources/css/AdminLTE.css">
<link href="/resources/css/community.css">
<script src="/resources/js/upload.js"></script>


<style>
.bg-red { background-color: var(--red) }
.white-bg{
background-color: rgba(255,255,255, 0.5) !important;
    left: 0%;
    right: 0%;
}
</style>

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
		<h3 class="box-title">소모임 목록</h3>
	</div>
	<div>
		<button id='btnRegister'>소모임 등록</button>
	</div>
	<div class='box-body'>
	<select name="searchType">
		<option value="all"
			<c:out value="${cri.searchType eq 'all'?'selected':''}"/>>
			전체</option>
		<option value="cname"
			<c:out value="${cri.searchType eq 'acate'?'selected':''}"/>>
			모임 이름</option>
		<option value="uid"
			<c:out value="${cri.searchType eq 'uid'?'selected':''}"/>>
			모임 지기</option>
	</select>
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
		<button id='btnSearch'>검색</button>
		
		
		<span onclick="community_list_to_grid_change()"> <i class="fas fa-th-large"></i> </span>
		<span onclick="community_grid_to_list_change()"> <i class="fas fa-list-ul"></i> </span>
		
	</div>
</div>

<!-- carousel -->
<div id="communityCarousel" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
  <c:forEach items="${attach}" var="attach" varStatus="status">
  	  <c:if test="${status.index == 0}">
 	 	 <li data-target="communityCarousel" data-slide-to="${status.index}" class="active"></li>  	<!-- 1개는 active 필요 -->
	  </c:if>
	  <c:if test="${status.index != 0}">
	  	<li data-target="communityCarousel" data-slide-to="${status.index}"></li>
  	  </c:if>
   </c:forEach>
  </ol>
  
  <div class="carousel-inner" role="listbox">
  	<c:forEach items="${list}" var="vo" varStatus="status">
  	  	<c:if test="${status.index == 0}">
			<div class="carousel-item active">	<!-- 1개는 active 필요 -->	      
      		<img class="d-block w-100" id="img_thumb_carousel_${status.index}" src="" alt="slide_${status.index}" style="height:400px !important">
	    	<div class="container">
              <div class="carousel-caption text-center white-bg">
           	    <a href="community/readPage.co${pageMaker.makeSearch(pageMaker.cri.page) }&cno=${vo.cno}">
           	    	<h1>${vo.cname}</h1>
          	    </a>
               	<p class="text-truncate">${vo.cdesc}</p>
               	<p>
               		<a class="btn btn-xs btn-outline-primary"  
               			href="/community/readPage.co${pageMaker.makeSearch(pageMaker.cri.page) }&cno=${vo.cno}"  
               			role="button">모임 구경하기 </a>
            	</p>
              </div>
            </div>
           </div>  		
	  	</c:if>	  	
	  	<c:if test="${status.index != 0}">
	     	<div class="carousel-item">
      		<img class="d-block w-100" id="img_thumb_carousel_${status.index}" src="" alt="slide_${status.index}" style="height:400px !important">
	    	<div class="container">
              <div class="carousel-caption text-center white-bg">
           	    <a href="/community/readPage.co${pageMaker.makeSearch(pageMaker.cri.page) }&cno=${vo.cno}">
           	    	<h1>${vo.cname}</h1>
          	    </a>
               	<p class="text-truncate">${vo.cdesc}</p>
               	<p>
               		<a class="btn btn-xs btn-outline-primary"  
               			href="/community/readPage.co${pageMaker.makeSearch(pageMaker.cri.page) }&cno=${vo.cno}"  
               			role="button">모임 구경하기 </a>
            	</p>
              </div>
            </div>
           </div>  	
    	</c:if>	     	
          
  		<script>
			var full_img_link = thumb_to_full_img('${vo.fullName}', "community");
			document.getElementById('img_thumb_carousel_${status.index}').src = full_img_link;
			console.log('${vo.fullName}',"community");
			console.log(full_img_link);
		</script>	
    </c:forEach>    
  </div>
  
  <a class="carousel-control-prev" href="#communityCarousel" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#communityCarousel" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

<div class="content">
<div id="community_grid" style="display:none">
	<div class="container">
		<div class="row">
			<c:forEach items="${list}" var="vo" varStatus="status">
		  	<div class="col-lg-3 col-md-4 col-xs-6">
		  		<div class="img_wrap">
			  		<a id="img_${status.index}" href="#" class="col-md-4">
			           	<img class="img-thumbnail" id="img_thumb_${status.index}"  style="height:200px !important" src="" alt="">
		           	</a>
		           	<div style="text-align:center;"> 
						<a href='/community/readPage.co${pageMaker.makeSearch(pageMaker.cri.page) }&cno=${vo.cno}'>
						${vo.cno} || ${vo.cname} <strong> [ ${vo.replycnt} ]</strong>
						</a>
						<div> 모임지기 <strong>${vo.uid}</strong> </div>
		        	</div>
	        	</div>
       		</div>
       		<script>
				var full_img_link = thumb_to_full_img('${vo.fullName}', "community");
				document.getElementById('img_thumb_${status.index}').src = full_img_link;
			</script>	
			</c:forEach>	
			<hr/>

		</div>
	</div>
</div>

<hr/>

<div id="community_list" >
	<div class="box-body" >
		<table class="table table-bordered">
			<tr>
				<th style="width: 10px">번호</th>
				<th>제목</th>
				<th>모임 이름</th>
				<th>모임 지기</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
			<c:forEach items="${list}" var="vo" varStatus="status">
			<tr>				
				<td>${vo.cno} </td>				
				<td>
					<a href='/community/readPage.co${pageMaker.makeSearch(pageMaker.cri.page) }&cno=${vo.cno}'>
						${vo.cname} <strong> [ ${vo.replycnt} ]</strong>
					</a>
				</td>
				<td>${vo.cname}</td>
				<td>${vo.uid}</td>
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
function community_list_to_grid_change() {
    var x = document.getElementById("community_grid");
    var y = document.getElementById("community_list");
    x.style.display = "block";
    y.style.display = "none";
}
function community_grid_to_list_change() {
    var x = document.getElementById("community_grid");
    var y = document.getElementById("community_list");
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
					<a class="page-link" aria-label="Previous" href="listPage.co${pageMaker.makeSearch(pageMaker.startPage - 1) }">
						<span aria-hidden="true">&laquo;</span>
				        <span class="sr-only">Previous</span>
			        </a>
		        </li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">
				<li class="page-item <c:out value="${pageMaker.cri.page == idx ? 'active':''}"/> ">
					<a class="page-link" href="listPage.co${pageMaker.makeSearch(idx)}">${idx}</a>
				</li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class="page-item" aria-label="Next">
						<a class="page-link" href="listPage.co${pageMaker.makeSearch(pageMaker.endPage +1) }">
						    <span aria-hidden="true">&raquo;</span>
     						<span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>
		</div>

	</div>	<!-- footer-->
</div>

</div> <!-- container -->
</div> <!-- row -->
</div> <!--col-md-12-->

<%@include file="../include/footer.jsp"%>

<script>
$(document).ready(function() {
	$('#btnSearch').on("click", function(event) {
		self.location = "listPage.co"
			+ '${pageMaker.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keywordInput').val();
	});

	$('#btnRegister').on("click", function(event) {
		self.location = "registerPage.co";
	});
});
</script>