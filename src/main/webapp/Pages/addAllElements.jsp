<%@page import="DMDB.Schedule"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<%@ page import="DMDB.ScheduleDbControl"%>
<%@ page import="DMDB.Schedule"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
	ArrayList<Schedule> schedules = null;
	schedules = (ArrayList<Schedule>) session.getAttribute("schedules"); // 세션에 저장한 스케줄 객체
	if (schedules.equals(null)) {
	%>
	<script>
		alert("잘못된 접근입니다.");
		history.back();
	</script>
	<%
	}
	
	ScheduleDbControl control = new ScheduleDbControl();
	int result = control.setElementsToSchedule(schedules);
	
	if(result < 0){
		%>
		<script>
			alert("저장에 실패했습니다.");
			history.back();
		</script>
		<%
	}
	else{
		session.setAttribute("schedules", null);
	%>
	<script>
		location.href='../SchedulePage/main.jsp';
	</script>
	<%} %>
</body>
</html>