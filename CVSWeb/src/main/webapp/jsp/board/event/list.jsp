<%@page import="project.util.calendar.ScheduleManager"%>
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
	
//	카테고리와 검색어를 받는다.	
	String category = request.getParameter("category");
	String searchText = request.getParameter("searchText");
	// out.println(searchText);
	
//	넘어온 카테고리와 검색어가 있으면 세션에 저장한다.
	session.setAttribute("category", category);
	session.setAttribute("searchText", searchText);
	
	EventboardService service = EventboardService.getInstance();
	EventboardCommentService commentService = EventboardCommentService.getInstance();

	ArrayList<EventboardVO> ev_notice = service.evSelectNotice();
	EventboardList eventboardList = null;
	
	// 카테고리, 검색어 값이 null인 경우(검색 버튼 누르기 전), 혹은 category가 "전체"인 경우
	if(category == null && (searchText == null || searchText.trim().length() == 0)	
		|| category.equals("전체") && (searchText == null || searchText.trim().length() == 0)) {
		eventboardList = service.evSelectList(currentPage);
	// 카테고리가 null이 아니거나, "전체"가 아닌 경우
	} else if (category != null || !category.equals("전체")) {
		// 검색어가 null인 경우
		if (searchText == null || searchText.trim().length() == 0) {
			eventboardList = service.evSelectListCategory(currentPage, category);
		// 검색어가 null이 아닌 경우
		} else {
			eventboardList = service.evSelectListMulti(currentPage, category, searchText);
			System.out.println("list"+searchText);
		}
	} 
	
	
	for (EventboardVO ev_vo : ev_notice) {
		ev_vo.setEv_commentCount(commentService.evCommentCount(ev_vo.getEv_idx()));
	}
	for (EventboardVO ev_vo : eventboardList.getList()) {
		ev_vo.setEv_commentCount(commentService.evCommentCount(ev_vo.getEv_idx()));
	}
		
	//	스케줄이 들어있는 리스트를 불러온다.
	request.setAttribute("schedList", ScheduleManager.getInstance().getList());
		
	//	공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
	request.setAttribute("ev_notice", ev_notice);
	request.setAttribute("eventboardList", eventboardList);
	request.setAttribute("currentPage", currentPage);
	pageContext.forward("listView.jsp");
%>


</body>
</html>







