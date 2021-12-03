<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DMDB.RestaurantView"%>
<%@page import="DMDB.RestaurantDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
RestaurantDbControl control = new RestaurantDbControl();
int pages = Integer.parseInt(request.getParameter("page"));
System.out.println(pages);
String uid = (String)session.getAttribute("UID");
String keyword = request.getParameter("keyword");
ArrayList<RestaurantView> restaurants;
boolean isNext = false;

if(keyword == null){
	restaurants = control.getLikeRestaurants("test", pages);
	if(control.isLikePages(uid, pages+1))
		isNext = true;
}
else{
	restaurants = control.getSearchedLikeRestaurants(uid, pages, keyword);
	if(control.isSearchedLikePages(uid, pages+1, keyword))
		isNext = true;
}
JSONArray json = new JSONArray();

RestaurantView firstRes = restaurants.remove(0);
JSONObject firstJson = firstRes.getJson();
firstJson.put("isNext", isNext);
json.add(firstJson);

for(RestaurantView res : restaurants){
	json.add(res.getJson());
}

System.out.println(json);
out.print(json);
%>