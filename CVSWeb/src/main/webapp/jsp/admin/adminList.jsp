<%@page import="project.member.MemberList"%>
<%@page import="project.board.admin.AdminboardList"%>
<%@page import="project.board.admin.AdminService"%>
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

	
	AdminService service = AdminService.getInstance(); 
//freeboard 데이터를 freeboardList에 담음
	FreeboardList freeboardList = service.abSelectList();
  
//member 데이터를 memberList에 담음
	MemberList memberList = service.amSelectList();


	
	
	
	
	

//	데이터를 화면에 표시하는 페이지(adminView.jsp)로 넘겨준다.
	request.setAttribute("freeboardList", freeboardList);
	request.setAttribute("memberList", memberList);
	pageContext.forward("adminView.jsp");
%>


</body>
</html>







