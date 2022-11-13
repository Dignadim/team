<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	session.removeAttribute("id");
	session.removeAttribute("nickname");
	session.removeAttribute("signupdate");
	session.removeAttribute("email");
	session.removeAttribute("password");
	session.removeAttribute("grade");
	
	out.println("<script>");
	out.println("alert('로그아웃되었습니다.')");
	out.println("location.href='../connectMain.jsp'");
	out.println("</script>");
%>
</body>
</html>