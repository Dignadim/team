<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
	<center>
		<h3>로그인</h3>
		<hr>
		<div class="container" style="margin-top: 100px; width: 800px">
			<form action=login_control.jsp method=post name="login_form">
				<input type="hidden" name=action value=login>
				<table class="table table-hover table-bordered">
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">아이디</td>
						<td><input class="form-control" type=text name=id></td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">비밀번호</td>
						<td><input class="form-control" type="password" name=password></td>
					</tr>
					<tr>
						<td colspan=2 align="center">
							<input class="btn btn-outline-success" type=submit name=submit value="로그인">
							<input class="btn btn-outline-primary" type=button name=register value="회원가입" onClick="location.href='register.jsp'">
							<input class="btn btn-outline-secondary" type=button name=register value="홈으로" onClick="location.href='../connectMain.jsp'">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</center>
</body>
</html>