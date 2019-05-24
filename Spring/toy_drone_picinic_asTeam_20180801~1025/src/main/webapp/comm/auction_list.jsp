<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.drone.co.AuctionVO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<%
   String id = (String)session.getAttribute("id");
   String nickname = (String)session.getAttribute("nickname");
   Integer authority = (Integer)session.getAttribute("authority");
   
     ArrayList<AuctionVO> auctionList = (ArrayList<AuctionVO>)request.getAttribute("auctionList");
     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
     
%>
            
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>중고거래게시판</title>


<script type="text/javascript"  src="http://pagination.js.org/dist/2.1.3/pagination.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">

</head>
<body>

<div class="container">

      <div class="row line_color_yellow_b mt-1 mb-1 pt-5">
         <div class="col-lg-12 text_align_center">
             <p class="small_logo">AUCTION</p>
             <p class="korean_center">중고 장터에서 드론을 팔아보세요</p>
         </div>
      </div>
      <div class="row mt-1 mb-1 pt-5">
         <div class="col-lg-12 text_align_center">
             <p class="korean_center"><a href="template.templ?page=auction_write.co">중고게시판에 글쓰기</a></p>
         </div>
      </div>
   
      
   <div class="row text_align_center mb-3">
      
   </div>   
      
 <%
      if(auctionList.size() == 0){
%>      
      <table class="table table-hover"> 
         <tr>
            <td align="center">
               게시판에 첫 글을 작성해주시겠어요?
            </td>
         </tr>
      </table>
<%
      }
      else{
         
 %>       
              
        <table id="drone_auction" class="table table-hover korean_board">
           <thead style="font-size:20px; font-weight: bold;">
               <tr height = "30">
                   <td align="center" width="20"> No</td>
                   <td align="center" width="370"> 제  목 </td>
                   <td align="center" width="100"> 가  격 </td>
                   <td align="center" width="100"> 제품명 </td>
                   <td align="center" width="100"> 작성자  </td>
                   <td align="center" width="100"> 판매 </td>  
                   <td align="center" width="100"> 날짜 </td>
                   <td align="center" width="100"> 조회수  </td>
               </tr>
            </thead>
  <%   
      for (int i=0;i < auctionList.size();i++){
         //System.out.println("auctionList.get(i): " + auctionList.get(i) );

         AuctionVO vo = auctionList.get(i);
         //System.out.println("getStoredFileName: " + vo.getStoredFileName() );         

   %>                       
            <tr style="font-size:15px; font-weight: bold;">
                   <td align="center" style="padding-top:18px;">
                    <%=vo.getNum() %>
                   </td>
                   <td align="center" style="padding-top:18px;">
                     <a href="template.templ?page=auction_detail.co?num=<%=vo.getNum()%>&readcount=<%=vo.getReadcount()%>&likecount=<%=vo.getLikecount() %>"><%=vo.getTitle() %></a>
                 </td>
                 <td align="center" style="padding-top:18px;">
                     <%=vo.getPrice() %>
                   </td>
                   <td align="center" style="padding-top:18px;">
                     <%=vo.getPname() %>
                   </td>
                   <td align="center" style="padding-top:18px;">
                      <%=vo.getId() %>
                   </td>
                   <td align="center" style="padding-top:18px;">
                       <p style="color:#f45a49;"><%=vo.getSales() %></p> 
                   </td>
                   <td align="center" style="padding-top:18px;">
                      <%=sdf.format(vo.getPdate())%> 
                   </td>
                   <td align="center" style="padding-top:18px;">
                       <%=vo.getReadcount()%>
                   </td>
                   
           </tr>
<%
 }
%>             
            </table>
<%
 }
%> 

<script>
    $(document).ready(function() {
      $('#drone_auction').DataTable( {
        "pagingType": "full_numbers"
        });
    });
</script>

<br>
<br>

</div><!-- div container 끝 -->
</body>

<style>

#drone_auction_wrapper{
   width:100%;
}

#drone_auction_length{
     font-family: 'Nanum Gothic Coding', monospace;
     font-weight: 400;
     line-height: 1.4;
     font-size: 0.8em;
}
#drone_auction_info {
   font-family: 'Nanum Gothic Coding', monospace;
     font-weight: 400;
     line-height: 1.4;
     font-size: 0.8em;
}

#drone_auction_paginate {
   font-family: 'Nanum Gothic Coding', monospace;
     font-weight: 400;
     line-height: 1.4;
     font-size: 0.8em;
}

#drone_auction_filter{
   font-family: 'Nanum Gothic Coding', monospace;
     font-weight: 400;
     line-height: 1.4;
     font-size: 0.8em;
}
               
.paginate_button:hover {
    color: #dee4f7;
    box-shadow: #dee4f7 0 0px 0px 40px inset;
    text-decoration: none !important 
}

.paginate_button: {
border-radius:25px;
}

</style>
</html>