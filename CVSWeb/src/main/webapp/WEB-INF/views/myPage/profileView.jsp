<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 뷰</title>
<link rel="icon" href="../images/favicon.png"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/myPageView.css">
<script	src="../js/myPage.js"></script>
</head>
<body>

	<div class="m-3 container">
		<div align="right">
			<input type="button" style="margin: 5px; width: 25px;" class="btn btn-close" onclick="self.close()">
		</div>
		<div class="container mt-3" align="center" style="vertical-align: middle;">
			<div style="padding: 80px 20px;">
				<img src="${vo.image}" alt="프로필사진" id="profile">
			</div>
			<h2 style="padding-bottom: 15px">${vo.nickname}(${vo.id})님의 프로필</h2>
			<div style="width: 450px; height: 200px;">${vo.introduce}</div>
		</div>	
		<div>
			<div align="right">
				<c:if test="${id != vo.id}">
					<c:if test="${grade != 'b'}">
						<input type="button" class="btn btn-outline-info" value="쪽지" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
					</c:if>
					<c:if test="${grade == 'b'}">
						<input type="button" class="btn btn-outline-secondary" value="쪽지" disabled>
					</c:if>
				</c:if>				
			</div>
		</div>
	</div>

<!-- Modal -->
<form action="goMsg" method="post" name="insertMsg">
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">쪽지 보내기</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div>보내는 사람: ${nickname}(${id})</div>
				<input type="hidden" value="${id}" id="mid" name="mid">
				<input type="hidden" value="${vo.id}" id="fid" name="fid">
				<textarea rows="10" class="form-control form-control-sm" name="msg" style="resize: none;" id="msg"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="goMsg()">전송</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
</form>

</body>
</html>