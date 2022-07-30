<%@page import="DMDB.UserDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
String uid = "G-" + request.getParameter("id");
String name = request.getParameter("name");
UserDbControl control = new UserDbControl();

if (!control.checkUid(uid))
	control.addNewUserToDb(uid, null, name, name, "X");

session.setAttribute("UID", uid);
%>

<script>
	location.href = "main.jsp";
</script>