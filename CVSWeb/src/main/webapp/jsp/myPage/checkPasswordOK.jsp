<%@page import="project.member.MemberService"%>
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
%>

	<jsp:useBean id="vo" class="project.member.MemberVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>
	${mbvo}
	
	
<%	
	MemberService.getInstance().changePassword(vo);
%>
</body>
</html>