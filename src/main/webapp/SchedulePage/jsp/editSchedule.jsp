<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="DMDB.ScheduleDbControl"%>
<%@ page import="DMDB.Schedule"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%

String schedule_key = request.getParameter("key");
String uid = (String)session.getAttribute("UID");

ScheduleDbControl control = new ScheduleDbControl();
ArrayList<Schedule> schedules = control.loadScheduleFromDb(uid, Integer.parseInt(schedule_key));

session.setAttribute("schedules", schedules);
%>

	<script type="text/javascript">
	location.href="../../Pages/schedule.jsp"
	</script>

</body>
</html>