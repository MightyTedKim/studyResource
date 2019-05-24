<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="map" style="width:100%; height:700px;"></div>


<script>
$(document).ready(function() {

	naver.maps.Event.addListener(map, 'click', function(e) {
	   naver.maps.Service.reverseGeocode({
		   location: new naver.maps.LatLng(e.latlng),
		}, function(status, response) {
		    if (status !== naver.maps.Service.Status.OK) {
		        return alert('한국 이외의 지역이 선택되었습니다. \n 새로고침 부탁드려요!');//if click coord goes out of bound
		}    
		 console.log("click");
		 var pco_x = e.latlng.lat();
		 var pco_y = e.latlng.lng();
		 var padd = response.result.items[0].address;
		 
		 var marker = get_marker(pco_x, pco_y, "기본");
		 var infowindow = get_infowindow(pco_x, pco_y, padd);
		 infowindow.open(map, marker);
		 
		 document.getElementById("pco_x").value = pco_x;
		 document.getElementById("pco_y").value = pco_y;
		 document.getElementById("padd").value = padd;
		});
	});
});
</script>

<script>
/*-----------------*/ 
/*     main_map    */
/*-----------------*/

var map = new naver.maps.Map(document.getElementById('map'), {
    zoom: 7,
    mapTypeId: 'normal',   
    center: new naver.maps.LatLng(37.549972999999966, 126.9414804999999), //Seoul Station
	minZoom: 1,
	maxZoom: 14,
	zoomControl: true, 
	zoomControlOptions: { 
  		position: naver.maps.Position.TOP_RIGHT
	},
	setOptions : {
		mapTypeControl : true
	}
});

var placeJSON, markers = [], infoWindows = [];

$.ajax({
	async: false,
	url : "/place/place_json",
	success : function(data) {
		placeJSON = data;
     },
    error : function(request, status, error) {
         console.log("code: " + request.status + "\n status:" + status	+ 
               "\n" + "error:" + error);
    }
});
console.log(placeJSON);

for (var i = 0; i < placeJSON.length; i++) { 
	var vo = placeJSON[i];
	var marker = get_marker(vo.pco_x, vo.pco_y, vo.pcate);
	var infoWindow = get_infowindow(vo.pco_x, vo.pco_y, vo.pname);

    markers.push(marker);
    infoWindows.push(infoWindow);
};

//get markers on bounds
naver.maps.Event.addListener(map, 'idle', function() {
    updateMarkers(map, markers);
});

function updateMarkers(map, markers) {
    var mapBounds = map.getBounds();
    var marker, position;

    for (var i = 0; i < markers.length; i++) {
        marker = markers[i]
        position = marker.getPosition();

        if (mapBounds.hasLatLng(position)) {
            showMarker(map, marker);
        } else {
            hideMarker(map, marker);
        }
    }
}

function showMarker(map, marker) {
    if (marker.setMap()) return;
    marker.setMap(map);
}
function hideMarker(map, marker) {
    if (!marker.setMap()) return;
    marker.setMap(null);
}

// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
function getClickHandler(seq) {
    return function(e) {
    	console.log("getClickHandler, seq=" + seq);
        var marker = markers[seq],
            infoWindow = infoWindows[seq];

        if (infoWindow.getMap()) {
            infoWindow.close();
        } else {
            infoWindow.open(map, marker);
        }
    }
}

for (var i=0, ii=markers.length; i<ii; i++) {
    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
}

</script>