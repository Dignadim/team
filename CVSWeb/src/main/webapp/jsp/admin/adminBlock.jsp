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


//id 피라메터값 받아옴
String id = request.getParameter("id");

// id랑 맞는 정보 가져옴
MemberVO vo = service.selectById(id);
service.blockUpdate(vo, banType);

// 수정된 정보를 다시 가져옴
vo = service.selectById(id);

%>

out.println("<script>");
alert('수정되었습니다.');
out.println("</script>");
<% 
request.setAttribute("vo", vo);
pageContext.forward("adminPageView.jsp");	
%>
</body>
</html>