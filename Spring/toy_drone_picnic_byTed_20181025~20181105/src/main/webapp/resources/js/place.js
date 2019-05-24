// make_pano_map
function make_pano_map(pco_x, pco_y, index, width, height) {
	var pano = new naver.maps.Panorama("pano_map[" + index + "]", {
		position: new naver.maps.LatLng(pco_x, pco_y),
        pov: {
            pan: -135, tilt: 29, fov: 100
        },
        size: new naver.maps.Size(width, height),
        aroundControl: true,
        aroundControlOptions: {
            position: naver.maps.Position.TOP_RIGHT
        }
    });
}
// make_img_map
function img_src(pco_x, pco_y, width, height){	
	let img_src = "https://openapi.naver.com/v1/map/staticmap.bin?";
		img_src += "clientId=VZh2P8e3BanI8L1zMwyD&url=http://localhost:8800&crs=EPSG:4326";
		img_src += "&level=10&w=" + width + "&h=" + height + "&&baselayer=default";
		img_src += "&center=" + pco_y + "," + pco_x
        img_src += "&markers=" + pco_y + "," + pco_x
	return img_src;
}
// map_change
function map_change(i) {
    var x = document.getElementById("thumbnail_map[" +i +"]");
    var y = document.getElementById("pano_wrap[" +i +"]");
    if (x.style.display === "none") {
        x.style.display = "block";
        y.style.display = "none";
    } else {
        x.style.display = "none";
        y.style.display = "block";
    }
}

//map_click
function mapZoom(pco_x, pco_y, pname){ 
	map.setOptions({
		center: new naver.maps.LatLng(pco_x, pco_y),
		zoom: 12
	});
};

//infowindow + marker
function get_content(pco_x, pco_y, pname){	
	var content = [
		'<div style="height:250px;width:350px;text-align:center;padding:10px;">',
	    '   <div>' + pname + '<divs>',
	    '   	<img src="' + img_src(pco_x, pco_y, 300, 200)+ '" alt="thumbnail Map">',
	    '	</div>',
	    '</div>'
	    ].join('');
	
	return content;
}
//infowindow + marker
function get_marker(pco_x, pco_y, pcate){
	map.setOptions({
		center: new naver.maps.LatLng(pco_x, pco_y),
		zoom: 12
	});
	console.log('/resources/img/marker/' + pcate + '.png');
	var marker = new naver.maps.Marker({
	    map: map,
	    position: new naver.maps.LatLng(pco_x, pco_y),
	    icon: {
	        url: '/resources/img/marker/' + pcate + '.png',
	        size: new naver.maps.Size(50, 50),
	    },
 	});
	return marker;
}

//infowindow + marker
function get_infowindow(pco_x, pco_y, pname){
	var infoWindow = new naver.maps.InfoWindow({
       content: get_content(pco_x, pco_y, pname),
       maxWidth: 500, 
       borderColor: "#e0eddc", 
       borderWidth: 5,
	});
	return infoWindow;
}


//for map searchAddresss
function searchAddress() {
    $('#address').on('keydown', function(e) {
        var keyCode = e.which;
        if (keyCode === 13) { // Enter Key
        	if ( !validation($('#address').val()) ){
        		return false;
        	}else{
            	searchAddressToCoordinate( $('#address').val() );
        	}
        }
    });
    $('#searchBtn_submit').on('click', function(e) {
        e.preventDefault();
    	if ( !validation($('#address').val()) ){
    		return false;
    	}else{
	        searchAddressToCoordinate( $('#address').val() );
    	}
    });
}

function validation(value){
	if (value==""){
		alert("주소를 입력 해주세요");
		return false;
	}
	return true;
}

// searchAddressToCoordinate
// when typing address, the info is shown according to coord
function searchAddressToCoordinate(address) {
	naver.maps.Service.geocode({
	     address: address
	 }, function(status, response) {
	     if (status === naver.maps.Service.Status.ERROR) {
	         return alert('도로명 주소로 입력해주세요. \n 예를 들어, 명달로 20길 32번지이면 명달로 까지만 입력해도 됩니다 :)');
	     }
		 var item = response.result.items[0];
	     var pco_x = item.point.y; // should be reversed
		 var pco_y = item.point.x;
		 var padd = item.address;	  

		 var marker = get_marker(pco_x, pco_y, "기본");
		 var infowindow = get_infowindow(pco_x, pco_y, padd);
		 infowindow.open(map, marker);
		 
		 document.getElementById("pco_x").value = pco_x;
		 document.getElementById("pco_y").value = pco_y;
		 document.getElementById("padd").value = padd;
	 });
}
