<%@page import="project.item.ItemCommentService"%>
<%@page import="project.item.ItemVO"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>commentOK</title>
</head>
<body>	
	
	<%
		request.setCharacterEncoding("UTF-8");
		// contentView.jsp에서 넘어오는 데이터를 받는다.
		int currentPage = Integer.parseInt((String) request.getParameter("currentPage"));
		int mode = Integer.parseInt(request.getParameter("mode"));
	%>
	
	<jsp:useBean id="co" class="project.item.ItemCommentVO">
		<jsp:setProperty property="*" name="co"/>
	</jsp:useBean>
	<%
		System.out.println(co);
		ItemCommentService service = ItemCommentService.getInstance();
		out.println("<script>");
		if (mode == 1) {
			out.println("alert('댓글 저장에 " + (service.insertItemComment(co) ? "성공했습니다." : "실패했습니다.") + "')");
		} else if (mode == 2) {
			out.println("alert('댓글 수정에 " + (service.updateItemComment(co) ? "성공했습니다." : "실패했습니다.") + "')");
		} else {
			out.println("alert('댓글 삭제에 " + (service.deleteItemComment(co.getIdx()) ? "성공했습니다." : "실패했습니다.") + "')");
		}
			out.println("location.href='itemSelectByIdx.jsp?idx=" + co.getGup() + "&currentPage=" + currentPage + "&job=itemView'");
			out.println("</script>");
		%>
	
</body>
</html>



















