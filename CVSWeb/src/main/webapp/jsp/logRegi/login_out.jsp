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
	String ogUrl = request.getHeader("referer");
	
	session.removeAttribute("id");
	session.removeAttribute("nickname");
	session.removeAttribute("password");
	session.removeAttribute("signupdate");
	session.removeAttribute("email");
	session.removeAttribute("grade");
	
	out.println("<script>");
	out.println("alert('로그아웃되었습니다.')");
	out.println("location.href='"+ogUrl+"'");
	out.println("</script>");
%>
</body>
</html>