<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="DMDB.Schedule"%>
<%@ page import="DMDB.Element"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<%
	ArrayList<Schedule> schedules = null;
	schedules = (ArrayList<Schedule>) session.getAttribute("schedules"); // 세션에 저장한 스케줄 객체
	if (schedules.equals(null)) {
	%>
	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		history.back();
	</script>
	<%
	} else {
	int dayCount = 0;
	dayCount = Integer.parseInt(request.getParameter("dayCount"));
	int start = Integer.parseInt(request.getParameter("start"));

	int tmp = schedules.get(dayCount).deleteElement(start);
	}
	%>

	<script type="text/javascript">
		window.close();
	</script>

</body>
</html>