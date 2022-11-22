<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 뷰</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../../css/myPageView.css">
<script type="text/javascript" src="../../js/adminmember.js" defer></script>
</head>
<body>


				<div class="b">
					
						
						<table class="table table-borderless table-hover" align="center" style="width: 500px; vertical-align: middle; margin: 20px; border-radius: 5px;">
							<tr height="70px">
								<th>ID</th>
								<td>${vo.id}</td>
							</tr>
							<tr height="70px">
								<th>닉네임</th>
								<td>${vo.nickname}</td>
							</tr>
							<tr height="70px">
								<th>이메일</th>
								<td>${vo.email}</td>
							</tr>
							<tr height="70px">
								<th>가입일자</th>
								<td>
								<fmt:formatDate value="${vo.signupdate}" pattern="yyyy.MM.dd"/>
								</td>
							</tr>
							<tr height="70px">
								<th>자기소개</th>
								<td>자기소개 내용</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
								<a href="./adminBlock.jsp?id=${vo.id}&banType=1">
									<button style="margin: 5px;" class="btn btn-outline-warning block" type="button" title="경고"
										>경고</button></a>
										<a href="./adminBlock.jsp?id=${vo.id}&banType=2">
									<button style="margin: 5px;" class="btn btn-outline-info block" type="button" title="차단"
										>차단</button></a>
										<a href="./adminBlock.jsp?id=${vo.id}&banType=3">
									<button style="margin: 5px;" class="btn btn-outline-secondary block" type="button" title="차단해제"
										>차단해제</button></a>
								</td>
							</tr>
						</table>
					
				</div><br/><br/><br/>
	

	<div class="clear">&nbsp;</div>

</body>
</html>