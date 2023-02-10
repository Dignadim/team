<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link rel="icon" href="../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/register.css"/>
<script defer="defer" type="text/javascript" src="../js/register.js"></script>
</head>
<body>

<%
	String ogUrl = request.getHeader("referer");
%>

	<c:if test="${msg != null}">
		<script type="text/javascript">
		alert('${msg}');
		</script>
	</c:if>

	<center>
		<h3>로그인</h3>
		<hr>
		<div class="container" style="margin-top: 50px; width: 800px"><br/><br/><br/>
			<form action=loginOK method=post name="login_form">
				<input type="hidden" name=action value=login>
				<table class="table table-hover table-bordered">
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">아이디</th>
						<td><input class="form-control" type=text name=userID></td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">비밀번호</th>
						<td><input class="form-control" type="password" name=userPW></td>
					</tr>
					<tr>
						<td colspan=2 align="center">
							<input type="hidden" name="ogUrl" value="<%=ogUrl%>"> <!--로그인폼에 오기 전 페이지의 url주소를 넘겨주기 위한 -->
							<input class="btn btn-outline-success" type="button" value="로그인" onclick="loginChk()">
							<input  id='modal-open' class="btn btn-outline-primary" type=button name=register value="회원가입" >
							<input class="btn btn-outline-secondary" type=button name=register value="홈으로" onClick="location.href='../'">
						</td>
					</tr>
					<tr style="border: none;">
						<td colspan=2 align="center" style="border: none;">
							<h5 id="cautionMsg" style="color: red; font-weight: bold;"></h5>
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
								<input type="text" name="regiid" placeholder="영문자 또는 숫자만 입력하세요." autocomplete="off" onkeyup="regtest()" id="regiid"/>
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
								<span id="idChkMsg" style="color: red; font-weight: bold; font-size: 16px;"></span>
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
								<span id="pssChkMsg" style="color: red; font-weight: bold; font-size: 16px;"></span>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" name="reginickname" placeholder="NickName" />
							</td>
						</tr>
						<tr>
							<td>
								<input type="email" onkeyup="regtestEmail()" name="regiemail" placeholder="Email" id="regiemail"/>
							</td>
						</tr>
						<tr>
							<td>
								<!-- 이메일 정규식 결과 메시지가 출력될 영역 -->
								<span id="emlMsg" style="color: red; font-weight: bold; font-size: 16px;"></span>
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
		<c:if test="${id != null}">
		<script type="text/javascript">
			alert('적절하지 않은 접근입니다.');
			location.href='../connectMain';
		</script>
		</c:if>
	</div>
	
	
	
</body>
</html>