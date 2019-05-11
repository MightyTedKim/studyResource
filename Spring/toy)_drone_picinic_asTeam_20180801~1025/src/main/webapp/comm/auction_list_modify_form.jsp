<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ page import="com.spring.drone.co.AuctionVO"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
   String id = (String)session.getAttribute("id");
   String nickname = (String)session.getAttribute("nickname");
   Integer authority = (Integer)session.getAttribute("authority");
   AuctionVO vo = (AuctionVO) request.getAttribute("auctionVO");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Auction_write</title>

    </head>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<body>
<div class="container">  
      <div class="row justify-content-center" id="roww"> 
        <div class="col-md-9" id="mdnight" >
          <form action="" method="post" enctype="multipart/form-data" id="uploadForm">
        <br />
            <h2 style="text-align:center;">중고거래 게시글 작성</h2>  
        <br /> 
            <div class="form-group" style="text-align: center; font-size: 20px; font-weight: bold; width: 50%; margin: auto;">
                 <br>
               <input type="hidden" class="form-control input-sm" name="num" id="num" value="<%=vo.getNum() %>" />
               <%-- <input type="hidden" class="form-control input-sm" name="id" id="id" value="<%=vo.getId() %>" /> --%>
                 
               <p class="p">아이디</p>
               <input type="text" class="form-control" name="id" value="<%=vo.getId() %>" readonly/>
                  <br>
               <p class="p">이름</p>
               <input type="text" class="form-control" name="nickname" id="nickname" value="<%=vo.getNickname() %>" readonly/>
                  <br>
                <p class="p">* 제목</p>
                <input type="text" class="form-control" id="title" name="title" value="<%=vo.getTitle() %>"/>
                <br>
                <p class="p">* 핸드폰번호</p>
                <input type="text" class="form-control" id="ph" name="ph" value="<%=vo.getPh() %>"  />
            </div>
            <hr/>  
            <br/>      
            <div style="text-align: center; font-size: 20px; font-weight: bold; width: 60%; margin: auto;">
	            <div class="form-group">
	                <p class="p">* 제품명</p>
	                <input type="text" class="form-control" id="pname" name="pname" value="<%=vo.getPname() %>"  />
	            </div>
	            <div class="form-group">
	                <p class="p">* 가격</p>
	                <input type="text" class="form-control" id="price" name="price" value="<%=vo.getPrice() %>"/>
	            </div>
	            <div class="class form-group">
	                <p class="p">* 판매상태</p>
	                <select class="form-control" id="sales" name="sales">   
	                    <option value="<%=vo.getSales() %>"><%=vo.getSales() %></option>                 
	                    <option value="판매중">판매중</option>
	                    <option value="거래중">거래중</option>
	                    <option value="판매완료">판매완료</option>                  
	                </select>    
	            </div>
	            <div class="form-group">
	                <p class="p">*판매이유</p>
	                <textarea class="form-control" id="body" name="body" rows="5"><%=vo.getBody() %></textarea>
	            </div> 
			</div>          
          
           <div class="row" id="row2">  
            <br> 
            <div class="col-lg-12" id="center">
             <div class="class form-group justify-content-center" id="upup"> 
                 <br>
                 <div class="attach" id="attach">
                     <label for="uploadInputBox" class="btn_file "><span><i class="fas fa-cloud-upload-alt"></i></span>&nbsp; File Upload</label> &nbsp;
                      <input id="uploadInputBox" type="file" name="filedata" multiple  />
                </div>     
            </div>

            <div class="wrap">               
                <input type="button" class="korean" id="button_click" value="작성" />
            </div> 
            <br>

               <div class="form-group">
               <!-- 미리 업로드한 파일 미리보기 영역 -->
                  <div id="previewPast" class="content"></div>
                <!--새롭게 업로드할 파일 미리보기 영역 -->
                  <div id="preview" class="content"></div>
                 </div>
               <div class="form-group">
                  <div id="pastFileInput">
                  </div>
               </div>
               <div class="form-group" id="hidden_input">                  
               </div>
               <div class="form-group" id="hidden_input2">
                </div>   
              
            </div>
           </div>  
        
       </form>
      </div>
     </div>
    </div>
            
   
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script> -->
<script>
    //임의의 file object영역
    var files = {};
    var previewIndex = 0;

    // image preview 기능 구현
    // input = file object[]
    function addPreview(input) {
        if (input[0].files) {
            //파일 선택이 여러개였을 시의 대응
            for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
                var file = input[0].files[fileIndex];
                if(validation(file.name)) continue;
                setPreviewForm(file);
            }
        } else
            alert('invalid file input'); // 첨부클릭 후 취소시의 대응책은 세우지 않았다.
    }
    
    function setPreviewForPastUpload(fileNames, originalNames, filesizes){
       var originalNames = "<%=vo.getOriginalName()%>";
       //alert('originalNames = ' + originalNames);
       
       var pastUpload = "";
       
       var uploadFiles = "";
       var uploadOriginalNames = "";
        var uploadSizes = "";
        
       var fileNames = "<%=vo.getStoredFileName()%>";
       var originalNames = "<%=vo.getOriginalName()%>";
       var fileSizes = "<%=vo.getFileSize()%>";
       
       var parsed = fileNames.split("///");
       var parsedNames = originalNames.split("///");
       var sizeParsed = fileSizes.split("///");
       
      for (var i = 0; i < parsed.length - 1;i++){
         pastUpload += "<div class=\"preview-box col-lg-3 m-2 \" value=\"" + i +"\">";
         pastUpload += "<img class=\"thumbnail\" src=\"";
         pastUpload += "<spring:url value='/image/auction/' />" + parsed[i] + "\"\/>";
         pastUpload += "<p>" + parsedNames[i] + "</p>";
         pastUpload += "<a href=\"#\" value=\"" + i + "\" onclick=\"deletePreviewForPast(this)\">";
         pastUpload += "삭제" + "</a></div>";
         uploadFiles += parsed[i] + "///";
         uploadOriginalNames += parsedNames[i] + "///";
         uploadSizes += sizeParsed[i] + "///";
      }
      /* var totalUploadFiles = "<input type='hidden' id='storedFileName' name='storedFileName' value='" 
      + uploadFiles + "' />" + "<input type='hidden' id='originalName' name='originalName' value='" 
      + uploadOriginalNames + "' />" + "<input type='hidden' id='fileSizes' name='fileSizes' value='" 
      + uploadSizes + "' />"; */
   
      $("#previewPast").append(pastUpload);
         /*
      var hidden_input = "";
      hidden_input += "<form id='prevUp'>";
      hidden_input += "<input type='hidden' id='1' value='" + uploadFiles + "' />";
      hidden_input += "<input type='hidden' id='2' value='" + uploadOriginalNames + "' />";
      hidden_input += "<input type='hidden' id='3' value='" + uploadSizes + "' />";
      hidden_input += "</form>";
      $("#hidden_input").empty();
      $("#hidden_input").append(hidden_input); */
    }
    
    function deletePreviewForPast(obj) {
        var imgNum = obj.attributes['value'].value;
        
        //delete files[imgNum];
        $("#previewPast .preview-box[value=" + imgNum + "]").remove();
        
        var totalUploadFiles = "<div id='toBeUp' value='" + imgNum + "'>" + imgNum + "</div>";
      $("#hidden_input2").append(totalUploadFiles);
    }
        /*alert("parsed = " + $("#1").val());
        var parsed =  $("#1").val().split("///");
        var originalParsed = $("#2").val().split("///");
        var sizeParsed = $("#3").val().split("///");

        var uploadFiles = "";
        var uploadOriginalNames = "";
        var uploadSizes = "";
        
        alert("imgNum = " + imgNum);
        for (var i = 0; i <parsed.length - 1; i++){
           alert("i = " + i);
           if (i == imgNum){
              uploadFiles += "";
              uploadOriginalNames += "";
              uploadSizes += "";
              alert("uploadOriginalNames2 = " +uploadOriginalNames);
           } 
           else{
              uploadFiles += parsed[i] + "///";
              uploadOriginalNames += originalParsed[i] + "///";
              uploadSizes += sizeParsed[i] + "///";
           }
        }
        
        var hidden_input = "";
       hidden_input += "<form id='prevUp'>";
       hidden_input += "<input type='hidden' id='1' value='" + uploadFiles + "' />";
       hidden_input += "<input type='hidden' id='2' value='" + uploadOriginalNames + "' />";
       hidden_input += "<input type='hidden' id='3' value='" + uploadSizes + "' />";
       hidden_input += "</form>";
       $("#hidden_input").empty();
      $("#hidden_input").append(hidden_input);
        
        var totalUploadFiles2 = "<input type='hidden' id='storedFileName' name='storedFileName' value='" 
         + uploadFiles + "' />" + "<input type='hidden' id='originalName' name='originalName' value='" 
         + uploadOriginalNames + "' />" + "<input type='hidden' id='fileSize' name='fileSize' value='" 
         + uploadSizes + "' />";
         
      alert("uploadOriginalNames = " + uploadOriginalNames);
      $("#pastFileInput").empty();
      $("#pastFileInput").append(totalUploadFiles2); 
      
        resizeHeight();
    } */
    
    function setPreviewForm(file, img){
        var reader = new FileReader();
        
        //div id="preview" 내에 동적코드추가.
        //이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
        reader.onload = function(img) {
            var imgNum = previewIndex++;
            $("#preview").append(
                    "<div class=\"preview-box col-lg-3 m-2 \" value=\"" + imgNum +"\">" +
                    "<img class=\"thumbnail\" src=\"" + img.target.result + "\"\/>" +
                    "<p>" + file.name + "</p>" +
                    "<a href=\"#\" value=\"" + imgNum + "\" onclick=\"deletePreview(this)\">" +
                    "삭제" + "</a>"
                    + "</div>"
            );
            //resizeHeight();
            files[imgNum] = file;            
        };
        
        reader.readAsDataURL(file);
    }


    //preview 영역에서 삭제 버튼 클릭시 해당 미리보기이미지 영역 삭제
    function deletePreview(obj) {
        var imgNum = obj.attributes['value'].value;
        delete files[imgNum];
        $("#preview .preview-box[value=" + imgNum + "]").remove();
        //resizeHeight();
    }

    //client-side validation
    //always server-side validation required
    function validation(fileName) {
        fileName = fileName + "";
        var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
        var fileNameExtension = fileName.toLowerCase().substring(
                fileNameExtensionIndex, fileName.length);
        if (!((fileNameExtension === 'jpg')
                || (fileNameExtension === 'gif') || (fileNameExtension === 'png'))) {
            
        	alert('jpg, gif, png 확장자만 업로드 가능합니다.');
            return true;
        } else {
            return false;
        }
    }

    $(document).ready(function() {      
       
       var originalNames = "<%=vo.getOriginalName()%>";
       //alert('originalNames = ' + originalNames);
       
       setPreviewForPastUpload();
        //submit 등록. 실제로 submit type은 아니다.
        $('#button_click').on('click',function() {
           
           var fileNames = "<%=vo.getStoredFileName()%>";
           var originalNames = "<%=vo.getOriginalName()%>";
           var fileSizes = "<%=vo.getFileSize()%>";
           //alert("originalNames = " + originalNames);
           
           var parsed = fileNames.split("///");
           var parsedNames = originalNames.split("///");
           var sizeParsed = fileSizes.split("///");
           
           var uploadFiles = "";
            var uploadOriginalNames = "";
            var uploadSizes = "";
            
            var deleteUploadFiles = "";
            var deleteUploadOriginalNames = "";
            var deleteUploadSizes = "";
            
            //alert('$("div[id=toBeUp]").length = ' + $("div[id=toBeUp]").length);
            /* 
            alert("투비업렝스 = " + $("#toBeUp:eq(0)").text());
            alert("투비업렝스 = " + $("#toBeUp:eq(1)").text());
            alert("투비업렝스 = " + $("#toBeUp:eq(2)").text());
            alert("투비업렝스 = " + $("#toBeUp:eq(3)").text()); */
            var numbers = "";
            for (var x=0; x < $("div[id=toBeUp]").length; x++){
               numbers += $('#hidden_input2 div').eq(x).text() + "///";
               //alert("$('#hidden_input2 div').eq(x).text() = " + $('#hidden_input2 div').eq(x).text());
            }
            
            var array = numbers.split("///");
            //alert("numbers = " + numbers);
            
          for (var i = 0; i < parsed.length-1;i++){
             if (array.indexOf(i+"") != -1){
                deleteUploadFiles += parsed[i] + "///";
                deleteUploadOriginalNames += parsedNames[i] + "///";
                deleteUploadSizes += sizeParsed[i] + "///";
                 }
                 else{
                    
                    uploadFiles += parsed[i] + "///";
                    uploadOriginalNames += parsedNames[i] + "///";
                    uploadSizes += sizeParsed[i] + "///";
                 }
         }
           //alert("deleteUploadOriginalNames = " + deleteUploadOriginalNames);
           //alert("uploadOriginalNames = " + uploadOriginalNames);
           var totalUploadFiles = "<input type='hidden' id='storedFileName' name='storedFileName' value='" 
             + uploadFiles + "' />" + "<input type='hidden' id='originalName' name='originalName' value='" 
             + uploadOriginalNames + "' />" + "<input type='hidden' id='fileSize' name='fileSize' value='" 
             + uploadSizes + "' />";
             
            totalUploadFiles += "<input type='hidden' id='deleteStoredFileName' name='deleteStoredFileName' value='" 
                + deleteUploadFiles + "' />" + "<input type='hidden' id='deleteOriginalName' name='deleteOriginalName' value='" 
                + deleteUploadOriginalNames + "' />" + "<input type='hidden' id='deleteFileSize' name='deleteFileSize' value='" 
                + deleteUploadSizes + "' />";
          
           $("#hidden_input").empty();
          $("#hidden_input").append(totalUploadFiles);
           
           
            var form = $('#uploadForm')[0];
            var formData = new FormData (form);
              
            
            for (var index = 0; index < Object.keys(files).length; index++) {
                //formData 공간에 files라는 이름으로 파일을 추가한다.
                //동일명으로 계속 추가할 수 있다.
                formData.append('files', files[index]);
            }
            
            //ajax 통신으로 multipart form을 전송한다.
            $.ajax({
                type : 'POST',
                enctype : 'multipart/form-data',
                processData : false,
                contentType : false,
                cache : false,
                async: false,
                timeout : 600000,
                url : '/drone/auction_list_modify.co',
                dataType : "json",
                data : formData,
                success : function(result, response) {
                    //이 부분을 수정해서 다양한 행동을 할 수 있으며,
                    //여기서는 데이터를 전송받았다면 순수하게 OK 만을 보내기로 하였다.
                    //-1 = 잘못된 확장자 업로드, -2 = 용량초과, 그외 = 성공(1)
                    if (result.res === -1) 
                    {
                        alert('jpg, gif, png, bmp 확장자만 업로드 가능합니다.');
                        // 이후 동작 ...
                    } 
                    else if (result.res === -2) {
                        alert('파일이 10MB를 초과하였습니다.');
                    }
                    else if (result.res === -3) {
                        alert('글 수정을 실패했습니다..미안ㅋ');
                    }
                    else
                    {
                       x = result.res ;
                        alert('글 수정 성공');
                    }
                },
                error : function(request,status,error){
                    alert('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
                }
                //전송실패에대한 핸들링은 고려하지 않음
            });
            location.href="template.templ?page=auction_detail.co?num=" + x;
        });
        // <input type=file> 태그 기능 구현
        $('#attach input[type=file]').change(function() {
            addPreview($(this)); //preview form 추가하기
        });
    });

    var uploadFile = $('.attach .uploadInputBox');
    uploadFile.on('change', function(){
       if(window.FileReader){
          var filename = $(this)[0].files[0].name;
       } else {
          var filename = $(this).val().split('/').pop().split('\\').pop();
       }
         $(this).siblings('.fileName').val(filename);
    });
</script>
</body>
</html>