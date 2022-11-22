<%@page import="project.member.MemberVO"%>
<%@page import="project.board.admin.AdminService"%>
<%@page import="project.member.MemberList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>connectAdminMyPageView</title>
</head>
<body>


<%
request.setCharacterEncoding("UTF-8");
AdminService service = AdminService.getInstance();

//모든 멤버 목록 얻어옴
MemberList memberListSort = service.amSelectList();


//id 피라메터값 받아옴
String id = request.getParameter("id");

//id랑 맞는 정보 가져옴
MemberVO vo = service.selectById(id);
//out.println(vo);

request.setAttribute("vo", vo);
pageContext.forward("adminPageView.jsp");

%>

</body>
</html>