<%@page import="org.apache.ibatis.exceptions.TooManyResultsException"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update Averscore OK</title>
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