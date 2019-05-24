<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
	System.out.println(">place_pano2.jsp");  
%>
<!-- saetllite view -->
<div id="accordion_pano">
	<div class="accordion-toggle"><!-- accordian-toggle -->
		<div class="place_pano_head"> 
			<i class="fas fa-map-marked-alt"></i>
		</div>
	</div>
	
  	<div class="accordion-content dropdown-content pano"><!-- accordian-content -->		
		<!-- 파노라마 --> 
		<div class="thumb_sate_wrap">    
			<div>
				<Strong>&nbsp;&nbsp;도로/항공뷰</Strong>
			</div> 
			<div id="place_pano" style="width:500px; height:300px; margin: 5px;" ></div>
		</div>	
	</div>
</div>
	
	
<script>
//init sate
var pano = new naver.maps.Panorama("place_pano", {
	position: new naver.maps.LatLng(37.4863559,127.0203771),
	pov: {
		pan: -135,
		tilt: 29,
		fov: 100
	},
	aroundControl: true,
	aroundControlOptions: {
	    position: naver.maps.Position.TOP_RIGHT
	}
});

// 지도를 클릭했을 때 발생하는 이벤트를 받아 파노라마 위치를 갱신합니다. 이때 거리뷰 레이어가 있을 때만 갱신하도록 합니다.
naver.maps.Event.addListener(map, 'click', function(e) {
    var latlng = e.coord;
    // 파노라마의 setPosition()은 해당 위치에서 가장 가까운 파노라마(검색 반경 300미터)를 자동으로 설정합니다.
    pano.setPosition(latlng);
    // 파노라마 위치가 갱신되었을 때 발생하는 이벤트를 받아 지도의 중심 위치를 갱신합니다.
    naver.maps.Event.addListener(pano, 'pano_changed', function() {
        var latlng = pano.getPosition();
        if (!latlng.equals(map.getCenter())) {
            map.setCenter(latlng);
        }
    });
});


$(document).ready(function() {
  $('#accordion_pano').find('.accordion-toggle').click(function(){
    $(this).next().slideToggle('easing');
  });
});
</script>
		
<style>
/*-------------------------------*/
/*       place_pano:            */
/*-------------------------------*/
.thumb_sate_wrap{
	width: 510px;
	height: 336px;
}

.place_pano_head{
  color: white;
  background:grey;
  border-radius: 15px;
  padding:10px;
}

.place_pano_head{
	text-align:center;
}
.place_pano_footer{
	text-align:center;
}

.accordion_pano{
	background: white;
}

.dropdown-content.pano {
	overflow: visible;
} 

/* .dropdown-content a {
	width:85%;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    right:2px;
}
 */ 
 </style>


    