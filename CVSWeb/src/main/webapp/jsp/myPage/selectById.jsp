<%@page import="project.member.MemberVO"%>
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

	String id = request.getParameter("id");
	
	MemberService service = MemberService.getInstance();

	MemberVO vo = service.selectById(id);
	
	request.setAttribute("vo", vo);
	
	out.println("<script>");
	out.println("location.href='changeInformationOK.jsp'");
	out.println("</script>");
%>
</body>
</html>