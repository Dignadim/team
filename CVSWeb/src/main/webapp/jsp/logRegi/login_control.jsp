<%@page import="project.member.MemberVO"%>
<%@page import="project.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="v" class="project.member.MemberVO" scope="page"></jsp:useBean>
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
	
	if(action.equals("login"))
	{
		MemberService m = MemberService.getInstance();
		MemberVO vo = m.searchID(v.getId());
			
			if(vo != null )
			{
		 		if(vo.getId().equals(v.getId()))
		 		{
					if(vo.getPassword().equals(v.getPassword()))
					{
						out.println("로그인 되었습니다.");
					}
					else
					{
						out.println("비밀번호가 틀렸습니다.");
					}
				}
			}
			else
			{
				out.println("아이디가 틀렸습니다.");
			}
	}
	
%>
</body>
</html>