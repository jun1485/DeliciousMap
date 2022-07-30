<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uid = (String)session.getAttribute("UID");

if(uid.charAt(1) == '-')
	out.print(true);
else
	out.print(false);

%>