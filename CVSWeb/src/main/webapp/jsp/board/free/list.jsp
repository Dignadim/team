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
	/* FreeboardCommentService commentService = FreeboardCommentService.getInstance(); */

//	모든 공지글을 얻어온다.

//	1페이지 분량의 메인글을 얻어온다.
	FreeboardList freeboardList = service.selectList(currentPage);

//	공지글과 메인글의 댓글 개수를 얻어와서 FreeboardVO 클래스의 commentCount에 저장한다.

//	공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
	request.setAttribute("freeboardList", freeboardList);
	request.setAttribute("currentPage", currentPage);
	pageContext.forward("listView.jsp");
%>


</body>
</html>







