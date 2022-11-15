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
	int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	FreeboardService.getInstance().fbIncrement(fb_idx);

	response.sendRedirect("selectByIdx.jsp?fb_idx=" + fb_idx + "&currentPage=" + currentPage + "&job=contentView");
%>

</body>
</html>





