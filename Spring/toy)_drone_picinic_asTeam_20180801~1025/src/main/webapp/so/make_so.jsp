<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>make_so.jsp</title>
</head>
<body>
<div class="container">
	<div class="row mt-1 mb-1 pt-5"
			style="background-image: url('${pageContext.request.contextPath}/resources/img/logo_pic/2.jpg'); background-size: cover; background-position: center; ">
			<div class="col-lg-12 line_color_yellow_b text_align_center mb-5">
				<p class="small_logo text_border">CIRCLE</p>
				<p class="korean_center text_border">드론 소모임을 만들어보세요</p>
			</div>
			<br /> <br />
	</div>
	
	<div class="row line_color_yellow_b mt-1 mb-1 p-5 div_center">
		<div class="col-lg-12 text_align_center">
			<%
			if(id == null){
			
			%>
			
				<p class="korean_center text_border">회원가입을 하시면 소모임을 창설하실 수 있습니다.</p>
			<%
			}
			else{
			%>
		<form id="make_so" action="template.templ?page=insertSo.somo" method="post" enctype="multipart/form-data">
			
			<input type="hidden" id="founder" name= "founder" value="<%=id%>" />
			<p class="smaller_logo">FOUNDER</p>
			 <input type="text" id="nickname" name="nickname" class="border_bottom_input korean" size="40" value="<%=nickname %>" readonly/>
			 <br />
			 <br />
			 <p class="smaller_logo">CIRCLE NAME</p>
			 <input type="text" id="name" name="name" class="border_bottom_input korean" size="40" placeholder="소모임 이름을 작성해주세요" />
			 <br />
			 <br />
			 <p class="smaller_logo">PLACE</p>
			 <input type="text" id="place" name="place" class="border_bottom_input korean" size="40" placeholder="주요 활동 지역을 적어주세요" />
			 <br />
			 <br />
			 <p class="smaller_logo">INTRO</p>
			 <input type="text" id="intro" name="intro" class="border_bottom_input korean" size="40" placeholder="소모임을 소개해주세요" />
			 <br />
			 <br />
			 <p class="smaller_logo">TEAM PHOTO</p>
			 <input class="korean" type="file" name="file" />
			 <br />
			 <br />
			 <input type="submit" class="korean" value="소모임등록"/>
		</form>
		<%
			}
		%>
		</div>
	</div>
	<br />
	<br />
</div>
</body>
</html>