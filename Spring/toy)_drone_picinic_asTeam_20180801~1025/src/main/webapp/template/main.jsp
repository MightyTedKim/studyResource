<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.spring.drone.news.NewsVO"%>
<%@ page import="com.spring.drone.news.NewsPaginationVO"%> 
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
 	System.out.println(">main.jsp");
	ArrayList<NewsVO> newsList = (ArrayList<NewsVO>)request.getAttribute("newsList");
	NewsPaginationVO newsPaginationVO = (NewsPaginationVO)request.getAttribute("newsPaginationVO");
%>
<!-- 이미지 슬라이더 시작 -->
<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active" style="height:450px; overflow: hidden; background-position: 50% 50%;">
      <img class="d-block w-100"  height="auto" src="${pageContext.request.contextPath}/resources/img/guide_logo1.jpg" alt="First slide">
	  	<div class="logo carousel-caption d-none d-md-block">
			<div>DRONE</div>
			<div>PICNIC</div>
        	<p>FIND BEST FLYING SPOTS ANYWHERE ANYTIME</p>
  		</div>    
    </div>
    <div class="carousel-item" style="height:450px; overflow: hidden; background-position: 50% 50%;">
      <img class="d-block w-100" height="auto" src="${pageContext.request.contextPath}/resources/img/guide_logo2.jpg" alt="Second slide">
    	<div class="logo carousel-caption d-none d-md-block"> 
			<div>DRONE</div>
			<div>PICNIC</div>
        	<p>FIND YOUR DRONE MATES</p> 
  		</div> 
    </div>
    <div class="carousel-item" style="height:450px; overflow: hidden; background-position: 50% 50%;">
      <img class="d-block w-100" height="auto" src="${pageContext.request.contextPath}/resources/img/guide_logo3.jpg" alt="Third slide">
    	<div class="logo carousel-caption d-none d-md-block">
			<div>DRONE</div>
			<div>PICNIC</div>
        	<p>SHARE YOUR FAVORITE FLYING PLACE</p>
  		</div> 
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
<!-- 이미지 슬라이더 끝 -->

<!-- 메인 디브 시작 -->

<div class="row mt-4 div_center" style="width:85%;height:220px;overflow: hidden;">
    <div class="pointer col-lg-4">
		<!-- 1st -->
		<div class="main_news">
	    	<table class="table table-condensed table-sm table_fixed">
				<thead>
				<tr class="d-flex board_font">
					<td class="col-9" style="font-size: 20px; text-align: center; font-weight: bold; line-height: 1.5em;">최신 드론 기사</td>
					<td class="col-3" ><p class="bottom_line"><a href="list.news">더보기</a></p></td>
				</tr>
				</thead>
				<tbody class="korean">
	 			<% 	 			
	 			System.out.println("main.jsp, newsList");
	 			System.out.println("main.jsp, newsList: " + newsList);
	 			if (newsList == null ||newsList.size() == 0){
	 			%>
	 			<tr class="d-flex">
					<td class="col-9 td_no_overflow" colspan="2">아직 기사가 크롤링되지 않았습니다. <br />
						<a href="template.templ?page=insert.news">여기</a>를 눌러 크롤링을 시작해주세요.  클릭 후 DB에 저장됩니다.
					</td>
				</tr>
	 				<%
	 				
	 			}else{
					for(int i=0;i < 8;i++){
						NewsVO vo = newsList.get(i);	
				%>
				<tr class="d-flex">
					<td class="col-9 td_no_overflow">
						<a href="template.templ?page=getNews.news?num=<%=vo.getNum() %>&pageNum=<%=newsPaginationVO.getCurrentPage() %>&number=<%=newsPaginationVO.getNumber() %>&readcount=<%=vo.getReadcount()%>">
							&nbsp;&nbsp;&nbsp;<%=vo.getTitle() %>
						</a>
					</td> 
					<td class="col-3 td_no_overflow"><%=vo.getSource() %></td>
				</tr>
				<%
					}
 				}
				%>
				</tbody>
			</table>
		</div><!-- class="main_news" -->
	</div><!--  class="main_news col-lg-4" -->

    <div class="pointer col-lg-4">
		<!-- 2nd -->
		<div class="main_img">
		    <div class="box">
		        <div class="imgBox">
		            <img src="${pageContext.request.contextPath}/resources/img/main_map_img.png" width="100%" height="220px" />
		        </div>
  		        <div class="content" onclick="location.href='template.templ?page=place.pl'">
	        		<h2>| 나들이 정보 |</h2>
		            <p>공역 정보, 드론 공원, 사설 비행장, 회원 추천 지역 등의 정보를 제공합니다. </p>
		        </div>
		    </div>
		</div><!-- class="main_img" -->
		      	
    </div>
    <div class="pointer col-lg-4">
     	<!-- 3rd -->    
		<div class="main_img2">
		    <div class="box">
		        <div class="imgBox">
			      	<img class="imgBox" src="${pageContext.request.contextPath}/resources/img/main_right_img.png" width="100%" height= "220px" />
		        </div>
		        <div class="content" onclick="location.href='template.templ?page=main.co'">		        
		            <h2>| 커뮤니티 |</h2>
		            <p>함께 드론을 날릴 사람들을 찾아봐요. 약속 장소를 정하고, 사진을 공유하고, 중고 드론을 구할 수 있어요 </p>
		        </div>
		    </div>
		</div> <!-- class="main_img2" -->
		
    </div>
