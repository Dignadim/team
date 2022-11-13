<%@page import="project.item.ItemVO"%>
<%@page import="project.item.ItemService"%>
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
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript" src="./js/deleteOrDelete.js" defer></script>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String job = request.getParameter("job");
	%>
	
		<div class="m-3" style="width: 1000px; padding: 30px; margin-left: auto; margin-right: auto;">
			<form action="itemDeleteOK.jsp" method="post">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="info" colspan="2" style="text-align: center; vertical-align: middle;">
								<h2>상품 삭제</h2>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="text-align: center; width: 150px; vertical-align: middle;">사진</th>
							<td>
								<img alt="상품 이미지" src="../${vo.itemImage}" style="width: 400px;">
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
						<tr>
							<td colspan="2" align="center">
								<input class="btn btn-primary" type="submit" value="삭제">
							</td>
						</tr>					
					</tbody>
				</table>
				<input type="hidden" name="idx" value="${vo.idx}"/>
				<input type="hidden" name="currentPage" value="${currentPage}"/>				
			</form>
		</div>


</body>
</html>