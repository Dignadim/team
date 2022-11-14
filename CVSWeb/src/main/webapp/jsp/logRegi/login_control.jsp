<%@page import="project.member.MemberVO"%>
<%@page import="project.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="v" class="project.member.MemberVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="v" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인/회원가입 처리화면</title>
</head>

<%
request.setCharacterEncoding("UTF-8");
%>

<body>
<%
String action = request.getParameter("action");
	
	if(action.equals("login") && v.getId() != null){
		MemberService m = MemberService.getInstance();
		MemberVO vo = m.searchID(v.getId().trim());
			
			if(vo != null){
		 		if(vo.getId().equals(v.getId().trim())){
					if(vo.getPassword().trim().equals(v.getPassword().trim())){
						out.println("<script>");
						out.println("alert('로그인되었습니다.')");
						out.println("location.href='../main.jsp'");
						out.println("</script>");
						session.setAttribute("id", vo.getId());
						session.setAttribute("nickname", vo.getNickname());
						session.setAttribute("email", vo.getEmail());
						session.setAttribute("password", vo.getPassword());
						session.setAttribute("signupdate", vo.getSignupdate());
						session.setAttribute("grade", vo.getGrade());
					}
					else{
						out.println("<script>");
						out.println("alert('비밀번호가 틀렸습니다.')");
						out.println("history.back()");
						out.println("</script>");
					}
				}
			}else{
				out.println("<script>");
				out.println("alert('아이디가 틀렸습니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
	}else{
		out.println("<script>");
		out.println("alert('아이디를 입력해주세요.')");
		out.println("history.back()");
		out.println("</script>");
	}
	
	
%>
</body>
</html>