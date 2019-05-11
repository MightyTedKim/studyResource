<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.spring.drone.co.AlbumVO"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
	AlbumVO vo = (AlbumVO) request.getAttribute("albumVO");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Album_write</title>
    </head>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<body>
<div class="container" id="left">
	<div class="row line_color_yellow_b mt-1 mb-5 pt-5">
		<div class="col-lg-12 text_align_center">
			 <p class="small_logo">UPLOAD YOUR PICTURES</p>
			 <p class="korean_center">드론으로 찍은 사진을 올려주세요</p>
		</div>
	</div>
		 <form action="" method="post" enctype="multipart/form-data" id="uploadForm">
      <div class=row id="row1">

        <div class="col-md-6 justify-content-left notosanskr w500" id="left">
            <div class="form-group">
            	
            	<input type="hidden" class="form-control input-sm" name="num" id="num" value="<%=vo.getNum() %>" />
            	<input type="hidden" class="form-control input-sm" name="id" id="id" value="<%=vo.getId() %>" />
            	
            	<p class="p">이름</p>
 				<input type="text" class="form-control input-sm" name="nickname" id="nickname" value="<%=vo.getNickname() %>" readonly/>
                <br>
                <p class="p">제목</p>
                <input type="text" class="form-control input-sm" name="title" id="title" placeholder="<%=vo.getTitle() %>"/>
            </div>
            <br>
            <div class="class form-group">
                <p class="p">카테고리</p>
                <select class="form-control input-sm" name="category" id="category">
                    <option value="<%=vo.getCategory() %>"><%=vo.getCategory() %></option>
                    <option value="자연">자연</option>
                    <option value="도시">도시</option>
                    <option value="풍경">풍경</option>
                    <option value="인물">인물</option>
                    <option value="스포츠">스포츠</option>
                </select>    
            </div> 
            <br>
            <div class="form-group">
                <p class="p">소감</p>
                <textarea class="form-control input-sm" name="body" name="body" rows="7" ><%=vo.getBody() %></textarea>
            </div> 
        </div>
       
        
        <div class="col-md-6 justify-content-right" id="right" >
            <div class="class form-group">
               
               <p class="p">Location</p>
               <div class="input-group-append">
               <input type="text" class="form-control input-sm" placeholder="검색">
                
                 <button class="btn btn-default" type="submit"><i class="fas fa-search"></i></div> </button>      
             <div id="map-canvas" style="height: 400px; width: 470px; margin: 20px;" ></div>
           </div> 
       </div> <!-- right div 끝  -->
      </div>  <!-- row div 끝  -->

        <div class="row" id="row2">  
            <br> 
            <div class="col-lg-12" id="center">
             <!-- <div class="class form-group justify-content-center" id="upup"> --> 
                 <br>
                 <div class="attach" id="attach">
                     <label for="uploadInputBox" class="btn_file "><span><i class="fas fa-cloud-upload-alt"></i></span>&nbsp; File Upload</label> &nbsp;
                      <input id="uploadInputBox" type="file" name="filedata" multiple  />
                </div>     
            <!-- </div> -->

            <div class="wrap">
                <input type="button" class="korean" id="button_click" value="작성"/>
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
        </div>  <!-- 마지막 업로드 영역 -->
        
    </form>
		

   
	</div> 
    <br />
    <br />
    <br />
            
   <!--gmap js 임포트-->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=true">
</script>    

