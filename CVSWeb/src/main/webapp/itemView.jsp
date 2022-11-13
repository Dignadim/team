<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개별 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
<script type="text/javascript" src="./js/itemView.js" defer></script>
</head>
<body>

	<div class="container" style="margin-top: 100px; width: 1200px">
		<table class="table table-bordered">
			<thead>
				<tr class="table-primary">
					<th class="info" colspan="3" style="text-align: left; vertical-align: middle;">
						<h2>선택 상품 보기</h2>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="7" width="550px;">
						<img alt="상품 이미지" src="${vo.itemImage}" style="width: 400px;">
					</td>
				</tr>
				<tr>
					<th width="200px">상품명</th>
					<td width="650px">
						${vo.itemName}
					</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>
						${vo.category}
					</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>
						${vo.itemPrice}
						<c:if test="${vo.eventType == '1+1'}">
							<br/>개당 가격 ${vo.itemPrice / 2}원!
						</c:if>
						<c:if test="${vo.eventType == '2+1'}">
							<br/>개당 가격 ${vo.itemPrice / 3 * 2}원!
						</c:if>
					</td>
				</tr>
				<tr>
					<th>판매 편의점</th>
					<td>
						${vo.sellCVS}
					</td>
				</tr>
				<tr>
					<th>행사</th>
					<td>
						${vo.eventType}
					</td>
				</tr>
				<tr>
					<th>평점</th>
					<td>
						<c:if test="${vo.averscore < 0.5}">
							${vo.averscore}
						</c:if>
						<c:if test="${vo.averscore >= 0.5 && vo.averscore < 1}">
							${vo.averscore}(<img alt="별점" src="./images/halfstar.png" height="20px">)
						</c:if>						
						<c:if test="${vo.averscore >= 1 && vo.averscore < 1.5}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 1.5 && vo.averscore < 2}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 2 && vo.averscore < 2.5}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 2.5 && vo.averscore < 3}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 3 && vo.averscore < 3.5}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 3.5 && vo.averscore < 4}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 4 && vo.averscore < 4.5}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 4.5 && vo.averscore < 5}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore == 5}">
							${vo.averscore}(<img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px"><img alt="별점" src="./images/star.png" height="20px">)						
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="1" align="left">
						<button class="btn btn-outline-info" onclick="location.href='itemSelectByIdx.jsp?idx=${vo.idx}&currentPage=${currentPage}&job=itemUpdate'">수정</button>
						<button class="btn btn-outline-info" onclick="location.href='itemSelectByIdx.jsp?idx=${vo.idx}&currentPage=${currentPage}&job=itemDelete'">삭제</button>
					</td>
					<td colspan="2" align="right">
						<button class="btn btn-outline-secondary" onclick="location.href='itemList.jsp?currentPage=${currentPage}'">돌아가기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div><br/>
	
	<hr style="width: 1200px; margin-left: auto; margin-right: auto;"/><br/>
	
	<c:set var="comment" value="${itemCommentList.list}"/>
	<form class="m-3" action="itemCommentOK.jsp" method="post">
		<table class="table" style="width: 1200px; margin-left: auto; margin-right: auto;">
			<!-- 댓글 입력, 수정, 삭제 -->
			<tr class="table-primary">
				<th colspan="4">댓글(${comment.size()})</th>
			</tr>
	
			<!-- <tr style="display: none;"> -->
			<tr>
				<td colspan="4">
					<!-- 수정 또는 삭제할 댓글의 글 번호를 넘겨준다. -->
					idx: <input type="text" name="idx" value="${vo.idx}" size="1"> 
					<!-- 현재 댓글이 어떤 메인 글의 댓글인지 넘겨준다. -->
					gup: <input type="text" name="gup" value="${vo.idx}" size="1">
					<!-- 메인 글이 표시되던 페이지 번호를 넘겨준다. -->
					currentPage: <input type="text" name="currentPage" value="${currentPage}" size="1">
					nickname: <input type="text" name="nickname">
				</td>
			</tr>
			
			<tr>
				<th colspan="1" class="align-middle" style="width: 100px; text-align: center;">
					<label for="content">내용</label>
				</th>
				<th colspan="2" style="width: 600px;">
					<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;">지금은 테스트 중이라 idx gup currentPage nickname 내용 다 값을 채워야 입력됨</textarea>
				</th>
				<th colspan="1" style="width: 200px; vertical-align: middle;" align="center">
					<input class="btn btn-outline-primary btn-sm" type="submit" name="submit" value="저장" style="margin: auto;"/>				
				</th>
			</tr>
		</table>
		<table class="table" style="width: 1200px; margin-left: auto; margin-right: auto;">	
			<tr>
				<th width="100px">닉네임</th>			
				<th width="500px">내용</th>
				<th width="200px">작성시각</th>
			</tr>
			<!-- 댓글이 없는 경우 -->
			<c:if test="${comment.size() == 0}">
				<tr align="center">
					<td colspan="4" style="margin: 20px;">
						<h2>댓글이 없습니다.</h2>
					</td>
				</tr>
			</c:if>
			<c:if test="${comment.size() != 0}">
				<c:forEach var="co" items="${comment}">
					<tr>
						<td>${co.nickname}</td>
						<td>${co.content}</td>
						<td>
							<fmt:formatDate value="${co.writeDate}" pattern="yyyy.MM.dd(E) a h:mm:ss"/>	
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</form>

</body>
</html>