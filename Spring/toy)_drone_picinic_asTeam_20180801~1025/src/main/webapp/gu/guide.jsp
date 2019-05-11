<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.spring.drone.gu.GuideVO"%>
<%@ page import = "java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	System.out.println(">guide.jsp");  
%>

  <div class="container">
  	<!-- guide head -->
    <div class="row mt-1 mb-1 pt-5" style="background-image: url('${pageContext.request.contextPath}/resources/img/logo_pic/4.jpg'); background-size: cover; background-position: center; ">
      <div class="col-lg-12 line_color_yellow_b text_align_center mb-5">
        <p class="small_logo text_border">GUIDE</p>
        <p class="korean_center text_border">드론을 날리는데 필요한 모든 지식을 한 페이지에서 만나보세요</p>
      </div>
      <br />
      <br />
    </div>

	<!-- guide_image/ -->
    <div class="row mt-4 justify-content-center align-items-center">
      <div class="col-lg-3 m-2 text_align_center">
        <div class="thumbnail-wrappper" >
          <img src="${pageContext.request.contextPath}/resources/img/guide/guide_main_1.jpg" class="d-block h-100" style="position: relative; left:-70px;"/>
        </div>
        <button class="btn btn-outline-dark korean_center btn-block" style=" margin-top: 15px; " type="submit" id="button_click" data-toggle="modal" data-target="#howToControl">드론 조종</button>
      </div>

      <div class="col-lg-3 m-2 text_align_center">
        <div class="thumbnail-wrappper">
          <img src="${pageContext.request.contextPath}/resources/img/guide/guide_main_2.jpg" style="height:350px; position: relative; left:-70px;"/>
        </div>
        <button class="btn btn-outline-dark korean_center btn-block" style=" margin-top: 15px; "  type="submit" id="button_click" data-toggle="modal" data-target="#statistic">드론 통계</button>
      </div>

      <div class="col-lg-3 m-2 text_align_center">
        <div class="thumbnail-wrappper">
          <img src="${pageContext.request.contextPath}/resources/img/guide/guide_main_3.png" style="height:350px; position: relative; left:-140px;"/>
        </div>
        <button class="btn btn-outline-dark korean_center btn-block" style=" margin-top: 15px; " type="submit" id="button_click" data-toggle="modal" data-target="#safeinform">안전 지식</button>
      </div>
    </div> <!-- class="row mt-4 justify-content-center align-items-center" -->
	<!-- /guide_image -->
	</div> <!-- class="container" -->
	<br />
   	<br />
   	

	<!-- Modal1 -->
	<div class="modal fade" id="howToControl" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
		<jsp:include page="guide_info1.jsp" />
	</div>
	
	<!-- Modal2 -->
	<div class="modal fade" id="statistic" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
		<jsp:include page="guide_info2.jsp" />
	</div>
	
	<!-- Modal3 -->
	<div class="modal fade" id="safeinform" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
		<jsp:include page="guide_info3.jsp" />
	</div>
