<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../include/header.jsp"%>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>    

<link href="/resources/css/place.css" rel="stylesheet">    
<script src="/resources/js/place.js"></script>

<style>
.listPage_padd{
	font-size:10px;
}
</style>
<script>
function modify_value_transfer(i){
	document.getElementById("modal_pno").value 
		= document.getElementById("pno_" + i).innerHTML.trim();  
	document.getElementById("modal_pname").value 
		= document.getElementById("pname_" + i).innerHTML.trim();  
	document.getElementById("modal_pdesc").value
		= document.getElementById("pdesc_" + i).innerHTML.trim();
	document.getElementById("modal_pcate").value 
		= document.getElementById("pcate_" + i).innerHTML.trim();  
	document.getElementById("modal_padd").value
		= document.getElementById("padd_" + i).innerHTML.trim();
};

$(document).ready(function() {
	$('#btnSearch').on("click", function(event) {
		self.location = "/place_list/listPage.pl"
			+ '${pageMaker.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keywordInput').val();
	});

	$('#btnRegister').on("click", function(event) {
		self.location = "/place/main.pl";
	});
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
		<div class="col-md-6 mx-auto">
		<h3 class="box-title">지도</h3>
		<select name="searchType">
			<option value="all"
				<c:out value="${cri.searchType eq 'all'?'selected':''}"/>>전체</option>
			<option value="pname"
				<c:out value="${cri.searchType eq 'pname'?'selected':''}"/>>장소</option>
			<option value="pdesc"
				<c:out value="${cri.searchType eq 'pdesc'?'selected':''}"/>>내용</option>
			<option value="pcate"
				<c:out value="${cri.searchType eq 'pcate'?'selected':''}"/>>유형</option>
		</select>
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword }'>
		<button id='btnSearch'>검색</button>
		<button id='btnRegister'>글 등록</button>
		
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
		</div>
	</div><!-- box header -->
	<br/>
	
	<c:import url="modifyPage.jsp" />
		
	<div class="box-body" style="text-align: center;">
		<c:forEach items="${placeList}" var="vo" varStatus="status">
		<div class="row">
			<div class="col-md-5 nopadding">
			<div class="map_wrap center">
				<div id="thumbnail_wrap[${status.index}]" style="display:block">		
					<div onclick="map_change(${status.index})" class="map_change">
						<i class="fas fa-plane"></i>
					</div>
					<img id="thumbnail_map[${status.index}]" src="" alt="thumbnmail_map">
				</div>
				
				<div id="pano_wrap[${status.index}]" style="display:none;">
					<div onclick="map_change(${status.index})" class="map_change">
						<i class="fas fa-map-marked-alt"></i>
					</div>
					<div id="pano_map[${status.index}]"></div>
				</div>
			</div>
			</div><!-- col-md-5 -->
		
			<div class="col-md-7 nopadding">
				<div class="map_header">						
					<span id ="pno_${status.index}">${vo.pno}</span>.
					<span id ="pname_${status.index}">${vo.pname}</span>
					<div id ="padd_${status.index}" class="listPage_padd">[ ${vo.padd} ]</div>
					<hr/>
				</div>
				<div class="map_body">
					<div id ="pdesc_${status.index}">${vo.pdesc}</div>
					<hr/>
				</div> 
				<div class="map_footer">
					<span id ="uid_${status.index}">${vo.uid}</span>||
					<span id ="pcate_${status.index}">${vo.pcate}</span>||
					<span><fmt:formatDate pattern="yy-MM-dd" value="${vo.regdate}"/></span>	
					<c:if test="${login.uid == vo.uid}">
		  			  <button class="btn-primary pointer" data-toggle="modal" data-target="#modifyModal" onclick="modify_value_transfer(${status.index})">
		  			  	modify
	  			  	  </button>
					</c:if>		
					<hr/>		
				</div>
			</div><!-- col-md-7 -->		
		</div><!-- row -->
		<br/><hr/>
		<script>
			document.getElementById('thumbnail_map[${status.index}]').src 
					= img_src('${vo.getPco_x()}','${vo.getPco_y()}',300,200);
   			make_pano_map('${vo.getPco_x()}','${vo.getPco_y()}', '${status.index}',300, 200);
   		</script>		
		</c:forEach>		
	</div><!-- /.box-body -->


	<div class="box-footer">
		<div class="text-center">
		
		</div>

	</div>	<!-- /.box-footer-->
</div><!-- box -->

</div> <!-- container -->
</div> <!-- row -->
</div> <!--col-md-12-->

<%@include file="../include/footer.jsp"%>



