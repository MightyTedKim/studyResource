<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>

<div class="input-group-append">
	<input id="address" type="text" style="padding:0; border-radius:15px;" placeholder="&#09; 검색할 주소">
	<input id="submit" type="button" style="font-size: 15px; padding-top: 0px;padding-bottom:0;margin-left: 5px;border: 0; border-radius:15px; height: 30px;margin-top: 5px;" class="btn btn-lg button_bg_blue korean_center" value="주소 검색"> 
</div>
 
<script>
/*--------------------------------------*/
/*       searchAddressToCoordinate     */
/*-------------------------------------*/
/*  when typing address, the info is shown according to coord  */
function searchAddressToCoordinate(address) {

naver.maps.Service.geocode({
     address: address
 }, function(status, response) {

     if (status === naver.maps.Service.Status.ERROR) {
         return alert('도로명 주소로 입력해주세요. \n 예를 들어, 명달로 20길 32번지이면 명달로 까지만 입력해도 됩니다 :)');
     }
     var item = response.result.items[0],
         point = new naver.maps.Point(item.point.x, item.point.y);
     
     //point coords has to be reversed
     var coord_x = item.point.y
     var coord_y = item.point.x
     var coord_x_y =  new naver.maps.LatLng(coord_x, coord_y);
     
     map.setOptions({
          mapTypeId: 'normal',
          center: new naver.maps.LatLng(coord_x_y.destinationPoint(0, 100)),
  		zoom: 12		
      });   
     
      //marker
      var marker = new naver.maps.Marker({
         position: new naver.maps.LatLng(coord_x, coord_y),
         map: map
     });    
      
     var contentString = [
         '<div class="iw_inner">',
         '   <div style="padding-top:20px;">',
         '      <h3>현재 위치</h3>',
         '   </div>',
         '   <p style="width:320px">' + item.address + '<br />',
         '      <img class="thumbnail_map_image_info" style="padding:10px;" src="' +  img_src_url(coord_x, coord_y) + '" alt="인포윈도우 사진" /><br />',
         '   </p>',
         '   <br/>',
         '</div>',
         '<hr/>'
     ].join('');

     var infowindow = new naver.maps.InfoWindow({
         content: contentString,
         maxWidth: 750,
         borderColor: "#e0eddc",
         borderWidth: 5,
     });
     infowindow.open(map, marker);

 });
}

</script>   