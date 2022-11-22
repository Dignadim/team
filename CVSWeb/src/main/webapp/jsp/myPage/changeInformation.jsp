<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../../css/myPageView.css">
<script type="text/javascript" src="../../js/myPage.js"></script>
</head>
<body>
	<!-- header -->
	<header>
		<div class="container-fluid">
			<nav class="navbar navbar-expand-sm bg-light">
				<div class="col-sm-2">
					<a href="../connectMain.jsp"><img src="../../images/teamlogo.png" style="width: 30px;"></a>
				</div>
				<div class="container-fluid col-sm-5">
					<ul class="navbar-nav">
						<li class="nav-item" style="padding-right: 70px;">
					    	<a class="nav-link" href="itemList.jsp?">모든 상품 보기</a>
					    </li>					
						<li class="nav-item dropdown" style="padding-right: 70px;">
							<a class="nav-link" href=".././board/event/list.jsp">모든 행사 보기</a>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">게시판</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="../board/free/list.jsp">자유게시판</a></li>
								<li><a class="dropdown-item" href="../board/rank/rank.jsp">랭킹게시판</a></li>
								<li><a class="dropdown-item" href="../board/new/new.jsp">신상게시판</a></li>
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
						<button type="button" class="btn btn-primary" onclick="location.href='../logRegi/login_form.jsp'">로그인</button>	
					</c:if>				
					<c:if test="${id != null}">
						<button type="button" class="btn btn-danger" onclick="location.href='../logRegi/login_out.jsp'">로그아웃</button>
						<c:if test="${grade.trim() != null && grade.trim() == 'y'}">
							<button class="btn btn-info" style="padding: 6px;" onclick="location.href='../admin/connectadmin.jsp'">관리 페이지로</button>	
						</c:if>
						<c:if test="${grade.trim() == null || grade.trim() != 'y'}">
							<button type="button" class="btn btn-warning" onclick="location.href='../myPage/myPageView.jsp'">마이페이지</button>	
							<input type="hidden" value="${grade}">
						</c:if>
					</c:if>					
				</div>
			</nav>
		</div>
	</header>
	<br/><br/>

<div class="m-3">
<jsp:useBean id="date" class="java.util.Date"/>
	<div id= "wrap">
	<nav style="display: none;">메뉴영역</nav>
		<div id="content">
			<div class="b">
				<div class="container mt-3" align="center" style="vertical-align: middle;">
					<div style="padding: 80px 20px;">
						<img src="../../images/img03.jpg" alt="프로필사진" id="profile">
						<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="file">
					</div>
					<h2 style="padding-bottom: 15px">프로필 사진 수정</h2>
					<div align="center">
						<textarea class="form-control" id="selfIntroduce" style="resize: none; width: 500px; margin: 15px;" placeholder="자기소개를 입력하세요." rows="3"></textarea>
					</div>
				</div>
			</div>
		<div class="b"> 
			<form id=f action="./selectById.jsp"  method="post"  align="center" onsubmit="return checkInfo(this);"><br /><br /><br /><br /><br />
				<table class="table table-bordered" align="center" style="width: 500px; vertical-align: middle; margin: 20px; border-radius: 5px;">
					<tr height="70px">
						<th style="vertical-align: middle;">ID</th>
						<td align="left">${id}</td>
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="nickname" class="form-label">닉네임</label></th>
						<td>
							<input class="form-control id="nickname" name="nickname" type="text" value="${nickname}">
						</td>
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="email" class="form-label">이메일</label></th>
						<td>
							<input class="form-control id="email" name="email" type="email" value="${email}">
						</td>
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;">가입일자</th>
						<td align="left">
							${signupdate.year + 1900} - ${signupdate.month + 1} - ${signupdate.date}
						</td>
					</tr> 
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="password" class="form-label">비밀번호 변경</label></th>
						<td>
							<input class="form-control id="password" name="password" type="password" value="${password}">
						</td>
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="password2" class="form-label">비밀번호 확인</label></th>
						<td>
							<input class="form-control id="password2" name="password2" type="password" value="${password}">
						</td>
					</tr>				
					<tr>
						<td colspan="2" align="center">		   
							<button
								style="margin: 5px;"
								class="btn btn-outline-warning"
								type= "submit"
								title="정보수정"
								>정보수정</button>	
							<button
								style="margin: 5px;"
								class="btn btn-outline-info"
								type= "reset"
								title="원래대로"
								>원래대로</button>	
							<button
								style="margin: 5px;"
								class="btn btn-outline-secondary"
								type= "button"
								title="돌아가기"
								onclick="history.back()"
								>돌아가기</button>	
							</td>
						</tr>			
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="clear">&nbsp;</div>
<input type="hidden" name="id" value="${id}"/> 

	<!-- footer  -->
	<footer>
		<div class="container-fluid"
			style="background-color: #f8f9fa; color: #777;">
			<div class="row" style="padding: 30px; font-size: 16px;"
				align="center">
				<div class="col-sm-3">&nbsp;</div>
				<div class="col-sm-6">
					<br />
					&copy;4조&nbsp;&nbsp;최성민&nbsp;&nbsp;길동현&nbsp;&nbsp;김민주&nbsp;&nbsp;신수혁&nbsp;&nbsp;최형록
					&nbsp;<br />
				</div>
				<div class="col-sm-3">&nbsp;</div>
			</div>
		</div>
	</footer>

</body>
</html>