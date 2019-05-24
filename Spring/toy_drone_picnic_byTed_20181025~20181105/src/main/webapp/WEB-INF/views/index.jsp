<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@include file="./include/header.jsp"%>

    <!-- Page Header -->
    <header class="masthead" style="background-image: url('/resources/img/contact-bg.jpg')">
      <div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <div class="index_header">
              <h1>DRONE PICNIC</h1>
              <span class="subheading">perfect place for spot finding</span>
            </div>
          </div>
        </div>
      </div>
    </header>

 <!-- Main Content -->
    <div class="container">
      <div class="row"> 
     
    <!-- 1st -->
    <div class="col-lg-4">
	    <div class="box">
	        <div class="index_text" onclick="location.href='board/listPage.pl'">		        
	            <h2>| 공지사항 |</h2>
	            <span>지도 날리러가장 </span>
	        </div>
	        <img src="/resources/img/contact-bg.jpg" width="100%" height= "220px" />
	    </div>
	</div>
	<!-- 2nd -->  
    <div class="col-lg-4">
	    <div class="box">
	        <div class="index_text" onclick="location.href='#'">		        
	            <h2>| 커뮤니티 |</h2>
	            <span>커뮤니티서 약속 잡자</span>
	        </div>
   	      	<img src="/resources/img/post-bg.jpg" width="100%" height= "220px" />
	    </div>
	</div>
  	<!-- 3rd -->  	
    <div class="col-lg-4">
    	<div class="box">  	
	        <div class="index_text" onclick="location.href='place/place_main.pl'">		        
	            <h2>| 지도 |</h2>
	            <span>지도 날리러가장 </span>
	        </div>
	        <img class="" src="/resources/img/home-bg.jpg" width="100%" height= "220px" />
	    </div>
    </div>
    
</div>
</div>

<style>
.index_header{
    padding: 100px;
    color: #fff;
    text-align: center;
}
.index_text{
    text-align: center;
}
</style>
<%@include file="./include/footer.jsp"%>
