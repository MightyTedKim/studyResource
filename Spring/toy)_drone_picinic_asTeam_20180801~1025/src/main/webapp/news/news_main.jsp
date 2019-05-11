<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.spring.drone.news.NewsVO"%>
<%@ page import="com.spring.drone.news.NewsPaginationVO"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	System.out.println(">news_main.jsp");  
	ArrayList<NewsVO> newsList = (ArrayList<NewsVO>)request.getAttribute("newsList");
	NewsPaginationVO newsPaginationVO = (NewsPaginationVO)request.getAttribute("newsPaginationVO");

	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>드론 뉴스</title>
<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">   
</head>
<body>

<div class="container">
	<div class="row mt-1 mb-1 pt-5"
		style="background-image: url('${pageContext.request.contextPath}/resources/img/logo_pic/20.jpg'); background-size: cover; background-position: center; ">
		<div class="col-lg-12 line_color_yellow_b text_align_center mb-5">
			<p class="small_logo text_border">NEWS</p>
			<p class="korean_center text_border">최신 드론 뉴스를 확인하세요</p>
			
		</div>
		<br /> <br />
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
	<!-- search -->
		     <div class="row mb-1 text-center">
		     	<div class="korean_board" style="width:80%; margin:auto;">
   		     		<p class="korean_center text-center text_border">나만의 검색어를 저장하시고 빠짐없이 뉴스를 확인해보세요</p>		     
		     		<form id="news_search" name="news_search" method="post">
		     			<!-- <select name="searchField" class="border_input p-1">
						    <option value="title_field">제목</option>
						    <option value="body_field">내용</option>
						    <option value="source_field">출처</option>
						</select>    -->
						<input type="hidden" name="searchId" id="searchId" value="<%=id %>" />
		                <input type="text" class="border_input" name="searchInput" id="searchInput" placeholder="검색어입력">
		               <input type="submit" class="button_bg_blue_small" id="insertKeyword" value="검색어등록" />
		     		</form>
		     	</div>
		     	<div class="col-sm-12 mt-2 korean_center" id="output">
		     	</div>
		   	</div> 
		   <!-- search/ --> 
<div class="row justify-content-center mt-5 p-2">
	<div class="col-lg-5 pt-4 orange_border" style="height: 400px;">
		<table class="table table-condensed table-sm table_fixed">
			<thead>
			<tr class="d-flex board_font">
				<td class="col-9" style="font-size: 20px; text-align: left; font-weight: bold; line-height: 1.5em;">드론교육뉴스</td>
				<td class="col-3" ><p class="bottom_line"><a href="template.templ?page=edu_news_list.news">더보기</a></p></td>
			</tr>
			</thead>
			<tbody class="korean">
 			<%
			for(int i=0;i < 10;i++){
				NewsVO vo = newsList.get(i);	
			%>
			<tr class="d-flex">
				<td class="col-9 td_no_overflow"><a href="template.templ?page=getNews.news?num=<%=vo.getNum() %>&pageNum=<%=newsPaginationVO.getCurrentPage() %>&number=<%=newsPaginationVO.getNumber() %>&readcount=<%=vo.getReadcount()%>"><%=vo.getTitle() %></a></td>
				<td class="col-3 td_no_overflow"><%=vo.getSource() %></td>
			</tr>
			<%
			}
			%>
			</tbody>
		</table>
	</div>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="col-lg-5 pt-4 orange_border" style="height: 400px;">
		<table class="table table-condensed table-sm table_fixed">
			<thead>
			<tr class="d-flex board_font">
				<td class="col-9" style="font-size: 20px; text-align: left; font-weight: bold; line-height: 1.5em;">공모전/대회 소식</td>
				<td class="col-3" ><p class="bottom_line"><a href="template.templ?page=com_news_list.news">더보기</a></p></td>
			</tr>
			</thead>
			<tbody class="korean">
 			<%
			for(int i=0;i < 10;i++){
				NewsVO vo = newsList.get(i);	
			%>
			<tr class="d-flex">
				<td class="col-9 td_no_overflow"><a href="template.templ?page=getNews.news?num=<%=vo.getNum() %>&pageNum=<%=newsPaginationVO.getCurrentPage() %>&number=<%=newsPaginationVO.getNumber() %>&readcount=<%=vo.getReadcount()%>"><%=vo.getTitle() %></a></td>
				<td class="col-3 td_no_overflow"><%=vo.getSource() %></td>
			</tr>
			<%
			}
			%>
			</tbody>
		</table>
	</div>
