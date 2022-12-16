<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link rel="icon" href="./images/favicon.png"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/freeboard.css"/>
<script type="text/javascript" src="./js/freeboard.js" defer="defer"></script>
<style type="text/css">
	body {
		font-family: 'Pretendard Variable';
	}
</style>
</head>
<body>
	
   
   <br/><br/>
	<!-- alert창을 띄울 메시지가 있으면 여기에 받아짐 -->
	<input type="hidden" id="msg" value="${msg}">
	<form class="m-3" method="post" name='insertForm'>
		<table class="table" style="width: 900px; height: 450px; margin-left: auto; margin-right: auto; margin-top: 80px;">
			<tr style="height: 30px;" class="table-light">
				<th style="display: none;">
					id: <input type="text" id="memberID" name="id" value="${id}">
					nickname: <input type="text" id="nickname" name="nickname" value="${nickname}">
				</th>
				<th class="align-middle table-primary" style="padding: 10px; text-align: center;">
					<label for="subject">제목</label>
				</th>
				<td colspan="2">
					<input id="fb_subject" class="form-control form-control-sm" type="text" name="fb_subject"
						placeholder="제목을 입력해주세요."/>
				</td>
				<th class="align-middle" width="80">
				<c:if test="${grade.trim().equals('y')}">
					공지글 <input class="form-check-input" type="checkbox" id="fb_notice" value="yes"/>
				</c:if>
				<c:if test="${!grade.trim().equals('y')}">
					<div width=0 height=0 style="visibility:hidden">
						<input class="form-check-input" type="checkbox" id="fb_notice" value="yes"/>
					</div>
				</c:if>
				</th>
			</tr>		
			<tr class="table-light">
				<th class="align-top table-primary" style="padding: 10px; text-align: center; vertical-align: middle;">
					<label for="content">내용</label>
				</th>
				<td colspan="2">
					<textarea id="fb_content" class="form-control form-control-sm" rows="15" name="fb_content" 
					 	style="resize: none;" placeholder="내용을 입력해주세요."></textarea>
				</td>
				<th></th>
			</tr>
			<tr class="table-light">
				<td colspan="4" align="right">
					<input class="btn btn-primary btn-lg" type="button" value="등록"
						style="font-size: 13px;" onclick="insertEmptyChk()"/>
				</td>
			</tr>		
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark" type="button" value="목록보기" onclick="location.href='fbList'"/>
				</td>
			</tr>	
		</table>	
		<input type="hidden" name="mode" value="Insert"/>
	</form><br/><br/>	
	
	
</body>
</html>