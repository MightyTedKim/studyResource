<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="드론 피크닉">
    <meta name="author" content="TedKim">

    <title>Drone Picnic</title>
    <!-- Jquery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <!-- popper -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>

    <!-- Bootstrap-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	
    <!-- Custom fonts for this template -->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="/resources/css/clean-blog.min.css" rel="stylesheet">
    <script src="/resources/js/clean-blog.min.js"></script>
	<!-- style by ted -->
    <link href="/resources/css/cssByTed.css" rel="stylesheet">    
	

  </head>

  <body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand" href="/index">Drone Picnic</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="/index">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/about">About</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/board/listPage.bo">board</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/album/listPage.al">album</a>
            </li>                      
            <li class="nav-item">
              <a class="nav-link" href="/community/listPage.co">Community</a>
            </li>
            <li class="nav-item dropdown">
		       <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          place
		       </a>
		       <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		         <a class="dropdown-item" href="/place/main.pl">place Map</a>
		         <a class="dropdown-item" href="/place_list/listPage.pl">place List</a>
		       </div>
      		</li>
         	
         	<c:if test="${empty login }" >
         	<li class="nav-item">         	
         	  <a class="nav-link" href="/user/page_login">login</a>
       	  	</li>
         	</c:if>
         	<c:if test="${not empty login }">
         	  <a href="#"></a>
         	  
         	     <li class="nav-item dropdown">
		       <a class="nav-link dropdown-toggle" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          ${login.uname }
		       </a>
		       <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
		         <a class="dropdown-item" href="#">personal info</a>
		         <a class="dropdown-item" href="" return false
			    	onclick="window.open('/chat_team.ch', 
			                         'newwindow', 
			                         'width=1300,height=850');">
			              chat</a>
		         <a class="dropdown-item" href="/user/temp_logout">logout</a>
		       </div>
      		</li>
         	</c:if>
         
          </ul>
        </div>
      </div>
    </nav>

	
<script>
if ("${msg}" != ""){
	alert("${msg}");
}
</script>

	