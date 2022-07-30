<%@page import="org.json.simple.JSONObject"%>
<%@page import="DMDB.UserDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserDbControl control = new UserDbControl();
String uid = (String)session.getAttribute("UID");
String nickName = control.getNickName(uid);
String phone = control.getPhone(uid);
String name = control.getName(uid);

JSONObject json = new JSONObject();
json.put("uid", uid);
json.put("nickName", nickName);
json.put("name", name);
json.put("phone", phone);

out.print(json);
%>