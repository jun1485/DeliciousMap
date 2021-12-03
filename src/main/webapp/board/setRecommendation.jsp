<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DMDB.PostDbControl"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
	String post_key = request.getParameter("post_key");
	String uid = (String) session.getAttribute("UID");

	PostDbControl control = new PostDbControl();
	if(control.isRecommendation(Integer.parseInt(post_key), uid)){
		%>
		<script>
		alert("이미 추천한 게시글 입니다.");
		</script> 
		<% 
	}
	else
		control.setRecommendationToPost(Integer.parseInt(post_key), uid);
	
	%>
	<script type="text/javascript">
	location.href="board_page.jsp?key=<%=post_key%>";
	</script>

</body>
</html>