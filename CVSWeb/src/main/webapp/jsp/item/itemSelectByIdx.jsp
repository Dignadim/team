<%@page import="project.item.ItemCommentService"%>
<%@page import="project.item.ItemCommentList"%>
<%@page import="project.item.ItemVO"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>item Select By Idx</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String job = request.getParameter("job");
		String avgID = request.getParameter("avgID");
	
		ItemService service = ItemService.getInstance();
		ItemVO vo = service.itemSelectByIdx(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("currentPage", currentPage);
		
		if (job.equals("itemView")) {
			ItemCommentList itemCommentList = ItemCommentService.getInstance().selectItemCommentList(idx);
			request.setAttribute("itemCommentList", itemCommentList);
		}
		
		pageContext.forward(job + ".jsp");
	%>

</body>
</html>