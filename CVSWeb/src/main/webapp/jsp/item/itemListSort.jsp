<%@page import="project.item.ItemList"%>
<%@page import="project.item.ItemVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemList</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>

	<%
	request.setCharacterEncoding("UTF-8");
	
	int currentPage = 1;
	int mode = 1;
	try {
		// 이전 페이지에서 넘어오는 화면에 표시할 페이지 번호를 받는다.
		currentPage = Integer.parseInt(request.getParameter("currentPage"));		
		// 실행할 번호(mode)를 받는다.
		mode = Integer.parseInt(request.getParameter("mode"));
	} catch (NumberFormatException e) {
		
	}
	
	ItemService service = ItemService.getInstance();
	
	// 모든 상품 목록을 얻어온다.
	ArrayList<ItemVO> items = service.selectItems();
	// 1페이지 분량의, mode대로 정렬된 상품을 얻어온다.
	ItemList itemList = service.itemListSort(currentPage, mode);
	
	// 상품의 목록을 request 영역에 저장해서 메인 글을 화면에 표시하는 페이지(itemListView.jsp)로 넘겨준다.
	request.setAttribute("items", items);
	request.setAttribute("currentPage", currentPage);
	request.setAttribute("itemList", itemList);
	
	pageContext.forward("itemListView.jsp");
	%>

</body>
</html>