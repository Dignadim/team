<%@page import="org.apache.ibatis.exceptions.TooManyResultsException"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update Averscore OK</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		int currentPage = 1;
	%>
		
	<jsp:useBean id="ao" class="project.item.ItemAvgVO">
		<jsp:setProperty property="*" name="ao"/>
	</jsp:useBean>
	
	<%
	System.out.println(ao);
	ItemService service = ItemService.getInstance();
	out.println("<script>"); 
	try {
		String avgID = service.selectAvgID(ao);
		if (avgID != null) {
			out.println("alert('평점을 이미 등록했습니다.')");						
		} else {
			if (ao.getUpdateScore() > 5 || ao.getUpdateScore()< 0) {		
				out.println("alert('0 ~ 5 사이의 값을 입력하세요.')");			
			} else {
				service.averscoreUpdate(ao);
				out.println("alert('평점을 등록했습니다.')");					
			}			
		}
	} catch (NumberFormatException e) {
		out.println("alert('숫자를 입력하세요.')");
	} catch (TooManyResultsException e) {
		out.println("alert('평점을 이미 등록했습니다.')");		
	} finally {		
		out.println("location.href='itemSelectByIdx.jsp?currentPage=" + currentPage + "&idx=" + ao.getItemIdx() + "&job=itemView'");
		out.println("</script>");
	}
	%>	 

</body>
</html>