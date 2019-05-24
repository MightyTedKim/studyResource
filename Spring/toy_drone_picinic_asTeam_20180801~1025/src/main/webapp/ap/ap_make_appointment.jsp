<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    

    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>  
<script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>

<script type="text/javascript"
   src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
   href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<hr/> 
<div id="appointment_wrap" class="appointment_wrap">
   <div class="row">
   
   <!-- 지도 -->
   <div class="appointment_map_wrap col-lg-4">   
      <div class="class form-group">
         <p class="p">Location</p>
         <div class="input-group-append">
            <input id="address" type="text" style="padding:0;" placeholder="검색할 주소" placeholder="불정로 6" />
         <input id="submit" type="button" style="padding-top: 0px;padding-bottom:  0;margin-left: 5px;border: 0;height: 30px;margin-top: 5px;" class="btn btn-lg button_bg_blue korean_center" value="주소 검색">         </div>       
         <div style="height:350px">
            <div id="appointment_map" style="width:350px;height:350px;"></div>
          </div>
      </div>            
   </div>   
   
   <!-- 공지사항 -->
   <div class="appointment_full_list col-lg-5">             
       <div class="col-lg-12 line_color_yellow_b text_align_center mb-3 pl-0">
           <p class="detail_logo">NOTICE</p>
       </div> <!-- line_color_yellow_b  -->

<script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>
       
       <div id="appoint-list" class="col-lg-12 line_color_yellow_b text_align_center mb-3 pl-0" style="float:center">
          <div class="list" id="appointment_list_ajax_full"></div> <!-- 리스트 넣을 공간 -->  
           <ul class="pagination"></ul>          
      </div> <!-- line_color_yellow_b  -->
   </div><!-- class="col-lg-5" -->



   <!-- 장소 등록 -->
   <div class="appointment_register col-lg-3">
      <form action="/post" method="post" id="appointment_register">
          <input type="hidden" class="form-control" name="User_Id" value="ExpectID"/>
          <input type="hidden" class="form-control" id="Appoint_Coord" name="Appoint_Coord"/>
         <div class="appointment_register_form form-group">
              <div class="row">
               <b>제목</b> 
                   <input type="text" class="form-control" name="Appoint_Title" maxlength="10" placeholder="10글자 이내로">    
         
               <b>날짜</b>
                   <input type="text" id="Appoint_Date" class="form-control" name="Appoint_Date">

               <b>장소</b>
                   <input type="text" id="Appoint_Place" class="form-control" name="Appoint_Place" readonly/>
                 
                 <hr/>
                 
               <b> <h5>세부 사항</h> </b>   
                    <textarea class="appoint_desc form-control" name="Appoint_Desc" rows="5" cols="40" maxlength="100" 
                       placeholder=" 회비 6만원이고요 &#10; 더우니까 손 선풍기 준비! &#10; ** 100글자 이내" ></textarea>
                    <div class="center" style="text-align: center;">
                      <b><input type="button" class="btn btn-lg button_bg_blue korean_center mt-2" id="so_appointment_register" value="약속 등록" style="border:0"></b>
                      </div>                   
              </div>   <!-- class="row" -->
           </div><!-- class="appointment_wrap" -->

          </div> <!-- class="appointment wrap" -->
      </form> <!-- action="/post" method="post" id="appointment_register"  -->
   </div><!-- class="col-lg-7" -->
</div>   
<hr/> 
<style>
.pagination>li>a, .pagination>li>span {
    position: relative;
    float: left;
    padding: 6px 12px;
    margin-left: -1px;
    line-height: 1.42857143;
    color: #337ab7;
    text-decoration: none;
    background-color: #fff;
    border: 1px solid #ddd;
}
.pagination>.active>a{
   z-index: 2;
    color: #fff;
    cursor: default;
    background-color: #428bca;
    border-color: #428bca;
}

.pagination>li>a {
 border-radius: 50% !important;
 margin: 0 5px;
 }


#appoint-list{
   text-align:left;
}

.appoint_desc{
   width:100%;

}
.appointment_content{
   width:95%;
}
.appointment_popover{
   width:90%;

}

.appointment_wrap{
   margin:auto;
   width: 100%;
   padding:10px;
   display: none;
}
</style>

</body>
<!-- 네이버 -->               
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>

<style type="text/css">
.search { position:absolute;z-index:1000;top:20px;left:20px; }
.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
.search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
</style>

