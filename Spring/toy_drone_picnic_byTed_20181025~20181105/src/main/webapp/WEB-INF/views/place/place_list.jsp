<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.thumb_map_header{
	}
	.thumb_map_body{
	    font-size: 15px;
		font-weight: bold;
	}
	.thumb_map_footer{
	}
</style>

<script>
$(document).ready(function() {
	$('#btnSearch').on("click", function(event) {
		self.location = "place/listPage.pl"
			+ '${pageMaker.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keywordInput').val();
	});

	$('#btnPlaceList').on("click", function(event) {
		self.location = "/place_main.pl";
	});
});
</script>
<div class="row nopadding">   

<!-- general form elements -->
<div class='box'>
	<div class="box-header with-border">
		<h3 class="box-title">지도</h3>
		<select name="searchType">
			<option value="all"
				<c:out value="${cri.searchType eq 'all'?'selected':''}"/>>전체</option>
			<option value="pname"
				<c:out value="${cri.searchType eq 'pname'?'selected':''}"/>>제목</option>
			<option value="pdesc"
				<c:out value="${cri.searchType eq 'pdesc'?'selected':''}"/>>내용</option>
			<option value="pcate"
				<c:out value="${cri.searchType eq 'pcate'?'selected':''}"/>>유형</option>
		</select>
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
		<button id='btnPlaceList'>자세히 보기</button>
		
		<nav aria-label="Page navigation">
			<ul class="pagination center">
				<c:if test="${pageMaker.prev}">
				<li class="page-item">
					<a class="page-link" aria-label="Previous" href="listPage.pl${pageMaker.makeSearch(pageMaker.startPage - 1) }">
						<span aria-hidden="true">&laquo;</span>
				        <span class="sr-only">Previous</span>
			        </a>
		        </li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">
				<li class="page-item <c:out value="${pageMaker.cri.page == idx ? 'active':''}"/> ">
					<a class="page-link" href="listPage.pl${pageMaker.makeSearch(idx)}">${idx}</a>
				</li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li class="page-item" aria-label="Next">
						<a class="page-link" href="listPage.pl${pageMaker.makeSearch(pageMaker.endPage +1) }">
						    <span aria-hidden="true">&raquo;</span>
     						<span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav> <!-- pagination -->
	</div><!-- box header -->
	<br/>
	
	<div class="box-body" style="text-align: center;">
		<c:forEach items="${placeList}" var="vo" varStatus="status">
		<div class="row">
			<div class="col-md-5 nopadding">
			<div>
				<div id="thumbnail_wrap[${status.index}]" style="display:block" onclick="mapZoom('${vo.getPco_x()}', '${vo.getPco_y()}')">		
					<img id="thumbnail_map[${status.index}]" src="" alt="thumbnmail_map">
				</div>				
			</div>
			</div><!-- col-md-5 -->
			<script>
			document.getElementById('thumbnail_map[${status.index}]').src 
					= img_src('${vo.getPco_x()}', '${vo.getPco_y()}',200, 150);
 			</script>
	
			<div class="col-md-7 nopadding">
				<div class="thumb_map_header">						
					<span id ="pname_${status.index}">장소: ${vo.pname}</span>
					<hr/>
				</div>
				<div class="thumb_map_body">
					<div id ="padd_${status.index}">주소 : ${vo.padd}</div>
					<hr/>
				</div> 
				<div class="thumb_map_footer">
					<span id ="pcate_${status.index}">유형 : ${vo.pcate}</span>
					<hr/>		
				</div>
			</div><!-- col-md-7 -->		
		</div><!-- row -->
		<br/><hr/>
		</c:forEach>		
	</div><!-- /.box-body -->

</div>
</div> 
