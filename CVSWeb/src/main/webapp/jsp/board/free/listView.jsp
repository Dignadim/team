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
				<th style="width: 150px; text-align: center;">닉네임</th>
				<th style="width: 560px; text-align: center;">제목</th>
				<th style="width: 70px; text-align: center;">댓글</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>
			<jsp:useBean id="date" class="java.util.Date"/>
			
			<!-- 공지글 -->
<%-- 		
			<c:if test="${currentPage == 1}">
			<c:forEach var="vo" items="${notice}">
				<tr class="table-warning">
					<td align="center">
						<i class="bi bi-envelope-exclamation-fill"></i>
					</td>
					<td>
						<i class="bi bi-tags"></i>
						<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
						<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
						
						<a href="increment.jsp?idx=${vo.idx}&currentPage=${freeboardList.currentPage}">
							${subject}(${vo.commentCount})
						</a>
						
						<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month && date.date == vo.writeDate.date}">
							<img alt="New" src="./images/ic_new.gif"/>
						</c:if>
						
						<c:if test="${vo.hit > 10}">
							<img alt="hot" src="./images/hot.gif"/>
						</c:if>
					</td>
					<td align="center">
						<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
						<c:set var="name" value="${fn:replace(vo.name, '>', '&gt;')}"/>
						${name}
					</td>
					<td align="center">
						<c:if test="${date.year == vo.writeDate.year && date.month == vo.writeDate.month && date.date == vo.writeDate.date}">
							<fmt:formatDate value="${vo.writeDate}" pattern="a h:mm:ss"/>
						</c:if>
						<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month || date.date != vo.writeDate.date}">
							<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
						</c:if>
					</td>
					<td align="center">
						${vo.hit}
					</td>
				</tr>
			</c:forEach>
			</c:if>
 --%>
			<!-- 메인글 -->
			<c:set var="list" value="${freeboardList.list}"/>
			<!-- 글이 없을때 -->
			<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="5">
					<marquee>테이블에 저장된 글이 없습니다.</marquee>
				</td>
			</tr>		
			</c:if>
			<!-- 글이 하나라도 있을 때 -->
			<c:if test="${list.size() != 0}">
			<c:forEach var="fb_vo" items="${list}">
<tr>
					<td align="center">
<%-- 					
						<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
						<c:set var="name" value="${fn:replace(vo.name, '>', '&gt;')}"/>
 --%>
						nickname
					</td>
					<td>
						<i class="bi bi-tags"></i>
						<c:set var="fb_subject" value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}"/>
						<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}"/>
						
						<a href="increment.jsp?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">
							${fb_subject}
						</a>
						
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<img alt="New" src="../../../images/ic_new.gif"/>
						</c:if>
						
						<c:if test="${fb_vo.fb_hit > 10}">
							<img alt="hot" src="../../../images/hot.gif"/>
						</c:if>
					</td>
					<td align="center">
						(${fb_vo.fb_commentCount})
					</td>
					<td align="center">
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm"/>
						</c:if>
						<c:if test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="yyyy.MM.dd(E)"/>(fb_date)
						</c:if>
					</td>
					<td align="center">
						${fb_vo.fb_hit}
					</td>
				</tr>			
			</c:forEach>
			</c:if>
			<!-- 페이지 이동 -->
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
					<input class="btn btn-outline-primary btn-sm" type="button" value="글쓰기" 
						 onclick="location.href='insert.jsp'"/>
				</td>
			</tr>
		</table>
	</div>

</body>
</html>