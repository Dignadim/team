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
<link rel="stylesheet" href="./css/main.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>

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
					    	<a class="nav-link" href="itemList.jsp">모든 상품 보기</a>
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
								<li><a class="dropdown-item" href="#">자유게시판</a></li>
								<li><a class="dropdown-item" href="#">랭킹게시판</a></li>
								<li><a class="dropdown-item" href="#">신상게시판</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="col-sm-2">
					<input type="text" class="form-control" placeholder="검색할 내용을 입력하세요." style="width: 200px;">
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-primary" onclick="#">검색</button>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary" onclick="location.href='login.jsp'">로그인</button>					
					<!-- 관리자만 보이는 부분 -->
					<button class="btn btn-info" onclick="location.href='itemInsert.jsp'">상품 등록</button>					
				</div>
			</nav>
		</div>
	</header>
	<br/><br/><br/>
	
	
	<div class="container">
		<div class="panel-heading">
			<h3 class="panel-title">
				&nbsp;&nbsp;&nbsp;2022년 11월 행사 목록
			</h3>
		</div>
		<div class="container">
			<div>
				<table class="table">
					<thead class="table-primary">
						<tr>
							<td>편의점</td>
							<td>내용</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><img alt="CU logo" src="./images/cu.png" height="20px;" align="left"></td>
							<td>CU 첫 회원가입시 5000원 할인 쿠폰 증정!</td>
						</tr>
						<tr>
							<td><img alt="CU logo" src="./images/gs25.png" height="20px;" align="left"></td>
							<td>GS25 첫 회원가입시 5000원 할인 쿠폰 증정!</td>
						</tr>
						<tr>
							<td><img alt="CU logo" src="./images/emart24.png" height="20px;" align="left"></td>
							<td>11월 18일 단 하루! 새우깡이 600원!</td>
						</tr>
					</tbody>
				</table>
				<button type="button" class="btn btn-primary" onclick="#">모든 행사 보러가기</button>
			</div>
		</div><br/><br/><br/><br/>
			
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;2022년 11월 행사 상품
				</h3>
			</div>
			<div class="container"  style="margin-top: 20px; padding: 5px 50px;">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<div style="width: 1000px; padding: 30px; overflow: auto"  align="center" class="bg-light"> <!-- 스크롤 -->
								<table class="table">
									<tr>
										<td style="padding: 20px"><img alt="alt" src="./images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="./images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="./images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="./images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="./images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="./images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="./images/img02.jpg" width="150px"></td>
									</tr>
									<tr>
										<td>
											<h5><a href="main.jsp">새우깡</a><span><img alt="CU logo" src="./images/cu.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="main.jsp">새우깡</a><span><img alt="gs logo" src="./images/gs25.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="main.jsp">새우깡</a><span><img alt="711 logo" src="./images/7eleven.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="main.jsp">새우깡</a><span><img alt="mini logo" src="./images/ministop.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="main.jsp">새우깡</a><span><img alt="emart logo" src="./images/emart24.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="main.jsp">새우깡</a><span><img alt="other logo" src="./images/other.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="main.jsp">새우깡</a><span><img alt="logo" src="./images/cu.png" height="20px;" align="right"></span></h5>
											1+1
										</td>

									</tr>
								</table>
							</div><br/>								
							<h4>편의점별 보기</h4>	
							<div>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="CU"> CU</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="GS25"> GS25</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="세븐일레븐"> 세븐일레븐</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="ministop"> ministop</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="이마트24"> 이마트24</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="기타편의점"> 기타 편의점</span>
							</div><br/>		
							<h4>행사별 보기</h4>	
							<div>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="1+1"> 1+1</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="2+1"> 2+1</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="카드사할인"> 카드사 할인</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="포인트적립"> 포인트 적립</span>							
							</div>
						</div>
					</div>
				</div>	
			</div>
			
			<br/><br/><br/><br/>

			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;2022년 11월 인기 상품 TOP5
				</h3>				
			</div>
			<div class="container"  style="margin-top: 20px; padding: 5px 50px;"  align="center">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<table class="table bg-light">
								<tr>
									<td><img alt="alt" src="./images/img02.jpg" width="150px"></td>
									<td><img alt="alt" src="./images/img02.jpg" width="150px"></td>
									<td><img alt="alt" src="./images/img02.jpg" width="150px"></td>
									<td><img alt="alt" src="./images/img02.jpg" width="150px"></td>
									<td><img alt="alt" src="./images/img02.jpg" width="150px"></td>
								</tr>
								<tr>
									<td>
										<h4><a href="main.jsp">새우깡</a></h4>
										1+1
									</td>
									<td>
										<h4><a href="main.jsp">새우깡</a></h4>
										1+1
									</td>
									<td>
										<h4><a href="main.jsp">새우깡</a></h4>
										1+1
									</td>
									<td>
										<h4><a href="main.jsp">새우깡</a></h4>
										1+1
									</td>
									<td>
										<h4><a href="main.jsp">새우깡</a></h4>
										1+1
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>	
			</div><br/><br/><br/><br/>
		
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;2022년 11월 8일 인기 게시글
				</h3>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<table class="table" style="margin-top: 20px;">
								<thead class="table-primary">
									<tr>
										<td width="200px">인기 순위</td>
										<td width="300px">닉네임</td>
										<td width="800px">제목</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>홍길동</td>
										<td>
											<a href="#">글 제목</a>
										</td>
									</tr>
									<tr>
										<td>2</td>
										<td>장길산</td>
										<td>
											<a href="#">글 제목</a>
										</td>						
									</tr>
									<tr>
										<td>3</td>
										<td>임꺽정</td>
										<td>
											<a href="#">글 제목</a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<button type="button" class="btn btn-primary" onclick="#" align="right">인기글 보러가기</button>
					</div>
				</div>	
		</div><br/><br/><br/><br/>
</div>
	</div>
	<!-- footer  -->
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

</body>
</html>