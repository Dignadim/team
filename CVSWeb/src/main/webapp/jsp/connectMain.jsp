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
<title>connect Main</title>
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
	
	    ItemService service = ItemService.getInstance();
	    
	    // 모든 상품 목록을 얻어온다.
	    ArrayList<ItemVO> items = service.selectItems();
	    
	    // 현재 행사 목록을 찾아와서 저장한다.
	    
	    // 현재 행사 상품을 찾아와서 저장한다.
	    
	    
	    // 인기상품 탑 5를 가져와서 저장한다.
	    ItemList itemTOP5 = service.selectItemTOP5();
	    
	    // 인기 게시글 탑 3을 가져와서 저장한다.
	    FreeboardList freeHitList = service.selectFreeHitList();
	    
	    // 데이터를 request로 넘긴다.
	    request.setAttribute("items", items);
	    request.setAttribute("itemTOP5", itemTOP5);	
		request.setAttribute("freeHitList", freeHitList);
	    
		pageContext.forward("main.jsp");
	%>

</body>
</html>