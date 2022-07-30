<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<%@ page import="DMDB.UserDbControl"%>
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
	String name = (String)request.getParameter("RegisterName");
	String phoneNum = (String)request.getParameter("RegisterPhone");
	
	UserDbControl control = new UserDbControl();
	
	String uid = control.findUid(name, phoneNum);
	
	if(uid == null){
		%> 
		<script type="text/javascript">
		alert("해당하는 ID를 발견하지 못했습니다.");
		history.back();
		</script>
		<%
	}
	else{
		%> 
		<script type="text/javascript">
		alert("찾은 ID는 " + "<%=uid%>" + "입니다. ");
		location.href="../index.html";
		</script>
		<%
	}
%>
</body>
</html>