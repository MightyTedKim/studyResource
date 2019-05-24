<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>

<div id="accordion_aero">
	<div class="accordion-toggle">
		<div class="aero_button_head"> 
			<i class="far fa-check-square"></i>
		</div>
		
	</div>	
  	<div class="accordion-content dropdown-content aero">
		<button type="button" class="btn btn-info" onclick="aero_color_off()" style="float:right; margin-bottom:5px" >&lt;초기화&gt;</button>
		<button type="button" class="btn btn-aero1" onclick="aero_coords('비행금지구역(LT_C_AISPRHC)')">비행금지</button>
		<button type="button" class="btn btn-aero2" onclick="aero_coords('비행제한구역(LT_C_AISRESC)')">비행제한</button>   
		<button type="button" class="btn btn-aero3" onclick="aero_coords('위험구역(LT_C_AISDNGC)')">위험</button>
		<button type="button" class="btn btn-aero4" onclick="aero_coords('관제권(LT_C_AISCTRC)')"> 관제권</button>
		<button type="button" class="btn btn-aero5" onclick="aero_coords('군작전구역(LT_C_AISMOAC)')">군작전</button>
		<button type="button" class="btn btn-aero6" onclick="aero_coords('훈련구역(LT_C_AISCATC)')">훈련</button>
	</div>
</div>

<script>
$(document).ready(function() {
  $('#accordion_aero').find('.accordion-toggle').click(function(){
    $(this).next().slideToggle('easing');
  });
});
</script> 


<hr/>

<style>

/*-------------------------------*/
/*       aero_button:            */
/*-------------------------------*/
.aero_button_head{
  color: white;
  background:grey;
  border-radius: 15px;
  padding:10px;
}

.dropdown-content.aero {
	width: 100%;
	height: 100%;
	overflow: visible;
 }
 
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f1f1f1;
    min-width: 10px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}
.dropdown-content a {
	width:85%;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    right:2px;
}
.dropdown a:hover {background-color: #ddd;}
.show {display: block;}
/*-----비행금지---red---*/
.btn-aero1 {background-color: #D04B56; width: 80px; float:right}
.btn-aero1:hover {background-color: #b54a4d;}
/*-----비행제한---yellow---*/
.btn-aero2 {background-color: #E3B622; width: 80px; float:right}
.btn-aero2:hover {background-color: #d1a71f;}
/*-----위험구역---green---*/
.btn-aero3 {background-color: #a3f902; width: 80px; float:right}
.btn-aero3:hover {background-color: #B7D9A5;}
/*-----관제권---purple---*/
.btn-aero4 {background-color: #e46cfc; width: 80px; float:right}
.btn-aero4:hover {background-color: #b66bbf;}
/*-----군작전구역---black---*/
.btn-aero5 {background-color: #adadad; width: 80px; float:right}
.btn-aero5:hover {background-color: #686568;}
/*-----훈련구역---khaki---*/
.btn-aero6 {background-color: #658918; width: 80px; float:right}
.btn-aero6:hover {background-color: #476605;}
</style>


<script>

/*-------------------------------*/
/*  aero_coords: 공역 정보 가져오기    */
/*-------------------------------*/
var history_aero = []; //초기 클릭만 작동하도록 history
function aero_coords(aero_select){//공역 정보 가져오기
   if (history_aero.includes(aero_select) == false){
      history_aero.push(aero_select);
      $.ajax({
           type: 'get',
           url :"${pageContext.request.contextPath}/resources/aero/" + aero_select + '.json',
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
   }else{
      console.log("history_aero.find(aero_select),already exists: " + history_aero.includes(aero_select));
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
           console.log("else: " + color + " : "+ feature.getProperty);
           console.log("==");
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

