<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
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
	
	<form class="m-3" method="post">
		<table class="table" style="width: 900px; height: 450px; margin-left: auto; margin-right: auto; margin-top: 80px;">
			<tr>
				<th colspan="4" class="table-primary" align="center">
					게시글 수정
				</th>
			</tr>
			<tr>
				<td colspan="4" style="display: none;">
					id: <input type="text" id="memberID" name="id" value="${fb_vo.id}">
					nickname: <input type="text" id="nickname" name="nickname" value="${fb_vo.nickname}">
					postID: <input type="text" id="postID" name="postID" value="${fb_vo.id}">
				</td>
			</tr>
			<tr style="height: 30px;">
				<th class="align-middle table-light" style="padding: 10px; text-align: center;">
					<label for="fb_subject">제목</label>
				</th>
				<td colspan="2">
					<input id="fb_subject" class="form-control form-control-sm" type="text" name="fb_subject"
						value="${fb_vo.fb_subject}"/>
				</td>
				<th class="align-middle" width="80">
				<c:if test="${grade.trim().equals('y')}">
					공지글 
					<c:if test="${fn:trim(fb_vo.fb_notice) == 'yes'}">
						<input class="form-check-input" type="checkbox" id="fb_notice" checked="checked"/>
					</c:if>
					<c:if test="${fn:trim(fb_vo.fb_notice) != 'yes'}">
						<input class="form-check-input" type="checkbox" id="fb_notice" value="yes"/>
					</c:if>		
				</c:if>		
				<c:if test="${!grade.trim().equals('y')}">
					<div width=0 height=0 style="visibility:hidden">
						<input class="form-check-input" type="checkbox" id="fb_notice" value="yes"/>
					</div>
				</c:if>	
				</th>
			</tr>		
			<tr>
				<th class="align-top table-light" style="padding: 10px; text-align: center; vertical-align: middle;">
					<label for="fb_content">내용</label>
				</th>
				<td colspan="2">
					<textarea id="fb_content" class="form-control form-control-sm" rows="15" name="fb_content" 
					 	style="resize: none;">${fb_vo.fb_content}</textarea>
				</td>
				<th></th>
			</tr>
			<tr class="table-light">
				<td colspan="4" align="right">
					<button type="button" class="btn btn-outline-primary" style="font-size: 15px;" data-bs-toggle="modal" data-bs-target="#update">
	 				 		수정</button>
	 				<!-- The Modal -->
					<div class="modal" id="update">
						<div class="modal-dialog">
							<div class="modal-content">
					
					      	<!-- Modal Header -->
					      	<div class="modal-header">
					        	<h4 class="modal-title">경고</h4>
					        	<i class="bi bi-exclamation-triangle-fill"></i>
					        	<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					      	</div>
						
						    <!-- Modal body -->
						    <div class="modal-body" align="left">
						    	이대로 수정하시겠습니까?
						    </div>
							
						    <!-- Modal footer -->
						    <div class="modal-footer">
						    	<input class="btn btn-secondary" value="예" type="button" data-bs-dismiss="modal" onclick="insertEmptyChk()"/>
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
						    </div>
							</div>
						</div>
					</div>	
				</td>
			</tr>		
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark" type="button" value="목록보기" onclick="location.href='fbList'"/>
				</td>
			</tr>	
		</table>	
		<input type="hidden" name="mode" value="Update"/>
		<input type="hidden" name="fb_idx" id="fb_idx" value="${fb_vo.fb_idx}">
		<input type="hidden" name="currentPage" value="${currentPage}">
	</form><br/><br/>
	

</body>
</html>