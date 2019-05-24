<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.spring.drone.pl.PlaceVO"%>
<%
	System.out.println(">place_register.jsp");  

	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
%>

<div id="accordion_register">
	<div class="accordion-toggle"><!-- accordian-toggle -->
		<div class="register_button_head"> <i class="far fa-plus-square"></i> </div>
	</div>	
	
  	<div class="accordion-content dropdown-content register"><!-- accordian-content -->			
		<form action="/post" method="post" id="place_register_form" style="padding: 19px;">
		   <div style="text-align">
		      <h2>장소 등록하기</h2>      
		   </div> 
		   
		   <div class="form-group">
		      <input type="hidden" class="form-control" id="place_register_coord_register" name="Place_Coord" value="클릭한 좌표"/>
		      <input type="hidden" class="form-control" id="place_register_nickname_register" name="User_Id" value="닉네임"/>      
		      <input type="hidden" class="form-control" id="place_register_add_register" name="Place_Add" value=" 클릭한 주소  "/>         
		   </div>   
		   
		   <div class="form-group">
		      <input type="text" maxlength="10" class="form-control" name="Place_Name" placeholder=" 장소명을 입력해주세요  "/>
		   </div>
		   
		   <div class="form-group">
		      <select class="form-control" name="Place_Cate">
		         <option value="개인 추천">개인 추천</option>
		         <option value="드론 비행장">드론 비행장</option>
		         <option value="드론 공원">드론 공원</option>
		      </select>    
		   </div>
		   
		   <div>
		      <textarea maxlength="70" class="form-control" name="Place_Desc" rows="5" placeholder=" 설명을 입력해주세요 :) " ></textarea>
		   </div>   
		   <br/>
		   <div class="place_register_footer">
		      <b><input type="button" class="btn btn-lg button_bg_blue korean_center" id="place_register_button" value="등록"></b>
		   </div> 
		</form> <!-- action="/post" method="post" -->
	</div>
</div>

<style>
/*-------------------------------*/
/*       place_register            */
/*-------------------------------*/
.register_button_head{
  color: white;
  background:grey;
  border-radius: 15px;
  padding:10px;
}

