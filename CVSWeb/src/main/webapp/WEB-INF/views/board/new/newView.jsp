<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신상 게시판</title>
<link rel="icon" href="../images/favicon.png"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../css/main.css">
</head>
<body>

<!-- header -->
<%@ include file="../../util/hfer/header.jsp" %>

	<c:set var="list" value="${newItemList.list}"/>
	<div class="m-3">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">
			<tr class="table-primary">
				<th colspan="6" style="font-size: 30px; text-align: center;">신상게시판</th>
			</tr>
			<tr>
				<td colspan="6" class="table-light" align="center">
					최근 30일 이내에 등록된 상품을 확인해보세요!
				</td>
			</tr>
			<tr class="table-light">
				<th style="width: 80px; text-align: center;">상품번호</th>
				<th style="width: 110px; text-align: center;">카테고리</th>
				<th style="width: 120px; text-align: center;">편의점</th>
				<th style="width: 480px; text-align: center;">상품명</th>
				<th style="width: 150px; text-align: center;">평점</th>
				<th style="width: 80px; text-align: center;">등록 날짜</th>
			</tr>
			
			<c:if test="${list == null}">
				<tr>
					<td align="center" colspan="6">
						<marquee><h2>최신 상품이 없습니다</h2></marquee>
					</td>			
				</tr>
			</c:if>
			<c:if test="${list != null}">
			<c:forEach var="vo" items="${list}">
			<tr>
				<td align="center" style="vertical-align: middle;">
					${vo.idx}
				</td>
				<!-- 상품의 카테고리 -->
				<td align="center" style="vertical-align: middle;">
					${vo.category}
				</td>
				<!-- 판매 편의점 -->
				<td align="center" style="vertical-align: middle;"> 
					<c:if test="${vo.sellCVS == 'CU'}">
						<img alt="CU logo" src="../images/cu.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == 'GS25'}">
						<img alt="GS logo" src="../images/gs25.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == '세븐일레븐'}">
						<img alt="711 logo" src="../images/7eleven.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == 'ministop'}">
						<img alt="mini logo" src="../images/ministop.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == '이마트24'}">
						<img alt="emart logo" src="../images/emart24.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == 'C·SPACE'}">
						<img alt="other logo" src="../images/other.png" height="25px"><br/>
					</c:if>
				</td>
			
				<td align="left">
					<h4><a href="../item/increment?idx=${vo.idx}&currentPage=1">${vo.itemName}</a></h4>
						${vo.eventType}
				</td>
				<td align="center" style="vertical-align: middle;">
					<c:if test="${vo.averscore < 0.5}">
						${vo.averscore}/5.0
					</c:if>
					<c:if test="${vo.averscore >= 0.5 && vo.averscore < 1}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/halfstar.png" height="15px">)
					</c:if>						
					<c:if test="${vo.averscore >= 1 && vo.averscore < 1.5}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore >= 1.5 && vo.averscore < 2}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/halfstar.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore >= 2 && vo.averscore < 2.5}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore >= 2.5 && vo.averscore < 3}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/halfstar.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore >= 3 && vo.averscore < 3.5}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore >= 3.5 && vo.averscore < 4}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/halfstar.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore >= 4 && vo.averscore < 4.5}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore >= 4.5 && vo.averscore < 5}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/halfstar.png" height="15px">)
					</c:if>
					<c:if test="${vo.averscore == 5}">
						${vo.averscore}/5.0<br/>(<img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px"><img alt="별점" src="../images/star.png" height="15px">)						
					</c:if>
				</td>
				<td align="center" style="vertical-align: middle;">
					<fmt:formatDate value="${vo.itemDate}" pattern="yy/MM/dd"/>
				</td>
			</tr>
			</c:forEach>
			
			<!-- 페이지 이동 버튼 -->
			<tr align="center" class="table table-light">
				<td colspan="6">
				
				<!-- 처음으로 -->
				<c:if test="${newItemList.currentPage > 1}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1'">≪</button>							
				</c:if>
				<c:if test="${newItemList.currentPage <= 1}">
					<button class="btn btn-outline-secondary" disabled title="첫 번째 페이지입니다.">≪</button>						
				</c:if>

				<!-- 10페이지 앞으로 -->
				<c:if test="${newItemList.startPage > 1}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${newItemList.startPage-1}'">＜</button>							
				</c:if>
				<c:if test="${newItemList.startPage <= 1}">
					<button class="btn btn-outline-secondary" disabled title="첫 10페이지입니다.">＜</button>				
				</c:if>
												
				<!-- 페이지 선택 -->
				<c:forEach var="i" begin="${newItemList.startPage}" end="${newItemList.endPage}" step="1">
					<c:if test="${newItemList.currentPage == i}">
						<input class="btn btn-outline-secondary" type="button" value="${i}" disabled/>	
					</c:if>
					<c:if test="${newItemList.currentPage != i}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}'" value="${i}"/>	
					</c:if>							
				</c:forEach>

				<!-- 10페이지 뒤로 -->
				<c:if test="${newItemList.endPage < newItemList.totalPage}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${newItemList.endPage+1}'">＞</button>								
				</c:if>
				<c:if test="${newItemList.endPage >= newItemList.totalPage}">
					<button class="btn btn-outline-secondary" disabled title="마지막 10페이지입니다.">＞</button>							
				</c:if>
				
				<!-- 마지막으로 -->
				<c:if test="${newItemList.currentPage < newItemList.totalPage}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${newItemList.totalPage}'">≫</button>								
				</c:if>
				<c:if test="${newItemList.currentPage >= newItemList.totalPage}">
					<button class="btn btn-outline-secondary" disabled title="마지막 페이지입니다.">≫</button>						
				</c:if>
				</td>
			</tr>	
			</c:if>
		</table>
	</div><br/><br/>
	
<!-- footer  -->
<%@ include file="../../util/hfer/footer.jsp" %>
	
</body>
</html>