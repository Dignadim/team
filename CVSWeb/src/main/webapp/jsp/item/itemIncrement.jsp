<%@page import="project.item.ItemVO"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemIncrement</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link rel="stylesheet" href="./css/main.css">
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		int currentPage = 1;
		int idx = Integer.parseInt(request.getParameter("idx"));
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			
		}
		ItemService service = ItemService.getInstance();
		service.itemIncrement(idx);
		
		response.sendRedirect("itemSelectByIdx.jsp?idx=" + idx + "&currentPage=" + currentPage + "&job=itemView");
	%>

</body>
</html>