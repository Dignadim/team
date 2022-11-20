<%@page import="project.util.calendar.ScheduleManager"%>
<%@page import="project.board.event.EventboardService"%>
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
	int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	

	out.println("<script>");
	EventboardService.getInstance().evDelete(ev_idx);	
	ScheduleManager.getInstance().delete(ev_idx);
	out.println("alert('게시글이 성공적으로 삭제되었습니다.')");
	out.println("location.href='list.jsp?currentPage=" + currentPage + "'");
	out.println("</script>");
%>

</body>
</html>









