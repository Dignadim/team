<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="icon" href="../images/favicon.png"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript" src="../js/main.js" defer></script>
</head>
<body>
	<jsp:useBean id="date" class="java.util.Date"/>
	<!-- header -->
	<header>
		<div class="container-fluid">
			<nav class="navbar navbar-expand-sm bg-light">
				<div class="col-sm-2">
					<a href="connectMain.jsp"><img src="../images/teamlogo.png" style="width: 30px;"></a>
				</div>
				<div class="container-fluid col-sm-5">
					<ul class="navbar-nav">
						<li class="nav-item" style="padding-right: 70px;">
					    	<a class="nav-link" href="./item/itemList.jsp?">모든 상품 보기</a>
					    </li>					
						<li class="nav-item dropdown" style="padding-right: 70px;">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">행사 보기</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="./board/event/list.jsp">모든 행사 보기</a></li>
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
								<li><a class="dropdown-item" href="./board/rank/rank.jsp">랭킹게시판</a></li>
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
							<button class="btn btn-info" style="padding: 6px;" onclick="location.href='./admin/connectadmin.jsp'">관리 페이지로</button>	
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
	
	<div class="container">
		<div class="panel-heading">
			<h3 class="panel-title">
				&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 행사 목록
			</h3>
		</div>
		<div class="container">
			<div>
				<table class="table">
					<thead class="table-primary">
						<tr>
							<td align="center" width="250px">편의점</td>
							<td align="center">행사 내용</td>
						</tr>
					</thead>
					<tbody>
						<c:set var="evList" value="${evList.list}"/>
						<c:forEach var="ev_vo" items="${evList}">
							<tr>
								<td align="center">
									<c:if test="${ev_vo.ev_sellcvs.trim() == 'CU'}">
										<img alt="CU logo" src="../images/cu.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == 'GS25'}">
										<img alt="GS logo" src="../images/gs25.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == '세븐일레븐'}">
										<img alt="711 logo" src="../images/7eleven.png" height="25px"><br/>						
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == 'ministop'}">
										<img alt="mini logo" src="../images/ministop.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == '이마트24'}">
										<img alt="emart logo" src="../images/emart24.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == '기타 편의점' || ev_vo.ev_sellcvs.trim() == '기타편의점'}">
										<img alt="other logo" src="../images/other.png" height="25px"><br/>
									</c:if>
								</td>
								<td><a href="./board/event/increment.jsp?ev_idx=${ev_vo.ev_idx}&currentPage=1">${ev_vo.ev_subject}</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button type="button" class="btn btn-primary" onclick="location.href='./board/event/list.jsp'">모든 행사 보러가기</button>
			</div>
		</div><br/><br/><br/><br/>
			
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 행사 상품
				</h3>
			</div>
			<div class="container"  style="margin-top: 20px; padding: 5px 20px;">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<div style="width: 1000px; padding: 30px; overflow: auto"  align="center" class="bg-light"> <!-- 스크롤 -->
								<table class="table">
									<tr>
										<td style="padding: 20px"><img alt="alt" src="../images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="../images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="../images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="../images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="../images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="../images/img02.jpg" width="150px"></td>
										<td style="padding: 20px"><img alt="alt" src="../images/img02.jpg" width="150px"></td>
									</tr>
									<tr>
										<td>
											<h5><a href="connectMain.jsp">새우깡</a><span><img alt="CU logo" src="../images/cu.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="connectMain.jsp">새우깡</a><span><img alt="gs logo" src="../images/gs25.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="connectMain.jsp">새우깡</a><span><img alt="711 logo" src="../images/7eleven.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="connectMain.jsp">새우깡</a><span><img alt="mini logo" src="../images/ministop.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="connectMain.jsp">새우깡</a><span><img alt="emart logo" src="../images/emart24.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="connectMain.jsp">새우깡</a><span><img alt="other logo" src="../images/other.png" height="20px;" align="right"></span></h5>
											1+1
										</td>
										<td>
											<h5><a href="connectMain.jsp">새우깡</a><span><img alt="logo" src="../images/cu.png" height="20px;" align="right"></span></h5>
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
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 인기 상품 TOP5
					<c:set var="list" value="${itemTOP5.list}"/>
				</h3>				
			</div>
			<div class="container"  style="margin-top: 20px; padding: 5px 20px;"  align="center">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<table class="table bg-light">
								<thead class="table-primary">
									<tr>
										<c:forEach var="vo" items="${list}" varStatus="i">
											<td>${i.count}위</td>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
									<tr>
										<c:forEach var="vo" items="${list}">
											<td><img style="border-radius: 10px;" alt="alt" src="${vo.itemImage}" height="150px"></td>
										</c:forEach>
									</tr>
									<tr>
										<c:forEach var="vo" items="${list}">
										<td>
											<h4><a href="./item/itemIncrement.jsp?idx=${vo.idx}&job=itemView">${vo.itemName}</a></h4>
											${vo.eventType}
										</td>
										</c:forEach>									
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>	
			</div><br/><br/><br/><br/>
		
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 ${date.date}일 인기 게시글
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
									<c:set var="freeHitList" value="${freeHitList.list}"/>
									<c:forEach var="fb_vo" items="${freeHitList}" varStatus="i">
										<tr>
											<td>${i.count}</td>
											<td>(테스트)</td>
											<td>
												<a href="./board/free/increment.jsp?fb_idx=${fb_vo.fb_idx}&currentPage=1">${fb_vo.fb_subject}</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<button type="button" class="btn btn-primary" onclick="location.href='./board/free/list.jsp'" align="right">인기글 보러가기</button>
					</div>
				</div>	
		</div><br/><br/><br/><br/>
	</div>
	</div>
	<!-- footer  -->
	<footer>
		<div class="container-fluid" style="background-color: #f8f9fa; color: #777;">
			<div class="row" style="padding: 30px; font-size: 16px;" align="center">
				<div class="col-sm-3">
					&nbsp;
				</div>
				<div class="col-sm-6">
					<br/>
					&copy;4조&nbsp;&nbsp;최성민&nbsp;&nbsp;길동현&nbsp;&nbsp;김민주&nbsp;&nbsp;신수혁&nbsp;&nbsp;최형록
					&nbsp;<br/>
				</div>
				<div class="col-sm-3">
					&nbsp;
				</div>
			</div>
		</div>
	</footer>

</body>
</html>