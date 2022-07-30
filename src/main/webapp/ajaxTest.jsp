<%@page import="org.json.simple.JSONObject"%>
<%@page import="DMDB.Restaurant"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="DMDB.Review"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DMDB.RestaurantDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
JSONObject json = new JSONObject();
RestaurantDbControl control = new RestaurantDbControl();
String r_num = "27419329";
Restaurant restaurant = control.loadRastaurant(r_num);
json.put("restaurantDB", restaurant.getJson());
ArrayList<Review> reviews = control.loadReviews(r_num);
JSONArray reviewArr = new JSONArray();
for (Review review : reviews) {
	reviewArr.add(review.getJson());
}
json.put("commentDB", reviewArr);
json.put("viewCountFromDB", restaurant.getViews());
json.put("likeCountFromDB", control.getLikesCount(r_num));
out.print(json);

/*
insert into Review (r_num, uid, content, score, time, c_num) values ("27419329", "test", "test1", 3, 1636641715691, 0);
insert into Review (r_num, uid, content, score, time, c_num) values ("27419329", "test", "test2", 5, 1636641715691, 1);
insert into Review (r_num, uid, content, score, time, c_num) values ("27419329", "test", "test3", 3, 1636641715691, 2);
insert into Review (r_num, uid, content, score, time, c_num) values ("27419329", "test", "test4", 5, 1636641715691, 3);
insert into Review (r_num, uid, content, score, time, c_num) values ("27419329", "test", "test5", 1, 1636641715691, 4);
*/
%>