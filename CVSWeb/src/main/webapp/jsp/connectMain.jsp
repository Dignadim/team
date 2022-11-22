<%@page import="project.board.event.EventboardList"%>
<%@page import="project.board.free.FreeboardList"%>
<%@page import="project.item.ItemList"%>
<%@page import="project.item.ItemVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>connect Main</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
	    ItemService service = ItemService.getInstance();
	    
	    // 모든 상품 목록을 얻어온다.
	    ArrayList<ItemVO> items = service.selectItems();
	    
	    // 현재 행사 목록을 찾아와서 저장한다.
	    EventboardList evList = service.selectEVList();
	    
	    // 현재 행사 상품 최신순으로 10개를 찾아와서 저장한다.
	    ItemList eventItemList = service.selectEventItemList();

	    // 인기상품 탑 5를 가져와서 저장한다.
	    ItemList itemTOP5 = service.selectItemTOP5();
	    
	    // 인기 게시글 탑 3을 가져와서 저장한다.
	    FreeboardList freeHitList = service.selectFreeHitList();
	    
	    // 데이터를 request로 넘긴다.
	    request.setAttribute("items", items);
		request.setAttribute("evList", evList);
		request.setAttribute("eventItemList", eventItemList);
		request.setAttribute("itemTOP5", itemTOP5);	
		request.setAttribute("freeHitList", freeHitList);
	    
		pageContext.forward("main.jsp");
	%>

</body>
</html>