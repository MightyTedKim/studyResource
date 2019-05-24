<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.drone.so.SomoimVO"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
   ArrayList<SomoimVO> soList = (ArrayList<SomoimVO>)request.getAttribute("soList");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   String id = (String)session.getAttribute("id");
   String nickname = (String)session.getAttribute("nickname");
%>

<!DOCTYPE html>
<html>
<head>
<style>
body {font-family: Arial, Helvetica, sans-serif;}

/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

/* Set a style for all buttons */
#but {
    background-color: #CED8F6;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 50%;
}

#but:hover {
    opacity: 0.8;
}

.vl {
    border-left: 2px solid #e8b7ba;
    height: auto;
    border-radius: 50px;
}

/* Extra styles for the cancel button */
.cancelbtn {
    width: auto;
    padding: 10px 18px;
   background-color: #CED8F6;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;

}

/* Center the image and position the close button */

.container {
    padding: 16px;
}

span.psw {
    float: right;
    padding-top: 16px;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
    position: absolute;
    right: 25px;
    top: 0;
    color: #000;
    font-size: 35px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: red;
    cursor: pointer;
}

/* Add Zoom Animation */
.animate {
    -webkit-animation: animatezoom 0.6s;
    animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
    from {-webkit-transform: scale(0)} 
    to {-webkit-transform: scale(1)}
}
    
@keyframes animatezoom {
    from {transform: scale(0)} 
    to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
    span.psw {
       display: block;
       float: none;
    }
    .cancelbtn {
       width: 100%;
    }
}


</style>
<meta charset="UTF-8">
<title>회원정보 관리 페이지</title>
<script>
function isSame() {
   var pw = document.getElementById('pw').value;
   var confirmPW = document.getElementById('pwCheck').value;
   if(pw.length < 3 || pw.length > 10) {
   window.alert('비밀번호 3~10자리만 써주시기 바랍니다.');
   document.getElementById('pw').value=document.getElementById('pwCheck').value='';
   document.getElementById('same').innerHTML='';
   }
   if(document.getElementById('pw').value!="&&document.getElementById('pwCheck').value!=") {
   if(document.getElementById('pw').value == document.getElementById('pwCheck').value) {
   document.getElementById('same').innerHTML = '비밀번호가 일치합니다.';
   document.getElementById('same').style.color='blue';
   }
   else {
   document.getElementById('same').innerHTML = '비밀번호가 일치하지 않습니다.';
   document.getElementById('same').style.color='red';
   }
}
}
</script>
</head>
<body>
   <%--    <img src="<spring:url value='/image/${storedFileName }' />
   <img src="/drone/image/${storedFileName }" /> --%>
   
<div class="container" >
    <div class="col-md-6 justify-content-left" id="lleft" style="text-align:center;  border:2px solid #f7d7d9; border-radius: 20px; margin-left:230px;">   
      
            <br />
            <img src="${pageContext.request.contextPath}/resources/img/user.png" width="80px"/>
            <br /><br />
            <p><%=nickname %></p>
            <button onclick="document.getElementById('id02').style.display='block'" id="but" style="width:auto; padding-top:11px; padding-bottom: 11px; border-radius:3px;">정보수정</button>
            <span class="text_button" id="but"><a href="#" id="id01" onClick="drop();">회원탈퇴</a></span>

      <!-- 모달창 -->
      <div id="id02" class="modal">
        <form class="modal-content animate" action="./template.templ?page=update.me" method="post">
          <div class="container">
            <input type="hidden" value="<%=id %>" name="id">
            <label for="nickname"><b>닉네임</b></label>
            <input type="text" value="<%=nickname%>" name="nickname" required>
      
            <label for="psw"><b>비밀번호</b></label>
            <input type="password" placeholder="Enter Password" id="pw" name="password" onChange="isSame()" required>
            
            <label for="psw"><b>비밀번호 확인</b></label>
            <input type="password" name="passwordConfirm" id="pwCheck" placeholder="Confirm Password" onChange="isSame()" required>
            <br>
            <span id="same"></span>
            <br>
            <!-- <input type="submit" value="수정하기" /> -->
            <button type="submit" id="but" style="width:100px;">수정</button>
             &nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" id="but" style="width:auto;" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Cancel</button> 
          </div>
        </form>
      </div> <!-- 모달창 끝 -->

<script> <!-- 회원탈퇴 스크립트 -->
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

function drop(){
    var con = confirm("탈퇴하시겠습니까?");
    if(con == true){
     location.href="template.templ?page=delete.me?id=<%=id%>";
    }else{}
   }
</script>
            <br />
            <br />
            <br />
         
      </div>
      <br />
    
   </div> <!-- 첫 div 끝 -->
   
    <div class="row">
       <div class="col-md-1"></div><div class="col-md-1"></div>
       <div class="col-md-4 justify-content-right" id="rright" style="text-align:center;">   
      <br />
      <span class="text_button">소모임 목록</span><br /><br />
      <br />
      <br />
      <table class="table table-sm table-light">
         <thead>
            <tr>
               <td scope="col">no.</td>
               <td scope="col">소모임이름</td>
               <td scope="col">방장</td>
               <td scope="col">개설날짜</td>
            </tr>
         </thead>
         <tbody>
         <%
            for(int i=0;i < soList.size();i++){
            SomoimVO somoimVO = soList.get(i);   
         %>
            <tr>
              <th scope="row">1</th>
              <td><a href="template.templ?page=somoim_detail.somo?num=<%=somoimVO.getNum()%>"><%=somoimVO.getName() %></a></td>
              <td><%=somoimVO.getFounder() %></td>
              <td><%=sdf.format(somoimVO.getFoundingdate()) %></td>
            </tr>
              <%
            }
              %>
         </tbody>
      </table>
   </div>
   
       <div class="vl"></div>
   
         <div class="col-md-4 justify-content-right" style="text-align:center;">
            <br />
            <span class="text_button">회원목록</span><br /><br />
            <br />
            <br />
            
            <table class="table table-sm table-light">
               <thead>
                  <tr>
                     <td scope="col">no.</td>
                     <td scope="col">회원아이디</td>
                     <td scope="col">이메일</td>
                     <td scope="col">권한</td>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                        <th scope="row">1</th>
                        <td>jiwon</td>
                       <td>pyogo@naver.com</td>
                       <td>최고관리자</td>
                   </tr>
               </tbody>
            </table>
         </div>
         
          <div class="col-md-1"></div>
         
      </div>
      
     <br><br><br><br><br><br>   
</div> <!-- 첫 div 끝 -->
</body>
</html>