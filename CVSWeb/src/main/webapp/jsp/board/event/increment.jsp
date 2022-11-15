<%@page import="project.board.event.EventboardService"%>
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
	int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	EventboardService.getInstance().evIncrement(ev_idx);

	response.sendRedirect("selectByIdx.jsp?ev_idx=" + ev_idx + "&currentPage=" + currentPage + "&job=contentView");
%>

</body>
</html>





