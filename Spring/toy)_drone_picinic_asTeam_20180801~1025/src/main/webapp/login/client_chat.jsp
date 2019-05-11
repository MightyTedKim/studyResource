<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="com.spring.drone.me.MemberVO"%>
<%
	String nickname = (String)session.getAttribute("nickname");
	System.out.println("login, client_chat.jsp, nickname: " + nickname);
%>
<html>
<head>
<meta charset="UTF-8">
<title>client chat</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoadCallback" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
<script type="text/javascript">
	
	w = new WebSocket("ws://localhost:8080/finalsocket/broadcasting?nickname=<%=nickname%>");
	w.onopen = function() {
		alert("WebSocket Connected");
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
			if (document.getElementById("input").value == "")		//메세지 입력란이 공백일 경우
				{
				alert("메세지를 입력해주세요");
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
		if(m[0] === 'message'){		//메세지일 경우
			if(m[1] == "<%=nickname%>") {		//메세지 보낸 사람이 본인일 경우 출력
				var div1 = document.createElement("div");
				div1.setAttribute("class", "outgoing_msg");
				var div2 = document.createElement("div");
				div2.setAttribute("class", "sent_msg");
				var p = document.createElement("p");
				var span = document.createElement("span");
				span.setAttribute("class", "time_date");
		        var date = new Date();
		        var hour = date.getHours();
		        p.innerText = "사용자가 말했습니다. " + "\n" + "\n" + m[2];
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
			else{		//본인이 아닌 사람의 메세지 출력
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
		else if(m[0] === 'nicknameList'){		//닉네임리스트일 경우
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
				alert("메세지를 입력해주세요 :)");
				}
			else{
				var input = document.getElementById("input").value;
				w.send("<%=nickname%>" + "/" + input);
				document.getElementById("input").value = ""; 
			}
		} document.getElementById("chat").scrollTop = document.getElementById("chat").scrollHeight; 
	}
	

</script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">
<style>
.container_client_chat{max-width:1170px; margin:auto; float: center;}
/* img{ max-width:100%;} */
.inbox_people {
  background: #f8f8f8 none repeat scroll 0 0;
  float: left;
  overflow: hidden;
  width: 208px; border-right:1px solid #c4c4c4;
}
.inbox_msg {
  border: 1px solid #c4c4c4;
  clear: both;
  overflow: hidden;
  float : center;
}
.top_spac{ margin: 20px 0 0;}


.recent_heading {float: left; width:40%;}
.srch_bar {
  display: inline-block;
  text-align: right;
  width: 60%; padding:
}
.headind_srch{ padding:10px 29px 10px 20px; overflow:hidden; border-bottom:1px solid #c4c4c4;}

.recent_heading h4 {
  color: #05728f;
  font-size: 21px;
  margin: auto;
}
.srch_bar input{ border:1px solid #cdcdcd; border-width:0 0 1px 0; width:80%; padding:2px 0 4px 6px; background:none;}
.srch_bar .input-group-addon button {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  padding: 0;
  color: #707070;
  font-size: 18px;
}
.srch_bar .input-group-addon { margin: 0 0 0 -27px;}

.chat_ib h5{ font-size:15px; color:#464646; margin:0 0 8px 0;}
.chat_ib p{ font-size:14px; color:#989898; margin:auto}
.chat_img {
  float: left;
  width: 11%;
}
.chat_ib {
  float: left;
  padding: 0 0 0 15px;
  width: 115px;
}

.chat_people{ overflow:hidden; clear:both;}
.chat_list {
  border-bottom: 1px solid #c4c4c4;
  margin: 0;
  padding: 18px 16px 10px;
}
.inbox_chat { height: 550px; overflow-y: scroll;}

.active_chat{ background:#ebebeb;}

.incoming_msg_img {
  display: inline-block;
  width: 6%;
}
.received_msg {
  display: inline-block;
  padding: 0 0 0 10px;
  width: 92%;
 }
 .received_withd_msg p {
  background: #FBEFF5 none repeat scroll 0 0;
  border-radius: 3px;
  color: #646464;
  font-size: 17px;
  margin: 0;
  padding: 5px 10px 5px 12px;
  width: 270px;
  margin-top: 10px;
}
.time_date {
  color: #747474;
  display: block;
  font-size: 12px;
  margin: 8px 0 0;
}
.received_withd_msg { width: 57%;}
.mesgs {
  float: left;
  padding: 30px 15px 0 25px;
  width: 590px;
}

 .sent_msg p {
  background: #CED8F6 none repeat scroll 0 0;
  border-radius: 3px;
  font-size: 17px;
  margin: 0; color:#646464;
  padding: 5px 10px 5px 12px;
  width:100%;
}
.outgoing_msg{ overflow:hidden; margin:5px 0 5px; }
.sent_msg {
  float: right;
  width: 46%;
}
.input_msg_write input {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  color: #4c4c4c;
  font-size: 15px;
  min-height: 48px;
  width: 100%;
}

.type_msg {border-top: 1px solid #c4c4c4;position: relative; width:550px;}
.msg_send_btn {
  background: #05728f none repeat scroll 0 0;
  border: medium none;
  border-radius: 50%;
  color: #fff;
  cursor: pointer;
  font-size: 17px;
  height: 33px;
  position: absolute;
  right: 0;
  top: 11px;
  width: 33px;
}
.messaging { padding: 0 0 50px 0; width: 800px; float: center;}
.msg_history {
  height: 516px;
  overflow-y: auto;
}
</style>
</head>
<body>
<div class="container_client_chat">
<h3 class=" text-center">채팅방</h3>
<div class="messaging">
      <div class="inbox_msg">
        <div class="inbox_people">
          <div class="headind_srch">
            <div class="recent_heading">
              <h4>참여자 List</h4>
              </div>
          </div>
          <div id="inbox_chat" class="inbox_chat">
            <!-- 참여자 리스트 들어가는 곳 -->
          </div>
        </div>
        <div class="mesgs">
          <div id="chat" class="msg_history">
			<!-- 채팅 들어가는 곳 -->
          </div>
          <!-- 채팅 쓰는곳 -->
          <div class="type_msg">
            <div class="input_msg_write">
              <input type="text" class="write_msg" id="input" onkeyup="enterkey();" placeholder="메세지 입력해주세요" />
              <button id="send_button" class="msg_send_btn" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
            </div>
          </div>
        </div>
      </div>
            
    </div>
    </div>
    
<script type="text/javascript">
//네이버 callback페이지 function
	var naver_id_login = new naver_id_login("vrfDd_oEEiXRnIQESd1g", "https://nid.naver.com/oauth2.0/authorize");
	// 접근 토큰 값 출력
	console.log(">login, client_chat, naver_id_login.oauthParams.access_token: , " + naver_id_login.oauthParams.access_token);
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
	  console.log(naver_id_login.getProfileData('email'));
	  console.log(naver_id_login.getProfileData('nickname'));
	  console.log(naver_id_login.getProfileData('birthday'));
	  console.log(naver_id_login.getProfileData('name'));
	  
	  var navernickname = naver_id_login.getProfileData('email');
	  var sp = navernickname.split("@");
	  var nickname = sp[0];
	 	location.href="client_chat.me?nickname=" + nickname;
	}

	</script>
</body>
</html>