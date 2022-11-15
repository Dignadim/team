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
	
<%	
	String password = request.getParameter("password");
	String password2 = request.getParameter("password2");
	
	if(!password.equals(password2)){
		out.println("<script>");
		out.println("alert('변경할 비밀번호가 서로 일치하지 않습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}
	
		MemberService.getInstance().update(vo);

	response.sendRedirect("../main.jsp");
%>
</body>
</html>



































