<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    <%@ page import="DMDB.ScheduleDbControl" %>
    <%@ page import="DMDB.Schedule" %>
<!DOCTYPE html>
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
		ArrayList<Schedule> schedules;
		ScheduleDbControl control = new ScheduleDbControl();
		
		schedules = (ArrayList<Schedule>)session.getAttribute("copy_schedule");
		String uid = (String)session.getAttribute("UID");
		
		String start_day =request.getParameter("start_date_selector") + " 00:00:00";		// yyyy-mm-dd hh:mm:ss
		Timestamp start = Timestamp.valueOf(start_day);
		
		String title = request.getParameter("title");
		
		for(int i = 0; i < schedules.size(); i++){
			schedules.get(i).setDate(start.getTime() + (24 * 60 * 60 * 1000 * i));
			for(int j = 0; j < schedules.get(i).getElementCount(); j++){
				Calendar cal = Calendar.getInstance();
				cal.setTimeInMillis(schedules.get(i).getDate().getTime());
				int year = cal.get(Calendar.YEAR);
				int month = cal.get(Calendar.MONTH) + 1;
				int day = cal.get(Calendar.DATE);
				int start_hour = schedules.get(i).getElementI(j).getStartTime();
				int end_hour = schedules.get(i).getElementI(j).getEndTime();
				schedules.get(i).getElementI(j).setStartTime(year, month, day, start_hour);
				schedules.get(i).getElementI(j).setEndTime(year, month, day, end_hour);
			}
		}
		schedules.get(0).setUid(uid);
		schedules.get(0).setName(title);
		schedules.get(0).setEnd_Day(schedules.get(schedules.size() - 1).getDate().getTime());
		
		int key = control.addNewScheduleToDB(schedules.get(0));
		
		schedules.get(0).setKey(key);
		
		control.setElementsToSchedule(schedules);
%>
</body>
<script>
window.close();
</script>
</html>