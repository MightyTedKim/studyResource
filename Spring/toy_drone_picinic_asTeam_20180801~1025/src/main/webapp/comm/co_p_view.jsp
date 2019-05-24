<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.spring.drone.co.AlbumVO"%>
<%@ page import="com.spring.drone.co.AlbumPaginationVO"%> 
<%@ page import="com.spring.drone.co.AlbumReplyVO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<%
	AlbumVO vo = (AlbumVO) request.getAttribute("albumVO");
	AlbumPaginationVO albumPaginationVO = (AlbumPaginationVO)request.getAttribute("albumPaginationVO");
	/* AlbumPageVO pageVO = (AlbumPageVO) request.getAttribute("pageVO"); */
	/* ArrayList<AlbumReplyVO> replyList = (ArrayList<AlbumReplyVO>) request.getAttribute("replyList");
	 */SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

 	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
   
      String tag1 = vo.getTag1();
      String tag2 = vo.getTag2();
      String tag3 = vo.getTag3();
      String tag4 = vo.getTag4();
      String tag5 = vo.getTag5();
      String tag6 = vo.getTag6();
      
      if(tag1 == null){
         tag1 = "";
      }
      if(tag2 == null){
         tag2 = "";
      }
      if(tag3 == null){
         tag3 = "";
      }
      if(tag4 == null){
         tag4 = "";
      }
      if(tag5 == null){
         tag5 = "";
      }
      if(tag6 == null){
         tag6 = "";
      }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Album_detail</title>
<script>
 function deleteAlbum(){
	 var con = confirm("글과 사진 모두 삭제됩니다.");
     if(con == true){
   
    	 location.href="template.templ?page=co_p_delete.co?num=" + <%=vo.getNum()%> + "&pageNum=" + <%=albumPaginationVO.getPageNum()%>;
         //logout을 위해 세션을 제거하는 페이지 호출
     }else{}
    }
</script>
<style>

#carouselExampleIndicators img {
        width: auto;
        margin: auto;
        height: 500px;
        max-height: 800px;
        border-radius: 15px;

   }
</style>


</head>
<body>

<div class="container">
		<div class="row line_color_yellow_b mt-1 mb-1 pt-5">
			<div class="col-lg-12 text_align_center">
				 <p class="small_logo">PHOTOGRAPHY</p>
				 <p class="korean_center">드론으로 찍은 사진을 올려주세요</p>
			</div>
		</div>
		<div class="row mt-1 mb-1 pt-2">
			<div class="col-lg-12 text_align_center">
				 <p class="korean_center"><a href="template.templ?page=co_p_write.co">사진 올리기</a> │ <a href="template.templ?page=co_p.co?num=<%=vo.getNum()%>&pageNum=<%=albumPaginationVO.getPageNum() %>">목록으로 돌아가기</a></p>
			</div>
		</div>   

   
  <div class="row">
     <div class="col-sm-6 justify-content-center align-items-center"  style="font-size: 14px; text-align: center; font-weight: bold; line-height: 1.5em;">
	     <div class="shadow p-2 bg-white rounded korean_center">
	      	<div class="row">
	      		<div class="col-sm-6">
	      			 <img src="${pageContext.request.contextPath}/resources/img/small/1.jpg" class="rounded-circle" width="80px" />
	      		</div>
	      		<div class="col-sm-6 text-left pt-3">
	      			<p><%=vo.getTitle() %></p><p>by <%=vo.getNickname() %></p>   
	      		</div>
	      	</div>
      	</div>
      </div>

      	
      
      <div class="col-sm-5 korean ml-1">
         <%--  <p><img src="${pageContext.request.contextPath}/resources/img/small/3.jpg" class="rounded-circle" width="30px" /> --%>
        	<div class="korean" id="likeput"></div>
			<p>
				<img src="${pageContext.request.contextPath}/resources/img/small/2.jpg" class="rounded-circle" width="30px" />
				<span style="font-size:20px;">&nbsp;조회수&nbsp;[<%=vo.getReadcount()%>]</span>
			</p>          	
			<p>
				<img src="${pageContext.request.contextPath}/resources/img/small/1.jpg" class="rounded-circle" width="30px" />
				<span style="font-size:20px;">
					<a href="template.templ?page=co_p_modify_form.co?num=<%=vo.getNum()%>">&nbsp;글 수정하기</a> | 
					<a href="#" onClick="deleteAlbum(); return false;">글 삭제하기</a>
				</span>
			</p>
			<input type="text" id="likeStatus" hidden="hidden">
			<input type="text" id="numS" hidden="hidden">
      </div>
   </div>
   

     <!-- Carousel -->
   <div class="row">
   <div class="col-sm-12 mb-20 justify-content-center align-items-center">
     <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
      
      	<%
	      	StringTokenizer parsed = new StringTokenizer(vo.getStoredFileName(), "///", false);
			ArrayList<String> parsedSet = new ArrayList<String>();
			while(parsed.hasMoreTokens()){
				parsedSet.add(parsed.nextToken());
			}
			
		%>
		<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
		<%
			for (int i = 1;i<parsedSet.size();i++){
      	%>
       <li data-target="#carouselExampleIndicators" data-slide-to="<%=i%>"></li>
		<%
			}
		%>
       </ol>
     <div class="carousel-inner">
     <div class="carousel-item active">
      	<img class="d-block w-100" src="<spring:url value='/image/album/' /><%=parsedSet.get(0).toString()%>" alt="<%=vo.getTitle()%>">
     </div>
     
     	<%
			for (int i = 1;i<parsedSet.size();i++){
		%>
     
     
     <div class="carousel-item">
      	<img class="d-block w-100" src="<spring:url value='/image/album/' /><%=parsedSet.get(i).toString()%>" alt="<%=vo.getTitle()%>">
     </div>
     <%
				}
     %>
    
     </div>
     <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
       <span class="carousel-control-prev-icon" aria-hidden="true"></span>
       <span class="sr-only">Previous</span>
     </a>
      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
       <span class="carousel-control-next-icon" aria-hidden="true"></span>
       <span class="sr-only">Next</span>
     </a>
   </div>
   </div>
   </div>
