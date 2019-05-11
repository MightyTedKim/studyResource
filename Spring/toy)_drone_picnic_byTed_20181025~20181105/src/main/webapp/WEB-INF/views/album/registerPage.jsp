<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>

<link href="/resources/css/AdminLTE.css" rel="stylesheet">
<link href="/resources/css/album.css" rel="stylesheet">

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
		<h3 class="box-title">REGISTER BOARD</h3>
	</div> <!-- /.box-header -->

<form id='registerForm' role="form" method="post">
	<div class="box-body">
		<div class="row">
		<div class="col-md-4">		
			<input type="hidden" id="uid" name="uid" value="${login.uid}" readonly/>
			<input type="hidden" id="pco_x" name="pco_x" placeholder="pco_x" readonly/>
			<input type="hidden" id="pco_y" name="pco_y" placeholder="pco_y" readonly/>
			<input type="hidden" id="padd" name="padd" placeholder="padd" readonly/>
			<input type="hidden" id="pcate" name="pcate" value="사진" readonly/>	
					
			<div class="form-control">${login.uid}</div>					
			<label>adrone</label>
			<input type="text" class="form-control" id="adrone" name="adrone" placeholder="adrone">
		
			<label>acate1</label>
			<select class="form-control" id="acate" name="acate">
		         <option value="풍경">풍경</option>
		         <option value="인물">인물</option>
		         <option value="기타">기타</option>
	        </select>      		
			<label>pname</label>
			<input type="text" name='pname' class="form-control" placeholder="10글자로 짧게 작성해주세요" maxlength="10">
			<label>pdesc</label>
			<textarea class="form-control" name="pdesc" rows="3" placeholder="pdesc"></textarea>
			
		</div>
		<hr/>
		<div class="col-md-8">
			<input id="address" type="text" placeholder="도로명 주소">
			<input id="searchBtn_submit" type="button" value="검색"> 
		

			<div style="height: 400px; width: 400px;">
				<div id="map" style="width:100%; height:400px;"></div>
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
		</div><!-- row -->
		
		<div class="form-group">
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
			url: '/uploadAjax.co',
			data: formData,
			dataType:'text',
			processData: false,
			contentType: false,
			type:'POST',
			success: function(data){
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);

				$(".uploadedList").append(html);
			}
		}); 
	});
	
	$("#registerForm").submit(function(event){
		console.log("registerForm");
		event.preventDefault();
		var str = "";
	 	$(".uploadedList .delbtn").each(function(index){
			str += "<input type='hidden' name='files[" + index + "]' value='" +
				$(this).attr("href") + "'> ";
		});
	 	$(this).append(str);
	 	console.log("str=" + str);
	 	console.log("$(this).get(0)=" + $(this).get(0));
	 	$(this).get(0).submit();
	}); 
	
	$(".uploadedList").on("click", ".delbtn" ,function(event){
		event.preventDefault();
		var that = $(this);
		alert("사진 파일을 삭제했습니다.");
		
		$.ajax({
			url:"/deleteFile.co",
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
