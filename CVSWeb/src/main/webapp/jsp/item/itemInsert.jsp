<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>

	<div class="container" style="margin-top: 100px; width: 800px">
		<form method="post" action="itemInsertOK.jsp"> 
			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th class="info" colspan="2" style="text-align: center; vertical-align: middle;">
							<h2>상품 등록</h2>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<th style="text-align: center; width: 150px; vertical-align: middle;">상품 사진</th>
						<td>
							<input type="file" name="itemImage"/><br/>
						</td>
					</tr>				
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">상품명</th>
						<td>
							<input class="form-control" type="text" placeholder="상품명을 입력해주세요." name="itemName">
						</td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">원가</th>
						<td>
							<input class="form-control" type="text" placeholder="원가를 입력해주세요." name="itemPrice" width="600px;">
						</td>
					</tr>				
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">카테고리</th>
						<td>
							<select class="form-select" name="category">
								<option selected>과자</option>
								<option>음료</option>
								<option>즉석식품</option>
								<option>생필품</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">판매 편의점</th>
						<td>
							<select class="form-select" name="sellCVS" size="6">
								<option selected>CU</option>
								<option>GS25</option>
								<option>세븐일레븐</option>
								<option>ministop</option>
								<option>이마트24</option>
								<option>기타 편의점</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">행사</th>
						<td>
							<select class="form-select" name="eventType">
								<option selected>(행사없음)</option>
								<option>1+1</option>
								<option>2+1</option>
								<option>포인트 적립</option>
								<option>카드사 할인</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="1" align="center">
							<input class="btn btn-success" type="button" onclick="location.href='connectMain.jsp'" value="메인으로">
						</td>
						<td colspan="1" align="center">
							<input class="btn btn-primary" type="submit" value="등록">
						</td>
					</tr>					
				</tbody>
			</table>
		</form>
	</div>

</body>
</html>