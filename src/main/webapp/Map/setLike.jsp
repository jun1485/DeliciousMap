<%@page import="DMDB.RestaurantDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
RestaurantDbControl control = new RestaurantDbControl();
String uid = (String)session.getAttribute("UID");
String r_num = request.getParameter("r_num");
control.setLikes(r_num, uid);
out.print(control.isLikes(r_num, uid));
%>