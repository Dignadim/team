<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemDeleteOK</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
	ItemService service = ItemService.getInstance();
	out.println("<script>"); 
	service.itemDelete(vo.getIdx());
	out.println("alert('" + vo.getIdx() + "번 글을 삭제했습니다.')");	
	out.println("location.href='itemList.jsp?currentPage=" + currentPage +"'");
	out.println("</script>");
	%>	 

</body>
</html>