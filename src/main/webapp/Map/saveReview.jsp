<%@page import="DMDB.RestaurantDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
String r_num = request.getParameter("r_num");
int score = Integer.parseInt(request.getParameter("score"));
String comment = request.getParameter("comment");
comment = comment.trim();
String uid = (String)session.getAttribute("UID");

RestaurantDbControl control = new RestaurantDbControl();

control.saveReview(r_num, uid, comment, score);
%>

<script type="text/javascript">location.href="info.jsp?r_num=<%=r_num%>"</script>