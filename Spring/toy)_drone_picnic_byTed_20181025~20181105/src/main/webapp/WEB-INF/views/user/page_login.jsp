<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<style>
.login-logo{
	text-align:center;
	padding:50px;
}
</style>

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


<body class="login-page">

<div class="container">
  <div class="row">
    <div class="col-lg-4 col-md-6 mx-auto">
  
  
<div class="login-box">
	<b>Drone</b>Picnic
		
<form action="/user/post_login" method="post">
	<div class="form-group">
		<input type="text" name="uid" class="form-control center login" placeholder="USER ID"/>
	</div>
	<div class="form-group">
		<input type="password" name="upw" class="form-control center login" placeholder="Password"/>
	</div>
  <hr/>
  <div class="row">
    <div class="col-md-8 mx-auto">    
        <label>
        	<input type="checkbox" id="checkbox"/> 자동 로그인
        	<input type="hidden" name="useCookie" id="checkValue" />
       	</label>
        <button type="submit" class="btn-primary" >로그인</button>            
    </div>
  </div> <!-- row -->
</form>
<hr/>
	<div class="col-md-8 mx-auto">
		<a href="/user/page_loginRegister" class="text-center">회원 가입</a>
	</div>
     
</div><!-- login-page -->

</div><!-- col-md-8 -->
</div><!-- row -->
</div><!-- container -->

</body>

 <script>
$(document).ready(function(){
	$('#checkValue').val($('#checkbox').prop('checked'));
		
    $('#checkbox').on("click", function(){
    	$('#checkValue').val($('#checkbox').prop('checked'));
  		});
});
</script>
<%@include file="../include/footer.jsp"%>
