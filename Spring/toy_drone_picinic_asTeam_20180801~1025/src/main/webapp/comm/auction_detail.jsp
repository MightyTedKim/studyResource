<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.drone.co.AuctionVO"%>
<%@ page import="com.spring.drone.co.AlbumReplyVO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
      
<%

   String id = (String)session.getAttribute("id");
   String nickname = (String)session.getAttribute("nickname");
   Integer authority = (Integer)session.getAttribute("authority");

   AuctionVO vo = (AuctionVO) request.getAttribute("auctionVO");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Auction detail</title>
<style>
#carouselExampleIndicators img {
        width: 650px;
        height: 500px;
        max-height: 500px;
        border-radius: 15px;

   }
   
#carouselExampleIndicators {
 border-radius: 15px;

}

   
</style>   
</head>
<body>
<div class="container">

      <div class="row line_color_yellow_b mt-1 mb-1 pt-5">
         <div class="col-lg-12 text_align_center">
             <p class="small_logo">AUCTION</p>
             <p class="korean_center">중고 장터에서 드론을 팔아보세요</p>
         </div>
      </div>
      <div class="row mt-1 mb-1 pt-3">
         <div class="col-lg-12 text_align_center">
           <p class="korean_center"><a href="template.templ?page=auction_list.co">게시판 목록으로 돌아가기</a></p>
         </div>
      </div>

   
   <div class="col-sm-12 m-2 justify-content-center align-items-center">
      <hr>
       <div style="text-align:center; font-size:50px;"><strong>제목 : <%=vo.getTitle()%></strong></div>
       <hr>
       <span style="text-align:right;">&nbsp;&nbsp;&nbsp;<%=sdf.format(vo.getPdate()) %>&nbsp; 조회수:&nbsp;<%=vo.getReadcount()%></span>
       <span style="text-align:right; float: right"><a href="template.templ?page=auction_list_modify_form.co?num=<%=vo.getNum()%>">글 수정하기</a>&nbsp;&nbsp;&nbsp; <a href="template.templ?page=auction_delete.co?num=<%=vo.getNum()%>">글 삭제하기</a></span>
      <br>
         
   <!-- 캐러셀 -->   
    <div class="row" id="row1">
       <div class="col-sm-7 justify-content-left align-items-center"> 
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">    
         <ol class="carousel-indicators">         
               <%
                  StringTokenizer parsed = new StringTokenizer(vo.getStoredFileName(), "///", false);
               ArrayList<String> parsedSet = new ArrayList<String>();
               while(parsed.hasMoreTokens()){
                  parsedSet.add(parsed.nextToken());
               }
               
            %>
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <%
               for (int i = 1;i<parsedSet.size();i++){
               %>
             <li data-target="#carouselExampleIndicators" data-slide-to="<%=i%>"></li>
            <%
               }
            %>
          </ol>
          
        <div class="carousel-inner">
        <div class="carousel-item active">
         <img class="d-block w-100" src="<spring:url value='/image/auction/' /><%=parsedSet.get(0).toString()%>" alt="<%=vo.getTitle()%>">
        </div>
     
           <%
            for (int i = 1;i<parsedSet.size();i++){
         %>
     
     
        <div class="carousel-item">
            <img class="d-block w-100" src="<spring:url value='/image/auction/' /><%=parsedSet.get(i).toString()%>" alt="<%=vo.getTitle()%>">
        </div>
     
           <%
                  }
           %>
    
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
   </div>

       <div class="col-sm-5 justify-content-right align-items-center" > 
           <table class="table" style="font-size:30px">
               <tbody>
                  <tr>
                      <th scope="row">ID : <%=vo.getId()%> </th>
                   </tr>
                    <tr>
                       <th scope="row">HP : <%=vo.getPh()%></th>
                   </tr>
                   <tr>
                       <th scope="row">제품명 : <%=vo.getPname()%> </th>
                   </tr>
                   <tr>
                       <th scope="row">가격 : <%=vo.getPrice()%></th> 
                   </tr>
                    <tr>
                      <th scope="row">판매 상황 : &nbsp;<h style="color:#f45a49;"><%=vo.getSales()%></h></th>
                   </tr>
                   <tr>
                       <th scope="row" style="font-size:  15px;"> 
                           <br> 
                           &nbsp; <%=vo.getBody()%> 
                           </th>
                   </tr>
               </tbody>
           </table>
       </div>
   
    </div>                          
