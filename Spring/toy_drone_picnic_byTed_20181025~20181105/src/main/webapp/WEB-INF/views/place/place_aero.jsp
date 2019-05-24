<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>

<script>
$(document).ready(function() {
  $('#accordion_aero').find('.accordion-toggle').click(function(){
    $(this).next().slideToggle('easing');
  });
});
</script> 
<style>
/*-----비행금지---red---*/
.btn-aero1 {background-color: #D04B56;}
.btn-aero1:hover {background-color: #b54a4d;}
/*-----비행제한---yellow---*/
.btn-aero2 {background-color: #E3B622;}
.btn-aero2:hover {background-color: #d1a71f;}
/*-----위험구역---green---*/
.btn-aero3 {background-color: #a3f902;}
.btn-aero3:hover {background-color: #B7D9A5;}
/*-----관제권---purple---*/
.btn-aero4 {background-color: #e46cfc;}
.btn-aero4:hover {background-color: #b66bbf;}
/*-----군작전구역---black---*/
.btn-aero5 {background-color: #adadad;}
.btn-aero5:hover {background-color: #686568;}
/*-----훈련구역---khaki---*/
.btn-aero6 {background-color: #658918;}
.btn-aero6:hover {background-color: #476605;}
</style>

<div id="accordion_aero">
	<div class="accordion-toggle">
		<div class="button_head"> 
			<i class="far fa-check-square"></i>
		</div>	
	</div>	
  	<div class="accordion-content dropdown-content aero">
		<button type="button" class="btn btn-info" onclick="aero_color_off()" style="margin-bottom:5px" >&lt;초기화&gt;</button>
		<button type="button" class="btn btn-aero1" onclick="aero_coords('비행금지구역(LT_C_AISPRHC)')">비행금지</button>
		<button type="button" class="btn btn-aero2" onclick="aero_coords('비행제한구역(LT_C_AISRESC)')">비행제한</button>   
		<button type="button" class="btn btn-aero3" onclick="aero_coords('위험구역(LT_C_AISDNGC)')">위험</button>
		<button type="button" class="btn btn-aero4" onclick="aero_coords('관제권(LT_C_AISCTRC)')"> 관제권</button>
		<button type="button" class="btn btn-aero5" onclick="aero_coords('군작전구역(LT_C_AISMOAC)')">군작전</button>
		<button type="button" class="btn btn-aero6" onclick="aero_coords('훈련구역(LT_C_AISCATC)')">훈련</button>
	</div>
</div>

<script>

/*-------------------------------*/
/*  aero_coords: 공역 정보 가져오기    */
/*-------------------------------*/
var history_aero = []; 

function aero_coords(aero_select){
   if (history_aero.includes(aero_select) == false){
      
      $.ajax({
           type: 'get',
           url :"/resources/geojson/" + aero_select + '.json',
           dataType: "json",
           cache: false,
           success :function(data){//성공시 
             console.log("=ajax URL 성공");
             map.data.addGeoJson(data);    //geojson 읽기
           },
           error: function(data, exception) { //실패시
              alert("=ajax URL 에러");
               console.log(data.url);
           }
       });
       aero_color_on(aero_select)// 색 입히기
       history_aero.push(aero_select);
   }else{
      console.log("already shown on map: " + history_aero.includes(aero_select));
   }
}
    
function aero_color_on(aero_select){
   //불러온 파일에 색 입히기    
   map.data.setStyle(function(feature) {
       if (feature.getProperty("prh_lbl_1") != null) {
           color = 'red';//비행금지 red
       } else if (feature.getProperty("res_lbl_1") != null) {   
           color = 'yellow';//비행제한 yellow
       } else if (feature.getProperty("dng_lbl_1") != null) {
           color = '#79b207';//위험 green
       } else if (feature.getProperty("ctr_lbl_1") != null) {
           color = '#e46cfc';//관제 purple
       } else if (feature.getProperty("moa_lbl_1") != null) {
           color = 'black';//군작전 black
       } else if (feature.getProperty("cat_lbl_1") != null) {
           color = '#658918';//훈련 kahki
       } else {
           color = 'blue'; // 미지정
       }
       return /** @type {google.maps.Data.StyleOptions} */({
           clickable:false,
           fillColor: color,//DB 연동:바탕 색
           fillOpacity: 0.4,
           strokeWeight: 0
       });
   });//map.data.style   
}

function aero_color_off(){
   map.data.setStyle({visible: false});
   history_aero = [];//클릭 할 수 있게 초기화
};

</script>

