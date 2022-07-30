<%@page import="DMDB.Schedule"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<%@ page import="DMDB.ScheduleDbControl"%>
<%@ page import="DMDB.Element"%>
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
	double lat = Double.parseDouble(request.getParameter("lat"));
	double lng = Double.parseDouble(request.getParameter("lng"));
	int start_time = Integer.parseInt(request.getParameter("start"));
	int end_time = Integer.parseInt(request.getParameter("end"));
	String name = request.getParameter("prt_title");
	String r_num = request.getParameter("r_num");
	boolean isRes = Boolean.parseBoolean(request.getParameter("isRes"));
	int dayCount = 0;
	dayCount = Integer.parseInt(request.getParameter("dayCount"));
	if (!(schedules.get(dayCount).timeCheck(start_time, end_time))) {
	%>
	<script>
		alert("스케쥴 중복입니다.");
		window.close();
	</script>
	<%
	} 
	else {
	schedules.get(dayCount).setTimeChecker(start_time, end_time);
	//String memo = request.getParameter("memo");
	Element element = new Element(name);
	//element.setMemo(memo);
	element.setGP(lat, lng);
	element.setStartTime(schedules.get(dayCount).getDate().getTime() + (60 * 60 * 1000 * start_time));
	element.setEndTime(schedules.get(dayCount).getDate().getTime() + (60 * 60 * 1000 * end_time));
	element.setR_num(r_num);
	element.setRes(isRes);

	schedules.get(dayCount).addElement(element);
	
	%>

	<script>
		history.back();
		//window.close();
	</script>
	<%
	}
	%>

</body>
</html>