<br />
<br />

   <div class="row">
   <div class="col-sm-6">
         <div id="map_canvas" style="height: 500px;"></div>
   </div>
   <div class="col-sm-6 pl-2 pt-2">
   <h4 class="small_logo" style="font-size:30px; font-weight: bold; color: grey;">MORE INFO</h4>
   <br />
   
			<table class="table table-hover">
            <tbody>
                <tr>
                  <th scope="row" class="detail_logo" style="font-size:30px">DATE</th>
                  <td class="korean align-middle" style="font-size:28px; color:lightslategray;"><%=sdf.format(vo.getPdate()) %></td>
                </tr>
                <tr>
                  <th scope="row" class="detail_logo" style="font-size:30px">DRONE</th>
                  <td class="korean align-middle" style="font-size:28px; color:lightslategray;"><%=vo.getPname() %></td>
                </tr>
                <tr>
                  <th scope="row" class="detail_logo" style="font-size:30px">PLACE</th>
                  <td class="korean align-middle" style="font-size:28px; color:lightslategray;"><%=vo.getCoor()%>  </td>
                </tr>
                <tr>
                  <th scope="row" class="detail_logo" style="font-size:30px">CATEGORY</th>
                  <td class="korean align-middle" style="font-size:28px; color:lightslategray;"><%=vo.getCategory() %></td>
                </tr>
             </tbody>
            </table>
            <br />
   
            <div class="col-sm-12 justify-content-right align-items-center p-0">
             <div class="form-group col-sm-12 p-0">   
                <form>          
                  <textarea name="message" class="form-control required korean p-1" id="message" 
                  style="font-size:20px;" title="Message" rows=3 readonly><%=vo.getBody() %></textarea>
                </form>      
              </div>
            </div>   
      </div>
   </div>
   
   <br />
   <div class="row">
      <div class="col-sm-6 justify-content-left align-items-center">
            <h4 class="detail_logo" style="font-size: 20px;">TAGS</h4>
            <span class="korean" ><%=tag1 %></span>
            <span class="korean" ><%=tag2 %></span>
            <span class="korean" ><%=tag3 %></span>
            <span class="korean" ><%=tag4 %></span>
            <span class="korean" ><%=tag5 %></span>
            <span class="korean" ><%=tag6 %></span>
      </div>
   </div>
   
	<div class="row mt-5">
		<div class="shadow bg-white rounded korean_center mb-3 p-2" style="font-size:20px; width:90%; margin:auto">
		<span class="detail_logo">TALK  </span>
		<span class="korean ml-3" style="font-size:20px;">답글을 남겨주세요!</span> 
   		<div class="shadow bg-white rounded korean mb-3" style="font-size:20px" id="output"> </div>
			<%
			if (id != null){
			%>
		
			<form id="form" name="form" method="post">
				<input type="hidden" id="num" name="num" value="<%=vo.getNum() %>" />
				<input type="hidden" id="renum" name="renum" value="0" />
				<input type="hidden" id="reid" name= "reid" value="<%=id %>" />
				<input type="hidden" id="ref" name="ref" value="0" />
				<input type="hidden" id="re_level" name="re_level" value="0" /> 
				<input type="hidden" id="re_step" name="re_step" value="0" /> 
				<div class="row pb-0">
					<div class="col-sm-2">
						<span class="smallest_logo">NAME</span>
					</div>
					<div class="col-sm-9 align-left">
						<input type="text" id="renickname" name="renickname" class="border_input korean mb-2 textarea_width"
					value="<%=nickname %>" readonly/>
					</div>
				</div>
				<div class="row mb-2">
					<div class="col-sm-2 align-center">
						<span class="smallest_logo">CONTENT</span>
					</div>
					<div class="col-sm-9 align-center">
						<textarea class="border_input korean textarea_width" rows="5" name="rebody" id="rebody" placeholder="메시지 입력"></textarea>
					</div>
				</div>
				<button type="submit" id="write" class="btn btn-lg button_bg_blue korean_center">글쓰기</button>
				<button type="reset" class="btn btn-lg button_bg_blue korean_center">지우기</button>
			</form>
			<%
			}
			else{
			%>
			<p class="korean">로그인을 하시면 댓글을 남기실 수 있습니다</p>
			<%
			}
			%>
		</div>
	</div>



