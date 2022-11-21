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
<title>랭킹 게시판</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	//	기본 카테고리는 전부
	String category = "모두";
	//	카테고리속성을 받아온다.
	String reCategory = (String) request.getParameter("category");
	
	//	받아온 카테고리 속성이 존재한다면 그걸로 카테고리를 바꿔준다.
	if(reCategory != null) category = reCategory;
	
	ItemService service = ItemService.getInstance();

	//	받아온 카테고리 속성의 상품만 담은 리스트를 만들어준다.
	ItemList itemCate = service.selectItemCateList(category);
	
	//	카테고리 속성의 상품만 담은 리스트에서 조회수 상위 ()개의 상품만 가져온다.
	try {
		itemCate = service.selectItemCateListHit(itemCate, 12);		
		 request.setAttribute("itemTOP", itemCate);	
	} catch (NullPointerException e) {
		out.println("<script>");
		out.println("alert('카테고리가 존재하지 않습니다.')");
		out.println("</script>");
	}
	
	
	//	조회수 상위 ()개의 상품을 리스트로 받아온다.
	//ItemList itemTOP = service.selectItemTOP(12);

	 //request.setAttribute("itemTOP", itemTOP);	
	 request.setAttribute("category", category);
	    
	pageContext.forward("rankView.jsp");
%>
	

</body>
</html>