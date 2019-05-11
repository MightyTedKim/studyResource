<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%
 String id = (String)session.getAttribute("id");
 String nickname = (String)session.getAttribute("nickname");
 Integer authority = (Integer)session.getAttribute("authority");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootsrap CDN -->
      <!-- 링크를 통해 서버로 부터 파일을 받아오는 cdn 방식으로 -->
       <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

       <title>Auction_write</title>
 
   </head>

<body>


   <div class="container" id="left"> 
      <div class="row line_color_yellow_b mt-1 mb-5 pt-5">
        <div class="col-lg-12 text_align_center">
            <p class="small_logo">UPLOAD YOUR AUCTION</p>
            <p class="korean_center">중고거래글을 작성해주세요. | <a href="template.templ?page=auction_list.co">목록으로 돌아가기</a>
            </p>
        </div>
     </div>
    
       
         <form action="" method="post" enctype="multipart/form-data" id="uploadForm">
           <div class="row">
           
         <div class="col-md-6 justify-content-left notosanskr w500" id="left">            
           <div class="form-group">
                <br>
              <p class="p">아이디</p>
              <input type="text" class="form-control" name="id" id="id" value="<%=id %>" readonly/>
                <br>
             <p class="p">이름</p>
             <input type="text" class="form-control" name="nickname" id="nickname" value="<%=nickname %>" readonly/>
                <br>
              <p class="p">*제목</p>
              <input type="text" class="form-control" id="title" name="title"   />
              <br>
              <br>
              <p class="p">*핸드폰번호</p>
              <input type="text" class="form-control" id="ph" name="ph"   />
          </div>
         </div>
          
        <div class="col-md-6 justify-content-right" id="right"> 
          <div class="form-group">
          
              <p class="p">*제품명</p>
              <input type="text" class="form-control" id="pname" name="pname"  />
          </div>
          <div class="form-group">
              <p class="p">*가격</p>
              <input type="text" class="form-control" id="price" name="price" />
          </div>
          <div class="class form-group">
              <p class="p">*판매상태</p>
              <select class="form-control" id="sales" name="sales">                    
                  <option value="판매중">판매중</option>
                  <option value="거래중">거래중</option>
                  <option value="판매완료">판매완료</option>                  
              </select>    
          </div>
          <div class="form-group">
              <p class="p">*판매이유</p>
              <textarea class="form-control" id="body" name="body" rows="5" /></textarea>
          </div> 
        </div> <!-- right div 끝  -->
      </div>  <!-- row div 끝  -->
        
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
              <!--  미리보기 영역-->
          <div id="preview" class="content"></div>
          </div>     
           </div>
      </div>  
      
     </form>
    </div>
   </div>
  </div>  

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
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
        //submit 등록. 실제로 submit type은 아니다.
        $('#button_click').on('click',function() {
           if ($('#uploadInputBox').val() === ""){
              alert('사진 파일을 업로드하셔야 합니다.');
           }
           else{
           
            var x = null;
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
                url : '/drone/imageupload.co',
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
                    else
                    {
                       x = result.res ;
                        alert('이미지 업로드 성공');
                        //
                       //alert('글번호 = ' + x);
                        location.href="template.templ?page=auction_detail.co?num=" + x;
                    }
                },
                error : function(request,status,error){
                    alert('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
                }
                //전송실패에대한 핸들링은 고려하지 않음
            });
           }
            
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