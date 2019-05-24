<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	Integer authority = (Integer)session.getAttribute("authority");
%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <title>Album_write</title>
<style type="text/css">
.search { position:absolute;z-index:1000;top:20px;left:20px; }
.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
.search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
</style>
    </head>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<body>
<div class="container" id="left">
	<div class="row line_color_yellow_b mt-1 mb-5 pt-5">
		<div class="col-lg-12 text_align_center">
			 <p class="small_logo">UPLOAD YOUR PICTURES</p>
			 <p class="korean_center">드론으로 찍은 사진을 올려주세요 | <a href="template.templ?page=co_p.co">목록으로 돌아가기</a>
			 </p>
		</div>
	</div>
		 <form action="" method="post" enctype="multipart/form-data" id="uploadForm">
      <div class="row">

        <div class="col-md-6 justify-content-left notosanskr w500" id="left">
            <div class="form-group">
            	<input type="hidden" name="coor" id="coor" value="" />
            	<input type="hidden" class="form-control input-sm" name="id" id="id" value="<%=id %>" readonly/>
            	
            	<p class="p">이름</p>
 				<input type="text" class="form-control input-sm" name="nickname" id="nickname" value="<%=nickname %>" readonly/>
                <br>
                <p class="p">제목</p>
                <input type="text" class="form-control input-sm" name="title" id="title"/>
            </div>
            <br>
            <div class="form-group">
                <p class="p">카테고리</p>
                <select class="form-control input-sm" name="category" id="category">
                    <option value="">--선택--</option>
                    <option value="자연">자연</option>
                    <option value="도시">도시</option>
                    <option value="풍경">풍경</option>
                    <option value="인물">인물</option>
                    <option value="스포츠">스포츠</option>
                </select>    
            </div>
            <p class="p">태그</p>
                <div class="form-group row autocomplate">
                
                <input id="myInput1" type="text" class="form-control" name="tag1" style="width: 110px; margin-left:18px;" placeholder="ex) #풍경"/>
                <input id="myInput2" type="text" class="form-control" name="tag2" style="width: 110px; margin-left:18px;" placeholder="ex) #팬텀4"/>
                <input id="myInput3" type="text" class="form-control" name="tag3" style="width: 110px; margin-left:18px;" placeholder="ex) #댕댕이"/>
               </div>
               <div class="form-group row autocomplate">
                <input id="myInput4" type="text" class="form-control" name="tag4" style="width: 110px; margin-left:18px;" placeholder="ex) #하늘"/>
                <input id="myInput5" type="text" class="form-control" name="tag5" style="width: 110px; margin-left:18px;" placeholder="ex) #서울"/>
                <input id="myInput6" type="text" class="form-control" name="tag6" style="width: 110px; margin-left:18px;" placeholder="ex) #건물"/>
               </div>
             
            <br>
            <div class="form-group">
                <p class="p">소감</p>
                <textarea class="form-control input-sm" name="body" name="body" rows="7" ></textarea>
            </div> 
        </div>
       
        
         <div class="col-md-6 justify-content-right" id="right">
            <div class="row form-group">
               <p class="p pl-3">Location</p><br/>
                <div class="col-sm-12 m-0 input-group-append">
                    <input id="address" type="text" style="padding:0;" placeholder="검색할 주소" placeholder="불정로 6" />
         <input id="submit" type="button" style="padding-top: 0px;padding-bottom:  0;margin-left: 5px;border: 0;height: 30px;margin-top: 5px;" class="btn btn-lg button_bg_blue korean_center" value="주소 검색">
                </div>
             </div>
             <div class="row form-group p-2">
                <div class="border border-secondary" style="height:600px; width:440px;">
                    <div id="map_canvas" style="width: 100%; height:100%;" >
                    </div>
                </div>
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
                <!-- 미리보기 영역 -->
            <div id="preview" class="content"></div>
            </div>     
             </div>
        </div>  <!-- 마지막 업로드 영역 -->
        
    </form>
		

   
	</div> 
    <br />
    <br />
    <br />


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
        	//alert("Object.keys(files).length = " + Object.keys(files).length);
        	//
        	//alert("files[0] = " + files[0]);
        	
        	if ($('#uploadInputBox').val() === ""){
        		alert('사진 파일을 업로드하셔야 합니다.');
        	}
        	else{
        	
        	var x = null;
            var form = $('#uploadForm')[0];
            var formData = new FormData (form);
            
            for (var index = 0; index < Object.keys(files).length + 1 ; index++) {
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
                url : '/drone/album_upload.co',
                dataType : "json",
                data : formData,
                success : function(result) {
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
                        location.href="template.templ?page=co_p_view.co?num=" + x;
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


<!-- 네이버 -->               
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>

<style type="text/css">
.search { position:absolute;z-index:1000;top:20px;left:20px; }
.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
.search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
</style>

<script >
var map = new naver.maps.Map("map_canvas", {  
    center: new naver.maps.LatLng(37.3595316, 127.1052133),
    zoom: 10,
    mapTypeControl: true
});

var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');

// search by tm128 coordinate
function searchCoordinateToAddress(latlng) {
    var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);
    
    var latlng_str = latlng.toString();
    var trim_coord_1 = latlng_str.replace("(lat:", "");
    var trim_coord_2 = trim_coord_1.replace("lng:", " ");
    var trim_coord_3 = trim_coord_2.replace(")", "");
    var place_coord_x = trim_coord_3.split(",")[0] - 0;
    var place_coord_y = trim_coord_3.split(",")[1] - 0;
    var place_coord_new = place_coord_x + "," + place_coord_y;

    infoWindow.close();

    naver.maps.Service.reverseGeocode({
        location: tm128,
        coordType: naver.maps.Service.CoordType.TM128
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('도로명 주소로 입력해주세요. \n 예를 들어, 명달로 20길 32번지이면 명달로 까지만 입력해도 됩니다 :)');
        }

        var items = response.result.items;
            
        for (var i=0, ii=items.length, item; i<ii; i++) {
            item = items[i];
            if(item.isRoadAddress == '[도로명 주소]'){
               break;               
            }
        }

        infoWindow.setContent([
               '<div style="padding:10px;min-width:200px;line-height:150%;">',          
                '   <b>주소: </b><br/>' + item.address +'<br />',
                '</div>'
            ].join('\n'));

        infoWindow.open(map, latlng);

//        console.log("searchCoordinateToAddress(latlng), latlng(좌표)-클릭: " + latlng);
        console.log("searchCoordinateToAddress(latlng), place_Coord_new(좌표)-클릭: " + place_coord_new);
       document.getElementById("coor").value = place_coord_new;
       $("#coor").val(place_coord_new);

    });
}

// result by latlng coordinate
function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        address: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('도로명 주소로 입력해주세요. \n 예를 들어, 명달로 20길 32번지이면 명달로 까지만 입력해도 됩니다 :)');
        }
        var item = response.result.items[0],
            point = new naver.maps.Point(item.point.x, item.point.y);

        infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '   <b>주소: </b><br/>' + item.address +'<br />',
                '</div>'
            ].join('\n'));

        
        var place_coord_new = item.point.y + "," + item.point.x;
