<%@page import="DMDB.Restaurant"%>
<%@page import="DMDB.RestaurantDbControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
RestaurantDbControl control = new RestaurantDbControl(); 

String r_num = request.getParameter("r_num");

if(!control.isRastaurantInDb(r_num)){
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String key = control.findPage(name, addr);
	if(key == null)		// 망고플레이트에 해당 음식점이 없다면
		control.saveRastaurant(r_num, name, addr, "", "", null);
	else
		control.rPage(key, name, r_num);
}

%>
	
<script type="text/javascript">location.href="info.jsp?r_num=<%=r_num%>"</script>
</body>
</html>