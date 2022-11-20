<%@page import="project.member.MemberList"%>
<%@page import="project.member.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="project.board.admin.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMemberSort</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	// Adminmember.js 에서 가져온 mode 넘버를 받음
	int mode = 1;
	try{
		mode = Integer.parseInt(request.getParameter("mode"));
	} catch (NumberFormatException e) {
		
	}
	
	AdminService service = AdminService.getInstance();
	
	// 모든 멤버 목록 얻어옴
	MemberList memberList = service.amSelectList();
	
	// mode대로 정렬된 멤버를 얻어옴.
	memberList = service.memberListSort(mode);
	
	//adminView로 넘겨줌
	request.setAttribute("memberList", memberList);
	pageContext.forward("adminView.jsp");
%>

</body>
</html>