//        console.log("searchAddressToCoordinate(address), point(좌표)-검색: " + point);
        console.log(">searchAddressToCoordinate, place_Coord_new: " + place_coord_new);      
        document.getElementById("coor").value = place_coord_new;
        $("#coor").val(place_coord_new);
        
        map.setCenter(point);
        infoWindow.open(map, point);
    });
}

function initGeocoder() {
    map.addListener('click', function(e) {
        searchCoordinateToAddress(e.coord);
    });
    $('#address').on('keydown', function(e) {
        var keyCode = e.which;
        if (keyCode === 13) { // Enter Key
            searchAddressToCoordinate($('#address').val());
        }
    });
    $('#submit').on('click', function(e) {
        e.preventDefault();
        searchAddressToCoordinate($('#address').val());
    });
}
naver.maps.onJSContentLoaded = initGeocoder;

//해시태그
function autocomplete(inp, arr) {
     /*두개의 파라미터를 입력한다.
      * 하나는 내가 실제 입력하는 값, 하나는 autocomplete을 위한 값들의 배열이다.*/
     var currentFocus;
     /*입력칸에 무언가 입력되면 이벤트가 발생하게된다.*/
     inp.addEventListener("input", function(e) {
         var a, b, i, val = this.value;

         closeAllLists();
         if (!val) { return false;}
         currentFocus = -1;
         /*아이템들을 담게될 div 태그를 만드는 부분 (values):*/
         a = document.createElement("DIV");
         a.setAttribute("id", this.id + "autocomplete-list");
         a.setAttribute("class", "autocomplete-items");
         /*autocomplete container의 자손으로 div태그를 추가한다.*/
         this.parentNode.appendChild(a);
        
         for (i = 0; i < arr.length; i++) {
           /*입력칸에 입력된 글자와 같은 글인지 체크하는 부분*/
           if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
             /*매칭되는 태그마다 div태그를 추가한다.*/
             b = document.createElement("DIV");
             /*매칭되는 글자에 bold효과를 준다.*/
             b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
             b.innerHTML += arr[i].substr(val.length);
             /*item값들을 담을 array를 input의 value값으로 설정한다.*/
             b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";

             b.addEventListener("click", function(e) {
                 
                 inp.value = this.getElementsByTagName("input")[0].value;
                 
                 closeAllLists();
             });
             a.appendChild(b);
           }
         }
     });
     
     /*키보드에서 키를 누르면 함수를 호출한다ㅏ.*/
     inp.addEventListener("keydown", function(e) {
         var x = document.getElementById(this.id + "autocomplete-list");
         if (x) x = x.getElementsByTagName("div");
         if (e.keyCode == 40) {
           /*아래쪽 방향키를 누르면 포커스가 이동한다.*/
           currentFocus++;

           addActive(x);
         } else if (e.keyCode == 38) { //위쪽 방향키
           /*위쪽 방향키를 누르면 포커스가 이동한다.*/
           currentFocus--;

           addActive(x);
         } else if (e.keyCode == 13) {
           /*엔터키에 의한 submit 방지를 위한 부분*/
           e.preventDefault();
           if (currentFocus > -1) {
             /*active item에 대한 시뮬레이션*/
             if (x) x[currentFocus].click();
           }
         }
     });
     
     function addActive(x) {
       /*active클래스만 고른다.*/
       if (!x) return false;
       /*active 클래스 지운다.*/
       removeActive(x);
       if (currentFocus >= x.length) currentFocus = 0;
       if (currentFocus < 0) currentFocus = (x.length - 1);
       /*"autocomplete-active"클래스 더하는 부분*/
       x[currentFocus].classList.add("autocomplete-active");
     }
     
     function removeActive(x) {
       /*active 상태 없애는 부분*/
       for (var i = 0; i < x.length; i++) {
         x[i].classList.remove("autocomplete-active");
       }
     }
     
     function closeAllLists(elmnt) {
       /*하나 선택되면 창 닫는다.*/
       var x = document.getElementsByClassName("autocomplete-items");
       for (var i = 0; i < x.length; i++) {
         if (elmnt != x[i] && elmnt != inp) {
         x[i].parentNode.removeChild(x[i]);
       }
     }
   }
     
   /* 다른 영역을 클릭하면 리스트가 닫힌다. */
   document.addEventListener("click", function (e) {
       closeAllLists(e.target);
   });
   }
   
var tags = ["#팬텀1","#팬텀2","#팬텀3","#팬텀4","#풍경","#인물","#강아지","#서울","#인천","#건물","#하늘",
      "#부천","#당진","#천안","#시흥","#고양이","#새","#한강","#이천","#광주","#부산","#대구","#울산",
      "#일본","#제주","#중국","#미국","#영국","#유럽","#아프리카","#강남","#포천","#여행","#드론","#바다",
      "#강릉","#속초","#야구장","#축구장","#부평","#문학","#잠실","#고척","#대전","#공항",
      "#공원","#SK와이번스","#우승","#가즈아","#메시","#보다는","#호날두","#가 거기서 왜 나와?"
   ];




autocomplete(document.getElementById("myInput1"), tags);
autocomplete(document.getElementById("myInput2"), tags);
autocomplete(document.getElementById("myInput3"), tags);
autocomplete(document.getElementById("myInput4"), tags);
autocomplete(document.getElementById("myInput5"), tags);
autocomplete(document.getElementById("myInput6"), tags);
//해시태그 끝



</script>         

</body>
</html>

