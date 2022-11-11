<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 - MyBatis</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
<center>
<h3>회원가입 화면</h3>
<hr>
<form action=login_control.jsp method=post>
<input type=hidden name=action value=register>
	<table border=1>
		<tr>
			<td>이름</td>
			<td><input type=text name=name></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type=text name=id></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type=text name=password></td>
		</tr>
		<tr>
			<td colspan=2>
				<input type=submit name=submit value="확인">
				<input type=reset name=reset value="다시 입력">
			</td>
		</tr>
	</table>
</form>
</center>
</body>
</html>