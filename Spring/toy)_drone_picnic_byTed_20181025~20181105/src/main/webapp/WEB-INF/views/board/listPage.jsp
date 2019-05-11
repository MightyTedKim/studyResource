<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../include/header.jsp"%>

<link href="/resources/css/board.css" rel="stylesheet">    
<link href="/resources/css/AdminLTE.css" rel="stylesheet">    

<style>
.bg-red { background-color: var(--red) }
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
		<h3 class="box-title">게시판</h3>
	</div>
	<div class='box-body'>
	<select name="searchType">
		<option value=""
			<c:out value="${cri.searchType == null?'selected':''}"/>>
			---</option>
		<option value="t"
			<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
			제목</option>
		<option value="c"
			<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
			내용</option>
		<option value="w"
			<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
			글쓴이</option>
		<option value="tc"
			<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
			제목 또는 내용</option>
		<option value="cw"
			<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
			내용 또는 글쓴이</option>
		<option value="tcw"
			<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
			전체</option>
	</select>
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
		<button id='btnSearch'>검색</button>
		<button id='btnRegister'>글 등록</button>
	</div>
</div>

<div class="box">
<!--<div class="box-header with-border">
		<h3 class="box-title">게시판</h3>
	</div> -->
	<br/>
	<div class="box-body" style="text-align: center;">
		<table class="table table-bordered">
			<tr>
				<th style="width: 10px">번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>

			<c:forEach items="${list}" var="boardVO">
			<tr>
				<td>${boardVO.bno}</td>
				<td><a
					href='/board/readPage.bo${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${boardVO.bno}'>
						${boardVO.title} 
						<strong> [ ${boardVO.replycnt} ]</strong>
					</a></td>
				<td>${boardVO.writer}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
						value="${boardVO.regdate}" /></td>
				<td><span class="badge bg-red">${boardVO.viewcnt }</span></td>
			</tr>
			</c:forEach>
		</table>
	</div><!-- /.box-body -->

	<div class="box-footer">
		<div class="text-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination col-md-6 mx-auto">
				<c:if test="${pageMaker.prev}">
				<li class="page-item">
					<a class="page-link" aria-label="Previous" href="listPage.bo${pageMaker.makeSearch(pageMaker.startPage - 1) }">
						<span aria-hidden="true">&laquo;</span>
				        <span class="sr-only">Previous</span>
			        </a>
		        </li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">
				<li class="page-item <c:out value="${pageMaker.cri.page == idx ? 'active':''}"/> ">
					<a class="page-link" href="listPage.bo${pageMaker.makeSearch(idx)}">${idx}</a>
				</li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class="page-item" aria-label="Next">
						<a class="page-link" href="listPage.bo${pageMaker.makeSearch(pageMaker.endPage +1) }">
						    <span aria-hidden="true">&raquo;</span>
     						<span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>
		</div>

	</div>	<!-- /.box-footer-->
</div>

</div> <!-- container -->
</div> <!-- row -->
</div> <!--col-md-12-->

<%@include file="../include/footer.jsp"%>

<script>
	var result = '${msg}';

	if (result == 'SUCCESS') {
		alert("처리가 완료되었습니다.");
	}
</script>

<script>
$(document).ready(function() {
	$('#btnSearch').on("click", function(event) {
		self.location = "listPage.bo"
			+ '${pageMaker.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keywordInput').val();
	});

	$('#btnRegister').on("click", function(event) {
		self.location = "registerPage.bo";
	});
});
</script>

