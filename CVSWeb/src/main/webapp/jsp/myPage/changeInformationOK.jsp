<%@page import="project.member.MemberVO"%>
<%@page import="project.member.MemberDAO"%>
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
	try{
		String id = request.getParameter("id");
		MemberService service = MemberService.getInstance();
		MemberVO original = service.selectById(vo.getId());
		service.update(vo);
		out.println("alert('" + original.getId() + " 님의 정보가 수정되었습니다.')");	
		out.println("location.href='../connectMain.jsp'");
	}catch(Exception e){
		out.println("alert('올바르지 않은 접근경로')");
		out.println("history.back()");
	}
	out.println("</script>");

%>

</body>
</html>



































