<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML4.0 Transactional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	iframe{
		width:0px;
		height:0px;
		border:0px;
	}
</style>
</head>
<body>
	<form id="form1" action="uploadForm" method="post" 
		enctype="multipart/form-data"
		target="zeroFrame">
		<input type="file" name="file"/>
		<input type="submit"/>
	</form>

	<iframe name="zeroFrame"></iframe>
		
</body>
<script>
	function addFilePath(msg){
		alert("msg= " + msg);
		document.getElementById("form1").reset();
	}
</script>

</html>

