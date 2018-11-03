<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="include/header.jsp"%>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->

			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">HOME PAGE</h3> <br/>
					<hr/>
					<h1>part2) 기본적인 게시물 관리</h1>
					<h3>1~7장) 등록/전체 목록 보기</h3>
					<ol>
						<li><a href='/board/register'>게시물 등록 : register</a> <br/></li>
						<li><a href='/board/listAll'>목록 조회(전체):listall</a> <br/><br/></li>
					
						<p> 꼭 bno 존재하는걸로 입력해야됨 </p>
						<li><a href='/board/read?bno=3'>상세 조회 : board/read?bno=3</a> <br/></li>
						<li><a href='/board/modify?bno=3'>수정: board/modify?bno=3</a> <br/></li>
						<li><a href='/board/listAll'>목록 보기: listall(위의 listall과 똑같음)</a> <br/></li>				
					</ol>
					<hr/>					
					<h3>8장) 일부 목록 보기 </h3>
					<ol>
						<li><a href='/board/listCri'>목록 조회(default): listCri</a> <br/></li>
						<li><a href='/board/listCri?page=1&perPageNum=10'>목록 조회(파라미터): listCri?page=1&perPageNum=10</a> <br/></li>
						<p>
							수정 삭제 read, modify(get/post)로 함 <br/>
							원하는 양의 목록만 가져올 수 있는지 테스트하는 페이지<br/><br/>
						</p>
					</ol>					
					<hr/> 
					<h3>9장) 페이징된 목록 보기 </h3>
					<ol>			
						<li><a href='/board/listPage'>목록 조회(default): listPage</a> <br/></li>
						<li><a href='/board/listPage?page=11&perPageNum=10'>목록 조회(파라미터): listPage?page=11&perPageNum=10</a> <br/></li>
						<br/>
						<p> 
							수정 삭제 readPage, modifyPage로 함 <br/>
							pagination에서 목록 돌아가기 해야되는데 기존 read/modify는 돌아갈 페이지 정보 X <br/>	
						</p> 
						
						<li><a href='/board/readPage?page=1&perPageNum=10&bno=5'>상세 조회 : /board/readPage?page=1&perPageNum=10&bno=5 </a> <br/></li>
						<li><a href='/board/modifyPage?bno=5&page=1&perPageNum=10'>수정: /board/modifyPage?bno=5&page=1&perPageNum=10 </a> <br/></li>
						
					</ol>
					<p><b>p278p 오류</b></p>
					<p>
						* 여기서 makeQuery 와 2개의 pagination 때문에 헷갈릴 수 있음 <br/>
						(작가 분이 여기는 조금 헷갈리게 썼다고 말하셨음) <br/>
						makeQuery 주석달고 하거나/ p286 makeQuery 만들면 됨<br/>
						 + 빵형은 makeQuery 같이 url 합치는건 js로 하는 경우가 많다고 패스하심							 
					</p>
					<hr/>
					
					<h3>10장) 검색 </h3>
					<ol>
						<li><a href='/sboard/list'> 상세 조회 : /sboard/list </a> <br/> </li>
						<li><a href='/sboard/list?page=2&perPageNum=10&searchType&keyword='>
								상세 조회(pagination 누르면) : /sboard/list?page=2&perPageNum=10&searchType&keyword= </a> <br/></li>
						<li><a href='/sboard/list?page=2&perPageNum=10&searchType&keyword=글'>
								상세 조회(pagination 누르면) + 글자 입력 : http://localhost:8080/sboard/list?page=1&perPageNum=10&searchType=t&keyword=글 </a> <br/></li>
					</ol>
					<p>
					sboard라는 폴더를 새로 만드는데, board안에 들어가도 상관은 없다고 한다. <br/>
					공부를 위해 따로 만들었다고 한다.<br/>
					SearchBoardController + SearchCriteria 도 만든다. <br/>
					</p>
					<p>
					여기서 헷갈렸던 것은 기존 board/list.jsp를 그대로 복사하다가 <br/>
					js에서 event.preventDefault()를 지우지 않아서 였다. <br/><br/>
					그리고 다른 DB와 달리 mysql은 || 가 or로 인식되서 concat과 다르다고 한다.
				 	</p>
				</div>
			</div>
		</div>	<!--/.col (left) -->
	</div> <!-- /.row -->
</section> <!-- /.content -->


<%@include file="include/footer.jsp"%>


