<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemUpdateOK</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	%>

	<jsp:useBean id="vo" class="project.item.ItemVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>

	<%
	out.println("<script>"); 
	try {
		ItemService service = ItemService.getInstance();
		service.itemUpdate(vo);
		out.println("alert('" + vo.getIdx() + "번 글을 수정했습니다.')");			
	} catch (Exception e) {
		out.println("alert('모든 정보를 입력하세요.')");		
	}
	out.println("location.href='itemSelectByIdx.jsp?currentPage=" + currentPage + "&idx=" + vo.getIdx() + "&job=itemView'");
	out.println("</script>");
	%>	 

</body>
</html>