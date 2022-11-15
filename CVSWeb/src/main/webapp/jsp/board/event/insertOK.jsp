<%@page import="project.board.event.EventboardVO"%>
<%@page import="project.board.event.EventboardService"%>
<%@page import="project.board.free.FreeboardService"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	
<%
 	out.println("<script>");
	out.println("alert('게시글이 등록되었습니다.')");
	EventboardService.getInstance().evInsert(ev_vo);
	out.println("location.href='list.jsp'");
	out.println("</script>");
%>

</body>
</html>