<script >
var map = new naver.maps.Map("appointment_map", {
    center: new naver.maps.LatLng(37.3595316, 127.1052133),
    zoom: 10,
    mapTypeControl: true
});

var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');

// search by tm128 coordinate
function searchCoordinateToAddress(latlng) {
    var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);
    
    var latlng_str = latlng.toString();
    var trim_coord_1 = latlng_str.replace("(lat:", "");
    var trim_coord_2 = trim_coord_1.replace("lng:", " ");
    var trim_coord_3 = trim_coord_2.replace(")", "");
    var place_coord_x = trim_coord_3.split(",")[0] - 0;
    var place_coord_y = trim_coord_3.split(",")[1] - 0;
    var place_coord_new = place_coord_x + "," + place_coord_y;

    infoWindow.close();

    naver.maps.Service.reverseGeocode({
        location: tm128,
        coordType: naver.maps.Service.CoordType.TM128
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('도로명 주소로 입력해주세요. \n 예를 들어, 명달로 20길 32번지이면 명달로 까지만 입력해도 됩니다 :)');
        }

        var items = response.result.items;
            
        for (var i=0, ii=items.length, item; i<ii; i++) {
            item = items[i];
            if(item.isRoadAddress == '[도로명 주소]'){
               break;               
            }
        }

        infoWindow.setContent([
               '<div style="padding:10px;min-width:200px;line-height:150%;">',          
                '   <b>주소: </b><br/>' + item.address +'<br />',
                '</div>'
            ].join('\n'));

        infoWindow.open(map, latlng);

//        console.log("searchCoordinateToAddress(latlng), latlng(좌표)-클릭: " + latlng);
        console.log("searchCoordinateToAddress(latlng), place_Coord_new(좌표)-클릭: " + place_coord_new);
       document.getElementById("Appoint_Place").value = item.address;
       document.getElementById("Appoint_Coord").value = place_coord_new;

    });
}

// result by latlng coordinate
function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        address: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('도로명 주소로 입력해주세요. \n 예를 들어, 명달로 20길 32번지이면 명달로 까지만 입력해도 됩니다 :)');
        }
        var item = response.result.items[0],
            point = new naver.maps.Point(item.point.x, item.point.y);

        infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '   <b>주소: </b><br/>' + item.address +'<br />',
                '</div>'
            ].join('\n'));

        
        var place_coord_new = item.point.y + "," + item.point.x;
//        console.log("searchAddressToCoordinate(address), point(좌표)-검색: " + point);
        console.log(">searchAddressToCoordinate, place_Coord_new: " + place_coord_new);       
        document.getElementById("Appoint_Place").value = item.address;
        document.getElementById("Appoint_Coord").value = place_coord_new;

        map.setCenter(point);
        infoWindow.open(map, point);
    });
}