<!--javascript 소스코드-->
<script type="text/javascript">
function initialize() {
    var myLatlng;
    var map;
    var marker;

    //   <!-- 구글맵에서 좌표값을 얻고 입력해주세요.  -->
    myLatlng = new google.maps.LatLng(37.482627, 126.928510);  

       
   var mapOptions = 
   {
    zoom: 17, //<!--지도 확대, 축소 정도 설정 -->
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false, //<!-- 마우스 스크롤 false -->
    draggable: false //<!-- 마우스 드레그(클릭) false -->
        };

        map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
        
        //<!-- 위치정보이름 및 위치정보주소 입력하세요. -->
        var contentString ='<p style="line-height: 20px;">위치정보이름</p><p>위치정보주소</p>'; 

        var infowindow = new google.maps.InfoWindow({
                content: contentString
        });

        marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: 'Marker'
        });

        infowindow.open(map, marker);

        google.maps.event.addListener(marker, 'click', function () {
                infowindow.open(map, marker);
        });
}

    google.maps.event.addDomListener(window, 'load', initialize);
    </script>

    <!-- Google API Key 값을 생성하여 입력하세요. -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?KEY=API_KEY&callback=initMap">
    </script> 

     
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

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
    	var pastUpload = "";
    	
    	var uploadFiles = "";
    	var uploadOriginalNames = "";
        var uploadSizes = "";
        
    	var fileNames = "<%=vo.getStoredFileName()%>";
    	var originalNames = "<%=vo.getOriginalName()%>";
    	var filesizes = "<%=vo.getFilesize()%>";
    	
    	var parsed = fileNames.split("///");
    	var parsedNames = originalNames.split("///");
    	var sizeParsed = filesizes.split("///");
    	
		for (var i = 0; i < parsed.length -1 ;i++){
			pastUpload += "<div class=\"preview-box col-lg-3 m-2 \" value=\"" + i +"\">";
			pastUpload += "<img class=\"thumbnail\" src=\"";
			pastUpload += "<spring:url value='/image/album/' />" + parsed[i] + "\"\/>";
			pastUpload += "<p>" + parsedNames[i] + "</p>";
			pastUpload += "<a href=\"#\" value=\"" + i + "\" onclick=\"deletePreviewForPast(this)\">";
			pastUpload += "삭제" + "</a></div>";
			uploadFiles += parsed[i] + "///";
			uploadOriginalNames += parsedNames[i] + "///";
			uploadSizes += sizeParsed[i] + "///";
		}
		
		/* var totalUploadFiles = "<input type='hidden' id='storedFileName' name='storedFileName' value='" 
			+ uploadFiles + "' />" + "<input type='hidden' id='originalName' name='originalName' value='" 
			+ uploadOriginalNames + "' />" + "<input type='hidden' id='filesize' name='filesize' value='" 
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
        
    	/* alert("parsed = " + $("#1").val());
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
        		alert("uploadOriginalNames2 = " + uploadOriginalNames);
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
			+ uploadOriginalNames + "' />" + "<input type='hidden' id='filesize' name='filesize' value='" 
			+ uploadSizes + "' />";
			
		alert("uploadOriginalNames = " + uploadOriginalNames);
		$("#pastFileInput").empty();
		$("#pastFileInput").append(totalUploadFiles2); */
		
        //resizeHeight();
    }
    
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
    	
		
    	setPreviewForPastUpload();
        //submit 등록. 실제로 submit type은 아니다.
        $('#button_click').on('click',function() {
        	
        	var fileNames = "<%=vo.getStoredFileName()%>";
        	var originalNames = "<%=vo.getOriginalName()%>";
        	var filesizes = "<%=vo.getFilesize()%>";
        	//alert("originalNames = " + originalNames);
        	
        	var parsed = fileNames.split("///");
        	var parsedNames = originalNames.split("///");
        	var sizeParsed = filesizes.split("///");
        	
        	var uploadFiles = "";
            var uploadOriginalNames = "";
            var uploadSizes = "";
            
            var deleteUploadFiles = "";
            var deleteUploadOriginalNames = "";
            var deleteUploadSizes = "";
            
           // alert('$("div[id=toBeUp]").length = ' + $("div[id=toBeUp]").length);
            /* 
            alert("투비업렝스 = " + $("#toBeUp:eq(0)").text());
            alert("투비업렝스 = " + $("#toBeUp:eq(1)").text());
            alert("투비업렝스 = " + $("#toBeUp:eq(2)").text());
            alert("투비업렝스 = " + $("#toBeUp:eq(3)").text()); */
            var numbers = "";
            for (var x=0; x < $("div[id=toBeUp]").length; x++){
            	numbers += $('#hidden_input2 div').eq(x).text() + "///";
            	alert("$('#hidden_input2 div').eq(x).text() = " + $('#hidden_input2 div').eq(x).text());
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
    			+ uploadOriginalNames + "' />" + "<input type='hidden' id='filesize' name='filesize' value='" 
    			+ uploadSizes + "' />";
    			
   			totalUploadFiles += "<input type='hidden' id='deleteStoredFileName' name='deleteStoredFileName' value='" 
       			+ deleteUploadFiles + "' />" + "<input type='hidden' id='deleteOriginalName' name='deleteOriginalName' value='" 
       			+ deleteUploadOriginalNames + "' />" + "<input type='hidden' id='deleteFilesize' name='deleteFilesize' value='" 
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
                url : '/drone/co_p_modify.co',
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
            location.href="template.templ?page=co_p_view.co?num=" + x;
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

    