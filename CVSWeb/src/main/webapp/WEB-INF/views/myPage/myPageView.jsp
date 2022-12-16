<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 뷰</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="./css/myPageView.css">
<script type="text/javascript" src="./js/myPage.js"></script>
</head>
<body>
	<!-- header -->
	<%@ include file="../util/hfer/header.jsp" %>
	<br/><br/>

	<!-- header 끝  -->
	<!-- alert창을 띄울 메시지가 있으면 여기에 받아짐 -->
	<input type="hidden" id="msg" value="${msg}">

	<c:if test="${id != null}">	
	<div class="m-3">
		<jsp:useBean id="date" class="java.util.Date" />
		<div id="wrap">
			<nav style="display: none;">메뉴영역</nav>
			<div id="content">
				<div class="b">
					<div class="container mt-3" align="center" style="vertical-align: middle;">
						<div style="padding: 80px 20px;">
							<img src="./images/img03.jpg" alt="프로필사진" id="profile">
						</div>
						<h2 style="padding-bottom: 15px">프로필 사진</h2>
						<div style="width: 450px; height: 200px;">회원 자기소개</div>
					</div>
				</div>
				<div class="b">
					<form id=f action="changeInformation" method="post"	align="center"><br /><br /><br /><br /><br />
						<table class="table table-borderless table-hover" align="center" style="width: 500px; vertical-align: middle; margin: 20px; border-radius: 5px;">
							<tr height="70px">
								<th>ID</th>
								<td>${id}</td>
							</tr>
							<tr height="70px">
								<th>닉네임</th>
								<td>${nickname}</td>
							</tr>
							<tr height="70px">
								<th>이메일</th>
								<td>${email}</td>
							</tr>
							<tr height="70px">
								<th>가입일자</th>
								<td>${signupdate.year + 1900} - ${signupdate.month + 1} - ${signupdate.date}</td>
							</tr>
							<tr height="70px">
								<th>자기소개</th>
								<td>회원 자기소개 내용</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<button style="margin: 5px;" class="btn btn-outline-warning" type="submit" title="정보수정">정보수정</button>
									<button style="margin: 5px;" class="btn btn-outline-info" type="button" title="쪽지함"
										onclick="location.href=noteBox.jsp">쪽지함 (차후 구현)</button>
									<button style="margin: 5px;" class="btn btn-outline-secondary" type="button" title="돌아가기"
										onclick="history.back()">돌아가기</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div><br/><br/><br/>
	</div>
	</c:if>
	<c:if test="${id == null}">
		<script type="text/javascript">
			alert('적절하지 않은 접근입니다.');
			location.href='main';
		</script>
	</c:if>
	<div class="clear">&nbsp;</div>

	<!-- footer  -->
	<%@ include file="../util/hfer/footer.jsp" %>
	<!--   <div class="form-check mb-3">
		    <label class="form-check-label">
		      <input class="form-check-input" type="checkbox" name="remember"> Remember me
		    </label>
		  </div>
		  

</div> -->

</body>
</html>