<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- --------- -->
<!-- handlbars -->
<!-- --------- -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'>
	<a href="{{getLink}}" data-toggle="lightbox" data-gallery="gallery" class="col-md-4">
		<img src="{{imgsrc}}" alt="Attachment">
		<div>{{fileName}}</div> 		
    </a>
</li>  
</script>
<!-- reply template -->
<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}}>
<i class="fa fa-comments bg-blue"></i>
 <div class="timeline-item" >
  <span class="time">
    <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
  </span>
  <h3 class="timeline-header"><strong>{{replyer}}</strong></h3>
  <div class="timeline-body">{{replytext}} </div>
    <div class="timeline-footer">

{{#eqReplyer replyer }}
	<a class="btn-primary btn-xs" 
		data-toggle="modal" data-target="#modifyModal">Modify</a>
{{/eqReplyer}}
 	</div>
  </div>			
</li>
{{/each}}
</script>
<script>
	Handlebars.registerHelper("eqReplyer", function(replyer, block) {
		var accum = '';
		if (replyer != null && replyer == '${login.uid}') {
			accum += block.fn();
		}
		return accum;
	});
	/* ------------------------------- */
	/* handlebar for date/ replyList   */
	/* ------------------------------ */
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});
</script>
<script>
	var bno = ${boardVO.bno}; // indicating specific board# for the reply
	var replyPage = 1; // has to start with page 1 at first
</script>
	
<div class="row"> <!-- row -->
	<div class="col-lg-4 col-md-6 mx-auto">	<!-- col-lg-8 -->	
	<div class="board-reply">
		<div class="board-reply-header">
			<c:if test="${not empty login}">
				<div class="form-group">
					<label for="exampleInputEmail1">Writer</label>
						 <input type="text" name="writer" class="form-control"
						placeholder="USER ID" id="newReplyWriter" value="${login.uid}" readonly="readonly"> 
					<label for="exampleInputEmail1">Reply Text</label> 
						<input type="text" name="writer" class="form-control" placeholder="REPLY TEXT" id="newReplyText">
				</div>
				<button type="submit" class="btn btn-primary" id="replyAddBtn"> ADD REPLY</button>
			</c:if>
		</div> <!-- board-reply-header -->
		
		<hr />

		<div class="board-reply-body">				
			<ul class="timeline"><!-- The time line --> 
				<li class="time-label" id="repliesDiv">
					<span class="bg-green">
						Replies List
						<small id="replycntSmall"> [ ${boardVO.replycnt} ] </small> 
					</span>
				</li>
			</ul>

			<ul id="pagination" class="pagination pagination-sm no-margin text-center"></ul>
			<hr />

			<!-- Modal -->
			<div id="modifyModal" class="modal modal-primary fade"
				role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="modal-title"></h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body" data-rno>
							<p>
								<input type="hidden" class="modal-rno" id="rno">
								<input type="text" id="replytext" class="form-control">
							</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
							<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			<!-- modal -->
			<script>
			$(".timeline").on("click", ".replyLi", function(event) {
				var reply = $(this);
			
				$("#modal-title").html(reply.find('.timeline-header').text()); //uid 
				
				//input text
				$("#rno").val(reply.attr('data-rno')); 
				$("#replytext").val(reply.find('.timeline-body').text());			
			});
			</script>
		</div><!-- board-reply-body -->
	</div><!-- board-reply -->
	
</div> <!-- col-lg-8 -->
</div> <!-- row -->
</div> <!-- conatiner -->
<!-- container -->
<script>
	/* ----------- */
	/* init        */
	/* ---------- */
	$(window).on('load', function() {
		getPage("/replies/" + bno + "/1");
		var template = Handlebars.compile($("#templateAttach").html());
		$.getJSON("/board/getAttach.bo/" + bno, function(list) {
			$(list).each(function() {
				var fileInfo = getFileInfo(this);
				var html = template(fileInfo);
				$(".uploadedList").append(html);
			});
		});
	});

	/*-----------------------*/
	/*       Pagination      */
	/*-----------------------*/

	var printData = function(replyArr, target, templateObject) {
		var template = Handlebars.compile(templateObject.html());
		var html = template(replyArr);
		$(".replyLi").remove(); //remove existing replyLi
		target.after(html); // and add the new replyLi to the tag 
	}

	var printPaging = function(pageMaker, target) { //reply list
		var str = "";
		if (pageMaker.prev) {// pageMaker : prev, startPage, endPage, next
			str += "<li class='page-item'><a class='page-link' href='"
					+ (pageMaker.startPage - 1) + "'> << </a></li>";
		}
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class= "page-item active"'
					: '';
			str += "<li "+strClass+"><a class='page-link' href='"+i+"'>" + i
					+ "</a></li>";
		}
		if (pageMaker.next) {
			str += "<li class='page-item'><a class='page-link'href='"
					+ (pageMaker.endPage + 1) + "'> >> </a></li>";
		}
		target.html(str); // target : specific html tag where list goes in
	};

	function getPage(pageInfo) { //int pageInfo
		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template')); //replyArr, target, templateObject
			printPaging(data.pageMaker, $(".pagination"));// pageMaker, target
			$("#modifyModal").modal('hide'); // hide modify modal
			$("#replycntSmall").html("[" + data.pageMaker.totalCount + "]"); //fetching new count value every time retrieving reply list
		});
	}

	$(".pagination").on("click", "li a", function(event) {
		// show another pageList on reply pagination click
		event.preventDefault();
		replyPage = $(this).attr("href"); //fetching repltPage info of li a tag
		getPage("/replies/" + bno + "/" + replyPage);
	});

	/*-----------------------*/
	/*     reply C(r)UD        */
	/*-----------------------*/
	//create		
	$("#replyAddBtn").on("click", function() {//adding reply on click
		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();
		$.ajax({ //use post to add
			type : 'post',
			url : '/replies/',
			headers : {
				"Content-Type" : "application/json","X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) {
				if (result == 'SUCCESS') {
					alert("등록 되었습니다.");
				} else if (result == 'EMPTY') {
					alert("필수 입력 값들이 입력되지 않았습니다.");
				}
				replyPage = 1;
				getPage("/replies/" + bno + "/" + replyPage); //pagination and list
				replytext.val("");
			}
		});
	});

	//update
	$("#replyModBtn").on("click", function() {//fetch title and replytext
		var rno = $(".modal-rno").val();
		var replytext = $("#replytext").val();
		console.log(rno);
		$.ajax({ //use put to modify  
			type : 'put',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json", "X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify({	replytext : replytext }),
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("수정 되었습니다.");
					getPage("/replies/" + bno + "/" + replyPage);
				}
			}
		});
	});
	//delete
	$("#replyDelBtn").on("click", function() { //fetch title and replytext
		var rno = $(".modal-rno").val()
		var replytext = $("#replytext").val();
		$.ajax({//use put to delete  
			type : 'delete',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("삭제 되었습니다.");
					getPage("/replies/" + bno + "/" + replyPage);
				}
			}
		});
	});

</script>