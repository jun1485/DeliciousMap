<%@page import="java.sql.Timestamp"%>
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
	ScheduleDbControl control = new ScheduleDbControl(); // DB에서 불러오기 위한 함수를 가진 객체
	String uid = null; // 유저 아이디를 저장할 변수
	uid = (String)session.getAttribute("UID");	// 세션에서 아이디를 불러옴
	if(uid.equals(null)){
		%>
		<script type="text/javascript">
		alert("잘못된 접근입니다.");
		location.href("index.html");
		</script>
		<% 
	}
	String start_day =request.getParameter("schedule-start-date") + " 00:00:00";		// yyyy-mm-dd hh:mm:ss
	Timestamp start = Timestamp.valueOf(start_day);		// String to timestamp
	String end_day = request.getParameter("schedule-end-date") + " 00:00:00";		// yyyy-mm-dd hh:mm:ss
	Timestamp end = Timestamp.valueOf(end_day);			// String to timestamp
	if(start.getTime() > end.getTime()){
		%>
		<script type="text/javascript">
		alert("끝날짜가 시작날짜보다 이릅니다.");
		history.back();
		</script>
		 <%
	}
	String name = request.getParameter("schedule-title");
	
	Schedule firstSchedule = new Schedule(uid);
	firstSchedule.setDate(start.getTime());
	firstSchedule.setEnd_Day(end.getTime());
	firstSchedule.setName(name);
	int dayCount = (int)(end.getTime() - start.getTime()) / (24 * 60 * 60 * 1000);
	
	int schedule_key = control.addNewScheduleToDB(firstSchedule);
	
	firstSchedule.setKey(schedule_key);
	
	ArrayList<Schedule> schedules = new ArrayList<Schedule>();
	
	schedules.add(firstSchedule);
	
	for(int i = 0; i < dayCount; i++){
		Schedule schedule = new Schedule(uid);
		schedule.setDate(start.getTime() + ((24 * 60 * 60 * 1000) * (i + 1)));
		schedule.setName(name);
		schedule.setKey(schedule_key);
		schedules.add(schedule);
	}
	session.setAttribute("schedules", schedules);
	
	%>
	
	<script type="text/javascript">
	location.href="../../Pages/schedule.jsp"
	</script>

</body>
</html>