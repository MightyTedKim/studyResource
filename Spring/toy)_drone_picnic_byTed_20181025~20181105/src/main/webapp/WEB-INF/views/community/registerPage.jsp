<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<link href="/resources/css/AdminLTE.css" rel="stylesheet">
<script src="/resources/js/place.js"></script>
<script src="/resources/js/upload.js"></script>

<script type="text/javascript" 
 	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>

<!-- Page Header -->
<header class="masthead" style="background-image: url('/resources/img/contact-bg.jpg')">
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
      	<div style="height: 60px;"></div>
      </div>
    </div>
  </div>
</header>

<div class="contatiner"><!-- container -->
<div class="row"><!-- row -->
<div class="col-lg-8 col-md-10 mx-auto">	<!-- col-lg -->

<div class="row">
	<div class="col-lg-8 col-md-10 mx-auto">

<div class="box">
	<div class="box-header">
		<h3 class="box-title">REGISTER COMMUNITY</h3>
	</div> <!-- /.box-header -->

<div class="row">
	<div class="col-md-11 mx-auto">
<form id='registerForm' role="form" method="post">
	<div class="box-body">
		<div class="row">
		<div class="col-md-6">		
			<input type="hidden" id="uid" name="uid" value="${login.uid}" readonly/>
			<input type="hidden" id="pco_x" name="pco_x" placeholder="pco_x" readonly/>
			<input type="hidden" id="pco_y" name="pco_y" placeholder="pco_y" readonly/>
			<input type="hidden" id="pcate" name="pcate" value="소모임" readonly/>	

			<label>주요 활동 지역</label>
			<input type="text" id="padd" name='padd' class="form-control" placeholder="주소를 검색해주세요" readonly>
			<label>모임 이름</label>
			<input type="text" id="cname" name="cname" class="form-control" placeholder="10글자로 짧게 작성해주세요" maxlength="10">
			<label>모임 설명</label>
			<textarea id='cdesc' name='cdesc' class="form-control" rows="4" placeholder="소모임 설명을 입력해주세요"></textarea>
						
		</div>
		<div class="col-md-6">
			<input id="address" type="text" placeholder="도로명 주소">	
			<span id="searchBtn_submit"><i class="fas fa-sign-in-alt"></i></span>
			<div style="height: 260; width: 360px;"> 
				<div id="map" style="width:100%; height:300px;"></div>
			</div>
			
			<script>
			var map = new naver.maps.Map(document.getElementById('map'), {
			    zoom: 7,
			    mapTypeId: 'normal',   
			    center: new naver.maps.LatLng(37.549972999999966, 126.9414804999999), //Seoul Station
				minZoom: 1,
				maxZoom: 14,
				zoomControl: true, 
				zoomControlOptions: { 
			  		position: naver.maps.Position.TOP_RIGHT
				},
				setOptions : {
					mapTypeControl : true
				}
			});		
			naver.maps.onJSContentLoaded = searchAddress;
			</script>
				
		</div>		
		</div><!-- row -->		<hr/>
		
		<div class="form-group">
			<div><strong>소모임 대문 사진 등록</strong></div>
			<h6>여러 사진을 등록하실 수 있지만, 가장 최근 사진이 선택됩니다. :) </h6>
			<label>File Drop Here</label>
			<div class="fileDrop"></div>
		</div>
	</div>
	<!-- /.box-body -->

	<div class="box-footer">
		<ul class="mailbox-attachments clearfix uploadedList"></ul> 		
		<button type="submit" class="btn btn-primary">Submit</button>
	</div>	
</form>
		</div> <!--col-->
	</div> <!-- row -->
		</div> <!-- col -->
	</div> <!-- row -->
</div> <!-- box -->

</div> <!-- container -->
</div> <!-- row -->
</div> <!--col-md-12-->

<style>
.fileDrop{
	width: 80%;
	height: 100px;
	border: 1px dotted gray;
	background-color: lightslategrey;
	margin: auto;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="template" type="text/x-handlebars-template">
	<li>
		<span class="mailbox-attachment-icon has-img">
			<img src="{{imgsrc}}" alt="Attachment">
		</span>
		<div class="mailbox-attachment-info">
			<a href ="{{getLink}}" class="mailbox-attachment-name">
				{{fileName}}
			</a>
			<a href ="{{fullName}}" class="btn-default btn-xs pull-right delbtn">
				<i class="far fa-trash-alt"></i>
			</a>
		</div>
	</li>		
</script>

<script>
	//enter disable from form submit
	$(function () {
		  $('input[type=text]').keypress(function(event) {
		    if (event.keyCode == 13) {
		      event.preventDefault();
		    }
		  });
		});

	var template = Handlebars.compile($("#template").html());
	/*-------------*/
	/*  fileDrop   */
	/*-------------*/
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		
		var files= event.originalEvent.dataTransfer.files;
		var file = files[0];
		
		var formData = new FormData();
		formData.append("file", file);
		
		$.ajax({
			url: '/community/uploadAjax',
			data: formData,
			dataType:'text',
			processData: false,
			contentType: false,
			type:'POST',
			success: function(data){
				var fileInfo = getFileInfo(data, "community");
				var html = template(fileInfo);

				$(".uploadedList").append(html);
			}
		}); 
	});
	
	$("#registerForm").submit(function(event){
		event.preventDefault();
		var str = "";
		var fileNumber = ""
	 	$(".uploadedList .delbtn").each(function(index){
	 		fileNumber += 1;
			str += "<input type='hidden' name='files[" + index + "]' value='" +
				$(this).attr("href") + "'> ";
		});
		
	 	$(this).append(str);
	 	if($('#cdesc').val() == "" || $('#cname').val() == ""){
	 		alert("빈칸이 없게 입력해주세요 :)")
	 		return
	 	} else if (fileNumber == 0 ){
	 		alert("대문 사진을 꼭 등록해주세요")
	 		return
	 	}
	 	$(this).get(0).submit();
	}); 
	
	$(".uploadedList").on("click", ".delbtn" ,function(event){
		event.preventDefault();
		var that = $(this);
		alert("사진 파일을 삭제했습니다.");
		
		$.ajax({
			url: "/community/deleteFile",
			type:"post",
			data: {fileName:$(this).attr("href")},
			dataType:"text",
			success:function(result){
				console.log("RESULT: " + result);
				if(result == 'deleted'){
					that.closest("li").remove();
				}
			}
		});
	});
</script>

<%@include file="../include/footer.jsp"%>
