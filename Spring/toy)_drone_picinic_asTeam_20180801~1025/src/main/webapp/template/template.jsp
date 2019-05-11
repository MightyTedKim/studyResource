<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String pagefile = (String)request.getAttribute("pagefile");
	%>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Required meta tags -->

<script src="${pageContext.request.contextPath}/resources/js/moment-with-locales.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<!-- ***** Include the above in your HEAD tag *** -->
<!-- Custom CSS 반드시 부트스트랩 하단에 위치해야 함 장소 이동 금지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css" />
<link href="https://fonts.googleapis.com/css?family=Comfortaa|Poiret+One|Nanum+Myeongjo|Nanum+Gothic+Coding" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>


<style>
/* =========소모임상세페이지 관련 스타일 시작===============*/
@import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css');

@import url('https://fonts.googleapis.com/css?family=Roboto');
@import url('https://fonts.googleapis.com/css?family=Raleway:300');
@import url('https://fonts.googleapis.com/css?family=Lusitana:400,700');

		.carousel-item > div {
  			float: left;
		}
		.carousel-by-item [class*="cloneditem-"] {
  			display: none;
		}
/* =========소모임상세페이지 관련 스타일 끝===============*/

.nanumgothiccoding * {
 font-family: 'Nanum Gothic Coding', monospace;
}

/** 이하는 공통 **/
.normal {
 font-style: normal;
}

.w100 {
 font-weight: 100;
}

.w300 {
 font-weight: 300;
}

.w350 {
 font-weight: 350;
}

.w400 {
 font-weight: 400;
}

.w500 {
 font-weight: 500;
 font-size: 14px;
}

li span {
 line-height: 1.8;
 font-size: 1.0em;
}

.small_font{
	font-size: 0.8em;
}
      .logo {
        /* font-family: 'Lobster', cursive; */
		/* font-family: 'Comfortaa', cursive; */
		font-family: 'Poiret One', cursive;
        font-size: 42px;
        font-weight: bold;
      }
      .small_logo {
        /* font-family: 'Lobster', cursive; */
		/* font-family: 'Comfortaa', cursive; */
		font-family: 'Poiret One', cursive;
        font-size: 85px;
        font-weight: bold;
      }
      .moderate_logo {
        /* font-family: 'Lobster', cursive; */
		/* font-family: 'Comfortaa', cursive; */
		font-family: 'Poiret One', cursive;
        font-size: 40px; 
        text-align: left; 
        font-weight: bold; 
        line-height: 1.5em;
      }
      .smaller_logo{
      	font-family: 'Poiret One', cursive;
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 0em; 
        text-align: center;
      }
      .detail_logo{
      	font-family: 'Poiret One', cursive;
        font-size: 40px;
        font-weight: bold; 
        text-align: left;
      }
      .smallest_logo{
      	font-family: 'Poiret One', cursive;
        font-size: 25px;
        font-weight: bold;
        text-align: left;
        float:right; 
        padding: 12px 20px;
    	margin: 8px 0;
      }
      .korean_text{
      	font-family: 'Nanum Myeongjo', serif;
      	font-size: 10px;
      	font-weight: normal;
		text-align: right; 
		font-weight: bold; 
		line-height: 1.1em;
      }
      .korean_text_center{
      	font-family: 'Nanum Myeongjo', serif;
      	font-size: 10px;
      	font-weight: normal;
		text-align: center; 
		font-weight: bold; 
		line-height: 1.1em;
      }
      .korean{
      	font-family: 'Nanum Myeongjo', serif;
      	font-size: 12px;
      	font-weight: normal;
		text-align: left; 
		font-weight: bold; 
		line-height: 1.5em;
      }
      .korean_center{
      	font-family: 'Nanum Myeongjo', serif;
      	font-size: 24px;
      	font-weight: normal;
		text-align: center; 
		font-weight: 1000;
		line-height: 1.1em;
      }
      .korean_right{
      	font-family: 'Nanum Myeongjo', serif;
      	font-size: 11px;
      	font-weight: normal;
		text-align: right; 
		font-weight: 1000;
		line-height: 1.1em;
      }
      .menu_font{
    	font-size: 19px;
		font-weight: bold; 
      }
      .board_font{
      	font-family: 'Nanum Myeongjo', serif;
      	font-size: 12px;
      	font-weight: normal;
		text-align: left; 
		font-weight: bold; 
		line-height: 1.1em;
      }
      
      .korean_board{
      	font-family: 'Nanum Gothic Coding', monospace;
      	font-weight: 400;
      	line-height: 1.4;
 		font-size: 0.8em;
      }
</style>


<!-- 'TOP' scroll button 시작 -->
  <style>
	#myBtn {
	  display: none;
	  position: fixed;
	  bottom: 20px;
	  right: 30px;
	  z-index: 99;
	  font-size: 18px;
	  border: none;
	  outline: none;
	  background-color: red;
	  color: white;
	  cursor: pointer;
	  padding: 15px;
	  border-radius: 4px;
	}
	
	#myBtn:hover {
	  background-color: #555;
	}
	</style>
<!-- scroll button 끝 -->

<head>
	<jsp:include page="header.jsp"/>
</head>

<body>
	<div class="container-fluid p-0">
		<jsp:include page='<%="../" + pagefile %>' />
	</div>
</body>

<footer class="w3-panel w3-center w3-opacity menu_font">
	<jsp:include page="footer.jsp"/>
</footer>

<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>

<!-- scroll button 시작 -->
<script>
	// When the user scrolls down 20px from the top of the document, show the button
	window.onscroll = function() {scrollFunction()};
	
	function scrollFunction() {
	    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	        document.getElementById("myBtn").style.display = "block";
	    } else {
	        document.getElementById("myBtn").style.display = "none";
	    }
	}
	
	// When the user clicks on the button, scroll to the top of the document
	function topFunction() {
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	}
	</script>
<!-- scroll button 끝 -->

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>


</html>
