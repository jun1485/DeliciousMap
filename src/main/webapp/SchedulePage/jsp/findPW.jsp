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
	String uid = (String)request.getParameter("RegisterID");
	String name = (String)request.getParameter("RegisterName");
	String phoneNum = (String)request.getParameter("RegisterPhone");
	
	UserDbControl control = new UserDbControl();
	
	String password = control.finePassword(uid, name, phoneNum);
	
	if(password == null){
		%> 
		<script type="text/javascript">
		alert("해당하는 비밀번호를 발견하지 못했습니다.");
		history.back();
		</script>
		<%
	}
	else{
		%> 
		<script type="text/javascript">
		alert("찾은 비밀번호는 " + "<%=password%>" + "입니다. ");
		location.href="../index.html";
		</script>
		<%
	}
%>
</body>
</html>