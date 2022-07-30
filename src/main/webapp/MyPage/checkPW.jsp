<%@page import="DMDB.UserDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserDbControl control = new UserDbControl();
String password = request.getParameter("password");
String uid = (String)session.getAttribute("UID");

System.out.println(password);

boolean result = control.checkPassword(uid, password);

System.out.println(result);

out.print(result);
%>