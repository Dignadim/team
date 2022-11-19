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
<script type="text/javascript" src="./js/adminmember.js" defer></script>
</head>
<body>

	<jsp:useBean id="date" class="java.util.Date"/>
	
	
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
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">행사 보기</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href=".././board/event/list.jsp">모든 행사 보기</a></li>
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
								<li><a class="dropdown-item" href="../board/free/list.jsp">자유게시판</a></li>
								<li><a class="dropdown-item" href="../board/rank/rank.jsp">랭킹게시판</a></li>
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
						<button type="button" class="btn btn-primary" onclick="location.href='../logRegi/login_form.jsp'">로그인</button>	
					</c:if>				
					<c:if test="${id != null}">
						<button type="button" class="btn btn-danger" onclick="location.href='../logRegi/login_out.jsp'">로그아웃</button>
						<c:if test="${grade.trim() != null && grade.trim() == 'y'}">
							<button class="btn btn-info" style="padding: 6px;" onclick="../item/itemInsert.jsp">관리 페이지로</button>	
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

<!-- header 끝  -->


<div id="contentLeft">
	<div class="body1">
		<!-- 가입된지 1달이하의 회원을 idx역순으로 표시   -->
		<c:set var="list" value="${memberList.list}"/>
			
		<table class="table" style="width: 100%;">
		<tr class="table-secondary">
		<th colspan="2" style="font-size: 20px; text-align: center;">신규가입</th>
		</tr>
				<c:forEach var="mb_vo" items="${list}">
			<c:if test="${date.year == mb_vo.signupdate.year && date.month == mb_vo.signupdate.month}">
					<tr>
						<th align= center>
							<img style ="width:30px;" alt="프로필사진" src="../../images/profile.jpg">
						</th>
						<th align="center">
							${mb_vo.nickname}님이 새로 가입하셧습니다.
						</th>	
					</tr>
			</c:if>
				</c:forEach>
		</table>
	</div>

	<div class="body1">	
	<!-- 회원 관리  -->
	
	<c:set var="list" value="${memberList.list}"/>
			
		<table class="table" style="width: 100%; border: 1px solid black;">
		
		
		<tr class="table-secondary">
		<th colspan="5" style="font-size: 20px; text-align: center;">회원관리</th>
		
		</tr>
		<tr>
		<th colspan="5">
		<select class="form-select" width="100" onchange="memberCheck()" id="memberCheck">
		
						<option selected>모든 회원</option>
						<option>관리자</option>
						<option>일반 회원</option>
						<option>경고 회원</option>
						<option>차단 회원</option>
		</select>
		</th>
		
		</tr>
		
			<tr>
			<th>아이디</th>
			<th>닉네임</th>
			<th>이메일</th>
			<th>가입일</th>
			<th>상태(경고)</th>
			</tr>
				<!-- <div id = "listOfMember"> -->
				<c:forEach var="mb_vo" items="${list}">
				
					<tr>
			
						<td align= center>
							${mb_vo.id}
						</td>
						<td align="center">
							${mb_vo.nickname}
						</td>
						<td align="center">
							${mb_vo.email}
						</td>
						<td align="center">
							<fmt:formatDate value="${mb_vo.signupdate}" pattern="yyyy.MM.dd"/>
						</td>
						<td align="center">
							${mb_vo.grade}
						</td>	
			
					</tr>
				</c:forEach>
				<!-- </div> -->
		</table>
		
				<div class="col-sm-2">
					<input type="text" class="form-control" placeholder="아이디 입력하세요." style="width: 200px;">
				</div> 
				<div class="col-sm-1">
					<button type="button" class="btn btn-primary" btn-modal" onclick="memberAdministrate()">검색</button>
				</div>
		
	</div>
	
	
	
	
	</div>
	
	


<div id="contentRight">
	<div class="body3">
	<!-- 각 게시판에 썻던 공지글이 나오게
	
	ex) 자유게시판
		공지 : ~~
		공지 : ~~
		
		상품게시판
		공지 : ~
		공지 : ~
		
		이런식으로
	  -->
	<table class="table" style="width: 100%; margin-left: auto; margin-right: auto; max-width : 800px;">
				<tr class="table-secondary">
					<th colspan="5" style="font-size: 20px; text-align: center;">공지글</th>
				</tr>
				
				<tr class="table-secondary">
					<th style="width: 125px; text-align: center;">게시판이름</th>
					<th style="width: 425px; text-align: center;">제목</th>
					<th style="width: 125px; text-align: center;">닉네임</th>
					<th style="width: 125px; text-align: center;">작성일</th>
				</tr>
				
				

		
				<c:set var="list" value="${freeboardList.list}"/>
				
				<c:if test="${list.size() == 0}">
				<tr>
					<td colspan="5">
						<marquee>테이블에 저장된 글이 없습니다.</marquee>
					</td>
				</tr>		
				</c:if>
	
				<c:if test="${list.size() != 0}">
				
				<c:forEach var="fb_vo" items="${list}">
				<tr>
					<td align="center">
						자유게시판
					</td>
					<td align="center">
						<i class="bi bi-tags"></i>
						<c:set var="fb_subject" value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}"/>
						<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}"/>
							
						<a href="../board/free/selectByIdx.jsp?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}&job=contentView">
							${fb_subject} (${fb_vo.fb_commentCount})
						</a>
							
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<img alt="New" src="../../images/ic_new.gif"/>
						</c:if>
							
						
					</td>
					<td align="center">
						닉네임
					</td>
					<td align="center">
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm"/>
						</c:if>
						<c:if test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="yyyy.MM.dd(E)"/>
						</c:if>
					</td>
					
				</tr>	
				
				</c:forEach>
				</c:if>
	
				
			</table>

	</div>
</div>
	
	
	

	
	
	
	
	
	
	
	<div class="body2">
	<!--  월 방문자 표시 그래프 -->
	그래프 구현
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