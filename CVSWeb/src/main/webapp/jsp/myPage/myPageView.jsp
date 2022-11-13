<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<jsp:useBean id="date" class="java.util.Date"/>
	<!-- header -->
	<header>
		<div class="container">
			<nav class="navbar navbar-expand-sm bg-light">
				<div class="col-sm-2">
					<h2 style="width: 200px;">타이틀</h2>
				</div>
				<div class="container-fluid col-sm-5">
					<ul class="navbar-nav">
						<li class="nav-item" style="padding-right: 70px;">
					    	<a class="nav-link" href="./item/itemList.jsp">모든 상품 보기</a>
					    </li>					
						<li class="nav-item dropdown" style="padding-right: 70px;">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">모든 행사 보기</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#">GS25</a></li>
								<li><a class="dropdown-item" href="#">CU</a></li>
								<li><a class="dropdown-item" href="#">세븐일레븐</a></li>
								<li><a class="dropdown-item" href="#">ministop</a></li>
								<li><a class="dropdown-item" href="#">이마트24</a></li>
								<li><a class="dropdown-item" href="#">기타 편의점</a></li>
							</ul>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">게시판</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="./board/free/list.jsp">자유게시판</a></li>
								<li><a class="dropdown-item" href="#">랭킹게시판</a></li>
								<li><a class="dropdown-item" href="#">신상게시판</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- 검색은 추후 구현 -->
				<div class="col-sm-2">
					<input type="text" class="form-control" placeholder="검색할 내용을 입력하세요." style="width: 200px; display: none;">
				</div> 
				<div class="col-sm-1">
					<button type="button" class="btn btn-primary" onclick="#" style="display:none;">검색</button>
				</div>
				<div class="col-sm-2">
					<c:if test="${id == null}">
						<button type="button" class="btn btn-primary" onclick="location.href='./logRegi/login_form.jsp'">로그인</button>	
					</c:if>				
					<c:if test="${id != null}">
						<button type="button" class="btn btn-danger" onclick="location.href='./logRegi/login_out.jsp'">로그아웃</button>
						<c:if test="${grade.trim() != null && grade.trim() == 'y'}">
							<button class="btn btn-info" style="padding: 6px;" onclick="./item/itemInsert.jsp">관리 페이지로</button>	
						</c:if>
						<c:if test="${grade.trim() == null || grade.trim() != 'y'}">
							<button type="button" class="btn btn-warning" onclick="location.href='./myPage/myPageView.jsp'">마이페이지</button>	
							<input type="hidden" value="${grade}">
						</c:if>
					</c:if>				
					
				</div>
			</nav>
		</div>
	</header>
	<br/><br/><br/>

<!-- header 끝  -->


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
	<br/><br/><br/><br/><br/>
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
</div>
<div class="clear">
</div>


<!-- footer  -->
<hr/>
	<footer>
		<div class="container" style="background-color: #e7e7e7; color: #777;">
			<div class="row">
				<div class="col-sm-3">
					copyright &copy;김철수 all rights reserved<br/>
					사업자 등록번호 123456-123-456789
				</div>
				<div class="col-sm-3">
					고객센터
					02-123-4567<br/>
				</div>
				<div class="col-sm-3">
					내용입니다.<br/>
					내용입니다.<br/>
					내용입니다.
				</div>
				<div class="col-sm-3">
					내용입니다.<br/>
					내용입니다.<br/>
					내용입니다.
				</div>
			</div>
		</div>
	</footer>
<!-- footer 끝 -->



	









		<!--   <div class="form-check mb-3">
		    <label class="form-check-label">
		      <input class="form-check-input" type="checkbox" name="remember"> Remember me
		    </label>
		  </div>
		  

</div> -->

</body>
</html>