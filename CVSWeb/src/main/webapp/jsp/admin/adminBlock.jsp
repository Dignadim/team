<%@page import="project.member.MemberList"%>
<%@page import="project.member.MemberService"%>
<%@page import="project.member.MemberVO"%>
<%@page import="project.board.admin.AdminService"%>
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


int banType = 1;
try{
	banType = Integer.parseInt(request.getParameter("banType"));
} catch (NumberFormatException e) {
	
}

AdminService service = AdminService.getInstance();
MemberService service1 = MemberService.getInstance();

//모든 멤버 목록 얻어옴
MemberList memberListSort = service.amSelectList();


//id 피라메터값 받아옴
String id = request.getParameter("id");


// id랑 맞는 정보 가져옴
 MemberVO vo = service1.selectById(id);

MemberVO original = service.selectById(vo.getId());
service.blockUpdate(vo, banType);
%>
	
</body>
</html>