<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../../css/adminpage.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>
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

<div class="body1">
<!-- 버그리포트 게시글을 이곳에 표시  -->
QNA/버그리포트
</div>

<div class="body1">
<!-- 각 게시판에 썻던 공지글이 나오게

ex) 자유게시판
	공지 : ~~
	공지 : ~~
	
	상품게시판
	공지 : ~
	공지 : ~
	
	이런식으로
  -->
게시판 관리
</div>


<div class="clear"></div>


<div class="body1">
<!-- 회원들의 정보와 쓴 글목록, 쓴 댓글, 차단상태등을 표시   -->
회원관리
</div>

<div class="body1">
<!-- 한달 단위로 신규회원가입시 표시  -->
신규회원표시
</div>

<div class="body2">
<!-- 캘린더에 행사기간이 나오는 표시  -->
캘린더 구현
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


</body>
</html>