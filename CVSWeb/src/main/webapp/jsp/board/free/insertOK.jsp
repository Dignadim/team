<%@page import="project.board.free.FreeboardService"%>
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

	<jsp:useBean id="fb_vo" class="project.board.free.FreeboardVO">
		<jsp:setProperty property="*" name="fb_vo"/>
	</jsp:useBean>
	
	
<%
	out.println("<script>");
	out.println("alert('게시글이 등록되었습니다.')");
	FreeboardService.getInstance().insert(fb_vo);
	out.println("location.href='list.jsp'");
	out.println("</script>");	
%>

</body>
</html>