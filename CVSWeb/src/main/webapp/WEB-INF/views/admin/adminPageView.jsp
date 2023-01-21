<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<link rel="icon" href="../images/favicon.png"/>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../css/myPageView.css">
<script type="text/javascript" src="../js/adminmember.js" defer></script>
</head>
<body onload="reload()">

	<c:if test="${msg != null}">
		<script type="text/javascript">
		alert('${msg}');
		</script>
	</c:if>

				<div align="right" style="margin: 10px; padding: 10px;">
					<button style="margin: 5px; width: 25px;" class="btn btn-close block" type="button" title="창닫기" onclick="self.close()"></button>				
				</div>
				<div class="b">
						
						<table class="table table-borderless table-hover" align="center" style="width: 500px; vertical-align: middle; margin: 20px; border-radius: 5px;">
							<tr height="70px">
								<th>ID</th>
								<td>${mb_vo.id}</td>
							</tr>
							<tr height="70px">
								<th>닉네임</th>
								<td>${mb_vo.nickname}</td>
							</tr>
							<tr height="70px">
								<th>이메일</th>
								<td>${mb_vo.email}</td>
							</tr>
							<tr height="70px">
								<th>가입일자</th>
								<td>
								<fmt:formatDate value="${mb_vo.signupdate}" pattern="yyyy.MM.dd"/>
								</td>
							</tr>
							<tr height="70px">
								<th>등급</th>
								<td>
								<c:if test="${mb_vo.grade eq 'n'}">
									정상
								</c:if>
								<c:if test="${mb_vo.grade eq 'y'}">
									관리자
								</c:if>
								<c:if test="${mb_vo.grade eq 'b'}">
									차단
								</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
								<input type="button" class="btn btn-outline-info" value="쪽지" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
								<c:if test="${mb_vo.grade eq 'n'}">
										<a href="adminBlock?id=${mb_vo.id}&banType=1">
									<button style="margin: 5px;" class="btn btn-outline-danger block" type="button" title="차단"
										>차단</button></a>
								</c:if>
								<c:if test="${mb_vo.grade eq 'b'}">
										<a href="adminBlock?id=${mb_vo.id}&banType=2">
									<button style="margin: 5px;" class="btn btn-outline-warning block" type="button" title="차단해제"
										>차단해제</button></a>
								</c:if>								
								</td>
							</tr>
						</table>
					
				</div><br/><br/><br/>
	

	<div class="clear">&nbsp;</div>
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
				<input type="hidden" value="${mb_vo.id}" id="fid" name="fid">
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