<%@page import="project.board.event.EventboardCommentService"%>
<%@page import="project.board.event.EventboardCommentList"%>
<%@page import="project.board.event.EventboardVO"%>
<%@page import="project.board.event.EventboardService"%>
<%@page import="project.board.free.FreeboardCommentService"%>
<%@page import="project.board.free.FreeboardCommentList"%>
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
	int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	String job = request.getParameter("job");
	
	EventboardService service = EventboardService.getInstance();
	EventboardVO ev_vo = service.evSelectByIdx(ev_idx);

	request.setAttribute("ev_vo", ev_vo);
	request.setAttribute("currentPage", currentPage);
	request.setAttribute("enter", "\r\n");


	if(job.equals("contentView")) {
		EventboardCommentList eventboardCommentList = EventboardCommentService.getInstance().evSelectCommentList(ev_idx);
		request.setAttribute("eventboardCommentList", eventboardCommentList);
	}	

	pageContext.forward(job + ".jsp");
%>

</body>
</html>










