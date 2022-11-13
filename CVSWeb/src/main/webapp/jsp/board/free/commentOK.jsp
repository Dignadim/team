<%@page import="project.board.free.FreeboardCommentService"%>
<%@page import="project.board.free.FreeboardCommentVO"%>
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

	<jsp:useBean id="fbc_vo" class="project.board.free.FreeboardCommentVO">
		<jsp:setProperty property="*" name="fbc_vo"/>
	</jsp:useBean>
	
	<%-- ${fbc_vo} --%>
	
<%
 	FreeboardCommentService service = FreeboardCommentService.getInstance();
	//contentView.jsp에서 넘어온 mode에 따라 1은 댓글 저장, 2는 댓글 수정, 3은 댓글 삭제 작업을 한다.
	out.println("<script>");
	switch (mode) {
		case 1:
			out.println("alert('댓글 저장에 " + (service.insertComment(fbc_vo) ? "성공했습니다." : "실패했습니다.") + "')");
			break;
 		case 2:
			out.println("alert('댓글 수정에 " + (service.updateComment(fbc_vo) ? "성공했습니다." : "실패했습니다.") + "')");
			break;
		case 3:
			out.println("alert('댓글 삭제에 " + (service.deleteComment(fbc_vo) ? "성공했습니다." : "실패했습니다.") + "')");
			break;
	}
	out.println("location.href='selectByIdx.jsp?fb_idx=" + fbc_vo.getFbc_gup() + "&currentPage=" + currentPage + "&job=contentView'");
	out.println("</script>"); 
%>

</body>
</html>