</div>
  
<div class="row mt-2 p-2 justify-content-center">
	<div class="col-lg-5 pt-4 orange_border" style="height: 400px;">
		<table class="table table-condensed table-sm table_fixed">
			<thead>
			<tr class="d-flex board_font">
				<td class="col-9" style="font-size: 20px; text-align: left; font-weight: bold; line-height: 1.5em;">드론레저상품모음</td>
				<td class="col-3" ><p class="bottom_line"><a href="template.templ?page=leisure_news_list.news">더보기</a></p></td>
			</tr>
			</thead>
			<tbody class="korean">
 			<%
			for(int i=0;i < 10;i++){
				NewsVO vo = newsList.get(i);	
			%>
			<tr class="d-flex">
				<td class="col-9 td_no_overflow"><a href="template.templ?page=getNews.news?num=<%=vo.getNum() %>&pageNum=<%=newsPaginationVO.getCurrentPage() %>&number=<%=newsPaginationVO.getNumber() %>&readcount=<%=vo.getReadcount()%>"><%=vo.getTitle() %></a></td>
				<td class="col-3 td_no_overflow"><%=vo.getSource() %></td>
			</tr>
			<%
			}
			%>
			</tbody>
		</table>
	</div>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="col-lg-5 pt-4 orange_border" style="height: 400px;">
		<table class="table table-condensed table-sm table_fixed">
			<thead>
			<tr class="d-flex board_font">
				<td class="col-9" style="font-size: 20px; text-align: left; font-weight: bold; line-height: 1.5em;">드론구직뉴스</td>
				<td class="col-3" ><p class="bottom_line"><a href="template.templ?page=job_news_list.news">더보기</a></p></td>
			</tr>
			</thead>
			<tbody class="korean">
 			<%
			for(int i=0;i < 10;i++){
				NewsVO vo = newsList.get(i);	
			%>
			<tr class="d-flex">
				<td class="col-9 td_no_overflow"><a href="template.templ?page=getNews.news?num=<%=vo.getNum() %>&pageNum=<%=newsPaginationVO.getCurrentPage() %>&number=<%=newsPaginationVO.getNumber() %>&readcount=<%=vo.getReadcount()%>"><%=vo.getTitle() %></a></td>
				<td class="col-3 td_no_overflow"><%=vo.getSource() %></td>
			</tr>
			<%
			}
			%>
			</tbody>
		</table>
	</div>
	</div>
</div>
<br />
<br />
<br />
<script>
function selectKeyList() {

	$('div#output').empty();

	$.ajax({
		url : '/drone/getKeywordList.news?searchId=<%=id%>',
		type : 'GET',
		dataType : "json",
		async: true,
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(data) {
			$.each(data, function(index, item) {
				var id = "<%=id%>";
				var output = "";
				if (id != "" & id == item.searchId){
					output += "<span>| <a href='template.templ?page=key_news_list.news?searchInput=" + item.searchInput + "'>" + item.searchInput + "</a> |</span>";
				}
				else{
					output= "";
				}
				
				$('div#output').append(output);
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



$(document).ready(function() {
	selectKeyList();

	$('#insertKeyword').click( function(event) {
		if (<%=id%> == null){
			alert('로그인을 하시면 퍼스널 뉴스 검색키워드를 저장하실 수 있습니다.');
		}
		else{
			var params = $("#news_search").serialize();
			
			console.log('params: ' + params);
			$.ajax({
				url : '/drone/insertKeyword.news',
				type : 'POST',
				data : params,
				dataType : "json",
				contentType : 'application/x-www-form-urlencoded; charset=utf-8',
				success : function(retVal) {
					if (retVal.res == "OK") {
						selectKeyList();
						$('#searchInput').val('');
					} else {
						alert("퍼스널 키워드 입력 실패");
					}
				},
	        	error : function(request,status,error){
	        		console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
	        	}
			});
			//기본 이벤트 제거
			event.preventDefault();
		}
		});
		selectKeyList();
});
</script>
</body>
</html>