</div>


<!-- 메인 디브 끝 -->
<style>

.center{
    margin: auto;
    width: 100%;
    border-bottom-style: inset;
    padding: 10px;
 }

.pointer {cursor: pointer;}

/*-------------------------------*/
/*         news magnify          */
/*-------------------------------*/
.main_news:hover {
    -ms-transform: scale(1.01); /* IE 9 */
    -webkit-transform: scale(1.01); /* Safari 3-8 */
    transform: scaleY(1.01); 
   	background:#f4f4f4;
}
</style>

<style>
/*-------------------------------*/
/*          main.news            */
/*-------------------------------*/
.main_news {
	width:100%;
	position:relative;
	box-shadow: 0 5px 10px rgba(0,0,0,.8);
}

</style>

<style>
/*-------------------------------*/
/*         image hover, black    */
/*-------------------------------*/
.main_img{
	width:100%;
	height:220px;	
}

.main_img .box {
	height: 220px;
    position:relative;
    background:#000;
    float:center;
    box-sizing:border-box;
    overflow:hidden;
    box-shadow:0 5px 10px rgba(0,0,0,.8);
}
.main_img .box:before {
	
    content:'';
    position:relative;
    border-top:1px solid #fff;
    border-bottom:1px solid #fff;
    box-sizing:border-box;
    transition:0.5s;
    transform: scaleX(0);
    opacity:0;
}
.main_img .box:hover:before {
    transform:scaleX(1);
    opacity:1;
}

.main_img .box:after {
    content:'';
    position:absolute;
    top:10px;
    left:10px;
    right:10px;
    bottom:10px;
    border-left:1px solid #fff;
    border-right:1px solid #fff;
    box-sizing:border-box;
    transition:0.5s;
    transform: scaleY(0);
    opacity:0;
}
.main_img .box:hover:after {
    transform:scaleY(1);
    opacity:1;
}
.main_img .box .imgBox {
    position:relative;
}
.main_img .box .imgBox img {
    width:100%;
    transition:0.5s;
}
.main_img .box:hover .imgBox img {
    opacity:.2;
    transform:scale(1.2);
}
.main_img .box .content {
    position:absolute;
    width:100%;
    top:50%;
    transform:translateY(-50%);
    z-index:2;
    padding:20px;
    box-sizing:border-box;
    text-align:center;
}
.main_img .box .content h2 {
    padding:0;
    color:#fff;
    transition:0.5s;
    transform:translateY(-50px);
    opacity:0;
    visibility:hidden;
}
.main_img .box .content p {
    margin:0;
    padding:0;
    color:#fff;
    transform:translateY(50px);
    opacity:0;
    visibility:hidden;
}
.main_img .box:hover .content h2,
.main_img .box:hover .content P {
    opacity:1;
    visibility:visible;
    transform:translateY(0px);
}

</style>


<style>
/*-------------------------------*/
/*     image hover, white        */
/*-------------------------------*/
.main_img2{
	width:100%;
	height:220px;
}

.main_img2 .box {
    position:relative;
    background:#fff;
    float:center;
    box-sizing:border-box;
    overflow:hidden;
    box-shadow:0 5px 10px rgba(0,0,0,.8);
}
.main_img2 .box:before {
    content:'';
    position:absolute;
    border-top:1px solid #000;
    border-bottom:1px solid #000;
    box-sizing:border-box;
    transition:0.5s;
    transform: scaleX(0);
    opacity:0;
}
.main_img2 .box:hover:before {
    transform:scaleX(1);
    opacity:1;
}
.main_img2 .box:after {
    content:'';
    position:absolute;
    top:10px;
    left:10px;
    right:10px;
    bottom:10px;
    border-left:1px solid #000;
    border-right:1px solid #000;
    box-sizing:border-box;
    transition:0.5s;
    transform: scaleY(0);
    opacity:0;
}
.main_img2 .box:hover:after {
    transform:scaleY(1);
    opacity:1;
}
.main_img2 .box .imgBox {
    position:relative;
}
.main_img2 .box .imgBox img {
    width:100%;
    transition:0.5s;
}
.main_img2 .box:hover .imgBox img {
    opacity:.2;
    transform:scale(1.2);
}
.main_img2 .box .content {
    position:absolute;
    width:100%;
    top:50%;
    transform:translateY(-50%);
    z-index:2;
    padding:20px;
    box-sizing:border-box;
    text-align:center;
}
.main_img2 .box .content h2 {
    padding:0;
    color:#000;
    transition:0.5s;
    transform:translateY(-50px);
    opacity:0;
    visibility:hidden;
}
.main_img2 .box .content p {
    margin:0;
    padding:0;
    color:#000;
    transform:translateY(50px);
    opacity:0;
    visibility:hidden;
}
.main_img2 .box:hover .content h2,
.main_img2 .box:hover .content P {
    opacity:1;
    visibility:visible;
    transform:translateY(0px);
}

</style>


