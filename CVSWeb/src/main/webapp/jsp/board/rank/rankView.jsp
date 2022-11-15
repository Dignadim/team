<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>랭킹 게시판</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<script type="text/javascript" src="../../../js/rankView.js" defer></script>
</head>
<body>

	<c:set var="list" value="${itemTOP.list}"/>

	<div class="m-3">
		<input type="button" class="btn btn-outline-primary" onclick="location.href='../../connectMain.jsp'" value="메인으로" style="margin: 10px;">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">
			<tr class="table-secondary">
				<th colspan="6" style="font-size: 30px; text-align: center;">랭킹게시판</th>
			</tr>
			<tr class="table-secondary">
				<td colspan="4">
				</td>
				<td colspan="2" align="right">
				현재 선택된 카테고리 : ${category}
					<select id="category" class="form-select" width="100" onchange="categorySelect()">
						<option selected>카테고리 고르기</option>
						<option>모두</option>
						<option>과자</option>
						<option>음료</option>
						<option>라면</option>
						<option>생필</option>
					</select>
				</td>
			</tr>
			<tr class="table-secondary">
				<th style="width: 105px; text-align: center;">인기순위</th>
				<th style="width: 105px; text-align: center;">카테고리</th>
				<th style="width: 200px; text-align: center;">편의점</th>
				<th style="width: 370px; text-align: center;">상품명</th>
				<th style="width: 150px; text-align: center;">평점</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>
			
			<c:forEach var="vo" items="${list}">
			<c:set var="i" value="${i + 1}"/>
			<tr>
				<td>
				<center>
					${i}위
				</center>
				</td>
				<!-- 상품의 카테고리 -->
				<td>
				<center>
					${vo.category}
				</center>
				</td>
				<!-- 판매 편의점 -->
				<td> 
				<center>
					<c:if test="${vo.sellCVS == 'CU'}">
						<img alt="CU logo" src="../../../images/cu.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == 'GS25'}">
						<img alt="GS logo" src="../../../images/gs25.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == '세븐일레븐'}">
						<img alt="711 logo" src="../../../images/7eleven.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == 'ministop'}">
						<img alt="mini logo" src="../../../images/ministop.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == '이마트24'}">
						<img alt="emart logo" src="../../../images/emart24.png" height="25px"><br/>
					</c:if>
					<c:if test="${vo.sellCVS == '기타 편의점'}">
						<img alt="other logo" src="../../../images/other.png" height="25px"><br/>
					</c:if>
					</center>
				</td>
			
				<td>
				<center>
					<h4><a href="../../item/itemIncrement.jsp?idx=${vo.idx}&job=itemView">${vo.itemName}</a></h4>
						${vo.eventType}
				</center>
				</td>
				<td>
				<center>
					${vo.averscore}
				</center>
				</td>
				<td>
				<center>
					${vo.hit}
				</center>
				</td>
			</tr>
			</c:forEach>
		
		</table>
	</div>
	
	
</body>
</html>