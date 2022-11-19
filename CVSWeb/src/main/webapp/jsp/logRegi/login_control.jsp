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
<body>
<%
request.setCharacterEncoding("UTF-8");
String action = request.getParameter("action");
String ogUrl =  request.getParameter("ogUrl");
/* out.println(ogUrl); */
	
	out.println("<script>");
	if(action.equals("login") && v.getId() != null){
		MemberService m = MemberService.getInstance();
		MemberVO vo = m.searchID(v.getId().trim());		
			if(vo != null){
		 		if(vo.getId().equals(v.getId().trim())){
					if(vo.getPassword().trim().equals(v.getPassword().trim())){
						out.println("alert('로그인되었습니다.')");
						out.println("location.href='" + ogUrl + "'");
						session.setAttribute("id", vo.getId());
						session.setAttribute("nickname", vo.getNickname());
						session.setAttribute("email", vo.getEmail());
						session.setAttribute("password", vo.getPassword());
						session.setAttribute("signupdate", vo.getSignupdate());
						session.setAttribute("grade", vo.getGrade());
					}
					else{
						out.println("alert('비밀번호가 틀렸습니다.')");
						out.println("history.back()");
					}
				}
			}else{
				out.println("alert('아이디가 틀렸습니다.')");
				out.println("history.back()");
			}
	}else{
		out.println("alert('아이디를 입력해주세요.')");
		out.println("history.back()");
	}
	out.println("</script>");
	
	
	
%>
</body>
</html>