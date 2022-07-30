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
	String content = request.getParameter("reply_content");
	String post_key = request.getParameter("post_key");
	String uid = (String) session.getAttribute("UID");
	
	if (uid == null || uid.equals("")) {
		%>
			<script type="text/javascript">
		alert("로그인이 필요합니다.")
		history.back();
		</script>
			<%
		}
	
	else if (content == null || content.equals("")) {
	%>
	<script type="text/javascript">
	alert("내용을 입력해주세요.")
	history.back();
	</script>
	<%
	}
	
	else if(content.length() > 1000){
		%>
		<script type="text/javascript">
		alert("1000자 이하로 작성해주세요.")
		history.back();
		</script>
		<%
	}
	
	else {
			String reply_comment_key = request.getParameter("reply_comment_key");
			if(reply_comment_key == null)
				reply_comment_key = "-1";

			PostDbControl control = new PostDbControl();
			control.addNewCommentToPost(content, uid, Integer.parseInt(post_key), Integer.parseInt(reply_comment_key));
	%>

	<script type="text/javascript">
	location.href="board_page.jsp?key=<%=post_key%>";
	</script>

	<%
	}
	%>

</body>
</html>