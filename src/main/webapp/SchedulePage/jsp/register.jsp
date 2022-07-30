<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<%@ page import="DMDB.UserDbControl"%>
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
	String uid = (String)request.getParameter("RegisterID");
	String nickName = (String)request.getParameter("RegisterNick");
	String phoneNum = (String)request.getParameter("RegisterPhone");
	String password = (String)request.getParameter("RegisterPW");
	String cPassword = (String)request.getParameter("CRegisterPW");
	String name = (String)request.getParameter("RegisterName");
	UserDbControl control = new UserDbControl();
	
	if(password != cPassword){
		%> 
		<script type="text/javascript">
		System.out.println(password);
		System.out.println(cPassword);
		alert("비밀번호를 다시 확인해주세요.");
		location.href="../register.html";
		</script>
		<%
	}
	
	else if(control.checkRegisterID(uid)){
		%> 
		<script type="text/javascript">
		alert("아이디는 최대 15자 이며, 특수문자를 사용하실 수 없습니다.");
		location.href="../register.html";
		</script>
		<%
	}
	
	else if(password.length() > 20){
		%> 
		<script type="text/javascript">
		alert("비밀번호는 최대 15자입니다.");
		location.href="../register.html";
		</script>
		<%
	}
	
	else if(control.checkUid(uid)){
		%> 
		<script type="text/javascript">
		alert("이미 존재하는 아이디 입니다.");
		location.href="../register.html";
		</script>
		<%
	}
	
	else if(control.checkNickName(nickName)){
		%> 
		<script type="text/javascript">
		alert("이미 존재하는 닉네임 입니다.");
		location.href="../register.html";
		</script>
		<%
	}
	
	int error_count = control.addNewUserToDb(uid, password, name, nickName, phoneNum);
	
	if(error_count == -1){
		%> 
		<script type="text/javascript">
		alert("회원가입실패");
		location.href="../register.html";
		</script>
		<%
	}
	else{
		%> 
		<script type="text/javascript">
		alert("회원가입에 성공했습니다. 로그인 해주세요.");
		location.href="../index.html";
		</script>
		<%
	}
%>
</body>
</html>