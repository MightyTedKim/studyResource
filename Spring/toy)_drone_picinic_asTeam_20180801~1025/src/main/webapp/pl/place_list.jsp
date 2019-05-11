<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import ="com.spring.drone.pl.PlaceVO" %>
<%@ page import ="java.util.*" %>
<%
   ArrayList<PlaceVO> placeList = (ArrayList<PlaceVO>) request.getAttribute("placeList");
%>     

<div class="row nopadding">   
	<div class="col-md-8" ><!-- 장소추천 header -->
		<input type="search" id="input-search" size="30" placeholder=" &nbsp;&nbsp;&nbsp;검색할 장소를 입력해주세요">
	</div>  <!-- 장소추천 header 끝 -->
	<div class="col-md-4">
		<a href="place_list_specific.pl"  
			    onclick="window.open('place_list_specific.pl', 
			                         'newwindow', 
			                         'width=1300,height=850'); 
			              return false;" style="right:2px;"
		>자세히 보기</a>
	</div>   
</div> <!-- class="place_list_heade -->
 
<%
for(int index = 0; index < placeList.size(); index ++){
   PlaceVO vo = placeList.get(index);
  
	//latlng has to be reversed for static image API
	String coord1 = vo.getPlace_Coord(); String[] words = coord1.split(",");String coord2 = words[1] + "," + words[0];
	String img_src = "https://openapi.naver.com/v1/map/staticmap.bin?";
		img_src += "clientId=VZh2P8e3BanI8L1zMwyD&url=http://localhost:8080&crs=EPSG:4326";
		img_src += "&level=10&w=300&h=200&&baselayer=default";
		img_src += "&center=" + coord2;
		img_src += "&markers=" + coord2;
%>

<!-- thumbnail content -->	
<div class="row thumb_card">
	<!-- thumbnail map -->                  
	<div class="thumbnail_map_image_wrap col-md-5 nopadding" onclick="mapZoom('<%=vo.getPlace_Name() %>', '<%=vo.getPlace_Add() %>','<%=vo.getPlace_Desc() %>', '<%=vo.getUser_Id() %>', '<%=vo.getPlace_Coord() %>', '<%=vo.getPlace_Cate() %>')">                          
		<img class="thumbnail_map_image" src="<%=img_src %>">
	</div>

	<div class="thumbnail_content_wrap col-md-7"> 
		<div>
			<div class="thumbnail_content_name"> <%=vo.getPlace_Name() %></div>
			<div class="thumbnail_content_category"> <%=vo.getPlace_Cate() %> </div>
		</div>	
		<hr/>									
		<div class="thumbnail_content_address mb-2"> <%=vo.getPlace_Add() %></div>		
	</div>	<!-- class="thumbnail_content_wrap -->	
		
</div> <!-- class="thumb_card" -->

<%  } %>


<script>
/*----------------------------------*/
/*        place_list search         */
/*----------------------------------*/
$(function() {    
    $('#input-search').on('keyup', function() {
      var rex = new RegExp($(this).val(), 'i');
        $('.thumb_card').hide();
        $('.thumb_card').filter(function() {
            return rex.test($(this).text());
        }).show();
    });
});
</script>

<!-- css -->
<style>
#input-search{
	border: 1px solid #c9c8c7;
    border-radius: 12px;
    margin-left: -5px;
    margin-bottom: 5px;
}

/*---------------------------*/
/*    thumbnail_map_simple   */
/*--------------------------*/
.thumbnail_content_name{
    font-size: 28px;
    width: 80%;
    display: inline;
}

.thumbnail_content_category{
    font-size: 10px;
    width: 20%;
    display: inline;
}

.thumbnail_content_address{
	font-size: 12px;
}

.nopadding {
   padding: 0 !important;
   margin: 0 !important;
}

.center{
    margin: auto;
    width: 100%;
    padding: 10px;
 }
 
/*--------------------------*/
/*    thumbnail_map (simple)  */
/*--------------------------*/   

.thumb_card{
    margin: 0 8px 8px;
    background: white;
    border-bottom: 0;
    box-shadow: 1px 1px 3px #a5a5a5;
}

.thumbnail_map_image{
   width: 100%;  
}
 
/*-------------------------------*/
/*        accordian              */
/*-------------------------------*/
.accordion-toggle {cursor: pointer;}
.accordion-content {display: none;}
</style> 
