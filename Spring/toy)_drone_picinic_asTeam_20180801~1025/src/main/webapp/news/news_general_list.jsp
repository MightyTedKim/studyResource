<%@ page contentType="text/html; charset=utf-8"%> 
<%@ page import="com.spring.drone.news.NewsVO"%>
<%@ page import="com.spring.drone.news.NewsPaginationVO"%> 
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%   
 
   ArrayList<NewsVO> newsList = (ArrayList<NewsVO>)request.getAttribute("newsList");
   NewsPaginationVO newsPaginationVO = (NewsPaginationVO)request.getAttribute("newsPaginationVO");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   int number = newsPaginationVO.getNumber();

	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
%>

<!DOCTYPE html>
<html> 
<head> 

<title>글 목록</title> 

<style>
   .search-width{
      width: 30%;
      float: right;
   }


   #h3 {
   text-align:center; 
   font-size: 40px; 
   color: #51465b;
   
   }
   
   #hr {
   height: 1px;
    background: #675a72;
   }
   
/*    .table {
   border: 2px solid #f4e8f7;
   }
 */
   
   
</style>

</head> 

<body>
<div class="container">

  <div class="row mt-1 mb-1 pt-5">
		<div class="col-lg-12 line_color_yellow_b text_align_center mb-5">
			<p class="small_logo text_border">NEWS ARCHIVE</p>
			<p class="korean_center text_border">드론 일반 뉴스 아카이브</p>
			<p class="korean_center text_border">나만의 검색어를 저장하시고 빠짐없이 뉴스를 확인해보세요</p>
			<!-- search -->
   
		     <div class="row mb-1">
		     	<div class="col-sm-12 korean_board">
					<div style="width:80%; margin:auto;">	     			     	
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
		     	</div>
		     	<div class="col-sm-12 mt-4 korean_center mb-3" id="output">
		     	</div>
		   	</div> 
		   <!-- search/ --> 
		</div>
		<br /> <br />
	</div>
	
	<div class="row mt-0 mb-1 pt-0">
		<div class="col-lg-12 text_align_center">
			 <p class="korean_center"><a href="template.templ?page=list.news">일반드론뉴스</a> │ 
			 <a href="template.templ?page=edu_news_list.news">드론교육뉴스</a> | 
			 <a href="template.templ?page=com_news_list.news">공모전/대회 소식</a> │ 
			 <a href="template.templ?page=leisure_news_list.news">드론레저상품모음</a> │ 
			 <a href="template.templ?page=job_news_list.news">드론구직란</a></p>
		</div>
	</div>
   
 
<%
      if(newsPaginationVO.getCount() == 0){
%>    
      <table class="table table-hover korean_board"> 
         <tr class="d-flex">
            <td align="center">
               게시판에 저장된 글이 없습니다.
            </td>
         </tr>
      </table>
<%
      }
      else
      {
%>
      <table class="table table-sm korean_board" style="font-size: 15px; font-weight: bold;">
         <thead>
         <tr class="d-flex" style="font-size: 25px;">
            <td class="col-sm-1"> 번호 </td>
            <td class="col-sm-8"> 제 목 </td>
            <td class="col-sm-2"> 출처 </td>
            <td class="col-sm-1"> 조회 </td>
         </tr>
<%
         for(int i=0;i < newsList.size();i++){
            NewsVO vo = newsList.get(i);   
%>      
            <tr class="d-flex">
               <td class="col-sm-1">
                  <%=number %>
               </td>
               <td class="col-sm-8 pl-0 td_no_overflow">
		          <a href="template.templ?page=getNews.news?num=<%=vo.getNum() %>&pageNum=<%=newsPaginationVO.getCurrentPage() %>&number=<%=newsPaginationVO.getNumber() %>&readcount=<%=vo.getReadcount()%>">
                     <%=vo.getTitle() %>
                  </a>
                 </td>
                  <td class="col-sm-2 td_no_overflow">
                  <a href="<%=vo.getUrl() %>" target="_blank">
                     <%=vo.getSource() %>
                  </a>
                  </td>   
                  <td class="col-sm-1">
                     &nbsp;<%=vo.getReadcount() %>
                  </td>
               </tr>
<%
               number--;
            }
%>
         </table>
         <br>
		<nav aria-label="Page navigation example">
  			<ul class="pagination justify-content-center">
<%
      }
      if(newsPaginationVO.getCount() > 0){
         int pageCount = ((newsPaginationVO.getCount()-1) / newsPaginationVO.getPageSize())+1;
         int startPage = 1;
         int i;
         if (newsPaginationVO.getCurrentPage()%10 !=0)
            startPage = (int)(newsPaginationVO.getCurrentPage()/10)*10+1;
         else
            startPage = newsPaginationVO.getCurrentPage() - 9;
         int pageBlock = 10;

         if(startPage > 10){
%>
            <li class="page-item disabled">
      			<a class="page-link" href="template.templ?page=list.news?pageNum=<%=startPage - pageBlock %>" tabindex="-1">PREV</a>
    		</li>
            
            
<%
         }
         for(i=startPage;(i<=startPage+(pageBlock-1))&&(i<=pageCount);i++){      
%>
            <li class="page-item"><a class="page-link" href="template.templ?page=list.news?pageNum=<%=i %>"><%=i %></a></li>
<%
         }
         
         if(i<pageCount){
%>
            <li class="page-item">
      			<a class="page-link" href="template.templ?page=list.news?pageNum=<%=startPage+pageBlock %>">NEXT</a>
    		</li>
   
<%
         }
      }
%>
			</ul>
		</nav>


    
  




   </div>
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