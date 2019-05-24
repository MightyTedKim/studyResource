<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import="com.spring.drone.so.SomoimVO"%>

<%
   String id = (String)session.getAttribute("id");
   String nickname = (String)session.getAttribute("nickname");
   int authority = 1;
   ArrayList<SomoimVO> foundedSoList = (ArrayList<SomoimVO>)session.getAttribute("foundedSoList");
   System.out.println("header.jsp, id : " + id);
%>
<style>

input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

.titlecontainer {
   font-size: 30px;
}
/* Set a style for all buttons */
.loginbutton {
    background-color: #CED8F6;
    color: black;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}
.joinbutton {
    background-color: #CED8F6;
    color: black;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

.buttonsgo {
    background-color: white;
    border: none;
    cursor: pointer;
    font-size: 19px !important;
    font-weight: bold !important; 
    font-family: initial;
}


/* Center the image and position the close button */
.titlecontainer {
    text-align: center;
    margin: 24px 0 12px 0;
    position: relative;
}

.containerlogin{
    padding: 16px;
   	width:60%;
	margin:auto;
}

span.psw {
    float: right;
    padding-top: 16px;
}

/* The Modal (background) */
.modalsgo{
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    padding-top: 60px;
}

/* Modal Content/Box */
.modal-contentsgo{
    background-color: #fefefe;
    margin: 0% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid #888;
    width: 50%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
    position: absolute;
    right: 25px;
    top: 0;
    color: #000;
    font-size: 35px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: red;
    cursor: pointer;
}

/* Add Zoom Animation */
.animate {
    -webkit-animation: animatezoom 0.6s;
    animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
    from {-webkit-transform: scale(0)} 
    to {-webkit-transform: scale(1)}
}

@keyframes animatezoom {
    from {transform: scale(0)} 
    to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
    span.psw {
       display: block;
       float: none;
    }
    .cancelbtn {
       width: 100%;
    }
}
</style>



<!-- naver/kakao/google login will start -->
<!-- 1. naver -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>

<!-- 2. kakao -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!-- 3. google -->
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="750876275305-duhcjp8ipktuoj6nl29il355r9l3eihd.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src='//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script><script src="//m.servedby-buysellads.com/monetization.js" type="text/javascript"></script>

<div class="menu_font col-lg-12 korean_text_center">
       <%
       if(id == null){
       %>
       <!-- 로그인/회원가입 모달 버튼 -->
       <div>
        <button class="buttonsgo" onclick="document.getElementById('id01').style.display='block'"><a class="menu_font" style="color: #336fce; float:right;">로그인</a></button> 
        <button class="buttonsgo" onclick="document.getElementById('id02').style.display='block'"><a class="menu_font" style="color: #336fce; float:left;">회원가입 </a></button>
       </div>
       <!-- 로그인 모달 -->
       <div id="id01" class="modalsgo">
         <span onclick="document.getElementById('id01').style.display='none'" 
       class="close" title="Close Modal">&times;</span>
       
         <!-- 로그인 모달 Content -->
         <form class="modal-contentsgo animate" action="/drone/template.templ?page=login.me" method="post">
           <div class="titlecontainer">
             Drone Picnic
           </div>
          
           <div class="containerlogin">
             <div><label style="font-size: 20px; margin-top: 10px;"><b>아이디</b></label></div>
             <input placeholder=" 아이디 입력해주세요" type="text" name="id" style="font-size:15px; text-align:center; width:200px; margin-top: 0px; border-radius: 25px;" required>
            <br>
             <div><label style="font-size: 20px; margin-top: 10px;"><b>비밀번호</b></label></div>
             <input placeholder=" 비밀번호 입력해주세요" type="password" style="font-size:15px; text-align:center;  width:200px; margin-top: 0px; border-radius: 25px;" name="password" required>
            <br>
             <button class="loginbutton" type="submit" style="width:275px; height:48px; font-size: 20px; border-radius: 25px;">로그인</button>
             <br>
             <br>
             <!-- 네이버로그인 -->
             <div id="naverIdLogin" align="center"></div>
             
            <!-- 카카오로그인 -->
             <div align="center">
             <a id="custom-login-btn" href="javascript:loginWithKakao()">
             <img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="277" height="55"/>
             </a>
             </div>
            <!-- 구글로그인 -->
             <div align="center" class="g-signin2" data-onsuccess="onSignIn" data-theme="dark" data-width="277" data-height="57" data-longtitle="true"></div>
           </div>
          
           <div class="containerlogin">
             <button type="button" onclick="document.getElementById('id01').style.display='none'"
               class="btn btn-lg button_bg_blue korean_center" style="border-radius: 25px; border:0">Cancel</button>
           </div>
         </form>
       </div>
       
       <!-- 회원가입 모달 -->
       <div id="id02" class="modalsgo">
         <span onclick="document.getElementById('id02').style.display='none'" 
       class="close" title="Close Modal">&times;</span>
       
         <!-- 회원가입 모달 Content -->
         <form class="modal-contentsgo animate" action="/drone/template.templ?page=joinprocess.me" method="post" >
           <div class="titlecontainer" style="font-family: 'Poiret One', cursive;">
             Drone Picnic<br>
           </div>
          
           <div class="containerlogin">
             <label style="font-size: 20px;"><b>아이디</b></label>
             <input type="text" placeholder="아이디를 입력해주세요" name="id" style="text-align:center; font-size: 20px; border-radius: 25px;" required>
            <br>
             <label style="font-size: 20px;"><b>비밀번호</b></label>
             <input type="password" placeholder="비밀번호 입력해주세요" id="pw" name="password"  style="text-align:center; font-size: 20px; border-radius: 25px;" onChange="isSame()" required>
            <br>
             <label style="font-size: 20px;"><b>비밀번호</b></label>
             <input type="password" placeholder="비밀번호 입력해주세요" name="passwordConfirm" id="pwCheck" style="text-align:center;  font-size: 20px; border-radius: 25px;" onChange="isSame()" required>
             <br>
              <span id="same" style="font-size:15px;"></span>
              <br> <br><br><br>
             <label style="font-size: 20px;"><b>닉네임</b></label>
             <input type="text" placeholder="닉네임을 입력해주세요" name="nickname" style="text-align:center; font-size: 20px; border-radius: 25px;" required>
             <button class="joinbutton" type="submit" style="font-size: 20px; font-size: 15px; border-radius: 25px;">회원가입</button>
           	<br/>
             <button type="button" onclick="document.getElementById('id02').style.display='none'"
               class="btn btn-lg button_bg_blue korean_center" style="font-family: 'Poiret One', cursive; border-radius: 25px; border:0">Cancel</button>
           </div>
         </form>
       </div>
       <%
       }
       else if(id != null & authority == 1){
       %>
       <a href="template.templ?page=manager_main.ma"><%=nickname %><span class="badge badge-light"></span></a>
         <a href="#" onClick="logout();">로그아웃</a>
        <%
       }
       else{
        %>
          <a class="korean_text" href="template.templ?page=manager_main.ma"><%=nickname %><span class="badge badge-light">  </span></a>
          <%
       }
          %>
</div>

<script type="text/javascript">  
/*------------- */
/*   logout()   */
/*------------- */

//로그인, 로그아웃 초기 설정
function logout(){
      var con = confirm("안녕히 가세요 :)");
      if(con == true){
       location.href="template.templ?page=logout.me";
      }else{}
     }

/*----------------------- */
/*   isSame(): pw check   */
/*----------------------- */
//비밀번호 체크
function isSame() {
   var pw = document.getElementById('pw').value;
   var confirmPW = document.getElementById('pwCheck').value;
   
   if(pw.length < 3 || pw.length > 10) {
   window.alert('비밀번호 3~10만 입력해주세요');
   document.getElementById('pw').value=document.getElementById('pwCheck').value='';
   document.getElementById('same').innerHTML='';
   }
   if(document.getElementById('pw').value!="&&document.getElementById('pwCheck').value!=") {
      if(document.getElementById('pw').value == document.getElementById('pwCheck').value) {
      document.getElementById('same').innerHTML = '비밀번호가 일치합니다.';
      document.getElementById('same').style.color='blue';
      }
      else {
      document.getElementById('same').innerHTML = '비밀번호가 일치하지 않습니다.';
      document.getElementById('same').style.color='red';
      }
   }
}

/*----------------------------------------- */
/*   naver, kako, google login functions   */
/*----------------------------------------- */

//1. 네이버 function   
var naverLogin = new naver.LoginWithNaverId(
   {
      clientId: "vrfDd_oEEiXRnIQESd1g",
      callbackUrl: "http://localhost:8080/drone/login/navercallbackpage.jsp",
      isPopup: false, /* 팝업을 통한 연동처리 여부 */
      loginButton: {color: "green", type: 3, height: 60}, /* 로그인 버튼의 타입을 지정 */
      callbackHandle: false
   }
);
/* 설정정보를 초기화하고 연동을 준비 */
naverLogin.init();
         
//2. 카카오 function
Kakao.init('4959f081993ee79ce2a4d351804a9145'); // 사용할 앱의 JavaScript 키를 설정해 주세요.

function loginWithKakao() {
	// 로그인 창을 띄웁니다.
	Kakao.Auth.login({
	success: function(authObj) {
	   Kakao.API.request({
	        url: '/v1/user/me',
	        success: function(res) {
	          console.log(JSON.stringify(res.id));
	          console.log(JSON.stringify(res.properties.profile_image));
	          console.log(JSON.stringify(res.properties.nickname));
	          var kaid = JSON.stringify(res.id);
	          var kanickgosplit = JSON.stringify(res.properties.nickname);
	          var kanicksplit = kanickgosplit.split("\"");
	          var kanick = kanicksplit[1];
	          
	          location.href="/drone/template.templ?page=socialjoinprocess.me?id=" + kaid + "&nickname=" + kanick + "&password=" + kaid;
	          alert(res.properties.nickname + ' 환영합니다. 카카오톡 ID로 로그인 하셨습니다.');
	        },
	        fail: function(error) {
	          alert(JSON.stringify(error));
	        }
	      });
	    },
	    fail: function(err) {
	      alert(JSON.stringify(err));
	    }
	});
}

//3. 구글 function
function onSignIn(googleUser) {
    // Useful data for your client-side scripts:
    var profile = googleUser.getBasicProfile();
    console.log("ID: " + profile.getId()); // Don't send this directly to your server!
    console.log('Full Name: ' + profile.getName());
    console.log('Given Name: ' + profile.getGivenName());
    console.log('Family Name: ' + profile.getFamilyName());
    console.log("Image URL: " + profile.getImageUrl());
    console.log("Email: " + profile.getEmail());
    alert(profile.getName() +  ' 환영합니다. 구글 ID로 로그인 하셨습니다.');
    // The ID token you need to pass to your backend:
    var id_token = googleUser.getAuthResponse().id_token;
    console.log("ID Token: " + id_token);
    location.href="/drone/template.templ?page=socialjoinprocess.me?id=" + profile.getId() + "&nickname=" + profile.getName() + "&password=" + profile.getId();
};
</script>
     