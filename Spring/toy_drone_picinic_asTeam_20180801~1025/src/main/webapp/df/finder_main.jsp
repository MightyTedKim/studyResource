<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.drone.df.DroneVO"%>
<%@ page import="com.spring.drone.news.NewsPaginationVO"%> 
<%@ page import="java.util.*" %>
<%
	ArrayList<DroneVO> droneList = (ArrayList<DroneVO>)request.getAttribute("droneList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
${jsonDroneList}
$(document).ready(function() {
	var droneArray = new Array();
	var droneJson = new Object();
	for (var i = 0;i < droneList.size();i++){
		DroneVO vo = droneList.get(i);
		alert("droneJson.speed = " + vo.getSpeed());
		droneJson.speed = vo.getSpeed();
		droneJson.weight = vo.getWeight();
		droneJson.capacity = vo.getCapacity();
		droneJson.runningtime = vo.getRunningtime();
		droneJson.frequency = vo.getFrequency();
		droneJson.distance = vo.getDistance();
		droneJson.camera = vo.getCamera();
	
		droneArray.push(droneJson);
	}
	var droneJson = JSON.stringify(droneJson);
});
</script>
</head>
<body>

</body>
</html>