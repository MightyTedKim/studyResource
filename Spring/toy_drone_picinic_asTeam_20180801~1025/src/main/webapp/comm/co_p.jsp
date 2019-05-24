<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.drone.co.AlbumVO"%>
<%@ page import="com.spring.drone.co.AlbumPaginationVO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
	ArrayList<AlbumVO> albumList = (ArrayList<AlbumVO>)request.getAttribute("albumList");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	AlbumPaginationVO albumPaginationVO = (AlbumPaginationVO)request.getAttribute("albumPaginationVO");
	int number = albumPaginationVO.getNumber();
		
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
	
	
%>
<html>
<head>

<title>사진첩</title>
<meta charset="utf-8">
<body>
<div class="container" style="position:relative;">
		<div class="row line_color_yellow_b mt-1 mb-5">
			<div class="col-lg-12 text_align_center">
				 <p class="small_logo">PHOTOGRAPHY</p>
				 <p class="korean_center">드론으로 찍은 사진을 올려주세요</p>
			</div>
		</div>
		<div class="row mt-1 mb-1">
			<div class="col-lg-12 text_align_center">
				<%
				if (id != null){
				%>
				 <p class="korean_center"><a href="template.templ?page=co_p_write.co?pageNum=<%=albumPaginationVO.getPageNum() %>">사진 올리기</a></p>
				 <%
				}
				else{
				 %>
				 <p class="korean_center">로그인을 하시면 사진을 업로드 하실 수 있습니다.</p>
				 <%
				}
				 %>
			</div>
		</div>
		
		<br>
		<div style="text-align:center;">
    <form action="/drone/template.templ?page=search_Album.co" method="post">
        <input type="text" name="search" id="search" placeholder="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;키워드 검색 후 엔터키를 눌러주세요!" style="width:40%; border-radius: 10px;" />
     </form>      
    </div> 
		 
		<div class="row line_color_yellow_b mt-1 mb-1 pt-2">
			
			<%
				for (int i=0;i < albumList.size();i++){
					AlbumVO vo = albumList.get(i);
					StringTokenizer parsed = new StringTokenizer(vo.getStoredFileName(), "///", false);
					ArrayList<String> parsedSet = new ArrayList<String>();
					while(parsed.hasMoreTokens()){
						parsedSet.add(parsed.nextToken());
					}

			%>
			
				<div class="col-sm-4 korean mb-5">
					<div style="height: 200px; width: 280px; overflow: hidden;" class="mb-3">
						<a href="#album_modal<%=i%>" class="card-link" data-toggle="modal">
						<img class="card-img-top rounded-0 mb-4" style="height: auto; width: 430px; overflow: hidden;" src="<spring:url value='/image/album/' /><%=parsedSet.get(0).toString()%>" alt="Card image cap">
						</a>
					</div>
						<div class="">
							<div class="card-title korean mb-1" style="font-size:20px;"><%=vo.getTitle() %></div>
							<h6 class="card-subtitle mb-2 text-muted">photo by <%=vo.getNickname()%>&nbsp;<%=sdf.format(vo.getPdate())%></h6>
							<div style="padding:1px;">
								<a href="template.templ?page=co_p_view.co?num=<%=vo.getNum()%>&pageNum=<%=albumPaginationVO.getCurrentPage() %>&number=<%=albumPaginationVO.getNumber() %>&readcount=<%=vo.getReadcount()%>&likecount=<%=vo.getLikecount() %>">자세히보기</a> &nbsp; 								
								<span class="card-link">조회수[<%=vo.getReadcount()%>]</span>&nbsp;&nbsp; 
							    <span><img src="/drone/resources/img/sodetail/like2.png" class="rounded-circle" style="width:15px; margin-top:-5px;"> [<%=vo.getLikecount() %>]</span>
						    </div>
							    
						</div>
					<div class="modal korean" id="album_modal<%=i%>" tabindex="-1" role="dialog">
					  <div class="modal-dialog modal-lg" role="document">
					    <div class="modal-content">
					   
					      <div class="modal-header">
					      	
					        <h5 class="modal-title"><%=vo.getTitle() %></h5>
					        
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					       <img class="modal-content img-fluid rounded-0" src="<spring:url value='/image/album/' /><%=parsedSet.get(0).toString()%>" alt="Card image cap">
					    
					        <p><%=vo.getBody() %></p>
					      </div>
					      
					    </div>
					  </div>
					</div>
				<br><br>	
				</div>
			<%
				}
			%>
<div class="row" style="position:absolute; left:20px; bottom:0px;"> 
	  <nav aria-label="Page navigation example">
	    <ul class="pagination justify-content-center">
	<%
	 
		if(albumPaginationVO.getCount() > 0){
		    int pageCount = ((albumPaginationVO.getCount()-1) / albumPaginationVO.getPageSize())+1;
		    int startPage = 1;
		    int i;
		    if (albumPaginationVO.getCurrentPage()%9 !=0)
		       startPage = (int)(albumPaginationVO.getCurrentPage()/9)*9+1;
		    else
		       startPage = albumPaginationVO.getCurrentPage() - 8;
		    int pageBlock = 9;
		    
		    if(startPage > 9){
	%>
		 <li class="page-item disabled">
	     <a class="page-link" href="template.templ?page=co_p.co?pageNum=<%=startPage - pageBlock %>" tabindex="-1">PREV</a>
		 </li>
	<%
	    }
	    for(i=startPage;(i<=startPage+(pageBlock-1))&&(i<=pageCount);i++){      
	%>
	     <li class="page-item"><a class="page-link" href="template.templ?page=co_p.co?pageNum=<%=i %>"><%=i %></a></li>
	<%
	    }
	    if(i<pageCount){
	%>
			<li class="page-item">
	 <a class="page-link" href="template.templ?page=co_p.co?pageNum=<%=startPage+pageBlock %>">NEXT</a></li>
	<%
	    }
	 }
	%>
	
	   </ul>
	</nav>
  </div>

</div><!-- yellow line 끝 -->	
</div><!-- div container 끝 -->

</body>
</html>