</div>
<script type="text/javascript">
function deleteReply(renum){
	//alert(renum);
	var con = confirm("댓글을 지우시겠습니까?");
    if(con == true){
    	$.ajax({
    		url : '/drone/deleteAlbumReply.co?renum=' + renum,
    		type : 'GET',
    		dataType : "json",
    		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
    		success : function(retVal) {
    			if (retVal.res == "OK") {
    				selectData();
    			} else {
    				alert("게시글 삭제 실패");
    			}
    		},
        	error : function(request,status,error){
        		console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
        	}
    	});
    	//기본 이벤트 제거
    	event.preventDefault();
    }
    else{
    	
    }
	
}

function modifyReply(renum){
	var params = $("#modifyform" + renum).serialize();
	
	$.ajax({
		url : '/drone/modifyAlbumReply.co',
		type : 'POST',
		data : params,
		dataType : "json",
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(retVal) {
			if (retVal.res == "OK") {
				selectData();
			} else {
				alert("게시글 수정 실패");
			}
		},
    	error : function(request,status,error){
    		console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
    	}
	});
	//기본 이벤트 제거
	event.preventDefault();
}


function insertReReply(num){
	var params = $("#form" + num).serialize();
	//alert('params' + params);
	$.ajax({
		url : '/drone/insertAlbumReply.co',
		type : 'POST',
		data : params,
		dataType : "json",
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(retVal) {
			if (retVal.res == "OK") {
				selectData();
				$('#renickname').val('');
				$('#rebody').val('');
			} else {
				alert("게시글 입력 실패");
			}
		},
    	error : function(request,status,error){
    		console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
    	}
	});
	//기본 이벤트 제거
	event.preventDefault();
}
function selectData() {
	//table내부 내용을 제거(초기화)
	$('div#output').empty();
	
	
	$.ajax({
		url : '/drone/getAlbumReplyList.co?num=' +<%=vo.getNum()%>,
		type : 'GET',
		//data : params,
		dataType : "json",
		async: false,
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success : function(data) {
			//alert("data : " + Object.keys(data).length);
			var replycount = "&nbsp;&nbsp;총&nbsp;" + Object.keys(data).length + "개의 댓글이 있습니다. <br />";
			$('div#output').append(replycount);
			$.each(data, function(index, item) {
				
				//alert("item.re_level : " + item.re_level);
				//console.log("co_p_viewindex, ajax, index: " + index);
				var re_level_space = 0
				if (item.re_level == 0){
					re_level_space = 1;
				}
				else{
					re_level_space = item.re_level*50;
				}
				var renum = item.renum;
				
				var id = "<%=id%>";
				var output_modify = "";
				if (id != "" & id == item.reid){
					output_modify += '<tr><td><a data-toggle="collapse" href="#collapseModify' + index + '" role="button" aria-expanded="false" aria-controls="collapseModify';
					output_modify += index + '">수정하기</a>';
					output_modify += '  │ <a href="#" onclick="deleteReply(' + item.renum + ')"> 삭제하기</a></td></tr>';
				}
				else{
					output_modify = "";
				}
				
				var date = new Date(item.pdate);
				var month = date.getMonth()+1;
				var day = date.getDate();
				var year = date.getFullYear();
				var hourString = date.getHours();
				var hour = Number(hourString);
				if (hour >= 12){
					hour = "오후 " + (hour-12) + "시 ";
				}
				else{
					hour = "오전 " + hour + "시 ";
				}
				var minute = date.getMinutes() + "분 ";
				var second = date.getSeconds() + "초 ";
				var fulldate = year + "-" + month + "-" + day + "&nbsp;&nbsp;" + hour + minute + second;
				
				var output = "<table class='mt-3 table table-sm table-borderless'>";
				output += "<tr><td rowspan='4' width='" + re_level_space + "px;' bgcolor='#eff3f9'></td>";
				output += '<td>';
				output += item.renickname + '&nbsp;님&nbsp;&nbsp;&nbsp;' + fulldate + '</td></tr>';
				output += output_modify;
				output += "<tr><td><a data-toggle='collapse' href='#collapseReply" + index + "' role='button' aria-expanded='false' aria-controls='collapseReply" + index + "'> 답글달기</a></td></tr>";
				
				output += '<tr><td>' + item.rebody + '</td></tr>';
				output += '</table>'
				
				/* 대댓글 COLLAPSE 시작 */
				output += '<div class="collapse p-2" id="collapseReply' + index + '">';
				output += '<form id="form'+ item.renum +'" action="javascript:insertReReply('+ item.renum +')" name="form" method="post">';
				output += '<input type="hidden" id="num" name="num" value="'+ <%=vo.getNum() %> +'" />';
				output += '<input type="hidden" id="renum" name="renum" value="'+ item.renum +'" />';
				output += '<input type="hidden" id="reid" name= "reid" value="<%=id%>" readonly/>';
				output += '<input type="hidden" id="ref" name="ref" value="' + item.ref + '" />';
				output += '<input type="hidden" id="re_level" name="re_level" value="' + item.re_level + '" /> ';
				output += '<input type="hidden" id="re_step" name="re_step" value="' + item.re_step + '" /> ';
				output += '<div class="row pb-0"><div class="col-sm-3"><span class="smallest_logo">NAME</span>';
				output += '</div><div class="col-sm-9 align-left">';
				
				output += '<input type="text" id="renickname" name="renickname" class="border_input korean mb-2 textarea_width" value="<%=nickname%>" readonly/>';
				output += '</div></div><div class="row mb-2"><div class="col-sm-3 align-center"><span class="smallest_logo">CONTENT</span>';
				output += '</div><div class="col-sm-9 align-center">';
				output += '<textarea class="border_input korean textarea_width" rows="5" name="rebody" id="rebody" placeholder="메시지 입력"></textarea>';
				output += '</div></div>';
				output += '<input type="submit" class="btn btn-lg button_bg_blue korean_center" value="글쓰기" />&nbsp;&nbsp;';
				output += '<input class="btn btn-lg button_bg_blue korean_center" type="button" value="취소" data-toggle="collapse" data-target="#collapseReply' + index + '" aria-expanded="false" aria-controls="collapseReply' + index + '" />';
				output += '</form></div>';
				
				/* 수정부분 COLLAPSE 시작 */
				output += '<div class="collapse p-2" id="collapseModify' + index + '">';
				output += '<form id="modifyform'+ item.renum +'" action="javascript:modifyReply('+ item.renum +')" name="form" method="post">';
				output += '<input type="hidden" id="num" name="num" value="'+ <%=vo.getNum() %> +'" />';
				output += '<input type="hidden" id="renum" name="renum" value="'+ item.renum +'" />';
				output += '<input type="hidden" id="reid" name= "reid" value="<%=id%>" readonly/>';
				output += '<div class="row pb-0"><div class="col-sm-3"><span class="smallest_logo">NAME</span>';
				output += '</div><div class="col-sm-9 align-left">';
				
				output += "<input type='text' id='renickname' name='renickname' class='border_input korean mb-2 textarea_width' value=<%=nickname%> readonly/>";
				output += '</div></div><div class="row mb-2"><div class="col-sm-3 align-center"><span class="smallest_logo">CONTENT</span>';
				output += '</div><div class="col-sm-9 align-center">';
				output += '<textarea class="border_input korean textarea_width" rows="5" name="rebody" id="rebody">'+ item.rebody +'</textarea>';
				output += '</div></div>';
				output += '<input type="submit" class="btn btn-lg button_bg_blue korean_center" value="수정" />&nbsp;&nbsp;';
				output += '<input class="btn btn-lg button_bg_blue korean_center" type="button" value="취소" data-toggle="collapse" data-target="#collapseModify' + index + '" aria-expanded="false" aria-controls="collapseModify' + index + '" />';
				output += '</form></div>';
				
				
				
				output += "</div>";
				output += '';

				
				console.log("output: "	+ output);
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
	likeGet();
	selectData();

	$('#write').click( function(event) {
		var params = $("#form").serialize();
		
		//alert('params' + params);
		$.ajax({
			url : '/drone/insertAlbumReply.co',
			type : 'POST',
			data : params,
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			success : function(retVal) {
				if (retVal.res == "OK") {
					selectData();
					$('#renickname').val('');
					$('#rebody').val('');
				} else {
					alert("게시글 입력 실패");
				}
			},
        	error : function(request,status,error){
        		console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
        	}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	selectData();
});
 
	//처음 접속시 유저가 좋아요를 체크했는지 안했는지 
	function likeGet() {
	   //alert('ajax 시작');
	   $.ajax({
	      url : '/drone/heartCheck.search',
	      type : 'POST',
	      dataType: "json",
	        contentType : 'application/x-www-form-urlencoded; charset=utf-8',
	      data : {
	         "id" : '<%=id%>',
	         "num" : <%=vo.getNum()%>
	       },
	      success:function(data){
	         /* alert(data.likeYn); */
	         var likeput = '';
	         
	         if('N' == data.likeYn){
	            likeput = '<p><a href="javascript:likeFunc();" class="korean" style="font-size: 20px;"><img src="${pageContext.request.contextPath}/resources/img/sodetail/like_void_3.png" style= "color:#E75450;" class="rounded-circle" width="29px" />&nbsp;&nbsp;좋아요</i></a></p>';
	            $('#likeStatus').val('N');
	         }
	         else{
	            likeput = '<p><a href="javascript:likeFunc();" class="korean" style="font-size: 20px;" ><img src="${pageContext.request.contextPath}/resources/img/sodetail/like2.png" class="rounded-circle" style="width:29px" />&nbsp;&nbsp;좋아요</i></a></p>';
	            $('#likeStatus').val('Y');
	         }
	         
	      
	            console.log("likeput:" + likeput);
	            $('#likeput').html(likeput);
	            //alert('ajax 성공');
	      },
	      error:function(){
	         alert("ajax통신 실패!!!");
	      }
	   });
	   
	   
	   
	}


	//클릭시 좋아요 선택,취소
	function likeFunc() {

	   /* alert($('#likeStatus').val()); */
	   var likeStatus = $('#likeStatus').val();
	   var updateStatus ='';
	   if(likeStatus=='Y'){
	      updateStatus='N'
	   }else{
	      updateStatus='Y'  
	   }
	   
	   $.ajax({
	      url : '/drone/likeUpdate.search',
	      type : 'POST',
	      dataType: "json",
	        contentType : 'application/x-www-form-urlencoded; charset=utf-8',
	      data : {
	         "id" : '<%=id%>',
	         "num" : <%=vo.getNum() %>,
	         "likeYn" : updateStatus
	      },
	      success:function(data){
	         /* alert(data.likeYn); */
	         var likeput = '';
	         
	         if('N' == data.likeYn){
	            likeput = '<p><a href="javascript:likeFunc();" class="korean" style="font-size: 20px;"><img src="${pageContext.request.contextPath}/resources/img/sodetail/like_void.png" class="rounded-circle" width="29px" style= "color:#E75450;" />&nbsp;&nbsp;좋아요</i></a></p>';
	            $('#likeStatus').val('N');
	         }
	         else{
	            likeput = '<p><a href="javascript:likeFunc();" class="korean" style="font-size: 20px;" ><img src="${pageContext.request.contextPath}/resources/img/sodetail/like2.png" class="rounded-circle" width="29px" />&nbsp;&nbsp;좋아요</i></a></p>';
	            $('#likeStatus').val('Y');
	         }
	         

	            console.log("likeput:" + likeput);
	            $('#likeput').html(likeput);
	      },
	      error:function(){
	         alert("ajax통신 실패!!!");
	      }
	   });
	   
	   
	   
	}
	
</script>
<!-- 네이버 -->               
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>

<script>
var map = new naver.maps.Map("map_canvas", {  
    center: new naver.maps.LatLng(<%=vo.getCoor()%> ),
    zoom: 10,
    mapTypeControl: true
});

var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');

var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(<%=vo.getCoor()%> ),
    map: map
});   

</script>




</body>


</html>