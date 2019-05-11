<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
	System.out.println(">place.jsp");  
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script type="text/javascript" 
    	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>
   	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">	
</head>
 
<body> 
<!-- page is made with 2 big chunk "place_map_wrap" and "place_list_wrap" 
	 over the "place_map_wrap", there are 3 buttons and 1 search text
	 on the left, there is "place_list_wrap"
	 inside, there is "place_list_specifc" to see the place info as a card or list
-->

<div class="row">
	<div class="place_map_wrap col-sm-8 nopadding">
		<div class="place_map" id="page-content-wrapper" > <!--main_map-->
			<jsp:include page="place_map.jsp" />
		</div>	
		<!-- map position: absolute, things that goes over the map -->
		<div class="place_aero"> <!-- 1 -->
			<jsp:include page="place_aero.jsp" />
		</div>		
		<div class="place_register"> <!-- 2 -->
			<jsp:include page="place_register.jsp" />
		</div>			
		<div class="place_pano"> <!-- 3 -->
			<jsp:include page="place_pano.jsp" />
		</div>		
		<div class="place_search"> <!-- 4 -->
			<jsp:include page="place_search.jsp" />
		</div>		
	</div> <!-- class="main_map row" -->	
	
	<div class="place_list_wrap col-sm-4 nopadding"> <!-- list -->                            
		<jsp:include page="place_list.jsp" />
	</div>	
	<br/>
</div>

</body>

<style>

/*-------------------------------*/
/*       "place_list_wrap":          */
/*-------------------------------*/
.place_list_wrap {
    border-radius: 15px;       
    background:white;
    height:700px;
    overflow-y: scroll;
   }

/*-------------------------------*/
/*       "place_search"        */
/*-------------------------------*/
.place_search{
    position: absolute;
    z-index: 1;
    display: inline-block;
    left: 210px;
    top: 2px;
    z-index: 1;
    border-radius: 15px;   
    padding:10px; 
    margin: 10px;
}


/*-------------------------------*/
/*       "place_pano"        */
/*-------------------------------*/
.place_pano{
    position: absolute;
    z-index: 1;
    display: inline-block;
    left: 150px;
    top: 2px;
    z-index: 1;
    border-radius: 15px;   
    padding:10px; 
    margin: 10px;
}

/*-------------------------------*/
/*       "place_register"        */
/*-------------------------------*/
.place_register{
    position: absolute;
    z-index: 1;
    display: inline-block;
    left: 100px;
    top: 2px;
    z-index: 1;
    border-radius: 15px;   
    padding:10px; 
    margin: 10px;
}

/*-------------------------------*/
/*       "place_aero"           */
/*-------------------------------*/
.place_aero{
    position: absolute;
    z-index: 1;
    display: inline;
    left: 50px;
    top: 2px;
    z-index: 1;
    padding:10px; 
    margin: 10px;
}

</style>


</html>
