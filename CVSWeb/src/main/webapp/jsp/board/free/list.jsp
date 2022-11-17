<%@page import="project.board.free.FreeboardCommentService"%>
<%@page import="project.board.free.FreeboardVO"%>
<%@page import="project.board.free.FreeboardList"%>
<%@page import="project.board.free.FreeboardService"%>
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
	
	FreeboardService service = FreeboardService.getInstance();
	FreeboardCommentService commentService = FreeboardCommentService.getInstance();

	ArrayList<FreeboardVO> fb_notice = service.fbSelectNotice();
	FreeboardList freeboardList = service.fbSelectList(currentPage);

//	공지글과 메인글의 댓글 개수를 얻어와서 FreeboardVO 클래스의 commentCount에 저장한다.
	for (FreeboardVO fb_vo : fb_notice) {
		fb_vo.setFb_commentCount(commentService.fbCommentCount(fb_vo.getFb_idx()));
	}
	for (FreeboardVO fb_vo : freeboardList.getList()) {
		fb_vo.setFb_commentCount(commentService.fbCommentCount(fb_vo.getFb_idx()));
	}

//	공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
	request.setAttribute("fb_notice", fb_notice);
	request.setAttribute("freeboardList", freeboardList);
	request.setAttribute("currentPage", currentPage);
	pageContext.forward("listView.jsp");
%>


</body>
</html>