</div>

<!-- 댓글 -->
<div class="row mt-5">
      <div class="shadow bg-white rounded korean mb-3" style="font-size:20px; width:90%; margin:auto" id="output"> </div>
      
      <div class="shadow bg-white rounded korean_center mb-3 p-2" style="font-size:20px; width:90%; margin:auto">
         <span class="detail_logo">TALK  </span>
         <span class="korean ml-3" style="font-size:20px;">답글을 남겨주세요</span> 
      
         <form id="form" name="form" method="post">
            <input type="hidden" id="num" name="num" value="<%=vo.getNum() %>" />
            <input type="hidden" id="renum" name="renum" value="0" />
            <input type="hidden" id="reid" name= "reid" value="<%=id %>" />
            <input type="hidden" id="ref" name="ref" value="0" />
            <input type="hidden" id="re_level" name="re_level" value="0" /> 
            <input type="hidden" id="re_step" name="re_step" value="0" /> 
            <div class="row pb-0">
               <div class="col-sm-3">
                  <span class="smallest_logo">NAME</span>
               </div>
               <div class="col-sm-9 align-left">
                  <input type="text" style="font-size:20px" id="renickname" name="renickname" class="border_input korean mb-2 textarea_width"
               value="<%=nickname %>" readonly/>
               </div>
            </div>
            <div class="row mb-2 mt-2">
               <div class="col-sm-3 align-center">
                  <span class="smallest_logo">CONTENT</span>
               </div>
               <div class="col-sm-9 align-center">
                  <textarea class="border_input korean textarea_width" style="padding:12px 20px; font-size:20px" rows="5" name="rebody" id="rebody" placeholder="메시지 입력"></textarea>
               </div>
            </div>
            <div style="float:center;">
	            <button type="submit" id="write" class="btn btn-lg button_bg_blue korean_center">글쓰기</button>
	            <button type="reset" class="btn btn-lg button_bg_blue korean_center">지우기</button>
            </div>
         </form>
	</div>
</div>
 
   
   
   
</div> <!-- class="container -->



<div class="row line_color_yellow_b mt-1 mb-1 pt-5"></div> 

