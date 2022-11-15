<%@page import="project.board.event.EventboardCommentService"%>
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
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int mode = Integer.parseInt(request.getParameter("mode"));
%>

	<jsp:useBean id="evc_vo" class="project.board.event.EventboardCommentVO">
		<jsp:setProperty property="*" name="evc_vo"/>
	</jsp:useBean>
	
	
<%
   	EventboardCommentService service = EventboardCommentService.getInstance();
	//contentView.jsp에서 넘어온 mode에 따라 1은 댓글 저장, 2는 댓글 수정, 3은 댓글 삭제 작업을 한다.
 	out.println("<script>");
	switch (mode) {
		case 1:
			out.println("alert('댓글 저장에 " + (service.evInsertComment(evc_vo) ? "성공했습니다." : "실패했습니다.") + "')");
			break;
 		case 2:
			out.println("alert('댓글 수정에 " + (service.evUpdateComment(evc_vo) ? "성공했습니다." : "실패했습니다.") + "')");
			break;
		case 3:
			out.println("alert('댓글 삭제에 " + (service.evDeleteComment(evc_vo.getEvc_idx()) ? "성공했습니다." : "실패했습니다.") + "')");
			break;
	}
	out.println("location.href='selectByIdx.jsp?ev_idx=" + evc_vo.getEvc_gup() + "&currentPage=" + currentPage + "&job=contentView'");
	out.println("</script>");
%>

</body>
</html>