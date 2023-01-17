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
<link rel="icon" href="../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../css/freeboard.css"/>
<script type="text/javascript" src="../js/freeboard.js" defer="defer"></script>
</head>
<body onload="fixSelected()">

<!-- header -->
<%@ include file="../../util/hfer/header.jsp" %>

	<div class="m-3">
		<table class="table table-bordered" style="width: 1000px; margin-left: auto; margin-right: auto;">
			<tr class="table-primary">
				<th colspan="5" style="font-size: 30px; text-align: center;">자유게시판</th>
			</tr>
			<tr>
				<td colspan="5">
					<form action="list" method="post" name="searchForm">
						<input id="beforeCategory" type="hidden" name="beforeCategory" value="${category}"/>
						<select class="form-select" id="category" name="category" style="width: 130px; display: inline !important;">
							<option>제목</option>
							<option>내용</option>
							<option>제목+내용</option>
							<option>닉네임</option>
						</select>
						<input class="form-control" type="text" id="searchText" name="searchText" value="${searchText}" style="width: 200px; padding-left: 10px; display: inline !important;"/>
						<input class="btn btn-primary searchBtn" type="submit" value="검색"/>
						<button class="btn btn-outline-secondary" onclick="backPage()">돌아가기</button>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="5" align="right"> 
					${freeboardList.totalCount}건 (${freeboardList.currentPage} / ${freeboardList.totalPage})
				</td>
			</tr>
			<tr class="table-light">
				<th style="width: 100px; text-align: center;">번호</th>
				<th style="width: 560px; text-align: center;">제목</th>
				<th style="width: 120px; text-align: center;">닉네임</th>
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
						
						<a href="increment?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">
							${fb_subject} (${fb_vo.fb_commentCount})
						</a>
						
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<img alt="New" src="../images/ic_new.gif"/>
						</c:if>
						
						<c:if test="${fb_vo.fb_hit > 100}">
							<img alt="hot" src="../images/hot.gif"/>
						</c:if>
					</td>
					<td align="center">
						<a class="profileView" onclick="profileView('${fb_vo.id}')">
							${fb_vo.nickname}
						</a>							
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
						
					<a href="increment?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">
						${fb_subject} (${fb_vo.fb_commentCount})
					</a>
						
					<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
						<img alt="New" src="../images/ic_new.gif"/>
					</c:if>
						
					<c:if test="${fb_vo.fb_hit > 100}">
						<img alt="hot" src="../images/hot.gif"/>
					</c:if>
				</td>
				<td align="center">
					<a class="profileView" onclick="profileView('${fb_vo.id}')">
						${fb_vo.nickname}
					</a>						
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
			<c:set var="num" value="${num-1}"/>	
			</c:forEach>
			</c:if>

			<tr align="center" class="table table-light">
				<td colspan="4" align="center">
					<c:if test="${freeboardList.currentPage > 1}">
						<button 
							class="btn btn-outline-primary" 
							type="button" 
							title="첫 페이지로 이동합니다."
							onclick="location.href='?currentPage=1&category=${category}&searchText=${searchText}'"
						>≪</button> 
					</c:if>
					<c:if test="${freeboardList.currentPage <= 1}">
						<button 
							class="btn btn-outline-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 페이지입니다."
						>≪</button>
					</c:if>
					
					<c:if test="${freeboardList.startPage > 1}">
						<button 
							class="btn btn-outline-primary"
							type="button" 
							title="이전 10페이지로 이동합니다."
							onclick="location.href='?currentPage=${freeboardList.startPage - 1}&category=${category}&searchText=${searchText}'"
						>＜</button>
					</c:if>
					<c:if test="${freeboardList.startPage <= 1}">
						<button 
							class="btn btn-outline-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 10페이지입니다."
						>＜</button>
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
								class="btn btn-outline-primary" 
								type="button" 
								onclick="location.href='?currentPage=${i}&category=${category}&searchText=${searchText}'"
							>${i}</button>
						</c:if>
					</c:forEach>
				
					<c:if test="${freeboardList.endPage < freeboardList.totalPage}">
					<button 
						class="btn btn-outline-primary" 
						type="button" 
						title="다음 10페이지로 이동합니다."
						onclick="location.href='?currentPage=${freeboardList.endPage + 1}&category=${category}&searchText=${searchText}'"
					>＞</button>
					</c:if>
					<c:if test="${freeboardList.endPage >= freeboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 10페이지입니다."
					>＞</button>
					</c:if>
					
					<c:if test="${freeboardList.currentPage < freeboardList.totalPage}">
					<button 
						class="btn btn-outline-primary" 
						type="button" 
						title="마지막 페이지로 이동합니다."
						onclick="location.href='?currentPage=${freeboardList.totalPage}&category=${category}&searchText=${searchText}'"
					>≫</button>
					</c:if>
					<c:if test="${freeboardList.currentPage >= freeboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 페이지입니다."
					>≫</button>
					</c:if>
				</td>
				<td colspan="1" align="right">
				<!-- 
					만약 로그인 하지 않고 누르는 경우 alert('회원만 이용 가능한 서비스입니다.')
					alert가 나온 후 바로 로그인 모달창 띄우기
				  -->
				<c:if test="${id == null}">
					<input class="btn btn-outline-primary btn-sm" type="button" value="글쓰기" 
							 onclick="cautionMsg()"/>
				</c:if>
				<c:if test="${id != null}">
					<input type="hidden" id="id" name="id" value="${id}">
					<c:if test="${grade.trim() != 'b'}">
						<input class="btn btn-outline-primary btn-sm" type="button" value="글쓰기" 
							 onclick="location.href='insert'"/>
					</c:if>
					<c:if test="${grade.trim() == 'b'}">
						<input class="btn btn-outline-secondary btn-sm" type="button" value="글쓰기" 
						disabled data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="차단당한 회원은 게시글을 작성할 수 없습니다."/>
					</c:if>
				</c:if>
				</td>
			</tr>
		</table>
	</div><br/><br/>
	
<!-- footer  -->
<%@ include file="../../util/hfer/footer.jsp" %>

</body>
</html>