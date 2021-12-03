<%@page import="DMDB.PostDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
PostDbControl control = new PostDbControl();
int p_num = Integer.parseInt(request.getParameter("p_num"));
int c_num = Integer.parseInt(request.getParameter("c_num"));
String content = request.getParameter("content");

control.editComment(content, p_num, c_num);
%>