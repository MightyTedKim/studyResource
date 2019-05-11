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
					<h3>10장) 검색 </h3>
					<ol>
						<li><a href='/board/listPage'> 상세 조회 : /board/listPage </a> <br/> </li>
						<li><a href='/board/listPage?page=2&perPageNum=10&searchType&keyword='>
								상세 조회(pagination 누르면) : /board/listPage?page=2&perPageNum=10&searchType&keyword= </a> <br/></li>
						<li><a href='/board/listPage?page=2&perPageNum=10&searchType&keyword=글'>
								상세 조회(pagination 누르면) + 글자 입력 : /board/listPage?page=1&perPageNum=10&searchType=t&keyword=글 </a> <br/></li>

				 	</p>
				</div>
			</div>
		</div>	<!--/.col (left) -->
	</div> <!-- /.row -->
</section> <!-- /.content -->


<%@include file="include/footer.jsp"%>