.accordion-content.register{
	background:white;
	border-radius:25px;
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

.dropdown-content.register {
	width: 300px;
	overflow: visible;
 } 
 
 
.dropdown-content a {
	width:85%;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    right:2px;
}
</style>

<script>

$(document).ready(function() {
  $('#accordion_register').find('.accordion-toggle').click(function(){
    $(this).next().slideToggle('easing');
  });
});

/*--------------------------------*/
/*    ajax로 place_list 불러오기        */
/*--------------------------------*/
function selectData() {
   //table내부 내용을 제거(초기화)
   $('div#products').empty();

   $.ajax({ 
      url : '/drone/getPlaceJSON.pl',
      type : 'POST',
      dataType : 'json',
      contentType : 'application/x-www-form-urlencoded; charset=utf-8',
      success : function(data) {
	         $.each(data, function(index, item) {
            <!-- JS don't move this, TED-->
            $(document).ready(function($) {
	            $('#accordion' + index).find('.accordion-toggle' + index).click(function(){
	              $(this).next().slideToggle('easing');
	            });
            });
            <!-- JS don't move this, TED-->
            
var output = "";
output += '<div class="item col-xs-4 col-lg-4">';<!-- card -->
output += '		<div class="thumbnail card" style="text-align:center; float: center;">  '; 
output += '	        <div id="accordion"' + index +'">';     
output += '			'; 
<!-- 지도 wrap-->                     
output += '<div class="thumbnail_map_wrap"';
output += '	     onclick="mapZoom(' + item.place_Name + ', ' + item.place_Add + ', ';
output += '	         			 ' + item.place_Desc + ', ' + item.user_Id + ','; 
output += '	         			 ' + item.place_Coord + ', ' + item.place_Cate + ')">';

var coord1 = item.place_Coord;
var words = coord1.split(",");
var coord2 = words[1] + "," + words[0];
var img_src = "https://openapi.naver.com/v1/map/staticmap.bin?";
img_src += "clientId=VZh2P8e3BanI8L1zMwyD&url=http://localhost:8080&crs=EPSG:4326";
img_src += "&level=10&w=300&h=200&&baselayer=default";
img_src += "&center=" + coord2;
img_src += "&markers=" + coord2;

output += '<img class="thumbnail_map_image" src="' + img_src + '" >';
output += '</div> ';

output += '	<div class="thumbnail_content_wrap" >';
output += '	  <div class="row">';
output += '	     <div class="place_card_address"> ';
output += '	     	<div class="accordion-toggle' + index + '">';
output += '	  			<div class="nanumgothiccoding" style="font-size:30px; float:center; width:100%">';
output += '	      		 ' + item.place_Name + '<i class="fas fa-angle-double-down"></i>';
output += '	            </div>  ';                         
output += '	        </div> ';
output += '	                   ';  
output += '	<div class="accordion-content place_card_desc" style="width:100%; margin:auto">';
output += '		<!-- 파노라마 -->';
output += '		<div class="thumb_pano_wrap"> ';
output += '	 		<div id="pano' + index + '" class="thumb_pano" style="height: 250px; width: 520px;"></div>';
output += '	</div>';
output += '	<div class="place_card_desc_content">';
output += '		<div style="font-size:10px; width:80%; margin:auto; padding:5px; border:1px solid #F6F6EE;">';
output += '			<div class="nanumgothiccoding" style="float:left;"><b> &nbsp;&nbsp;주소:</b>' + item.place_Add + '</div><br/>';							
output += '	<div class="nanumgothiccoding" style="float:left;"><b> &nbsp;&nbsp;분류:</b>' + item.place_Cate + '</div>';
output += '		<br/>';							
output += '	</div>';
output += '	<div class="nanumgothiccoding" style="padding:5px; width:80%; margin:auto; border:1px solid #F6F6EE;">';
output += '		' + item.place_Desc;
output += '			</div>';
output += '				';
output += '		</div>';
output += '	</div>'; <!-- class="accordion-content place_card_desc" -->
                    
output += '	                 </div>'; <!-- class="place_card_address" -->
output += '	              </div>';  <!-- class="row" --> 
output += '	           </div>';  <!-- class="thumbnail_content_wrap" --> 
output += '			</div>'; <!-- "thumbnail_caption card-body" -->
output += '		</div>'; <!-- "thumbnail card" -->
output += '</div>'; <!-- card --> 

$('div#products').append(output);
            
            <!-- JS don't move this, TED: make_pano_map() needs to be done at the end-->
            console.log("make_map_pano 예정, index : " + index);
            make_pano_map(words[0], words[1], index);
            <!-- JS don't move this, TED--> 
            }) 
         },
         error : function(request, status, error) {
              console.log("code: " + request.status + "\n" + request.responseText + 
                    "\n" + "error" + error);
         } 
   });
};

/*-------------------------------------------------*/
/*   "장소 등록" 누르면 DB 저장 후 ajax로 목록 다시 불러오기    */
/*-------------------------------------------------*/
$('#place_register_button').click( function(event) {
   var params = $("#place_register_form").serialize();
   $.ajax({
      url : '/drone/placeRegister.pl',
      type : 'post',
      data : params,
      dataType : 'json',
      contentType : 'application/x-www-form-urlencoded; charset=utf-8',  
      success : function(retVal) {
         if(retVal.res == "OK"){
            console.log("DB 연결 (성공), res: " + retVal.res);
            selectData();
         }else{
            console.log("DB 연결 (실패), res: " + retVal.res);
         }
      },
      error : function(request, status, error) {
           console.log("code: " + request.status + "\n" + request.responseText + 
                 "\n" + "error" + error);
      }
   });
   event.preventDefault();   //기본 이벤트 제거
});
</script>

<style>
.wrap {
    text-align: center;
}

a.submit:hover {
    color: rgba(255, 255, 255, 0.85);
    box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
    text-decoration: none !important 
}      



</style>

    