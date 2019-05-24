<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="col-lg-12 line_color_yellow_b text_align_center mb-3 pl-0 pointer" onclick="appoint_click()">         
   <p class="detail_logo" style="font-size:30px; padding-bottom: 15.5px;">
      <span>APPOINTMENT LIST</span>
      <span style="float:right;"><b> &#43 </b></span>
   </p>
    <p class="korean">공지사항을 확인해주세요</p>
</div>

<div class="col-lg-12 line_color_yellow_b text_align_center mb-3 pl-0 pb-4"> 
    <div id="appointment_list_ajax_main"></div> <!-- 리스트 넣을 공간 -->
</div>

<style>
#appointment_list_ajax_main{
   text-align:left;
}
</style>

<script>

function appoint_click() {
   $('.appointment_wrap').toggle(   );
};
</script>