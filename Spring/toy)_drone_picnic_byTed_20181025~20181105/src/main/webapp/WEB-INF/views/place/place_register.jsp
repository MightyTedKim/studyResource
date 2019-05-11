<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<style>
/*-------------------------------*/
/*       place_register            */
/*-------------------------------*/
.accordion-content.register{
	background:white;
	border-radius:25px;
}
 
.dropdown-content.register {
	width: 300px;
	overflow: visible;
 } 

</style>
<script>
$(document).ready(function() {
  $('#accordion_register').find('.accordion-toggle').click(function(){
    $(this).next().slideToggle('easing');
  });
});
</script>

<div id="accordion_register">
	<div class="accordion-toggle"><!-- accordian-toggle -->
		<div class="button_head"> <i class="far fa-plus-square"></i> </div>
	</div>	
	
  	<div class="accordion-content dropdown-content register"><!-- accordian-content -->			
		<form action="/place/create.pl" id="place_register_form" method="post" style="padding: 19px;">
   	      <input type="text" class="form-control" id="uid" name="uid" value="${login.uid}"/>
   	      <input type="text" class="form-control" id="pco_x" name="pco_x" placeholder="클릭한 좌표 x"/>
   	      <input type="text" class="form-control" id="pco_y" name="pco_y" placeholder="클릭한 좌표 y"/>
	      <input type="text" class="form-control" id="padd" name="padd" placeholder=" 클릭한 주소  " readonly/>
  	      <div style="text-align">
		      <h2>장소 등록하기</h2>      
		  </div> 	   
		  <div class="form-group">
		      <input type="text" maxlength="10" class="form-control" id="pname" name="pname" placeholder=" 장소명을 입력해주세요  "/>
		  </div>   
		  <div class="form-group">
		      <select class="form-control" name="pcate">
		         <option value="개인">개인 추천</option>
		         <option value="비행장">드론 비행장</option>
		         <option value="공원">드론 공원</option>
		      </select>    
		  </div>		   
		  <div>
		      <textarea maxlength="70" class="form-control" name="pdesc" rows="3"
		      		 placeholder=" 설명을 입력해주세요 :) " ></textarea>
		  </div>   
		   <br/>
		   <div class="place_register_footer">
		      <b><input type="submit" class="btn-lg" 
		      			id="place_register_button" value="등록"></b>
		   </div> 
		</form> <!-- action="/post" method="post" -->
	</div>
</div>
