<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

</head>
<body>
	
	
	<header>
	 	<div>
	 		<a href="#" style="color: black; font-weight: bold; position: relative; top: 20px; left: 20px; 
	 				border: 10px solid;">사이트 이름</a>
	 	</div>
	</header>
	<div class="m-5">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">			
			<tr class="table-secondary">
				<th style="width: 70px; text-align: center;">닉네임</th>
				<th style="width: 150px; text-align: center;">제목</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>	
			<tr class="table-secondary">
				<td align="center">
<%-- 				
					<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
					<c:set var="name" value="${fn:replace(vo.name, '>', '&gt;')}"/>
 --%>
					nickname
				</td>
				<td align="center">
					<c:set var="fb_subject" value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}"/>
					<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}"/>
					${fb_subject} ?
				</td>
				<td align="center">
					<jsp:useBean id="date" class="java.util.Date"/>
					<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
						<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm:ss"/> ?
					</c:if>
					<c:if test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
						<fmt:formatDate value="${fb_vo.fb_date}" pattern="yyyy.MM.dd(E)"/> ?
					</c:if>
				</td>
				<td align="center">
					${fb_vo.fb_hit} ?
				</td>
			</tr>	
			<tr class="table-secondary">
				<th style="text-align: center;">내용</th>
				<td colspan="3" height="400" style="background-color: #F2F2F2;" >
					<c:set var="fb_content" value="${fn:replace(fb_vo.fb_content, '<', '&lt;')}"/>
					<c:set var="fb_content" value="${fn:replace(fb_content, '>', '&gt;')}"/>
					<c:set var="fb_content" value="${fn:replace(fb_content, enter, '<br/>')}"/>
					${fb_content} ?????
				</td>
			</tr>	
			<tr class="table-secondary">
				<td colspan="4" align="right">
					<input class="btn btn-light btn-sm" type="button" value="수정하기" style="font-size: 13px;" 
						onclick="location.href= 'selectByIdx.jsp?idx=${fb_vo.fb_idx}&currentPage=${currentPage}&job=update'"/>
					<input class="btn btn-light btn-sm" type="button" value="삭제하기" style="font-size: 13px;"
						onclick="location.href= 'selectByIdx.jsp?idx=${fb_vo.fb_idx}&currentPage=${currentPage}&job=delete'"/>
				</td>
			</tr>	
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark btn-lg" type="button" value="목록보기"
						style="font-size: 13px;" onclick="location.href='list.jsp?currentPage=${currentPage}'"/>
				</td>
			</tr>
		</table>
	</div>
	

</body>
</html>








