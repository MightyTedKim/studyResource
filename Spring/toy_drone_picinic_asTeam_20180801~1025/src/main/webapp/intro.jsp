<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
    
    <!-- Custom CSS 반드시 부트스트랩 하단에 위치해야 함 장소 이동 금지 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css" />
  <link href="https://fonts.googleapis.com/css?family=Comfortaa|Poiret+One|Nanum+Myeongjo|Nanum+Gothic+Coding" rel="stylesheet">
  

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial;
    font-size: 17px;
}

#myVideo {
    position: fixed;
    right: 0;
    bottom: 0;
    min-width: 100%; 
    min-height: 100%;
}

.content {
    position: fixed;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    color: #f1f1f1;
    width: 100%;
    padding: 20px;
}

#myBtn {
    width: 200px;
    font-size: 18px;
    padding: 10px;
    border: none;
    background: #000;
    color: #fff;
    cursor: pointer;
}

#myBtn:hover {
    background: #ddd;
    color: black;
    

}
.logo {
        /* font-family: 'Lobster', cursive; */
		/* font-family: 'Comfortaa', cursive; */
		font-family: 'Poiret One', cursive;
        font-size: 42px;
        font-weight: normal;
      }
</style>
</head>
<body>

<video autoplay muted loop id="myVideo">
  <source src="${pageContext.request.contextPath}/resources/img/PicnicDroneOverview.mp4" type="video/mp4">
  Your browser does not support HTML5 video.
</video>

<div class="content">
  <h1 class="logo">DRONE PICNIC</h1>
  <p>Drone Picnic's purpose is to give location information to whom seek drone spots.</p>
  <button id="myBtn" onclick="location.href='template.templ?page=main.templ'">Welcome</button>
</div>

<script>
var video = document.getElementById("myVideo");
</script>

</body>
</html>