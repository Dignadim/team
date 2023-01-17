<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정할 상품 보기</title>
<link rel="icon" href="../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript" src="../js/itemInsert.js" defer></script>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String job = request.getParameter("job");
	%>
	<div class="container">
		<div class="m-3" style="width: 1000px; padding: 30px; margin-left: auto; margin-right: auto; margin-top: 200px;" align="center">
			<form action="itemUpdateOK" method="post">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="table-primary" colspan="2" style="text-align: center; vertical-align: middle; font-size: 30px;">
								<div>상품 수정</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">상품 사진</th>
							<td>
								<input type="text" class="form-control" name="itemImage" value="${vo.itemImage}" readonly onclick="openWin()" data-bs-toggle="tooltip" title="이미지를 수정하려면 텍스트 박스를 클릭하세요.">
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">상품명</th>
							<td>
								<input class="form-control" type="text" placeholder="상품명을 수정해주세요." name="itemName" value="${vo.itemName}">
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">원가</th>
							<td>
								<input class="form-control" type="text" placeholder="원가를 수정해주세요." value="${vo.itemPrice}" name="itemPrice" width="600px;" >
							</td>
						</tr>				
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">카테고리</th>
							<td>
								<select class="form-select" name="category">
									<c:if test="${vo.category.trim() == '식품'}">
										<option selected>식품</option>
									</c:if>
									<c:if test="${vo.category.trim() != '식품'}">
										<option>식품</option>
									</c:if>					
									<c:if test="${vo.category.trim() == '음료/아이스크림'}">
										<option selected>음료/아이스크림</option>
									</c:if>
									<c:if test="${vo.category.trim() != '음료/아이스크림'}">
										<option>음료/아이스크림</option>
									</c:if>					
									<c:if test="${vo.category.trim() == '과자/빵'}">
										<option selected>과자/빵</option>
									</c:if>
									<c:if test="${vo.category.trim() != '과자/빵'}">
										<option>과자/빵</option>
									</c:if>					
									<c:if test="${vo.category.trim() == '잡화'}">
										<option selected>잡화</option>
									</c:if>
									<c:if test="${vo.category.trim() != '잡화'}">
										<option>잡화</option>
									</c:if>					
									<c:if test="${vo.category.trim() == '기타상품'}">
										<option selected>기타상품</option>
									</c:if>
									<c:if test="${vo.category.trim() != '기타상품'}">
										<option>기타상품</option>
									</c:if>					
								</select>
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">판매 편의점</th>
							<td>
								<select class="form-select" name="sellCVS">
									<c:if test="${vo.sellCVS.trim() == 'CU'}">
										<option selected>CU</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() != 'CU'}">
										<option>CU</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() == 'GS25'}">
										<option selected>GS25</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() != 'GS25'}">
										<option>GS25</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() == '세븐일레븐'}">
										<option selected>세븐일레븐</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() != '세븐일레븐'}">
										<option>세븐일레븐</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() == 'ministop'}">
										<option selected>ministop</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() != 'ministop'}">
										<option>ministop</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() == '이마트24'}">
										<option selected>이마트24</option>
									</c:if>								
									<c:if test="${vo.sellCVS.trim() != '이마트24'}">
										<option>이마트24</option>
									</c:if>								
									<c:if test="${vo.sellCVS != 'CU' && vo.sellCVS != 'GS25' && vo.sellCVS != '세븐일레븐' && vo.sellCVS != 'ministop' && vo.sellCVS != '이마트24'}">
										<option selected>기타 편의점</option>
									</c:if>								
									<c:if test="${vo.sellCVS == 'CU' || vo.sellCVS == 'GS25' || vo.sellCVS == '세븐일레븐' || vo.sellCVS == 'ministop' || vo.sellCVS == '이마트24'}">
										<option>기타 편의점</option>
									</c:if>					
								</select>
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">행사</th>
							<td>
								<select class="form-select" name="eventType">
									<c:if test="${vo.eventType.trim() == '1+1'}">
										<option selected>1+1</option>
									</c:if>								
									<c:if test="${vo.eventType.trim() != '1+1'}">
										<option>1+1</option>
									</c:if>
									<c:if test="${vo.eventType.trim() == '2+1'}">
										<option selected>2+1</option>
									</c:if>								
									<c:if test="${vo.eventType.trim() != '2+1'}">
										<option>2+1</option>
									</c:if>
									<c:if test="${vo.eventType.trim() == '할인'}">
										<option selected>할인</option>
									</c:if>								
									<c:if test="${vo.eventType.trim() != '할인'}">
										<option>할인</option>
									</c:if>
									<c:if test="${vo.eventType.trim() == '기타행사'}">
										<option selected>기타행사</option>
									</c:if>								
									<c:if test="${vo.eventType.trim() != '기타행사'}">
										<option>기타행사</option>
									</c:if>
								</select>
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">평점</th>
							<td>
								<div>${vo.averscore} 점</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input class="btn btn-primary" type="submit" value="수정">
							</td>
						</tr>					
					</tbody>
				</table>
				<input type="hidden" name="idx" value="${vo.idx}"/>
				<input type="hidden" name="currentPage" value="${currentPage}"/>				
			</form>
		</div>
	</div>


</body>
</html>