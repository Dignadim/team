<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemUpdateOK</title>
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
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	%>

	<jsp:useBean id="vo" class="project.item.ItemVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>

	<%
	out.println("<script>"); 
	try {
		ItemService service = ItemService.getInstance();
		service.itemUpdate(vo);
		out.println("alert('" + vo.getIdx() + "번 글을 수정했습니다.')");			
	} catch (Exception e) {
		out.println("alert('모든 정보를 입력하세요.')");		
	}
	out.println("location.href='itemSelectByIdx.jsp?currentPage=" + currentPage + "&idx=" + vo.getIdx() + "&job=itemView'");
	out.println("</script>");
	%>	 

</body>
</html>