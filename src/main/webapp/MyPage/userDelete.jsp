<%@page import="DMDB.UserDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserDbControl control = new UserDbControl();
String uid = (String)session.getAttribute("UID");

control.userDelete(uid);
%>

<script>
alert("탈퇴되었습니다.");
location.href="../SchedulePage/index.html";
</script>