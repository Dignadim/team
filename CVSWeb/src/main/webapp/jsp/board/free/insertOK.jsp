<%@page import="project.board.free.FreeboardService"%>
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

	<jsp:useBean id="fb_vo" class="project.board.free.FreeboardVO">
		<jsp:setProperty property="*" name="fb_vo"/>
	</jsp:useBean>
	
	
<%
	FreeboardService.getInstance().insert(fb_vo);	
	
	response.sendRedirect("list.jsp");
%>

</body>
</html>