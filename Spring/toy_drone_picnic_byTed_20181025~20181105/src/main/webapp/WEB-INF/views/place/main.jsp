<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

<link href="/resources/css/place.css" rel="stylesheet"> 
<script src="/resources/js/place.js"></script>

<script type="text/javascript" 
 	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>
 
 
<!-- Page Header -->
<header class="masthead" style="background-image: url('/resources/img/contact-bg.jpg'); 
									margin-bottom: 10px;">
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
      	<div style="height: 60px;"></div>
      </div>
    </div>
  </div>
</header>

<body> 
<div class="row">
	<div class="place_map_wrap col-sm-8 nopadding">
		<div class="place_map" id="page-content-wrapper" > <!--main_map-->
		 	<c:import url= "place_map.jsp" />
		</div>	
		
	 	<!--  overlay, position: absolute -->
		<div class="place_btn_common place_btn_1"> <!-- 1 -->
			<c:if test="${not empty login}">
				<c:import url="place_register.jsp" />					 	  		
			</c:if>	
		</div>
		<div class="place_btn_common place_btn_2"> <!-- 2 -->
			<c:import url="place_pano.jsp" />
		</div>		
		<div class="place_btn_common place_btn_3"> <!-- 3 -->
			<c:import url="place_aero.jsp" />			
		</div>
	    <div class="place_btn_common place_btn_4"> <!-- 4 -->
	    	<c:import url="place_search.jsp"/>
		</div>	
	</div> <!-- class="main_map row" -->	
	
	<div class="place_list_wrap col-sm-4 nopadding"> <!-- list -->
    	<c:import url="place_list.jsp"/>
    </div>			
	<br/>
</div>


<%@include file="../include/footer.jsp"%>

