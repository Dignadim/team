<%@page import="project.board.event.EventboardService"%>
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
	int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
%>

	<jsp:useBean id="ev_vo" class="project.board.event.EventboardVO">
		<jsp:setProperty property="*" name="ev_vo"/>
	</jsp:useBean>
	
<%	
	out.println("<script>");
	EventboardService.getInstance().evUpdate(ev_vo);	
	out.println("alert('게시글이 성공적으로 수정되었습니다.')");
	out.println("location.href='list.jsp?currentPage=" + currentPage + "'");
	out.println("location.href='selectByIdx.jsp?ev_idx="+ev_idx+"&currentPage="+currentPage+"&job=contentView'");
	out.println("</script>");
%>

</body>
</html>