function initGeocoder() {
    map.addListener('click', function(e) {
        searchCoordinateToAddress(e.coord);
    });
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
</script>

<script>

/*-------------------------------*/
/*           mapZoom()           */
/*-------------------------------*/

function mapZoom(Coord, Add){//search
   console.log("=mapZoom(Coord): " + Coord);
   console.log("=mapZoom(Add): " + Add);
   
   var trim_coord_1 = Coord.replace("(lat:", "");
   var trim_coord_2 = Coord.replace("lng:", " ");
   var trim_coord_3 = Coord.replace(")", "");
   
   var Coord_x = trim_coord_3.split(",")[0] - 0;
   var Coord_y = trim_coord_3.split(",")[1] - 0;

   map.setOptions({
       zoom: 12,
        mapTypeId: 'normal',
        center: new naver.maps.LatLng(Coord_x, Coord_y)
    });
   
    //marker
    var marker = new naver.maps.Marker({
       position: new naver.maps.LatLng(Coord_x, Coord_y),
       map: map
   });   
    
   var img_src = "https://openapi.naver.com/v1/map/staticmap.bin?";
   img_src += "clientId=VZh2P8e3BanI8L1zMwyD&url=http://localhost:8080&crs=EPSG:4326";
   img_src += "&level=10&w=300&h=200&&baselayer=satellite&overlayers=anno_satellite";
   img_src += "&center=" + Coord_y + "," + Coord_x;
   img_src += "&markers=" + Coord_y + "," + Coord_x;
   
   var contentString = [
        '<div class="iw_inner">',
        '   <div style="padding-top:20px;">',
        '      <h6> ' + Add + '</h6>',
        '   </div> ',
        '</div>',
          ].join('');
       
   
   var infowindow = new naver.maps.InfoWindow({
       content: contentString,
       maxWidth: 750,
       borderColor: "#e0eddc",
       borderWidth: 5,
   });
   
   infowindow.open(map, marker);
}


/*--------------------------------*/
/*              popover           */
/*--------------------------------*/

function appoint_popover(){
   $('.appointment_popover').popover();
   
    $('.appointment_popover').on('click', function (e) {
        $('.appointment_popover').not(this).popover('hide');
    });
};

/*--------------------------------*/
/*              날짜                         */
/*--------------------------------*/
$('#Appoint_Date').daterangepicker({
    singleDatePicker: true,
    timePicker: true,
    timePicker24Hour: true,
    startDate: "08/21/2018", //moment().startOf('hour')
    locale: {
        format: 'MM/DD hh:mm A'
      } 
}, function(start, end, label) {
   console.log('New date range selected: ' + start.format('YYY Y-MM-DD') + ' (predefined range: ' + label + ')');
});

/*--------------------------------*/
/*    place_list 불러오기        */
/*--------------------------------*/

$(document).ready(function() {
   function selectData_Map() {
      console.log("=selectData()");
      $('div#appointment_list_ajax_full').empty();
      $('div#appointment_list_ajax_main').empty();
      
      $.ajax({
         url : '/drone/getAppointJSON.ap',
         type : 'POST',
         dataType : 'json',
         async: false,
         contentType : 'application/x-www-form-urlencoded; charset=utf-8',
         success : function(data) {
            $.each(data, function(index, item) {
               console.log("selectData(), getPlaceJSON, index: " + index + ", " + JSON.stringify(item) );
               
               
               var header =  "<b>장소명:</b><br/>" + item.appoint_Title;
               
               var content = "<b>날짜:</b><br/>" + item.appoint_Date + "<hr/>";
               content += "<b>세부 사항:</b><br/> " + item.appoint_Desc;
               
               
               console.log("item.appoint_Coord: " + item.appoint_Coord);
               console.log("item.appoint_Place: " + item.appoint_Place);
               
               var output='';
                   output += '<div class="appointment_pagination">';
                     output += '   <a class="appointment_popover pointer" onclick="appoint_popover()" data-html="true" data-placement="right"';
                   output += '      title="' + header + '" data-content="' + content + '">';
                   output += '     <span onclick="mapZoom(\''+ item.appoint_Coord + '\', \'' + item.appoint_Place + '\')">';
                   output += '        ' + (index + 1) + '. &nbsp; &nbsp; <b>|</b> &nbsp;';
                   output += '        ' + item.appoint_Title + '&nbsp; &nbsp; <b>|</b> &nbsp;';
                   output += '        ' + item.appoint_Date;
                   output += '     </span>';
                   output += '   </a>';
                   output += '</div>';
                   
          
                   
               $('div#appointment_list_ajax_full').append(output);
               
               if(index < 5){ //main page insert
                  $('div#appointment_list_ajax_main').append(output);
               }

            });
         },
         error : function(request, status, error) {
              console.log("code: " + request.status + "\n" + request.responseText + 
                    "\n" + "error" + error);
         }
      });
   }
   selectData_Map();
/* 
/*--------------------*/
/*      pagination    */
/*--------------------*/
  var monkeyList = new List('appoint-list', {
  valueNames: ['appointment_pagination'],
  page: 10,
  pagination: true
});

   /*-------------------------------------------------*/
   /*   "장소 등록" 누르면 DB 저장 후 ajax로 목록 다시 불러오기    */
   /*-------------------------------------------------*/
   $('#so_appointment_register').click( function(event) {
      console.log("=so_appointment_register click");
      var params = $("#appointment_register").serialize();
      console.log("params: " + params);
      
      $.ajax({
         url : '/drone/appointRegister.ap',
         type : 'post',
         data : params,
         dataType : "json",
          contentType : 'application/x-www-form-urlencoded; charset=utf-8',
         
         success : function(retVal) {
            if(retVal.res == "OK"){
               console.log("DB 연결 (성공), res: " + retVal.res);
               selectData_Map();
               
            }else{
               console.log("DB 연결 (실패), res: " + retVal.res);
            }
         },
         error : function(request, status, error) {
              console.log("code: " + request.status + "\n" + request.responseText + 
                    "\n" + "error" + error);
         }
      });
      //기본 이벤트 제거
      event.preventDefault();
   }); //ajax
   
});
</script>
    
</html>