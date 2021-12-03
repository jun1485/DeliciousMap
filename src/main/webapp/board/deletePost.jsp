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

PostDbControl control = new PostDbControl();
control.deletePostFromDb(Integer.parseInt(post_key));

%>

<script type="text/javascript">
alert("삭제되었습니다.");
location.href="board.jsp";
</script>

</body>
</html>