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
<link rel="stylesheet" href="./css/register.css"/>
<script defer="defer" type="text/javascript" src="./js/register.js"></script>
</head>
<body>

	<center>
		<h3>로그인</h3>
		<hr>
		<div class="container" style="margin-top: 50px; width: 800px"><br/><br/><br/>
			<form action=login_control method=post name="login_form">
				<table class="table table-hover table-bordered">
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">아이디</th>
						<td><input class="form-control" type=text name=id></td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">비밀번호</th>
						<td><input class="form-control" type="password" name=password></td>
					</tr>
					<tr>
						<td colspan=2 align="center">
							<input type="hidden" name="ogUrl" value= "${ogUrl}"> <!--로그인폼에 오기 전 페이지의 url주소를 넘겨주기 위한 -->
							<input class="btn btn-outline-success" type=submit name=submit value="로그인">
							<input  id='modal-open' class="btn btn-outline-primary" type=button name=register value="회원가입" >
							<input class="btn btn-outline-secondary" type=button name=register value="홈으로" onClick="location.href='main'">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</center>
	
	<div id="modal">
		<div id="content">
			<input type='button' value='X' class="close" id='modal-close'/>
			<div class="container" id="container">
				<div class="form-container sign-up-container">
					<h1>회원 가입하기</h1>
					<span>소중한 개인정보를 공짜로 적어주세요.</span>
					<table>
						<tr>
							<td>
								<input type="text" name="regiid" placeholder="ID" autocomplete="off" />
							</td>
							<td>
								<button onclick="idChk()">
									중복검사
								</button>
							</td>
						</tr>
						<tr>
							<td>
								<!-- 아이디 중복 검사 결과 메시지가 출력될 영역 -->
								<h5 id="idChkMsg" style="color: red; font-weight: bold;"></h5>
							</td>
						</tr>
						<tr>
							<td>
								<input type="password" name="regipassword" placeholder="Password" onkeyup="pssChk()"/>
							</td>
							<td>
								<input type="password" name="regipasswordCh" placeholder="Password 확인" onkeyup="pssChk()"/>
							</td>
						</tr>
						<tr>
							<td>
								<!-- 비밀번호 일치 검사 결과 메시지가 출력될 영역 -->
								<h5 id="pssChkMsg" style="color: red; font-weight: bold;"></h5>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" name="reginickname" placeholder="NickName" />
							</td>
						</tr>
						<tr>
							<td>
								<input type="email" name="regiemail" placeholder="Email" />
							</td>
						</tr>
						<tr>
							<td>
								<button onclick="register()">Sign Up</button>
							</td>
						</tr>
					</table>
				</div>
				
			</div>
		</div>
	</div>
	
	<%@ include file="../util/hfer/footer.jsp" %>
	
</body>
</html>