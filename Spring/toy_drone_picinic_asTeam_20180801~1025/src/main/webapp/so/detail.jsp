<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.spring.drone.so.SomoimPostVO"%>
<%@ page import="com.spring.drone.so.SomoimVO"%>
<%@ page import="com.spring.drone.so.SMVO"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
   	ArrayList<SomoimPostVO> somoimPostList = (ArrayList<SomoimPostVO>)request.getAttribute("somoimPostList");
	ArrayList<SMVO> smVOList = (ArrayList<SMVO>)request.getAttribute("smVOList");
   	SomoimVO somoimVO = (SomoimVO)request.getAttribute("somoimVO");
   	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Drone_Picnic_Community</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>


<script src="${pageContext.request.contextPath}/resources/js/detail_chat.js"></script> 
<script type="text/javascript">
function deletePost(num){
	
	var con = confirm("글을 지우시겠습니까?");
    if(con == true){
    	$.ajax({
    		url : '/drone/deletePost.somo?num=' + num,
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

function modifyPost(num){
	var params = $("#modifyform" + num).serialize();
	
	$.ajax({
		url : '/drone/modifyPost.somo',
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


function insertPost(num){
	var params = $("#form" + num).serialize();
	//alert('params' + params);
	$.ajax({
		url : '/drone/insertPost.somo',
		type : 'POST',
		data : params,
		dataType : "json",
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(retVal) {
			if (retVal.res == "OK") {
				selectData();
				$('#body').val('');
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
	//alert("<%=somoimVO.getNum()%>");
	$('div#output').empty();
	
	
	$.ajax({
		url : '/drone/getPostList.somo?somoim_num=' + <%=somoimVO.getNum()%>,
		type : 'GET',
		//data : params,
		dataType : "json",
		async: false,
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(data) {
			//alert("data : " + Object.keys(data).length);
			var postcount = "&nbsp;&nbsp;총&nbsp;" + Object.keys(data).length + "개의 댓글이 있습니다. <br />";
			$('div#output').append(postcount);
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
				var num = item.num;
				
				var id = "<%=id%>";
				var output_modify = "";
				if (id != "" & id == item.id){
					output_modify += '<tr><td><a data-toggle="collapse" href="#collapseModify' + index + '" role="button" aria-expanded="false" aria-controls="collapseModify';
					output_modify += index + '">수정하기</a>';
					output_modify += '  │ <a href="#" onclick="deletePost(' + item.num + ')"> 삭제하기</a></td></tr>';
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
				output += item.nickname + '&nbsp;님&nbsp;&nbsp;&nbsp;' + fulldate + '</td></tr>';
				output += output_modify;
				output += "<tr><td><a data-toggle='collapse' href='#collapseReply" + index + "' role='button' aria-expanded='false' aria-controls='collapseReply" + index + "'> 답글달기</a></td></tr>";
				
				output += '<tr><td>' + item.body + '</td></tr>';
				output += '</table>'
				
				/* 글 COLLAPSE 시작 */
				output += '<div class="collapse p-2" id="collapseReply' + index + '">';
				output += '<form id="form'+ item.num +'" action="javascript:insertPost('+ item.num +')" name="form" method="post">';
				output += '<input type="hidden" id="somoim_num" name="somoim_num" value="'+ item.somoim_num +'" />';
				output += '<input type="hidden" id="num" name="num" value="'+ item.num +'" />';
				output += '<input type="hidden" id="id" name= "id" value="<%=id%>" readonly/>';
				output += '<input type="hidden" id="ref" name="ref" value="' + item.ref + '" />';
				output += '<input type="hidden" id="re_level" name="re_level" value="' + item.re_level + '" /> ';
				output += '<input type="hidden" id="re_step" name="re_step" value="' + item.re_step + '" /> ';
				output += '<div class="row pb-0"><div class="col-sm-3"><span class="smallest_logo">NAME</span>';
				output += '</div><div class="col-sm-9 align-left">';
				
				output += '<input type="text" id="nickname" name="nickname" class="border_input korean mb-2 textarea_width" value="<%=nickname%>" readonly/>';
				output += '</div></div><div class="row mb-2"><div class="col-sm-3 align-center"><span class="smallest_logo">CONTENT</span>';
				output += '</div><div class="col-sm-9 align-center">';
				output += '<textarea class="border_input korean textarea_width" rows="5" name="body" id="body" placeholder="메시지 입력"></textarea>';
				output += '</div></div>';
				output += '<button type="submit" class="button_bg_blue korean_center">글쓰기</button>&nbsp;&nbsp;';
				output += '<button class="button_bg_blue korean_center" type="button"';
				output += ' data-toggle="collapse" data-target="#collapseReply';
				output += index + '" aria-expanded="false" aria-controls="collapseReply' + index + '">';
				output += '취소</button></form></div>';
				
				/* 수정부분 COLLAPSE 시작 */
				output += '<div class="collapse p-2" id="collapseModify' + index + '">';
				output += '<form id="modifyform'+ item.num +'" action="javascript:modifyPost('+ item.num +')" name="form" method="post">';
				output += '<input type="hidden" id="somoim_num" name="somoim_num" value="'+ item.somoim_num +'" />';
				output += '<input type="hidden" id="num" name="num" value="'+ item.num +'" />';
				output += '<input type="hidden" id="id" name= "id" value="<%=id%>" readonly/>';
				output += '<div class="row pb-0"><div class="col-sm-3"><span class="smallest_logo">NAME</span>';
				output += '</div><div class="col-sm-9 align-left">';
				
				output += '<input type="text" id="nickname" name="nickname" class="border_input korean mb-2 textarea_width" value="<%=nickname%>" readonly/>';
				output += '</div></div><div class="row mb-2"><div class="col-sm-3 align-center"><span class="smallest_logo">CONTENT</span>';
				output += '</div><div class="col-sm-9 align-center">';
				output += '<textarea class="border_input korean textarea_width" rows="5" name="body" id="body">'+ item.body +'</textarea>';
				output += '</div></div>';
				output += '<button type="submit" class="button_bg_blue korean_center">수정</button>&nbsp;&nbsp;';
				output += '<button class="button_bg_blue korean_center" type="button" data-toggle="collapse" data-target="#collapseModify' + index + '" aria-expanded="false" aria-controls="collapseModify' + index + '">';
				output += '취소</button></form></div>';
				
				output += "</div>";
				
				console.log("output: "	+ output);
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

function joinSo(){
	
	var id = '<%=id%>';
	if (id == null){
		alert("로그인을 하셔야 소모임에 가입하실 수 있습니다.")
		
	}
	else{
	var con = confirm("이 소모임에 가입하시겠습니까?");
	
    if(con == true){
  	
     location.href="template.templ?page=joinSo.somo?id=<%=id%>&num=<%=somoimVO.getNum()%>&nickname=<%=nickname%>";

    }else{}
	}
}


$(document).ready(function() {

	selectData();

	$('#write').click( function(event) {
		var params = $("#form").serialize();
		
		//alert('params' + params);
		$.ajax({
			url : '/drone/insertPost.somo',
			type : 'POST',
			data : params,
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			success : function(retVal) {
				if (retVal.res == "OK") {
					selectData();
					$('#body').val('');
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
</head>

<body>
<div class="container"> 
   <!-- 소모임 대문 사진, 메뉴 -->  
<div class="row mt-1 mb-1 pt-5"
	style="background-image: url('<spring:url value='/image/somo_logo/' /><%=somoimVO.getStoredFileName()%>'); background-size: cover; background-position: center; ">
	<div class="col-lg-12 line_color_yellow_b text_align_center mb-5">
		<p class="small_logo text_border">YOUR CIRCLE</p>
		<p class="korean_center text_border"><%=somoimVO.getName() %>&nbsp;|&nbsp;<%=somoimVO.getIntro() %></p>
	</div>
	<br /> <br />
</div>

<div class="row mt-1 mb-1 pt-5">
	<div class="col-lg-12 text_align_center">
		<%
		int yes = 0;
		if (id != null){
			for (int i = 0;i < smVOList.size();i++){
				SMVO smvo = smVOList.get(i);
				if (smvo.getSm_id().equals(id) & smvo.getSm_id().equals(somoimVO.getFounder())){
					yes = 1;
				}
				if (smvo.getSm_id().equals(id)){
					yes = 2;
				}
				else{
					yes = 0;
				}
			}
			if (yes == 1){
		%>
		<span class="korean_center"><a href="#"><%=nickname %> 님이 창단한 소모임입니다</a> │ <a href="#" data-toggle="modal" data-target="#memberModal">가입회원</a></span>
		<%
			}
			else if (yes == 2){
		%>
		<span class="korean_center"><a href="#" onclick="joinSo(); return false;"><%=nickname %> 님이 가입하신 소모임입니다</a> │ 소모임사진첩 │ <a href="#" data-toggle="modal" data-target="#memberModal">가입회원</a></span>
		<%
			}
			if (yes == 0){
		%>
		<span class="korean_center"><a href="#" onclick="joinSo(); return false;">소모임 가입하기</a> │ 소모임사진첩 │ 가입회원</span>
		<%
				}
			}
		
		else{
		%>
		<span class="korean_center"><a href="#" onclick="joinSo(); return false;">소모임 가입하기</a> │ 소모임사진첩 │ 가입회원</span>
		<%
		}
		%>
		
		<!-- memberModal -->
		<div class="modal fade" id="memberModal" tabindex="-1" role="dialog" aria-labelledby="memberModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title korean_board" id="memberModalLabel">소모임 회원 목록</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body korean_board">
		      		<ol class="text-left">
		      <%
		      for (int i = 0;i < smVOList.size();i++){
					SMVO smvo = smVOList.get(i);
		      %>
		      			<li><%=smvo.getSm_nickname()%></li>
		      <%
		      }
		      %>
		      		</ol>
		      </div>
		      
		    </div>
		  </div>
		</div>

	</div>
</div>

	     <!-- 본문 -->
      <div class="row">
         <!-- 약속 등록 -->
         <jsp:include page="../ap/ap_make_appointment.jsp" />
      </div>
        

      <div class="row">
         <div class="so_content col-lg-9">
      <!-- 소모임 게시글-->
    
   <div class="row pt-1">
		<div class="col-lg-12 line_color_yellow_b text_align_center mb-3">
			<p class="detail_logo">CIRCLE PHOTOGRAPHY</p>
			<p class="korean">우리 회원들이 찍은 사진이닷@</p>
		</div>
	</div>
   
		<!-- 캐러셀 -->

<div class="row blog mt-2 pr-5">
                <div class="col-md-12 p-2">
                    <div id="blogCarousel" class="carousel slide" data-ride="carousel">

                        <ol class="carousel-indicators">
                            <li data-target="#blogCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#blogCarousel" data-slide-to="1"></li>
                        </ol>

                        <!-- Carousel items -->
                        <div class="carousel-inner">

                            <div class="carousel-item active">
                                <div class="row">
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#1">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/1.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#2">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/2.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#3">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/3.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#4">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/4.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                </div>
                                <!--.row-->
                            </div>
                            <!--.item-->

                            <div class="carousel-item">
                                <div class="row">
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#5">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/5.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#6">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/6.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#7">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/7.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                    <div class="col-md-3" style="height:140px; width:auto; overflow: hidden;">
                                        <a href="#" data-toggle="modal" data-target="#8">
                                            <img src="${pageContext.request.contextPath}/resources/img/carou/8.jpg" alt="Image" style="height: 100%; max-width:100%;">
                                        </a>
                                    </div>
                                </div>
                                <!--.row-->
                            </div>
                            <!--.item-->

                        </div>
                        <!--.carousel-inner-->
                    </div>
                    <!--.Carousel-->

                </div>
            </div>
           <!-- 캐러셀 끝 -->
           
           <!-- 캐러셀을 위한 모달 시작 -->
           <!-- Modal -->
           <% 
           
           for (int i = 1;i<9;i++){
           %>
			<div class="modal fade" id="<%=i%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">사진첩</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        	<img src="${pageContext.request.contextPath}/resources/img/carou/<%=i %>.jpg" alt="Image" class="w-100" />
                                        
			      </div>
			    </div>
			  </div>
			</div>
			<%
           }
			%>
		<!-- 캐러셀을 위한 모달 끝 -->
           	
      <!-- 소모임 게시글-->
	<div class="row mt-3">
      <div class="col-sm-12 mb-0 p-0">
         <p class="detail_logo">TALK</p>
         <p class="korean">소모임 소통 창구입니다.</p>
      </div>
   </div>

	
	
	<div class="row mt-0">
		<div class="col-sm-12 shadow bg-white rounded korean_center mb-0 p-4">
		<%
		if (yes == 1 | yes == 2){
		%>
		
			<form id="form" name="form" method="post">
				<input type="hidden" id="somoim_num" name="somoim_num" value="<%=somoimVO.getNum() %>" />
				<input type="hidden" id="num" name="num" value="0" />
				<input type="hidden" id="id" name= "id" value="<%=id %>" />
				<input type="hidden" id="ref" name="ref" value="0" />
				<input type="hidden" id="re_level" name="re_level" value="0" /> 
				<input type="hidden" id="re_step" name="re_step" value="0" /> 
				<div class="row pb-0">
					<div class="col-sm-3">
						<span class="smallest_logo">NAME</span>
					</div>
					<div class="col-sm-9 align-left">
						<input type="text" id="nickname" name="nickname" class="border_input korean mb-2 textarea_width"
					value="<%=nickname %>" readonly/>
					</div>
				</div>
				<div class="row mb-2">
					<div class="col-sm-3 align-center">
						<span class="smallest_logo">CONTENT</span>
					</div>
					<div class="col-sm-9 align-center">
						<textarea class="border_input korean textarea_width" rows="5" name="body" id="body" placeholder="메시지 입력"></textarea>
					</div>
				</div>
				<input type="submit" id="write" class="button_bg_blue korean_center" value="글쓰기">
				<input type="reset" class="button_bg_blue korean_center" value="지우기">
			</form>
		<%
		}
		else{
		%>
			<p class="korean">해당 소모임에 가입하시면 글을 남기실 수 있습니다</p>
		<%
		}
		%>
		</div>
	</div>
	
	 <div class="row mt-0">
      <div class="col-sm-12 mb-3 p-1" id="newest_output">
         
      </div>
   </div>
   <div class="row mt-0">
      <div class="col-sm-12 shadow bg-white rounded korean mb-0 p-4" id="output">
         
      </div>
   </div>
   
   <div class="row mt-0">
      <div class="col-sm-12 mb-3 p-4" id="older_ouput">
         
      </div>
   </div>
</div>
         
          <div class="so_sidemenu col-lg-3">
            <!-- appointmentList -->                     
             <div class="row pt-1">
               <jsp:include page="./so_getAppointList.jsp" />
            </div> 
            <br/>
            <!-- memberList -->            
            <div class="row pt-1">
               <jsp:include page="./so_getMemberList.jsp" />
            </div>
            
         </div>  
      </div>
     </div>
<script type="text/javascript">

w = new WebSocket("ws://localhost:8080/drone/broadcasting?nickname=<%=nickname%>");
   w.onopen = function() {
      //alert("WebSocket Connected");
   }
   w.onmessage = function(e) {
      log(e.data.toString());
   }
   w.onclose = function(e) {
      log("WebSocket closed");
   }
   w.onerror = function(e) {
      log("WebSocket error");
   }
   window.onload = function() {
      document.getElementById("send_button").onclick = function() {
         if (document.getElementById("input").value == "")      //메세지 입력란이 공백일 경우
            {
            alert("메세지를 입력하세요");
            }
         else{
            var input = document.getElementById("input").value;
            w.send("<%=nickname%>" + "/" + input);
            document.getElementById("input").value = ""; 
         }
      }; document.getElementById("chat").scrollTop = document.getElementById("chat").scrollHeight;

   }

   var log = function(s){
      var m = s.split("/");
      if(m[0] === 'message'){      //메세지일 경우
         if(m[1] == "<%=nickname%>") {      //메세지 보낸 사람이 본인일 경우 출력
            var div1 = document.createElement("div");
            div1.setAttribute("class", "outgoing_msg");
            var div2 = document.createElement("div");
            div2.setAttribute("class", "sent_msg");
            var p = document.createElement("p");
            var span = document.createElement("span");
            span.setAttribute("class", "time_date");
              var date = new Date();
              var hour = date.getHours();
              p.innerText = "<%=nickname%>" + "\n" + "\n" + m[2];
              if(hour <= 12) {
                 span.innerText = hour + "시" + date.getMinutes() + "분" + "AM";
              }
              else {
                 span.innerText = hour-12 + "시" + date.getMinutes() + "분" + "PM";
              }
              div1.appendChild(div2);
              div2.appendChild(p);
              p.appendChild(span);
              $('#chat').append(div1);
         }
         else{      //본인이 아닌 사람의 메세지 출력
            var div1 = document.createElement("div");
            div1.setAttribute("class", "incoming_msg");
            var div2 = document.createElement("div");
            div2.setAttribute("class", "incoming_msg_img");
            var div3 = document.createElement("div");
            div3.setAttribute("class", "received_msg");
            var div4 = document.createElement("div");
            div4.setAttribute("class", "received_withd_msg");
            var p = document.createElement("p");
            var span = document.createElement("span");
            span.setAttribute("class", "time_date");
            var date = new Date();
              var hour = date.getHours();
              p.innerText = m[1] + "\n" + "\n" + m[2];
              if(hour <= 12) {
                 span.innerText = hour + "시" + date.getMinutes() + "분" + "AM";
              }
              else {
                 span.innerText = hour-12 + "시" + date.getMinutes() + "분" + "PM";
              }
              div1.appendChild(div2);
              div2.appendChild(div3);
              div3.appendChild(div4);
              div4.appendChild(p);
              p.appendChild(span);
              $('#chat').append(div1);
         } 
      }
      else if(m[0] === 'nicknameList'){      //닉네임리스트일 경우
         $('#inbox_chat').empty();
         for(var i=1; i<m.length; i++){
            if(i == m.length-1){ continue;}
            var div1 = document.createElement("div");
            div1.setAttribute("class", "chat_list");
            var div2 = document.createElement("div");
            div2.setAttribute("class", "chat_people");
            var div3 = document.createElement("div");
            div3.setAttribute("class", "chat_img");
            var div4 = document.createElement("div");
            div4.setAttribute("class", "chat_ib");
            var h5 = document.createElement("h5");
            h5.setAttribute("id", "nicknameList");
            h5.innerText = "@" + m[i];
            
              div1.appendChild(div2);
              div2.appendChild(div3);
              div3.appendChild(div4);
              div4.appendChild(h5);
              
              $('#inbox_chat').append(div1);
              
         }
         
      } document.getElementById("chat").scrollTop = document.getElementById("chat").scrollHeight; 
   }

   function enterkey() {
        if (window.event.keyCode == 13) {
             // 엔터키가 눌렸을 때 실행할 내용
             if (document.getElementById("input").value == "")
            {
            alert("메세지를 입력하세요");
            }
         else{
            var input = document.getElementById("input").value;
            w.send("<%=nickname%>" + "/" + input);
            document.getElementById("input").value = "";
         }
      }
      document.getElementById("chat").scrollTop = document
            .getElementById("chat").scrollHeight;
   }
</script>
</body>
</html>