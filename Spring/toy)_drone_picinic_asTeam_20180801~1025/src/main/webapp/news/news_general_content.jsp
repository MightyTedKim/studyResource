<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.drone.news.NewsVO"%>
<%@ page import="com.spring.drone.news.NewsPaginationVO"%>
<%@ page import="com.spring.drone.news.ReplyVO"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  
<%
	NewsVO vo = (NewsVO) request.getAttribute("newsVO");
	NewsPaginationVO newsPaginationVO = (NewsPaginationVO) request.getAttribute("newsPaginationVO");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
</head>

<!--  
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
-->
<script type="text/javascript">
$(document).ready( function() {
	//목록
	function selectData() {
		//table내부 내용을 제거(초기화)
		$('div#reply_body').empty();
		var params = $("#reply_input_form").serialize();
		$.ajax({
			url : '/drone/getReplyJSON.news',
			type : 'POST',
			data : params,
			dataType : 'json',
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			success : function(data) {
				$.each(data, function(index, item) {
					var output = '';
					output += '<br />';
					output += '글쓴이: ' + item.replyid + '<br /><hr/>';
					output += '&nbsp;&nbsp;&nbsp; 답글:   ' + item.replybody + '<br /><hr/>';
					// output += '<input type="hidden" id="ref" value="item.ref" /><input type="hidden" id="re_level" value="item.re_level" /><input type="hidden" id="ref" value="item.re_step" />';

				 	console.log("output: "	+ output);
					$('div#reply_body').append(output);
				});
			},
			error : function(jqXHR, exception) {
				var msg = '';
		        if (jqXHR.status === 0) {
		            msg = 'Not connect.\n Verify Network.';
		        } else if (jqXHR.status == 404) {
		            msg = 'Requested page not found. [404]';
		        } else if (jqXHR.status == 500) {
		            msg = 'Internal Server Error [500].';
		        } else if (exception === 'parsererror') {
		            msg = 'Requested JSON parse failed.';
		        } else if (exception === 'timeout') {
		            msg = 'Time out error.';
		        } else if (exception === 'abort') {
		            msg = 'Ajax request aborted.';
		        } else {
		            msg = 'Uncaught Error.\n' + jqXHR.responseText;
		        }
		        alert("selectData error: " + msg);
			}
		});

	}
	
	$('#button_click').click( function(event) {
		var params = $("#reply_input_form").serialize();
		
		$.ajax({
			url : '/drone/insertReply.news',
			type : 'POST',
			data : params,
			dataType : 'json',
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			
			success : function(retVal) {
				if (retVal.res == "OK") {
					selectData();
					$('#replyid').val('');
					$('#replybody').val('');
				} else {
					alert("Insert Fail");
				}
			},
			error : function(jqXHR, exception) {
				var msg = '';
		        if (jqXHR.status === 0) {
		            msg = 'Not connect.\n Verify Network.';
		        } else if (jqXHR.status == 404) {
		            msg = 'Requested page not found. [404]';
		        } else if (jqXHR.status == 500) {
		            msg = 'Internal Server Error [500].';
		        } else if (exception === 'parsererror') {
		            msg = 'Requested JSON parse failed.';
		        } else if (exception === 'timeout') {
		            msg = 'Time out error.';
		        } else if (exception === 'abort') {
		            msg = 'Ajax request aborted.';
		        } else {
		            msg = 'Uncaught Error.\n' + jqXHR.responseText;
		        }
		        alert("button_click error: " + msg);
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	selectData();
});
</script>
<body>
	<div align="center" class="container">
		<div class="row line_color_yellow_b mt-1 mb-1 pt-5">
			<div class="col-sm-12 text_align_center">
			 	<p class="small_logo">GENERAL NEWS</p>
			 	<p class="korean_center">드론 일반 기사를 한 곳에서 확인하세요</p>
			</div>
		</div>
		
	<div class="row mt-1 mb-1 pt-5">
		<div class="col-lg-12 text_align_center">
			 <p class="korean_center"><a href="template.templ?page=list.news">일반드론뉴스</a> │ 
			 <a href="template.templ?page=edu_news_list.news">드론교육뉴스</a> | 
			 <a href="template.templ?page=com_news_list.news">공모전/대회 소식</a> │ 
			 <a href="template.templ?page=leisure_news_list.news">드론레저상품모음</a> │ 
			 <a href="template.templ?page=job_news_list.news">드론구직란</a></p>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 p-3">
			<table class="table korean" style="font-size:20px">
			<thead>
				<tr>
					<th scope="col">기사제목</th>
					<th scope="col"><%=vo.getTitle()%></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">출처</th>
					<td><%=vo.getSource() %></td>
				</tr>
				<tr>
					<th scope="row">발행일</th>
					<td><%=vo.getPdate() %></td>
				</tr>
				<tr>
					<th scope="row" colspan="2" style="padding:50px"><%=vo.getBody() %>
						<hr> <a href="<%=vo.getUrl()%>" target="_blank">원글 보기</a><br />
						출처: <%=vo.getSource()%><br /> <a href="<%=vo.getUrl()%>"
						target="_blank"><%=vo.getUrl()%></a></th>
				</tr>
				<tr>
					<th scope="row">조회수 <%=vo.getReadcount()%></th>
					<td>글번호 <%=newsPaginationVO.getNumber()%>
					</td>
				<tr>
			</tbody>
		</table>
		<table class="table table-bordered">
			<tr>
				<td scope="row">
					<div class="col-sm-10 m-2 mt-2 korean" style="font-size:20px" id="reply_body"></div>
				</td>
			</tr>
		</table>

		<form id="reply_input_form" method="post" onsubmit="return false;">
			<table class="table table-sm">
				<tr>
					<td scope="row" colspan="2">
						<div style="width:80%; margin:auto;">
							<input type="hidden" id="num" name ="num" value="<%=vo.getNum()%>" />
							<input type="hidden" id="ref" name ="ref" value="1" />
							<input type="hidden" id="re_level" name ="re_level" value="0" />
							<input type="hidden" id="re_step" name ="re_step" value="0" />
							<span> <strong>글쓴이 </strong></span> <input type="text" id="replyid" name ="replyid"/>
							<span> <strong>답글 </strong></span> <textarea rows="5" id="replybody" name ="replybody" style="width: 100%;">
							</textarea>
							
    						<button type="submit" id="button_click"><b>답글달기</b></button>
							
							<!-- <button class="btn btn-primary" id="button_click" type="submit">답글달기</button> -->
						</div>

					</td>
				</tr>
			</table>
		</form>
		
		</div>
	</div>
		
	</div>
</body>
</html>