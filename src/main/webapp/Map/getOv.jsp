<%@page import="org.json.simple.JSONObject"%>
<%@page import="DMDB.RestaurantDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
RestaurantDbControl control = new RestaurantDbControl();
String r_num = request.getParameter("r_num");
String uid = (String)session.getAttribute("UID");
String img = control.loadImage(r_num);
if(img == null || img.equals("")) 
	img = "../img/altImg.png";
double score = control.getScores(r_num);
boolean like = control.isLikes(r_num, uid);
JSONObject json = new JSONObject();
json.put("img", img);
json.put("score", score);
json.put("like", like);
System.out.println(img);
out.print(json);
%>
