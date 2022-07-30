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
	String title = request.getParameter("title");
	String content = request.getParameter("text");
	String schedule_key = request.getParameter("schedule_key");
	String uid = (String) session.getAttribute("UID");

	if (uid == null || uid.equals("")) {
	%>
	<script type="text/javascript">
		alert("로그인이 필요합니다.")
		history.back();
	</script>
	<%
	}

	else if (title == null || title.equals("")) {
	%>
	<script type="text/javascript">
		alert("제목을 입력해주세요.")
		history.back();
	</script>
	<%
	}

	else if (title.length() > 1000) {
	%>
	<script type="text/javascript">
		alert("제목은 1000자 이하로 입력해주세요.");
		history.back();
	</script>
	<%
	}
	
	else if (content.length() > 10000) {
		%>
			<script type="text/javascript">
		alert("본문은 10000자 이하로 입력해주세요.");
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

	else if (schedule_key == null || schedule_key.equals("")) {
	%>
	<script type="text/javascript">
		alert("스케줄을 선택해주세요.")
		history.back();
	</script>
	<%
	} else {

	PostDbControl control = new PostDbControl();
	control.addNewPostToDb(title, content, uid, Integer.parseInt(schedule_key));
	%>
	<script type="text/javascript">
		location.href = "board.jsp"
	</script>
	<%
	}
	%>

</body>
</html>