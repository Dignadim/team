<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="./images/favicon.png"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
</head>
<body>

	<!-- header -->
	<header>
		<div class="container-fluid">
			<nav class="navbar navbar-expand-sm bg-light">
				<div class="col-sm-2">
					<a href="./"><img src="./images/teamlogo.png" style="width: 30px;"></a>
				</div>
				<div class="container-fluid col-sm-6">
					<ul class="navbar-nav">
						<li class="nav-item" style="padding: 5px 45px;">
					    	<a class="nav-link" href="./item/list">모든 상품 보기</a>
					    </li>					
						<li class="nav-item dropdown" style="padding: 5px 45px;">
							<a class="nav-link" href="./event/list">모든 행사 보기</a>
						</li>
						<li class="nav-item dropdown" style="padding: 5px 45px;">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">게시판</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="./free/list">자유게시판</a></li>
								<li><a class="dropdown-item" href="./rank/view">랭킹게시판</a></li>
								<li><a class="dropdown-item" href="./new/view">신상게시판</a></li>
							</ul>
						</li>
						<li class="nav-item dropdown" style="padding: 5px 45px;">
							<a class="nav-link" href="map">편의점 찾기</a>
						</li>
					</ul>
				</div>
				<!-- 검색은 추후 구현 -->
				<div class="col-sm-2">
					<input type="text" class="form-control" placeholder="검색할 내용을 입력하세요." style="width: 200px; display: none;">
					<button type="button" class="btn btn-primary" onclick="#" style="display:none;">검색</button>
					<c:if test="${id != null}">
						<div align="right" style="vertical-align: middle;"><b>${nickname}</b>님, 반갑습니다!&nbsp;&nbsp;&nbsp;</div>
					</c:if>
				</div> 
				<div class="col-sm-2">
					<c:if test="${id == null}">
						<button type="button" class="btn btn-primary" onclick="location.href='./member/login'">로그인</button>	
					</c:if>				
					<c:if test="${id != null}">
						<button type="button" class="btn btn-danger" onclick="location.href='./member/logout'">로그아웃</button>
						<c:if test="${grade.trim() != null && grade.trim() == 'y'}">
							<button class="btn btn-info" style="padding: 6px;" onclick="location.href='./member/admin'">관리 페이지로</button>	
						</c:if>
						<c:if test="${grade.trim() == null || grade.trim() != 'y'}">
							<button type="button" class="btn btn-warning" onclick="location.href='./member/myPage'">마이페이지</button>	
							<input type="hidden" value="${grade}">
						</c:if>
					</c:if>				
					
				</div>
			</nav>
		</div>
	</header>
	<br/><br/><br/>

	<c:if test="${msg != null}">
		<script type="text/javascript">
		alert('${msg}');
		</script>
	</c:if>

</body>
</html>