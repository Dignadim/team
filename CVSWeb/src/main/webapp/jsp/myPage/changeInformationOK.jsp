<%@page import="project.member.MemberService"%>
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

	<jsp:useBean id="vo" class="project.member.MemberVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>
	
<%	
	out.println("<script>"); 
	try {
		MemberService service = MemberService.getInstance();
		service.update(vo);
		out.println("alert('" + vo.getId() + " 님의 정보가 수정되었습니다.')");	
	} catch (Exception e) {
		out.println("alert('모든 정보를 입력하세요.')");
	}
	out.println("location.href='../connectMain.jsp'");
	out.println("</script>");

%>
</body>
</html>



































