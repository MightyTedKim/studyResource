
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<!-- modifyModal -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
	<div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
	    <div class="modal-header mx-auto">
	      <h4 class="modal-title">장소 정보 수정</h4>     
	      <button type="button" class="close" data-dismiss="modal">&times;</button>
	    </div>
     
		<div class="modal-body mx-auto" data-rno>
			<form role="form" action="modifyPage.pl" method="post">	
			
				<input type='hidden' name='page' value="${cri.page}"> 
				<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
				<input type='hidden' name='searchType' value="${cri.searchType}">
				<input type='hidden' name='keyword' value="${cri.keyword}">
				<input type='hidden' id="modal_pno" name="pno" value="pno">    
				  
				<p><label>장소명</label><br/>
				<input type="text" id="modal_pname" name="pname" value="pname"></p>
				<p><label>설명</label><br/>
				<input type="text" id="modal_pdesc" name="pdesc" value="pdesc"></p>
				<p><label>유형</label><br/>
				<input type="text" id="modal_pcate" name="pcate" value="pcate"></p>        
				<p><label>주소</label><br/>
				<input type="text" id="modal_padd" name="padd" value="padd"></p>        
			
				<button type="submit" class="btn btn-warning btnModify"> 수정 </button>
				<button type="submit" class="btn btn-danger btnDelete"> 삭제 </button>
			</form>
		</div>
	</div>
	</div>
</div> <!-- modal -->    
	
	
<script>
$(document).ready(function(){
	var formObj = $("form[role='form']");
	console.log(formObj);	
	$(".btnModify").on("click", function(){
		formObj.attr("action", "/place_list/modifyPage.pl");
		formObj.attr("method", "post");		
		formObj.submit();
	});	
	$(".btnDelete").on("click", function(){
		formObj.attr("action", "/place_list/removePage.pl");
		formObj.submit();
	});	
});
</script>