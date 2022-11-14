<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 뷰</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="../../css/myPageView.css">

</head>
<body>
<div class="m-3">

<header>

헤더영역
</header>


<div id= "wrap">
<nav>
메뉴영역
</nav>
<div id="content">
<div class="b">
	<div class="container mt-3" align="center" >
	  <img src="../../images/img03.jpg" class="rounded" alt="프로필사진" width="304" height="536"> 
	  <h2>프로필 사진</h2>	       
	아이디<br/><br>
	닉네임<br/><br>
	이메일<br/><br>
	</div>

</div>
<div class="b"> 
	<form id=f action="checkPasswordOK.jsp"  method="post"  align="center">
		<table align="center" border="1" cellpadding="5" cellspacing="0">
			<tr>
				<th>
					  <div class="mb-3 mt-3">
					    <label for="id" class="form-label">ID</label>
					  </div>
				<th>
						회원정보
				</th>
				
			</tr>
			<tr>
				<th>		  
					<div class="mb-3 mt-3">
					  <label for="nickname" class="form-label">닉네임</label> 
					</div>
				</th>
				<td>
						회원 닉네임
				</td>
			</tr>
			<tr>
				<th>		  
					<div class="mb-3 mt-3">
						<label for="email" class="form-label">E-mail</label>
					</div>
				</th>
				<td>
						회원 E-mail
				</td>
			</tr>
			<tr>
				<th>		  
					<div class="mb-3 mt-3">
						<label for="signupdate" class="form-label">가입일자</label>
					</div>
				</th>
				<td>
						회원 가입일자
				</td>
			</tr> 
			<tr>
				<th>		  
					<div class="mb-3 mt-3">
						<label for="selfIntroduce" class="form-label">자기소개</label>
					</div>
				</th>
				<td>
						회원 자기소개
				</td>
			</tr> 
			
					
		<tr>
		<td colspan="2" align="center">		   
			  
			<button
				class="btn btn-primary"
				type= "button"
				title="쪽지함"
				onclick="location.href=noteBox.jsp"
				>쪽지함 (차후 구현)</button>	
			
			 <button type="submit"
			 		 class="btn btn-primary"
			 		 title="비밀번호변경"
			 		 >비밀번호 변경</button>
	
			<button
				class="btn btn-primary"
				type= "button"
				title="정보수정"
				onclick="location.href=changeInformation.jsp"
				>정보수정</button>	
		</td>
		</tr>
				
				
		</table>
	</form>
</div>
</div>
</div>
<footer>
푸터영역
</footer>



	









		<!--   <div class="form-check mb-3">
		    <label class="form-check-label">
		      <input class="form-check-input" type="checkbox" name="remember"> Remember me
		    </label>
		  </div>
		  

</div> -->

</body>
</html>