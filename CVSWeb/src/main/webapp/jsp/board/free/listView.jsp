<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 보기</title>
<link rel="icon" href="../../../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../../../css/listView.css"/>
<style type="text/css">


	
</style>
</head>
<body>

	<header>
		<div class="container">
			<nav class="navbar navbar-expand-sm bg-light">
				<div class="col-sm-2">
					<h2 style="width: 200px;">타이틀</h2>
				</div>
				<div class="container-fluid col-sm-5">
					<ul class="navbar-nav">
						<li class="nav-item" style="padding-right: 70px;">
					    	<a class="nav-link" href="#">모든 상품 보기</a>
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
					<button class="btn btn-info" onclick="#">관리 페이지로</button>					
				</div>
			</nav>
		</div>
	</header>

	<div class="m-3">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">
			<tr class="table-secondary">
				<th colspan="5" style="font-size: 30px; text-align: center;">자유게시판</th>
			</tr>
			<tr class="table-secondary">
				<td colspan="5" align="right"> 
					${freeboardList.totalCount}(${freeboardList.currentPage} / ${freeboardList.totalPage})
				</td>
			</tr>
			<tr class="table-secondary">
				<th style="width: 150px; text-align: center;">번호</th>
				<th style="width: 560px; text-align: center;">제목</th>
				<th style="width: 70px; text-align: center;">닉네임</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>
			<jsp:useBean id="date" class="java.util.Date"/>
			
			<!-- 공지글 -->
			<c:if test="${currentPage == 1}">
			<c:forEach var="fb_vo" items="${fb_notice}">
				<tr class="table-warning">
					<td align="center">
						<i class="bi bi-envelope-exclamation-fill"></i>
					</td>
					<td>
						<i class="bi bi-tags"></i>
						<c:set var="fb_subject" value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}"/>
						<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}"/>
						
						<a href="increment.jsp?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">
							${fb_subject} (${fb_vo.fb_commentCount})
						</a>
						
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<img alt="New" src="../../../images/ic_new.gif"/>
						</c:if>
						
						<c:if test="${fb_vo.fb_hit > 100}">
							<img alt="hot" src="../../../images/hot.gif"/>
						</c:if>
					</td>
					<td align="center">
<%-- 						<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
						<c:set var="name" value="${fn:replace(vo.name, '>', '&gt;')}"/> --%>
						nickname
					</td>
					<td align="center">
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm"/>
						</c:if>
						<c:if test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="yyyy.MM.dd(E)"/>
						</c:if>
					</td>
					<td align="center">
						${fb_vo.fb_hit}
					</td>
				</tr>
			</c:forEach>
			</c:if>
			
			<c:set var="list" value="${freeboardList.list}"/>
			
			<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="5">
					<marquee>테이블에 저장된 글이 없습니다.</marquee>
				</td>
			</tr>		
			</c:if>

			<c:if test="${list.size() != 0}">
			<c:set var="num" value="${freeboardList.totalCount - ((freeboardList.currentPage-1) * 10) }"/>
			<c:forEach var="fb_vo" items="${list}">
			<tr>
				<td align="center">
					${num}
				</td>
				<td>
					<i class="bi bi-tags"></i>
					<c:set var="fb_subject" value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}"/>
					<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}"/>
						
					<a href="increment.jsp?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">
						${fb_subject} (${fb_vo.fb_commentCount})
					</a>
						
					<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
						<img alt="New" src="../../../images/ic_new.gif"/>
					</c:if>
						
					<c:if test="${fb_vo.fb_hit > 100}">
						<img alt="hot" src="../../../images/hot.gif"/>
					</c:if>
				</td>
				<td align="center">
					nickname
				</td>
				<td align="center">
					<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
						<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm"/>
					</c:if>
					<c:if test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
						<fmt:formatDate value="${fb_vo.fb_date}" pattern="yyyy.MM.dd(E)"/>
					</c:if>
				</td>
				<td align="center">
					${fb_vo.fb_hit}
				</td>
			</tr>	
			<c:set var="num" value="${num-1}"/>		<!--  -->
			</c:forEach>
			</c:if>

			<tr>
				<td colspan="5" align="center">
					<c:if test="${freeboardList.currentPage > 1}">
						<button 
							class="btn btn-outline-secondary" 
							type="button" 
							title="첫 페이지로 이동합니다."
							onclick="location.href='?currentPage=1'"
						>처음</button> 
					</c:if>
					<c:if test="${freeboardList.currentPage <= 1}">
						<button 
							class="btn btn-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 페이지입니다."
						>처음</button>
					</c:if>
					
					<c:if test="${freeboardList.startPage > 1}">
						<button 
							class="btn btn-outline-secondary"
							type="button" 
							title="이전 10페이지로 이동합니다."
							onclick="location.href='?currentPage=${freeboardList.startPage - 1}'"
						>이전</button>
					</c:if>
					<c:if test="${freeboardList.startPage <= 1}">
						<button 
							class="btn btn-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 10페이지입니다."
						>이전</button>
					</c:if>
					
					<c:forEach var="i" begin="${freeboardList.startPage}" end="${freeboardList.endPage}" step="1">
						<c:if test="${freeboardList.currentPage == i}">
							<button 
								class="btn btn-outline-secondary" 
								type="button" 
								disabled="disabled"
							>${i}</button> 
						</c:if>
						<c:if test="${freeboardList.currentPage != i}">
							<button 
								class="btn btn-outline-secondary" 
								type="button" 
								onclick="location.href='?currentPage=${i}'"
							>${i}</button>
						</c:if>
					</c:forEach>
				
					<c:if test="${freeboardList.endPage < freeboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						title="다음 10페이지로 이동합니다."
						onclick="location.href='?currentPage=${freeboardList.endPage + 1}'"
					>다음</button>
					</c:if>
					<c:if test="${freeboardList.endPage >= freeboardList.totalPage}">
					<button 
						class="btn btn-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 10페이지입니다."
					>다음</button>
					</c:if>
					
					<c:if test="${freeboardList.currentPage < freeboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						title="마지막 페이지로 이동합니다."
						onclick="location.href='?currentPage=${freeboardList.totalPage}'"
					>끝</button>
					</c:if>
					<c:if test="${freeboardList.currentPage >= freeboardList.totalPage}">
					<button 
						class="btn btn-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 페이지입니다."
					>끝</button>
					</c:if>
				</td>
			</tr>
			<tr class="table-secondary">
				<td colspan="5" align="right">
				<!-- 
					만약 로그인 하지 않고 누르는 경우 alert('회원만 이용 가능한 서비스입니다.')
					alert가 나온 후 바로 로그인 모달창 띄우기
				  -->
					<input class="btn btn-outline-primary btn-sm" type="button" value="글쓰기" 
						 onclick="location.href='insert.jsp'"/>
				</td>
			</tr>
		</table>
	</div>
	<footer>
		<div class="container" style="background-color: #e7e7e7; color: #777;">
			<div class="row">
				<div class="col-sm-3">
					copyright 김철수 all rights reserved<br/>
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