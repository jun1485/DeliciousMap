<%@page import="DMDB.UserDbControl"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="DMDB.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DMDB.PostDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
PostDbControl control = new PostDbControl();
UserDbControl userDB = new UserDbControl();
int pages = Integer.parseInt(request.getParameter("page"));
String uid = (String)session.getAttribute("UID");
ArrayList<Post> posts = control.getWriterPost(pages, uid);
JSONArray jsonArr = new JSONArray();

Post firstPost = posts.remove(0);
JSONObject firstJson = new JSONObject(); 
firstJson.put("uid", userDB.getName(uid));
firstJson.put("title", firstPost.getTitle());
firstJson.put("date", firstPost.getDate());
firstJson.put("views", firstPost.getViews());
firstJson.put("recommends", firstPost.getRecommendation_count());
firstJson.put("isNext", control.isExistedWriterPage(pages+1, uid));
firstJson.put("p_num", firstPost.getKey());
jsonArr.add(firstJson);

for(Post post : posts){
	JSONObject json = new JSONObject();
	json.put("uid", userDB.getName(uid));
	json.put("title", post.getTitle());
	json.put("date", post.getDate());
	json.put("views", post.getViews());
	json.put("recommends", post.getRecommendation_count());
	json.put("p_num", post.getKey());
	jsonArr.add(json);
}

out.print(jsonArr);
%>