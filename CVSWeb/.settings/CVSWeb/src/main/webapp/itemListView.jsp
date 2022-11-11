<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든 상품 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<div class="m-3">
		<input type="button" class="btn btn-outline-primary" onclick="location.href='main.jsp'" value="메인으로">
		<table class="table" style="width: 1200px; margin-left: auto; margin-right: auto;">
			<tr class="table-primary">
				<th colspan="6" style="font-size: 20px; text-align: center;">모든 상품 보기</th>
			</tr>			
			
			<tr>
				<td colspan="6">
					<div class="container">
						<div style="padding: 20px 20px;">
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
							</div><br/>	
							<h4>가격별 보기</h4>	
							<div>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="1000원"> ~ 1,000원</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="5000원"> ~ 5,000원</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="10000원"> ~ 10,000원</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="50000원"> ~ 50,000원</span>							
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="기타가격"> 기타</span>							
							</div><br/>	
							<h4>카테고리별 보기</h4>	
							<div>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="과자"> 과자</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="음료"> 음료</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="라면"> 라면</span>
								<span style="padding: 10px;"><input class="form-check-input" type="checkbox" value="생필품"> 생필품</span>							
							</div>			
						</div>
					</div>
				</td>						
			</tr>
			
			<tr>
				<td colspan="6" align="right">
					${itemList.totalCount} 건 (${itemList.currentPage} / ${itemList.totalPage})<br/>				
				</td>
			</tr>
			<tr class="table table-light">
				<th style="text-align: center; width: 100px">상품번호</th>
				<th style="text-align: center; width: 100px">편의점</th>
				<th style="text-align: center; width: 200px">카테고리</th>
				<th style="text-align: center; width: 500px">상품명</th>
				<th style="text-align: center; width: 200px">가격</th>
				<th style="text-align: center; width: 100px">행사여부</th>
			</tr>		
		
			<!-- 상품 목록을 출력한다. -->
			<!-- itemList.jsp에서 request 영역에 저장한 itemList에서 1페이지 분량의 글이 저장된 ArrayList를 꺼내온다. -->
			<c:set var="list" value="${itemList.list}"/>
			
			<!-- 상품 목록이 1건도 없으면 글이 없다고 출력한다. -->
			<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="6" align="center">
					<h2>테이블에 저장된 글이 없습니다.</h2>			
				</td>
			</tr>
			</c:if>
			
			<c:if test="${list.size() != 0}">
				<c:forEach var="vo" items="${list}">
					<tr>
						<td align="center">
							${vo.idx}
						</td>
						<td align="center">
							${vo.sellCVS}
						</td>					
						<td align="center">
							${vo.category}
						</td>					
						<td align="center">
							<a class="aaa" href="itemIncrement.jsp?idx=${vo.idx}&currentPage=${itemList.currentPage}&job=itemView">${vo.itemName}</a>				
						</td>					
						<td align="center">
							${vo.itemPrice}
						</td>					
						<td align="center">
							${vo.eventType}
						</td>					
					</tr>
				</c:forEach>
			</c:if>
			<tr>
				<td colspan="4">&nbsp;</td>
				<td colspan="1">
					<input type="text" class="form-control" placeholder="검색할 내용을 입력하세요." style="width: 200px;">
				</td>
				<td colspan="1">
					<button type="button" class="btn btn-primary" onclick="#">검색</button>
				</td>
			</tr>
			<!-- 페이지 이동 버튼 -->
			<tr align="center" class="table table-light">
				<td colspan="5">
				
				<!-- 처음으로 -->
				<c:if test="${itemList.currentPage > 1}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage <= 1}">
					<button class="btn btn-outline-secondary" disabled title="첫 번째 페이지입니다.">≪</button>						
				</c:if>

				<!-- 10페이지 앞으로 -->
				<c:if test="${itemList.startPage > 1}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage <= 1}">
					<button class="btn btn-outline-secondary" disabled title="첫 10페이지입니다.">＜</button>				
				</c:if>
												
				<!-- 페이지 선택 -->
				<c:forEach var="i" begin="${itemList.startPage}" end="${itemList.endPage}" step="1">
					<c:if test="${itemList.currentPage == i}">
						<input class="btn btn-outline-secondary" type="button" value="${i}" disabled/>	
					</c:if>
					<c:if test="${itemList.currentPage != i}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}'" value="${i}"/>	
					</c:if>							
				</c:forEach>

				<!-- 10페이지 뒤로 -->
				<c:if test="${itemList.endPage < itemList.totalPage}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage >= itemList.totalPage}">
					<button class="btn btn-outline-secondary" disabled title="마지막 10페이지입니다.">＞</button>							
				</c:if>
				
				<!-- 마지막으로 -->
				<c:if test="${itemList.currentPage < itemList.totalPage}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage >= itemList.totalPage}">
					<button class="btn btn-outline-secondary" disabled title="마지막 페이지입니다.">≫</button>						
				</c:if>
				</td>	
					
				<!-- 상품 입력 버튼 -->
				<td align="right" colspan="1">
					<input class="btn btn-outline-primary" type="button" value="상품 입력" onclick="location.href='itemInsert.jsp'"/>
				</td>					
			</tr>
		</table>
	</div>	

</body>
</html>