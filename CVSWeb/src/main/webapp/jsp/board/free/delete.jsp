<%@page import="project.board.free.FreeboardVO"%>
<%@page import="project.board.free.FreeboardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	

	out.println("<script>");
	FreeboardService.getInstance().fbDelete(fb_idx);	
	out.println("alert('게시글이 성공적으로 삭제되었습니다.')");
	out.println("location.href='list.jsp?currentPage=" + currentPage + "'");
	out.println("</script>");
%>

</body>
</html>









