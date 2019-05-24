<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
		
<style>
/*-------------------------------*/
/*       place_pano:            */
/*-------------------------------*/
.thumb_sate_wrap{
	width: 510px;
	height: 336px;
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
</style>

<script>
$(document).ready(function() {
	$('#accordion_pano').find('.accordion-toggle').click(function(){
	  $(this).next().slideToggle('easing');
	});
	//init sate
	var pano = new naver.maps.Panorama("place_pano", {
		position: new naver.maps.LatLng(37.4863559,127.0203771),
		pov: {
			pan: -135,
			tilt: 29,
			fov: 100
		},
		size: new naver.maps.Size(500, 300),
		aroundControl: true,
		aroundControlOptions: {
		    position: naver.maps.Position.TOP_RIGHT
		}
	});
	
	naver.maps.Event.addListener(map, 'click', function(e) {
	    pano.setPosition(e.coord); 
	    naver.maps.Event.addListener(pano, 'pano_changed', function() {
	        if (!latlng.equals(map.getCenter())) {
	            map.setCenter(pano.getPosition());
	        }
	    });
	});
});



</script>


<!-- saetllite view -->
<div id="accordion_pano">
	<div class="accordion-toggle"><!-- accordian-toggle -->
		<div class="button_head"> 
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
	
	

    