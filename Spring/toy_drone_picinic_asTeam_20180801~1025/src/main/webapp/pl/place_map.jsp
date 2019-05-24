<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
	System.out.println(">place_map.jsp");  

	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
	System.out.println(">place_map.jsp, id: " + id);
	System.out.println(">place_map.jsp, nickname: " + nickname);
	System.out.println(">place_map.jsp, authority: " + authority);


%>


<div id="map" style="width:100%; height:700px;"></div>

<script>
/*-------------------------------*/ 
/*       main_map                */
/*-------------------------------*/
/*  main map which will show almost all the info in the website  */

var map = new naver.maps.Map(document.getElementById('map'), {
    zoom: 7,
    mapTypeId: 'normal',   
    center: new naver.maps.LatLng(37.549972999999966, 126.9414804999999),
	minZoom: 1, //지도의 최소 줌 레벨
	maxZoom: 14,
	zoomControl: true, //줌 컨트롤의 표시 여부
	zoomControlOptions: { //줌 컨트롤의 옵션
  	  position: naver.maps.Position.TOP_RIGHT
	}
});//초기지도 끝

map.setOptions("mapTypeControl", true); //지도 유형 컨트롤의 표시 여부

function initGeocoder() {
	 map_click();

    $('#address').on('keydown', function(e) {
        var keyCode = e.which;
        if (keyCode === 13) { // Enter Key
            searchAddressToCoordinate($('#address').val());
        }
    });
    $('#submit').on('click', function(e) {
        e.preventDefault();
        searchAddressToCoordinate($('#address').val());
    });
}
naver.maps.onJSContentLoaded = initGeocoder;

/*-----------------------------*/
/*   img_src_url_click     */
/*----------------------------*/
/*   static map image needs a reversed coordinates     */
function img_src_url(coord_x, coord_y){
	
    var img_src = "https://openapi.naver.com/v1/map/staticmap.bin?";
    img_src += "clientId=VZh2P8e3BanI8L1zMwyD&url=http://localhost:8080&crs=EPSG:4326";
    img_src += "&level=10&w=300&h=200&&baselayer=satellite&overlayers=anno_satellite";
    img_src += "&center=" + coord_y + "," + coord_x; //needs to reverse coords for static map image
    img_src += "&markers=" + coord_y + "," + coord_x; 
    return img_src;
}

/*-----------------------------*/
/*        map_click        */
/*----------------------------*/
/* when clicking the main_map, 
 pops up with infowindow which has a thumnail satellite img 
 can register flying spots when clicking the + button
*/ 
function map_click(coord){//click
   naver.maps.Event.addListener(map, 'click', function(e) {   
		naver.maps.Service.reverseGeocode({
		    location: new naver.maps.LatLng(e.latlng),
		}, function(status, response) {
		    if (status !== naver.maps.Service.Status.OK) {
		        return alert('한국 이외의 지역이 선택되었습니다. \n 새로고침 부탁드려요!');//if click coord goes out of bound
			}
         var result = response.result, // 검색 결과의 컨테이너
               items = result.items; // 검색 결과의 배열
         var address = items[0].address;
         var coord_x = e.latlng.lat();
         var coord_y = e.latlng.lng();
         var coord_x_y =  new naver.maps.LatLng(coord_x, coord_y);
         var coord_db = coord_x + "," + coord_y;

         
         map.setOptions({
              mapTypeId: 'normal',
/*               center: new naver.maps.LatLng(coord_x_y.destinationPoint(0, 100)),
 */          });   
		
         var contentString = [
              '<div class="iw_inner">',
              '   <div style="padding-top:20px;">',
              '      <h3>현재 위치</h3>',
              '   </div>',
              '   <p style="width:320px">' + address + '<br />',
              '      <img class="thumbnail_map_image_info" style="padding:10px;" src="' +  img_src_url(coord_x, coord_y) + '" alt="인포윈도우 사진" /><br />',
              '   </p>',
              '   <br/>',
              '</div>',
              '<hr/>'
          ].join('');
         
          var marker = new naver.maps.Marker({
              position: new naver.maps.LatLng(e.latlng),
        	  map: map
     	  });
          
          var infowindow = new naver.maps.InfoWindow({
              content: contentString,
              maxWidth: 750,
              borderColor: "#e0eddc",
              borderWidth: 5,
          });      
          
          infowindow.open(map, marker);
          
		  var nickname = "<%=nickname %>";
          
          document.getElementById("place_register_coord_register").value = coord_db;
          document.getElementById("place_register_add_register").value = address;
          document.getElementById("place_register_nickname_register").value = nickname;
       });
   });
}//click


/*-------------------------------*/
/*           mapZoom()           */
/*-------------------------------*/
/* when thumbnail image is clicked, 
  the main map zooms and centers to the specific 
  coordinates with the infowindow */
    
function mapZoom(Place_Name, Place_Add, Place_Desc, User_Id, Place_Coord ,Place_Cate){ //search
   var trim_coord_1 = Place_Coord.replace("(lat:", "");
   var trim_coord_2 = Place_Coord.replace("lng:", " ");
   var trim_coord_3 = Place_Coord.replace(")", "");
   
   var place_Coord_x = trim_coord_3.split(",")[0] - 0;//to make it as int
   var place_Coord_y = trim_coord_3.split(",")[1] - 0;
   
   place_Coord_x_y =  new naver.maps.LatLng(place_Coord_x, place_Coord_y);
   map.setOptions({
        mapTypeId: 'normal',
        center: new naver.maps.LatLng(place_Coord_x_y.destinationPoint(0, 100)),
		zoom: 12		
    });   
   
    //marker
    var marker = new naver.maps.Marker({
       position: new naver.maps.LatLng(place_Coord_x, place_Coord_y),
       map: map
   });    
    
   var contentString = [
        '<div class="iw_inner">',
        '   <div style="padding-top:20px;">',
        '      <h3> ' + Place_Name + '</h3>',
        '   </div> ',
        '   <hr/> ',
        '   <p style="width:320px">' + Place_Add + '<br />',
        '      <img class="thumbnail_map_image_info" style="padding:10px;" src="' + img_src_url(place_Coord_x, place_Coord_y) + '" alt="인포윈도우 사진" /><br />',
        '   <b>추천 by : </b>' + User_Id + '<b>&nbsp;&nbsp;|&nbsp;&nbsp;분류: </b>' + Place_Cate + '<br /><hr/>',
        '   <b>설명 : </b>' + Place_Desc + '<br />',
        '   </p>',
        '</div>',
        '<br/>',
          ].join('');
   
   var infowindow = new naver.maps.InfoWindow({
       content: contentString,
       maxWidth: 750,
       borderColor: "#e0eddc",
       borderWidth: 5,
   });  
   
   infowindow.open(map, marker);
}
</script>