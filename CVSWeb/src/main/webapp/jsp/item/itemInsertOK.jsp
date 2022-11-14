<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="project.item.ItemService"%>
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

	<jsp:useBean id="vo" class="project.item.ItemVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>
	
	<%
		out.println("<script>");
		try {
			ItemService.getInstance().itemInsert(vo);		
			out.println("alert('상품을 입력했습니다.')");						
		} catch (Exception e) {
			out.println("alert('모든 정보를 입력하세요.')");			
		}
		// 메인글 1페이지 분량의 글 목록을 얻어오는 페이지(itemList.jsp)로 넘겨준다.
		out.println("location.href='itemList.jsp'");	
		out.println("</script>");	
		
	%>	
</body>
</html>