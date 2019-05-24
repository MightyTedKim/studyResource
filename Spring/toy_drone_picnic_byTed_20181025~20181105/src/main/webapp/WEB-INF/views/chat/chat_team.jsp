<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page session="true" %>

<link href="/resources/css/chat.css" rel="stylesheet">
<!-- Bootstrap-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!------ Include the above in your HEAD tag ---------->

<html>
<head>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
$(document).ready(function(){
	window.resizeTo(1400, 730);

	$('.chat_list').mouseover(function(){
		this.style.cursor = 'pointer';
		this.style.backgroundColor = '#ebebeb';
	}).mouseout(function(){
		this.style.backgroundColor = '#f8f8f8';
	}).click(function(){
		var tagId = $(this).attr('id');
		location.href="./chat_team.ch?region="+tagId;
	});
	
});
	var log = function(s){
		var d = new Date();
		var m = s.split("/");
		console.log("s= ", s);
		console.log("m= ", m);
		var msg="";
		if(m[0] === 'message'){
			if(m[1] === '${login.uname}'){
				console.log("out, ${login.uname}, " + m[1]);
				msg += '<div class="outgoing_msg"><div class="sent_msg"><p>';
				msg += m[2];
				msg += '</p><span class="time_date">';
				msg += d.getHours() + ':' + d.getMinutes();
				msg += ' | ' + (d.getMonth() + 1) + '월 ' + d.getDate() + '일</span></div></div></div>'
				$('#messageList').append(msg);
			}else{
				console.log("in, ${login.uname}, " + m[1]);
				msg += '<div class="incoming_msg"><div class="received_msg"> <div class="received_withd_msg"><p>';
				msg += m[2];
				msg += '</p><span class="time_date">';
				msg += d.getHours() + ':' + d.getMinutes();
				msg += ' | ' + (d.getMonth() + 1) + '월 ' + d.getDate() + '일</span></div></div></div>'
				$('#messageList').append(msg);
			}
		}else if(m[0] === 'nameList'){
			$("#nameList").empty();
			
			for(var i=1; i<m.length; i++){
				var inhtml = "";
				if(i == m.length-1){ continue;}
				inhtml += '<div class="name_list"><div class="chat_people"><div class="chat_img">';
				inhtml += '<img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>';
				inhtml += '<div class="chat_ib"><h5>';
				inhtml += m[i];
				inhtml += '<span class="chat_date">나</span></h5></div></div></div>';
				$("#nameList").append(inhtml);
			}
		}else if(m[0] === 'remove'){
			$("#nameList").empty();
			for(var i=1; i<m.length; i++){
				var inhtml = "";
				if(i == m.length-1){ continue;}
				inhtml += '<div class="name_list"><div class="chat_people"><div class="chat_img">';
				inhtml += '<img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>';
				inhtml += '<div class="chat_ib"><h5>';
				inhtml += m[i];
				inhtml += '<span class="chat_date">';
				inhtml += '</span></h5></div></div></div>';
				$("#nameList").append(inhtml); 
			}
		}
	} //log()함수 정의 끝

// 	w = new WebSocket("ws://localhost:8080/broadcasting?region=${region}");
 	w = new WebSocket("ws://192.168.0.59:8080/broadcasting?region=${region}");
	w.onopen = function(){
		alert('WebSocket Connected!!!');
	}
	w.onmessage = function(e){
		log(e.data.toString());
	}
	w.onclose = function(e){
		log("WebSocket Closed");
	}
	w.onerror = function(e){
		log("WebSocket error!!!");
	}

	window.onload = function(){
		document.getElementById("send_button").onclick = function(){
				var input = document.getElementById("input").value;
				if(input == null || input == ""){
					return false;
				}
				w.send("${uname}/" + input);
				document.getElementById("input").value = "";
			}
	}
</script>
</head>
<body>
<style>
.chat{
    border: 1px solid #c4c4c4;
    padding:5px;
}
</style>
<div class="container">
<div class="row">

	<div class="col-md-2">  
        <div class="inbox_chatList">      
	 		<div class="headind_srch">
				<div class="recent_heading">
					<h4>소모임</h4>
				</div>
			</div> 
	        <!-- 1 -->
	        <div class="chat_list" id="seoul">
            <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>서울</h5>
                </div>
              </div>
            </div>
			<!-- 2 -->
	        <div class="chat_list" id="busan">
	              <div class="chat_people">
	                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
	                <div class="chat_ib">
	                  <h5>부산</h5>
	                </div>
	              </div>
        	</div>        
   		</div> <!-- inbox_chatList -->
    </div><!-- col-md-2 -->
    
	<div class="col-md-6">
		<div class="msg_history" id='messageList'></div> 
		 
		<div class="type_msg">
			<div class="input_msg_write">
				<input id="input" type="text" class="write_msg" placeholder="Type a message" />
				<button id="send_button" class="msg_send_btn" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
			</div>
		</div>
    </div> <!-- col-md-6 -->
     
    <div class="col-md-3">	        
		<div class="headind_srch">
			<div class="recent_heading">
				<h4>채팅 참여자</h4>
			</div>
		</div>
		<div class="inbox_chat" id="nameList"></div>
	</div> <!-- col-md-3 -->
	

</div> <!-- row -->
</div> <!-- container -->


