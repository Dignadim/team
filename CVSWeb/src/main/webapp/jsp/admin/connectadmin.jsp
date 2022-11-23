<%@page import="project.board.event.EventboardList"%>
<%@page import="project.board.event.EventboardCommentList"%>
<%@page import="project.member.MemberList"%>
<%@page import="project.board.admin.AdminService"%>
<%@page import="project.board.free.FreeboardList"%>
<%@page import="project.item.ItemList"%>
<%@page import="project.item.ItemVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>connectAdmin</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
<!-- <script type="text/javascript" src="./js/main.js" defer></script> -->
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>


<%
request.setCharacterEncoding("UTF-8");

//Adminmember.js 에서 가져온 mode 넘버를 받음
	int mode = 1;
	try{
		mode = Integer.parseInt(request.getParameter("mode"));
	} catch (NumberFormatException e) {
		
	}
	
	AdminService service = AdminService.getInstance();
	

	// 모든 멤버 목록 얻어옴
	MemberList memberListSort = service.amSelectList();
	
	// mode대로 정렬된 멤버를 얻어옴.
	memberListSort = service.memberListSort(mode);	



	
//freeboard 데이터를 freeboardList에 담음
	FreeboardList freeboardList = service.abSelectList();
  
//member 데이터를 memberList에 담음
	MemberList memberList = service.amSelectList();

// eventboard 데이터를 eventboardList에 다음
	EventboardList eventboardList = service.aebSelectList();
	


//	데이터를 화면에 표시하는 페이지(adminView.jsp)로 넘겨준다.
	request.setAttribute("memberListSort", memberListSort);
	request.setAttribute("freeboardList", freeboardList);
	request.setAttribute("memberList", memberList);
	request.setAttribute("eventboardList", eventboardList);
	pageContext.forward("adminView.jsp");
%>


</body>
</html>