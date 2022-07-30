<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="DMDB.ScheduleDbControl" %>
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
control.deleteScheduleFromDb(uid, Integer.parseInt(schedule_key));

%>

<script type="text/javascript">
location.href="../main.jsp";
</script>

</body>
</html>