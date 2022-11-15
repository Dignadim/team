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
	int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	String job = request.getParameter("job");
	
	FreeboardService service = FreeboardService.getInstance();
	FreeboardVO fb_vo = service.fbSelectByIdx(fb_idx);

	request.setAttribute("fb_vo", fb_vo);
	request.setAttribute("currentPage", currentPage);
	request.setAttribute("enter", "\r\n");
	
	if(job.equals("contentView")) {
		FreeboardCommentList freeboardCommentList = FreeboardCommentService.getInstance().fbSelectCommentList(fb_idx);
		request.setAttribute("freeboardCommentList", freeboardCommentList);
	}	
	
	pageContext.forward(job + ".jsp");
%>

</body>
</html>










