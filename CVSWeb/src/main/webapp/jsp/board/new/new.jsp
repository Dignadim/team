<%@page import="project.item.ItemVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="project.item.ItemService"%>
<%@page import="project.item.ItemList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신상 게시판</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	int currentPage = 1;
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));		
	} catch (NumberFormatException e) {
		
	}
	
	ItemService service = ItemService.getInstance();
	
	// 신상품: 등록된지 30일 이내의 상품
	// 모든 신상품 목록을 얻어온다. 
	ArrayList<ItemVO> newItems = service.selectNewItems();
	
	// 1페이지 분량의 신상품을 얻어온다.
	ItemList newItemList = service.selectNewItemList(currentPage);
	
	request.setAttribute("newItems", newItems);
	request.setAttribute("currentPage", currentPage);
	request.setAttribute("newItemList", newItemList);	

	pageContext.forward("newView.jsp");
%>
	

</body>
</html>