<%@page import="com.tjoeun.service.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemInsertOK</title>
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
	%>

	<jsp:useBean id="vo" class="com.tjoeun.vo.ItemVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>

	<%
	// itemInsert.jsp에서 넘어온 데이터를 메인글 테이블에 저장하는 메소드를 실행한다.
	if (vo.getItemName() == null || vo.getItemPrice() == 0 || vo.getCategory() == null) {
		out.println("<script>");
		out.println("alert('데이터를 모두 입력해주세요.')");
 		out.println("</script>");
 		response.sendRedirect("itemInsert.jsp");
	} else {
		ItemService.getInstance().insert(vo);		
		// 메인글 1페이지 분량의 글 목록을 얻어오는 페이지(itemList.jsp)로 넘겨준다.
		response.sendRedirect("itemList.jsp");	
	}
		
	%>	

</body>
</html>