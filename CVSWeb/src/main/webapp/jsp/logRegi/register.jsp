<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="../../css/register.css"/>
<script type="text/javascript" src="../../js/jquery-3.6.1.js"></script>
<script defer="defer" type="text/javascript" src="../../js/register.js"></script>
</head>
<body>

	<label>회원가입하기</label>
	<button id='modal-open'>가입하기</button>
	
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
								<input type="text" name="id" placeholder="ID" autocomplete="off" />
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
								<input type="password" name="password" placeholder="Password" 
								onkeyup="pssChk()"/>
							</td>
							<td>
								<input type="password" name="passwordCh" placeholder="Password 확인" 
								onkeyup="pssChk()"/>
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
								<input type="text" name="nickname" placeholder="NickName" />
							</td>
						</tr>
						<tr>
							<td>
								<input type="email" name="email" placeholder="Email" />
							</td>
						</tr>
						<tr>
							<td>
								<button onclick="register()">Sign Up</button>
							</td>
						</tr>
					</table>
				</div>
				
				<table>
					<tr>
						<td colspan="3" style="text-align: center;">
							
							<!-- 오류 메시지가 출력될 영역 -->
							<h5 id="errorMessage" style="color: lime; font-weight: bold;">
								${messageContent}					
							</h5>
						</td>
					</tr>
				</table>
				
			</div>
		</div>
	</div>
	

					
					



</body>
</html>