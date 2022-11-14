<%@page import="javax.swing.plaf.synth.SynthOptionPaneUI"%>
<%@page import="project.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	<%-- ${vo.id} --%>

<%
//	insert.jsp에서 넘어온 데이터를 메인글 테이블에 저장하는 메소드를 실행한다.

	MemberService.getInstance().insert(vo);

	response.sendRedirect("register.jsp");
%>

</body>
</html>