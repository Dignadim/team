<%@page import="com.tjoeun.vo.ItemList"%>
<%@page import="com.tjoeun.vo.ItemVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tjoeun.service.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemList</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>

	<%
	request.setCharacterEncoding("UTF-8");
	// 이전 페이지에서 넘어오는 화면에 표시할 페이지 번호를 받는다.
	int currentPage = 1;
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));		
	} catch (NumberFormatException e) {
		
	}
	
	ItemService service = ItemService.getInstance();
	
	// 모든 상품 목록을 얻어온다.
	ArrayList<ItemVO> items = service.selectItems();
	// 1페이지 분량의 상품을 얻어온다.
	ItemList itemList = service.selectItemList(currentPage);
	
	// 상품의 목록을 request 영역에 저장해서 메인 글을 화면에 표시하는 페이지(itemListView.jsp)로 넘겨준다.
	request.setAttribute("items", items);
	request.setAttribute("currentPage", currentPage);
	request.setAttribute("itemList", itemList);
	
	pageContext.forward("itemListView.jsp");
	%>

</body>
</html>