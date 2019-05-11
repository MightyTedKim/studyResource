<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
            

<!-- <div class="col-lg-12 line_color_yellow_b text_align_center mb-3 pl-3" style="height: 68px">
	<p class="detail_logo">
		<span>MEMBER LIST</span>
		<span style="float:right;"><b> &#43 </b></span>
	</p>
    <p class="korean">소모임 회원들을 확인하세요</p>
</div> -->

            <div class="row pt-1 align-center pl-3">
               <div class="col-sm-12">
                     <div class="messaging"> 
                        <div class="inbox_msg">
                                 
                        <div class="mesgs">
                           <div class="somoim_name smaller_logo p-1" align="center" style="font-size:30px">MEMBER CHAT</div>
                           <div class="somoim_desc p-1 korean_board" align="center" style="font-size:15px; padding-top:10px;">
                           대화를 나눌 수 있습니다
                           </div>
                           <div id="chat" class="msg_history">
                              <!-- 채팅 들어가는 곳 -->
               </div>
               <!-- 채팅 쓰는곳 -->
               <div class="type_msg">
                  <div class="input_msg_write">
                     <input type="text" class="write_msg korean_board" id="input"
                        onkeyup="enterkey();" placeholder="메세지를 입력하세요" />
                     <button id="send_button" class="msg_send_btn" type="button">
                        <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
                     </button>
                  </div>
               </div>
            </div>
         </div>

         <!-- <p class="text-center top_spac small_font">
            chat designed by <a target="_blank" href="#">Sgo_Lee</a>
         </p> -->

      </div>
   </div>
            </div>


