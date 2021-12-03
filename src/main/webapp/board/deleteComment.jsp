<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="DMDB.PostDbControl" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
String post_key = request.getParameter("post_key");
String comment_key = request.getParameter("comment_key");

PostDbControl control = new PostDbControl();
control.deleteCommentFromDb(Integer.parseInt(post_key), Integer.parseInt(comment_key));
%>

<script type="text/javascript">
location.href="board_page.jsp?key=<%=post_key%>";
</script>

</body>
</html>