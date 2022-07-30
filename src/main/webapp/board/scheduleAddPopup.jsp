<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<%@ page import ="DMDB.ScheduleDbControl" %>
<%@ page import = "DMDB.ScheduleForView" %>
<html lang="kor">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>스케줄 업로드</title>
<script src="https://kit.fontawesome.com/a9ea2ab270.js"
	crossorigin="anonymous"></script>
<style>
html {
	border: 1px black solid;
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	display: flex;
	justify-content: center;
	padding: 0;
	margin: 0;
	-ms-overflow-style: none;
	scrollbar-width: none;
	border: 1px black solid;
	font-family: 'Noto Sans KR', sans-serif;
}

body::-webkit-scrollbar {
	display: none;
}

* {
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
}

.popup_contents {
	border: 1px solid #BDBDBD;
	width: 500px;
	height: 600px;
}

.close_button {
	display: inline;
	width: 30%;
	height: 20%;
}

.timeSchedule {
	border: 1px solid;
	border-radius: 20px;
	margin-top: 7%;
	margin-left: 10%;
	margin-right: 10%;
	height: 18%;
	padding: 4%;
	cursor: pointer;
	position: relative;
	transition: transform 300ms ease-in;
}

.timeSchedule:hover {
	transform: scale(1.1);
}

.schedule-start-date {
	display: inline-block;
}

.sel-btn {
	font-size: 1.5rem;
	outline: none;
	border: none;
	background-color: transparent;
	transition: transform 200ms ease-in;
	cursor: pointer;
	margin-left: 1%;
	margin-right: 1%;
}

.sel-btn:hover {
  transform: scale(1.2);
}
</style>
</head>

<body>
<% 
ArrayList<ScheduleForView> schedules;
ScheduleDbControl control = new ScheduleDbControl();
String uid = null;
uid = (String)session.getAttribute("UID");
schedules = control.loadUserSchedulesFromDb(uid);
%>


	<div class="popup_contents" align="center">
	<% for(int i = 0; i < schedules.size(); i++){ %>
		<div class="timeSchedule"  id="<%=i%>" onclick="clickclick(<%=i%>, '<%=schedules.get(i).getName()%>', '<%=schedules.get(i).getKey()%>')" align="left">
			<%=schedules.get(i).getName()%>
			<i class="fas fa-check" style="display: none; margin-left: 10%" id="<%=i%>check"></i>
			 <br>
			<br>
			 시작 : <%=schedules.get(i).getStart_day()%> ~ 끝 : <%=schedules.get(i).getEnd_day()%>
		</div>
		<%} %>
		<div style="margin-bottom: 10%">
		</div>
		<div class="close_button" align="center">
			<button id="okButton" name="okButton" onClick='sel_schedule()' class="sel-btn">
			<i class="fas fa-upload"></i></button>
			<button id="closeButton" name="closeButton" onClick='self.close()'  class="sel-btn">
			<i class="fas fa-times" ></i></button>
		</div>
	</div>

</body>

<script>
var isSel = -1;
var sche_title;
var sche_key;

function clickclick(id, title, key) {
	if(isSel != -1){
		var tmp2 = document.getElementById(isSel + "check");
		tmp2.style.display = "none";
	}
	var tmp1 = document.getElementById(id + "check");
	tmp1.style.display = "inline";
	isSel = id;
	
	sche_title = title;
	sche_key = key;
}

function sel_schedule() {
	opener.parent.getScheduleInfo(sche_title, sche_key);
	
	window.close();
}
</script>

</html>