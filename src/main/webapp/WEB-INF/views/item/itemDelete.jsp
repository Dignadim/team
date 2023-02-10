<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제할 상품 보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String job = request.getParameter("job");
	%>
	
	<div class="container">
		<div class="m-3" style="width: 1000px; padding: 30px; margin-left: auto; margin-right: auto; margin-top: 200px;">
			<form action="itemDeleteOK" method="post">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="table-primary" colspan="2" style="text-align: center; vertical-align: middle; font-size: 30px;">
								<div>상품 삭제</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">사진</th>
							<td align="center">
								<c:if test="${vo.itemImage.indexOf('http') == -1}">
									<c:if test="${vo.sellCVS == 'CU'}">		
										<img alt="상품 이미지" src="https://${vo.itemImage}" style="height: 500px; width: 500px; border-radius: 10px;">
									</c:if>
									<c:if test="${vo.sellCVS != 'CU'}">		
										<img alt="상품 이미지" src="${vo.itemImage}" style="height: 500px; width: 500px; border-radius: 10px;">
									</c:if>
								</c:if>
								<c:if test="${vo.itemImage.indexOf('http') != -1}">
								<img alt="상품 이미지" src="${vo.itemImage}" style="height: 500px;width: 500px;  border-radius: 10px;">
								</c:if>
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">상품명</th>
							<td>
								${vo.itemName}
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">원가</th>
							<td>
								${vo.itemPrice}
							</td>
						</tr>				
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">카테고리</th>
							<td>
								${vo.category}
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">판매 편의점</th>
							<td>
								${vo.sellCVS}
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">행사</th>
							<td>
								${vo.eventType}
							</td>
						</tr>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">평점</th>
							<td>
								${vo.averscore}
							</td>
						</tr>
						<c:if test="${vo.eventType == '덤증정'}">
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">증정 상품</th>
							<td style="padding: 10px 20px;">
								<c:if test="${vo.addItemImage == null || vo.addItemName == null}">
									<div style="text-align: left; color: grey;">증정 상품 정보가 없습니다.</div>
								</c:if>
								<c:if test="${vo.addItemImage != null}">
									<img src="${vo.addItemImage}" width="200px" height="200px;"><br/>							
									${vo.addItemName}
								</c:if>
							</td>
						</tr>					
						</c:if>
						<tr>
							<td colspan="2" align="center" style="padding: 20px;">
								<input class="btn btn-primary" type="submit" value="삭제">
							</td>
						</tr>					
						<tr style="border: none;">
							<td colspan="2" align="right" style="border: none;">
								<input class="btn btn-secondary" type="button" onclick="history.back()" value="뒤로가기">
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