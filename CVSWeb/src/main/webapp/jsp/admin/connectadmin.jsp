<%@page import="project.board.admin.AdminService"%>
<%@page import="project.board.free.FreeboardList"%>
<%@page import="project.item.ItemList"%>
<%@page import="project.item.ItemVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>connectAdmin</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>


	<%
	

			request.setCharacterEncoding("UTF-8");
		
		// freeboard 데이터를 freeboard 리스트에 담음 
		AdminService service = AdminService.getInstance(); 
		FreeboardList freeboardList = service.abSelectList();
		
		
		
		 
		    
		    // 데이터를 화면에 표시하는 페이지(adminView.jsp)로 넘겨준다.
		   request.setAttribute("freeboardList", freeboardList);

		 
		    
		    
		    
		    
			pageContext.forward("adminView.jsp");
	%>

</body>
</html>