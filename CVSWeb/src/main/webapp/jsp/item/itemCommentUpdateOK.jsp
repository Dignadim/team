<%@page import="project.item.ItemCommentService"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemCommentUpdateOK</title>
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

	<jsp:useBean id="co" class="project.item.ItemCommentVO">
		<jsp:setProperty property="*" name="co"/>
	</jsp:useBean>
 	
	<%
	//System.out.println(co);
	ItemCommentService service = ItemCommentService.getInstance();
	out.println("<script>"); 
	service.itemCommentUpdate(co); 
	out.println("location.href='itemSelectByIdx.jsp?currentPage=" + currentPage + "&idx=" + co.getGup() + "&job=itemView" + "'");
	out.println("</script>");
	%>	 

</body>
</html>