<!-- delete댓글 -->
<script type="text/javascript">
   function deleteReply(renum){
      alert(renum);
      var con = confirm("댓글을 지우시겠습니까?");
      
       if(con == true){
          $.ajax({
             url : '/drone/deleteAuctionReply.co?renum=' + renum,
             type : 'GET',
             dataType : "json",
             contentType : 'application/x-www-form-urlencoded; charset=utf-8',
             success : function(retVal) {
                if (retVal.res == "OK") {
                   selectData();
                } else {
                   alert("게시글 삭제 실패");
                }
             },
              error : function(request,status,error){
                 console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
              }
          });
          //기본 이벤트 제거
          event.preventDefault();
       }
       else{
          
       }
      
   }
   
   function modifyReply(renum){
      var params = $("#modifyform" + renum).serialize();
      
      $.ajax({
         url : '/drone/modifyAuctionReply.co',
         type : 'POST',
         data : params,
         dataType : "json",
         contentType : 'application/x-www-form-urlencoded; charset=utf-8',
         success : function(retVal) {
            if (retVal.res == "OK") {
               selectData();
            } else {
               alert("게시글 수정 실패");
            }
         },
          error : function(request,status,error){
             console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
          }
      });
      //기본 이벤트 제거
      event.preventDefault();
   }
   
   
   function insertReReply(num){
      var params = $("#form" + num).serialize();
      //alert('params' + params);
      $.ajax({
         url : '/drone/insertAuctionReply.co',
         type : 'POST',
         data : params,
         dataType : "json",
         contentType : 'application/x-www-form-urlencoded; charset=utf-8',
         success : function(retVal) {
            if (retVal.res == "OK") {
               selectData();
               $('#renickname').val('');
               $('#rebody').val('');
            } else {
               alert("게시글 입력 실패");
            }
         },
          error : function(request,status,error){
             console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
          }
      });
      //기본 이벤트 제거
      event.preventDefault();
   }
   function selectData() {
      //table내부 내용을 제거(초기화)
      $('div#output').empty();
            
      $.ajax({
         url : '/drone/getAuctionReplyList.co?num=' +<%=vo.getNum()%>,
         type : 'GET',
         //data : params,
         dataType : "json",
         async: false,
         contentType : 'application/x-www-form-urlencoded; charset=utf-8',
         success : function(data) {
            //alert("data : " + Object.keys(data).length);
            var replycount = "&nbsp;&nbsp;총&nbsp;" + Object.keys(data).length + "개의 댓글이 있습니다. <br />";
            $('div#output').append(replycount);
            $.each(data, function(index, item) {
               
               //alert("item.re_level : " + item.re_level);
               //console.log("co_p_viewindex, ajax, index: " + index);
               var re_level_space = 0
               if (item.re_level == 0){
                  re_level_space = 1;
               }
               else{
                  re_level_space = item.re_level*50;
               }
               var renum = item.renum;
               
               var id = "<%=id%>";
				var output_modify = "";
				if (id != "" & id == item.reid){
					output_modify += '<tr><td><a data-toggle="collapse" href="#collapseModify' + index + '" role="button" aria-expanded="false" aria-controls="collapseModify';
					output_modify += index + '">수정하기</a>';
					output_modify += '  │ <a href="#" onclick="deleteReply(' + item.renum + ')"> 삭제하기</a></td></tr>';
				}
				else{
					output_modify = "";
				}
				
				var date = new Date(item.pdate);
				var month = date.getMonth()+1;
				var day = date.getDate();
				var year = date.getFullYear();
				var hourString = date.getHours();
				var hour = Number(hourString);
				if (hour >= 12){
					hour = "오후 " + (hour-12) + "시 ";
				}
				else{
					hour = "오전 " + hour + "시 ";
				}
				var minute = date.getMinutes() + "분 ";
				var second = date.getSeconds() + "초 ";
				var fulldate = year + "-" + month + "-" + day + "&nbsp;&nbsp;" + hour + minute + second;
				
				var output = "<table class='mt-3 table table-sm table-borderless'>";
				output += "<tr><td rowspan='4' width='" + re_level_space + "px;' bgcolor='#eff3f9'></td>";
				output += '<td>';
				output += item.renickname + '&nbsp;님&nbsp;&nbsp;&nbsp;' + fulldate + '</td></tr>';
				output += output_modify;
				output += "<tr><td><a data-toggle='collapse' href='#collapseReply" + index + "' role='button' aria-expanded='false' aria-controls='collapseReply" + index + "'> 답글달기</a></td></tr>";
				
				output += '<tr><td>' + item.rebody + '</td></tr>';
				output += '</table>'
				
               
               /* 대댓글 COLLAPSE 시작 */
               output += '<div class="collapse p-2" id="collapseReply' + index + '">';
               output += '<form id="form'+ item.renum +'" action="javascript:insertReReply('+ item.renum +')" name="form" method="post">';
               output += '<input type="hidden" id="num" name="num" value="'+ <%=vo.getNum() %> +'" />';
               output += '<input type="hidden" id="renum" name="renum" value="'+ item.renum +'" />';
               output += '<input type="hidden" id="reid" name= "reid" value="<%=id%>" readonly/>';
               output += '<input type="hidden" id="ref" name="ref" value="' + item.ref + '" />';
               output += '<input type="hidden" id="re_level" name="re_level" value="' + item.re_level + '" /> ';
               output += '<input type="hidden" id="re_step" name="re_step" value="' + item.re_step + '" /> ';
               output += '<div class="row pb-0"><div class="col-sm-3"><span class="smallest_logo">NAME</span>';
               output += '</div><div class="col-sm-9 align-left">';
               
               output += '<input type="text" id="renickname" name="renickname" class="border_input korean mb-2 textarea_width" value="<%=nickname%>" readonly/>';
               output += '</div></div><div class="row mb-2"><div class="col-sm-3 align-center"><span class="smallest_logo">CONTENT</span>';
               output += '</div><div class="col-sm-9 align-center">';
               output += '<textarea class="border_input korean textarea_width" rows="5" name="rebody" id="rebody" placeholder="메시지 입력"></textarea>';
               output += '</div></div>';
               output += '<button type="submit" class="btn btn-lg button_bg_blue korean_center">글쓰기</button>&nbsp;&nbsp;';
               output += '<button class="btn btn-lg button_bg_blue korean_center" type="button" data-toggle="collapse" data-target="#collapseReply' + index + '" aria-expanded="false" aria-controls="collapseReply' + index + '">';
               output += '취소</button></form></div>';
               
               /* 수정부분 COLLAPSE 시작 */
               output += '<div class="collapse p-2" id="collapseModify' + index + '">';
               output += '<form id="modifyform'+ item.renum +'" action="javascript:modifyReply('+ item.renum +')" name="form" method="post">';
               output += '<input type="hidden" id="num" name="num" value="'+ <%=vo.getNum() %> +'" />';
               output += '<input type="hidden" id="renum" name="renum" value="'+ item.renum +'" />';
               output += '<input type="hidden" id="reid" name= "reid" value="<%=id%>" readonly/>';
               output += '<div class="row pb-0"><div class="col-sm-3"><span class="smallest_logo">NAME</span>';
               output += '</div><div class="col-sm-9 align-left">';
               
               output += '<input type="text" id="renickname" name="renickname" class="border_input korean mb-2 textarea_width" value="<%=nickname%>" readonly/>';
               output += '</div></div><div class="row mb-2"><div class="col-sm-3 align-center"><span class="smallest_logo">CONTENT</span>';
               output += '</div><div class="col-sm-9 align-center">';
               output += '<textarea class="border_input korean textarea_width" rows="5" name="rebody" id="rebody">'+ item.rebody +'</textarea>';
               output += '</div></div>';
               output += '<button type="submit" class="btn btn-lg button_bg_blue korean_center">수정</button>&nbsp;&nbsp;';
               output += '<button class="btn btn-lg button_bg_blue korean_center" type="button" data-toggle="collapse" data-target="#collapseModify' + index + '" aria-expanded="false" aria-controls="collapseModify' + index + '">';
               output += '취소</button></form></div>';
               
                     
               output += "</div>";
               output += '';
   
               
               console.log("output: "   + output);
               $('div#output').append(output);
            });
         },
         error : function(jqXHR, exception) {
            var msg = '';
              if (jqXHR.status === 0) {
                  msg = 'Not connect.\n Verify Network.';
              } else if (jqXHR.status == 404) {
                  msg = 'Requested page not found. [404]';
              } else if (jqXHR.status == 500) {
                  msg = 'Internal Server Error [500].';
              } else if (exception === 'parsererror') {
                  msg = 'Requested JSON parse failed.';
              } else if (exception === 'timeout') {
                  msg = 'Time out error.';
              } else if (exception === 'abort') {
                  msg = 'Ajax request aborted.';
              } else {
                  msg = 'Uncaught Error.\n' + jqXHR.responseText;
              }
              alert("selectData error: " + msg);
         }
      });
   
   }
   $(document).ready(function() {
      selectData();
   
      $('#write').click( function(event) {
         var params = $("#form").serialize();
         
         // alert('params' + params);
         $.ajax({
            url : '/drone/insertAuctionReply.co',
            type : 'POST',
            data : params,
            dataType : "json",
            contentType : 'application/x-www-form-urlencoded; charset=utf-8',
            success : function(retVal) {
               if (retVal.res == "OK") {
                  selectData();
                  $('#renickname').val('');
                  $('#rebody').val('');
               } else {
                  alert("게시글 입력 실패");
               }
            },
              error : function(request,status,error){
                 console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
              }
         });
         //기본 이벤트 제거
         event.preventDefault();
      });
      selectData();
   });
</script>

</body>
</html>