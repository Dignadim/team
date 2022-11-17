<%@page import="project.item.ItemCommentService"%>
<%@page import="project.item.ItemVO"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>commentOK</title>
<link rel="stylesheet" href="./css/css.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>	
	
	<%
		request.setCharacterEncoding("UTF-8");
		// contentView.jsp에서 넘어오는 데이터를 받는다.
		int currentPage = Integer.parseInt((String) request.getParameter("currentPage"));
		int mode = Integer.parseInt(request.getParameter("mode"));
	%>
	
	<jsp:useBean id="co" class="project.item.ItemCommentVO">
		<jsp:setProperty property="*" name="co"/>
	</jsp:useBean>
	<%
		System.out.println(co);
		ItemCommentService service = ItemCommentService.getInstance();
		out.println("<script>");
		if (mode == 1) {
			service.insertItemComment(co);
		} else if (mode == 2) {
			service.updateItemComment(co);	
		} else {
			service.deleteItemComment(co.getIdx());	
		}
			out.println("location.href='itemSelectByIdx.jsp?idx=" + co.getGup() + "&currentPage=" + currentPage + "&job=itemView'");
			out.println("</script>");
		%>
	
</body>
</html>



















