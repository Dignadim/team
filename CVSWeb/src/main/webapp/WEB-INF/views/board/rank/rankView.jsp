<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>랭킹 게시판</title>
<link rel="icon" href="../images/favicon.png"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<script type="text/javascript" src="../js/rankView.js" defer></script>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>

<!-- header -->
<%@ include file="../../util/hfer/header.jsp" %>

	<c:set var="list" value="${itemTOP.list}"/>

	<div class="m-3">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">
			<tr class="table-primary">
				<th colspan="6" style="font-size: 30px; text-align: center;">랭킹게시판</th>
			</tr>
			<tr class="table-light">
				<td colspan="3">
				</td>
				<td colspan="1" align="right" style="vertical-align: middle;">
					현재 선택된 카테고리 : ${category}
				</td>				
				<td colspan="2" align="right">
					<select id="category" class="form-select" width="100" onchange="categorySelect()">
						<option selected>카테고리 고르기</option>
		                 <option>모두</option>
		                 <option>간편식품</option>
		                 <option>가공식품</option>
		                 <option>즉석식품</option>
		                 <option>신선식품</option>
		                 <option>과자/빵</option>
		                 <option>아이스크림</option>
		                 <option>음료</option>
		                 <option>잡화</option>
		                 <option>기호식품</option>
		                 <option>기타상품</option>
					</select>
				</td>
			</tr>
			<tr class="table-light">
				<th style="width: 80px; text-align: center;">인기순위</th>
				<th style="width: 110px; text-align: center;">카테고리</th>
				<th style="width: 120px; text-align: center;">편의점</th>
				<th style="width: 480px; text-align: center;">상품명</th>
				<th style="width: 150px; text-align: center;">평점</th>
				<th style="width: 80px; text-align: center;">조회수</th>
			</tr>
			
			<c:if test="${list.size() == 0}">
			<tr>
				<td align="center" colspan="6" style="vertical-align: middle;">
					<marquee><h1>등록된 상품이 없습니다.</h1></marquee>
				</td>
			</tr>
			</c:if>
			<c:forEach var="vo" items="${list}">
			<c:set var="i" value="${i + 1}"/>
			<tr>
				<td align="center" style="vertical-align: middle;">
					${i}위
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
					${vo.hit}
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="6" class="table-light">&nbsp;</td>
			</tr>
		</table>
	</div><br/><br/>

<!-- footer  -->
<%@ include file="../../util/hfer/footer.jsp" %>
	
</body>
</html>