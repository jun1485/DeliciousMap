<%@page import="DMDB.UserDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserDbControl control = new UserDbControl();
String nickName = request.getParameter("nickName");
String password = request.getParameter("password");
String uid = (String)session.getAttribute("UID");

control.changePassword(uid, password);
control.setNickName(uid, nickName);
%>