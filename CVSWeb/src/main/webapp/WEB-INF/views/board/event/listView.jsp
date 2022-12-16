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
<link rel="icon" href="./images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/listView.css"/>
<script type="text/javascript" src="./js/eventboard.js" defer="defer"></script>
<style type="text/css">
* {
	font-family: "Pretendard";
}
</style>
</head>
<body onload="fixSelected()">

    <!-- header -->
   <%@ include file="../../util/hfer/header.jsp" %>
   <br/><br/>

	<!-- alert창을 띄울 메시지가 있으면 여기에 받아짐 -->
	<input type="hidden" id="msg" value="${msg}">
	<div class="m-3">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">
			<tr class="table-primary">
				<th colspan="5" style="font-size: 30px; text-align: center;">행사 정보 게시판</th>
			</tr>
			<tr>
				<td colspan="5">
					<form action="evList" method="post" name="searchForm">
						<input id="beforeCvs" type="hidden" name="ev_sellcvs" value="${category}"/>
						<select class="form-select" id="category" name="category" style="width: 130px; display: inline !important;">
							<option>전체</option>
							<option>GS25</option>
							<option>CU</option>
							<option>세븐일레븐</option>
							<option>ministop</option>
							<option>이마트24</option>
							<option>기타편의점</option>
						</select>
						<input class="form-control" type="text" id="searchText" name="searchText" value="${searchText}" style="width: 150px; padding-left: 10px; display: inline !important;"/>
						<input class="btn btn-primary" type="submit" value="검색"/>
						<button class="btn btn-outline-secondary" onclick="backPage()">돌아가기</button>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="5" align="right"> 
					${eventboardList.totalCount}건 (${eventboardList.currentPage} / ${eventboardList.totalPage})
				</td>
			</tr>
			<tr class="table-light">
				<th style="width: 150px; text-align: center;">번호</th>
				<th style="width: 560px; text-align: center;">제목</th>
				<th style="width: 70px; text-align: center;">닉네임</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>
			<jsp:useBean id="date" class="java.util.Date"/>
			
			<!-- 공지글 -->
			<c:if test="${currentPage == 1}">
			<c:forEach var="ev_vo" items="${ev_notice}">
				<tr class="table-warning">
					<td align="center">
						<i class="bi bi-envelope-exclamation-fill"></i>
					</td>
					<td>
						<i class="bi bi-tags"></i>
						<c:set var="ev_subject" value="${fn:replace(ev_vo.ev_subject, '<', '&lt;')}"/>
						<c:set var="ev_subject" value="${fn:replace(ev_subject, '>', '&gt;')}"/>
						
						<a href="evSelectByIdx?ev_idx=${ev_vo.ev_idx}&currentPage=${eventboardList.currentPage}&job=increment">
							[${ev_vo.ev_sellcvs.trim()}] ${ev_subject} (${ev_vo.ev_commentCount})
						</a>
						
						<c:if test="${date.year == ev_vo.ev_date.year && date.month == ev_vo.ev_date.month && date.date == ev_vo.ev_date.date}">
							<img alt="New" src="./images/ic_new.gif"/>
						</c:if>
						
						<c:if test="${ev_vo.ev_hit > 100}">
							<img alt="hot" src="./images/hot.gif"/>
						</c:if>
					</td>
					<td align="center">
						${ev_vo.nickname}
					</td>
					<td align="center">
						<c:if test="${date.year == ev_vo.ev_date.year && date.month == ev_vo.ev_date.month && date.date == ev_vo.ev_date.date}">
							<fmt:formatDate value="${ev_vo.ev_date}" pattern="a h:mm"/>
						</c:if>
						<c:if test="${date.year != ev_vo.ev_date.year || date.month != ev_vo.ev_date.month || date.date != ev_vo.ev_date.date}">
							<fmt:formatDate value="${ev_vo.ev_date}" pattern="yyyy.MM.dd(E)"/>
						</c:if>
					</td>
					<td align="center">
						${ev_vo.ev_hit}
					</td>
				</tr>
			</c:forEach>
			</c:if>
			
			<c:set var="list" value="${eventboardList.list}"/>
			
			<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="5">
					<marquee>테이블에 저장된 글이 없습니다.</marquee>
				</td>
			</tr>		
			</c:if>

			<c:if test="${list.size() != 0}">
			<c:forEach var="ev_vo" items="${list}">
			<tr>
				<td align="center">
					${ev_vo.ev_idx}
				</td>
				<td>
					<i class="bi bi-tags"></i>
					<c:set var="ev_subject" value="${fn:replace(ev_vo.ev_subject, '<', '&lt;')}"/>
					<c:set var="ev_subject" value="${fn:replace(ev_subject, '>', '&gt;')}"/>
					<a href="evSelectByIdx?ev_idx=${ev_vo.ev_idx}&currentPage=${eventboardList.currentPage}&job=increment">
						[${ev_vo.ev_sellcvs.trim()}] ${ev_subject} (${ev_vo.ev_commentCount})
					</a>
						
					<c:if test="${date.year == ev_vo.ev_date.year && date.month == ev_vo.ev_date.month && date.date == ev_vo.ev_date.date}">
						<img alt="New" src="./images/ic_new.gif"/>
					</c:if>
						
					<c:if test="${ev_vo.ev_hit > 100}">
						<img alt="hot" src="./images/hot.gif"/>
					</c:if>
				</td>
				<td align="center">
					${ev_vo.nickname}
				</td>
				<td align="center">
					<c:if test="${date.year == ev_vo.ev_date.year && date.month == ev_vo.ev_date.month && date.date == ev_vo.ev_date.date}">
						<fmt:formatDate value="${ev_vo.ev_date}" pattern="a h:mm"/>
					</c:if>
					<c:if test="${date.year != ev_vo.ev_date.year || date.month != ev_vo.ev_date.month || date.date != ev_vo.ev_date.date}">
						<fmt:formatDate value="${ev_vo.ev_date}" pattern="yyyy.MM.dd(E)"/>
					</c:if>
				</td>
				<td align="center">
					${ev_vo.ev_hit}
				</td>
			</tr>	
			</c:forEach>
			</c:if>

			<tr align="center" class="table table-light">
				<td colspan="4" align="center">
					<c:if test="${eventboardList.currentPage > 1}">
						<button 
							class="btn btn-outline-primary" 
							type="button" 
							title="첫 페이지로 이동합니다."
							onclick="location.href='?currentPage=1&category=${category}'"
						>≪</button> 
					</c:if>
					<c:if test="${eventboardList.currentPage <= 1}">
						<button 
							class="btn btn-outline-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 페이지입니다."
						>≪</button>
					</c:if>
					
					<c:if test="${eventboardList.startPage > 1}">
						<button 
							class="btn btn-outline-primary"
							type="button" 
							title="이전 10페이지로 이동합니다."
							onclick="location.href='?currentPage=${eventboardList.startPage - 1}&category=${category}'"
						>＜</button>
					</c:if>
					<c:if test="${eventboardList.startPage <= 1}">
						<button 
							class="btn btn-outline-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 10페이지입니다."
						>＜</button>
					</c:if>
					
					<c:forEach var="i" begin="${eventboardList.startPage}" end="${eventboardList.endPage}" step="1">
						<c:if test="${eventboardList.currentPage == i}">
							<button 
								class="btn btn-outline-secondary" 
								type="button" 
								disabled="disabled"
							>${i}</button> 
						</c:if>
						<c:if test="${eventboardList.currentPage != i}">
							<button 
								class="btn btn-outline-primary" 
								type="button" 
								onclick="location.href='?currentPage=${i}&category=${category}'"
							>${i}</button>
						</c:if>
					</c:forEach>
				
					<c:if test="${eventboardList.endPage < eventboardList.totalPage}">
					<button 
						class="btn btn-outline-primary" 
						type="button" 
						title="다음 10페이지로 이동합니다."
						onclick="location.href='?currentPage=${eventboardList.endPage + 1}&category=${category}'"
					>＞</button>
					</c:if>
					<c:if test="${eventboardList.endPage >= eventboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 10페이지입니다."
					>＞</button>
					</c:if>
					
					<c:if test="${eventboardList.currentPage < eventboardList.totalPage}">
					<button 
						class="btn btn-outline-primary" 
						type="button" 
						title="마지막 페이지로 이동합니다."
						onclick="location.href='?currentPage=${eventboardList.totalPage}&category=${category}'"
					>≫</button>
					</c:if>
					<c:if test="${eventboardList.currentPage >= eventboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 페이지입니다."
					>≫</button>
					</c:if>
				</td>
				<td colspan="1" align="right">
				<c:if test="${grade.trim().equals('y')}">
					<input class="btn btn-outline-primary btn-sm" type="button" value="글쓰기" 
						 onclick="location.href='evInsert'"/>
				</c:if>
				</td>
			</tr>
		</table>
	</div><br/><br/>

   <!-- footer  -->
   <%@ include file="../../util/hfer/footer.jsp" %>

</body>
</html>