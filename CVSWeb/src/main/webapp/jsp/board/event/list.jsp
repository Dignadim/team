<%@page import="project.board.event.EventboardCommentService"%>
<%@page import="project.board.event.EventboardList"%>
<%@page import="project.board.event.EventboardVO"%>
<%@page import="project.board.event.EventboardService"%>
<%@page import="java.util.ArrayList"%>
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
	int currentPage = 1;
	try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	} catch (NumberFormatException e) {
		
	}
	
	EventboardService service = EventboardService.getInstance();
	EventboardCommentService commentService = EventboardCommentService.getInstance();

	ArrayList<EventboardVO> ev_notice = service.evSelectNotice();
	EventboardList eventboardList = service.evSelectList(currentPage);

//	공지글과 메인글의 댓글 개수를 얻어와서 EventboardVO 클래스의 commentCount에 저장한다.

	for (EventboardVO ev_vo : ev_notice) {
		ev_vo.setEv_commentCount(commentService.evCommentCount(ev_vo.getEv_idx()));
	}
	for (EventboardVO ev_vo : eventboardList.getList()) {
		ev_vo.setEv_commentCount(commentService.evCommentCount(ev_vo.getEv_idx()));
	}

//	공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
	request.setAttribute("ev_notice", ev_notice);
	request.setAttribute("eventboardList", eventboardList);
	request.setAttribute("currentPage", currentPage);
	pageContext.forward("listView.jsp");
%>


</body>
</html>







