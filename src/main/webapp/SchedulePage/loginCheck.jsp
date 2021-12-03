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
	String uid = (String)request.getParameter("loginId");
	String password = (String)request.getParameter("password");
	
	UserDbControl control = new UserDbControl();
	
	if(control.checkUid(uid)){
		if(control.checkPassword(uid, password)){
			session.setAttribute("UID", uid);
			%><script>
			location.href ="main.jsp";
			</script><%
		}
		else{
			%><script>
			alert("올바르지 않은 비밀번호입니다.");
			history.back();
			</script><%
		}
	}
	else{
		%>
		<script>
		alert("올바르지 않은 아이디입니다.");
		history.back();
		</script>
		<%
	}
	
%>

</body>
</html>