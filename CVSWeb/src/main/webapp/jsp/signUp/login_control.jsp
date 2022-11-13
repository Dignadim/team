<%@page import="project.signup.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="m" class="project.signup.LoginEx" scope="page"></jsp:useBean>
<jsp:useBean id="v" class="project.signup.LoginVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="v"/>

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
	
	if(action.equals("login")){
	LoginVO vo = m.getDB(v.getId());
		
		if(vo != null ){
	 		if(vo.getId().equals(v.getId())){
		if(vo.getpassword().equals(v.getpassword())){
			out.println("로그인 되었습니다.");
		}
		else{
			out.println("비밀번호가 틀렸습니다.");
		}
	}
		}
		else{
	out.println("아이디가 틀렸습니다.");
		}
	}
	else if(action.equals("register")){
		int cnt = m.insertDB(v);
 		if(cnt > 0){
	out.println("회원가입이 완료되었습니다.");
		}
		else{
	out.println("회원가입이 실패하였습니다.");
		}
	}
%>
</body>
</html>