<%@page import="project.board.event.EventboardVO"%>
<%@page import="project.board.event.EventboardService"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
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
%>

	<jsp:useBean id="ev_vo" class="project.board.event.EventboardVO">
		<jsp:setProperty property="*" name="ev_vo"/>
	</jsp:useBean>
	<%-- ${ev_vo} --%>
	<jsp:useBean id="mb_vo" class="project.member.MemberVO">
		<jsp:setProperty property="*" name="mb_vo"/>
	</jsp:useBean>
	<%-- ${mb_vo} --%>
	
<%	
	ev_vo.setId(mb_vo.getId());
	ev_vo.setNickname(mb_vo.getNickname());

	out.println("<script>");
	out.println("alert('게시글이 등록되었습니다.')");
	EventboardService.getInstance().evInsert(ev_vo);
	out.println("location.href='list.jsp'");
	out.println("</script>"); 
%>

</body>
</html>