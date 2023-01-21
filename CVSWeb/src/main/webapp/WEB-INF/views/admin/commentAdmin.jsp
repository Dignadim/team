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
<style type="text/css">
</style>
</head>
<body onload="reload()">

	<c:if test="${msg != null}">
		<script type="text/javascript">
		alert('${msg}');
		</script>
	</c:if>
	
	<div class="b">
		<form action="deleteRC" method="post">
			<table class="table table-borderless table-hover" align="center" style="width: 500px; vertical-align: middle; margin: 20px; border-radius: 5px;">
				<c:set var="list" value="${reportCommentList.list}"/>
				<c:forEach var="vo" items="${list}">
				<tr height="70px">
					<th width="30%">작성자ID</th>
					<td>${vo.id}</td>
				</tr>
				<tr height="70px">
					<th>작성자 닉네임</th>
					<td>${vo.nickname}</td>
				</tr>
				<tr height="70px">
					<th>댓글</th>
					<td>${comment}</td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="padding: 120px;">
						<%-- <a href="adminBlock?id=${vo.id}&banType=1">
							<button style="margin: 5px;" class="btn btn-outline-danger block" type="button" title="회원차단">회원차단</button>
						</a> --%>
						<input type="hidden" name="idx" value="${idx}">
						<input type="hidden" name="location" value="${location}">
						<input class="btn btn-outline-dark block" type="submit" value="댓글삭제">
						<button style="margin: 5px;" class="btn btn-outline-secondary block" type="button" title="창닫기"
							onclick="self.close()">창닫기</button>
					</td>
				</tr>
				</c:forEach>
			</table>
		</form>
	</div><br/><br/><br/>

	<div class="clear">&nbsp;</div>

</body>
</html>