<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

    
<!-- Page Header-->
<header class="masthead" style="background-image: url('/resources/img/contact-bg.jpg')">
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
      	<div style="height: 60px;"></div>
      </div>
    </div>
  </div>
</header>
<style>

</style>


<body class="login-page">

<div class="container">
<div class="row">
<div class="col-lg-4 col-md-6 mx-auto">

<div class="login-box">
	<b>Drone</b>Picnic
		
<form action="/user/post_loginRegister" method="post">
	<label><b>ID</b></label>  <br/>
	<input type="text" placeholder="Enter ID"
	      	class="id" name="uid" id="checkID" oninput="checkId()" required> <br/>
	
	<span id="id_alert" style="font-size:15px;"></span><br/>
	
	<label><b>Nickname</b></label>  <br/>
	<input type="text" placeholder="Enter Nickname" 
	      	class="nick" name="uname" id="checkNick" oninput="checkNickName()" required > <br/>
	
	<span id="nick_alert" style="font-size:15px;"></span><br/>
	
	<hr/>
	<label> <b>Password</b></label>   <br/>
	<input type="password" placeholder="Enter Password" 
			name="upw"class="upass" oninput="checkPwd()" required>  <br/>
	<label> <b>Repeat Password</b></label>  <br/>
	<input type="password" placeholder="Repeat Password" 
	        class="pass" id="repwd" oninput="checkPwd()" required >  <br/>
	
	<span id="pw_alert" style="font-size:15px;"></span><br/>
	
	<div class="clearfix">
		<button type="button" class="initbtn">초기화</button>
		<button type="submit" class="signupbtn" disabled="disabled">회원가입</button>
	</div>
</form>
</div><!-- login box -->

</div><!-- col-md-8 -->
</div><!-- row -->
</div><!-- container -->

</body>

<script>
//아이디와 비밀번호가 맞지 않을  경우 가입버튼 비활성화를 위한 변수설정
var idCheck = 0; //1이면 제출 가능
var nickCheck = 0;
var pwdCheck = 0;

//아이디 체크하여 가입버튼 비활성화, 중복확인.
function checkId() {
	 var inputed = $('.id').val();
	 $.ajax({
		async: true,
		type : 'POST',
		data : inputed,
		url : "/user/idCheck",
		dataType : "json",
		contentType: "application/json; charset=UTF-8",
	    success : function(data) {
	    	if (data == '1') {
		       	document.getElementById("id_alert").innerHTML = "아이디가 존재합니다." ;
	            $("#checkID").css("background-color", "#FFCECE"); //red
	            idCheck = 0;
	            signupDisable();
	        } else if(data == '0') { //success
	        	 document.getElementById("id_alert").innerHTML = "사용 가능한 아이디 입니다.";
	             $("#checkID").css("background-color", "#B0F6AC"); //green
	             idCheck = 1;  
	             signupCheck();
	        } 
	     },
		 error : function(error) {     
		 	if (inputed == ""){
	    		document.getElementById("id_alert").innerHTML = "값을 입력해주세요" ;
	    		$("#checkID").css("background-color", "#FFCECE"); //red 
	    	    signupDisable();
	    	} else{
		       console.log("error : " +error);	
	    	}
	     }
	 });
};

function checkNickName() {
	 var inputed = $('.nick').val();
	 $.ajax({
		async: true,
		type : 'POST',
		data : inputed,
		url : "/user/nickCheck",
		dataType : "json",
		contentType: "application/json; charset=UTF-8",
	    success : function(data) {
	    	if (data == '1') {
		       	document.getElementById("nick_alert").innerHTML = "닉네임이 존재합니다." ;
	            $("#checkNick").css("background-color", "#FFCECE"); //red 
	            nickCheck = 0;
	            signupDisable();
	        } else if(data == '0') { //success
				document.getElementById("nick_alert").innerHTML = "사용 가능한 닉네임 입니다.";
				$("#checkNick").css("background-color", "#B0F6AC"); //green
				nickCheck = 1;
				signupCheck();
	        } 
	     },
		 error : function(error) {     
		 	if (inputed == ""){
	    		document.getElementById("nick_alert").innerHTML = "값을 입력해주세요" ;
	    		$("#checkNick").css("background-color", "#FFCECE"); //red
	    	    signupDisable();
	    	} else{
		       console.log("error : " +error);	
	    	}
	     }
	 });
};

//재입력 비밀번호 체크하여 가입버튼 비활성화 또는 맞지않음을 알림.
    function checkPwd() {
        var inputed = $('.pass').val();
        var reinputed = $('#repwd').val();
        
        if(inputed=="" || reinputed==""){
	        document.getElementById("pw_alert").innerHTML = "pw를 입력해주세요" ;
            $("#repwd").css("background-color", "#FFCECE");
	        signupDisable();
		} else if (inputed != reinputed) {
	        document.getElementById("pw_alert").innerHTML = "pw가 일치하지 않습니다." ;
	        $("#repwd").css("background-color", "#FFCECE");
	        pwdCheck = 0;
	        signupDisable();
   		} else if (inputed == reinputed) { //success
	        document.getElementById("pw_alert").innerHTML = "pw가 일치합니다." ;
            $("#repwd").css("background-color", "#B0F6AC");
            pwdCheck = 1;
            signupCheck();
   		}
    };
    
    function signupDisable() {
        $(".signupbtn").prop("disabled", true);
        $(".signupbtn").css("background-color", "#aaaaaa");
    }
    //닉네임과 이메일 입력하지 않았을 경우 가입버튼 비활성화
    function signupCheck() {
        if(idCheck==1 && pwdCheck == 1 && nickCheck == 1) {
            $(".signupbtn").prop("disabled", false);
            $(".signupbtn").css("background-color", "#4CAF50"); // green, login enabled
        }
    };
    
    //캔슬버튼 눌렀을 눌렀을시 인풋박스 클리어
    $(".initbtn").click(function(){
        $(".id").val(null);
        $(".nick").val(null);
        $(".pass").val('');
        $(".signupbtn").prop("disabled", true);
        $(".signupbtn").css("background-color", "#aaaaaa");
    });
</script>


<%@include file="../include/footer.jsp"%>
