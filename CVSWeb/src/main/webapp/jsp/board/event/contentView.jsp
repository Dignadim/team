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
<script type="text/javascript" src="../../../js/eventboard.js" defer="defer"></script>

</head>
<body>
	
	
	<header>
		<div class="container">
			<nav class="navbar navbar-expand-sm bg-light">
				<div class="col-sm-2">
					<h2 style="width: 200px;">타이틀</h2>
				</div>
				<div class="container-fluid col-sm-5">
					<ul class="navbar-nav">
						<li class="nav-item" style="padding-right: 70px;">
					    	<a class="nav-link" href="#">모든 상품 보기</a>
					    </li>					
						<li class="nav-item dropdown" style="padding-right: 70px;">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">모든 행사 보기</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#">GS25</a></li>
								<li><a class="dropdown-item" href="#">CU</a></li>
								<li><a class="dropdown-item" href="#">세븐일레븐</a></li>
								<li><a class="dropdown-item" href="#">ministop</a></li>
								<li><a class="dropdown-item" href="#">이마트24</a></li>
								<li><a class="dropdown-item" href="#">기타 편의점</a></li>
							</ul>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">게시판</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#">자유게시판</a></li>
								<li><a class="dropdown-item" href="#">랭킹게시판</a></li>
								<li><a class="dropdown-item" href="#">신상게시판</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="col-sm-2">
					<input type="text" class="form-control" placeholder="검색할 내용을 입력하세요." style="width: 200px;">
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-primary" onclick="#">검색</button>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary" onclick="location.href='login.jsp'">로그인</button>					
					<!-- 관리자만 보이는 부분 -->
					<button class="btn btn-info" onclick="#">관리 페이지로</button>					
				</div>
			</nav>
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
					관리자
				</td>
				<td align="center">
					<c:set var="ev_subject" value="${fn:replace(ev_vo.ev_subject, '<', '&lt;')}"/>
					<c:set var="ev_subject" value="${fn:replace(ev_subject, '>', '&gt;')}"/>
					[${ev_vo.ev_sellcvs.trim()}] ${ev_subject}
				</td>
				<td align="center">
					<jsp:useBean id="date" class="java.util.Date"/>
					<c:if test="${date.year == ev_vo.ev_date.year && date.month == ev_vo.ev_date.month && date.date == ev_vo.ev_date.date}">
						<fmt:formatDate value="${ev_vo.ev_date}" pattern="a h:mm:ss"/>
					</c:if>
					<c:if test="${date.year != ev_vo.ev_date.year || date.month != ev_vo.ev_date.month || date.date != ev_vo.ev_date.date}">
						<fmt:formatDate value="${ev_vo.ev_date}" pattern="yyyy.MM.dd(E)"/>
					</c:if>
				</td>
				<td align="center">
					${ev_vo.ev_hit}
				</td>
			</tr>	
			<tr class="table-secondary">
				<th style="text-align: center;">내용</th>
				<td colspan="3" height="400" style="background-color: #F2F2F2;" >
					<c:set var="ev_content" value="${fn:replace(ev_vo.ev_content, '<', '&lt;')}"/>
					<c:set var="ev_content" value="${fn:replace(ev_content, '>', '&gt;')}"/>
					<c:set var="ev_content" value="${fn:replace(ev_content, enter, '<br/>')}"/>
					${ev_content}
				</td>
			</tr>	
			<tr class="table-secondary">
				<td colspan="4" align="right">
				<!-- 글을 게시한 회원정보와 contentView에 들어온 회원 정보가 일치한 경우에만 보이도록 -->
					<input class="btn btn-light btn-sm" type="button" value="수정하기" style="font-size: 13px;" 
						onclick="location.href= 'selectByIdx.jsp?ev_idx=${ev_vo.ev_idx}&currentPage=${currentPage}&job=update'"/>
					<button type="button" class="btn btn-light btn-sm" style="font-size: 13px;" data-bs-toggle="modal" data-bs-target="#delete">
 					 		삭제하기</button>
 					<!-- The Modal -->
					<div class="modal" id="delete">
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
					        삭제하시면 복구가 어렵습니다. <br/>
					        그래도 삭제하시겠습니까?
					      </div>
					
					      <!-- Modal footer -->
					      <div class="modal-footer">
					      	<input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="예"
					      		onclick="location.href= 'selectByIdx.jsp?ev_idx=${ev_vo.ev_idx}&currentPage=${currentPage}&job=delete'"/>
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
					      </div>
					
					    </div>
					  </div>
					</div>		
				</td>
			</tr>	
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark btn-lg" type="button" value="목록보기"
						style="font-size: 13px;" onclick="location.href='list.jsp?currentPage=${currentPage}'"/>
					<input id="ev_sellcvs" type="hidden" value="${ev_vo.ev_sellcvs}">
				</td>
			</tr>
		</table>
	</div>
	
 	
	<!-- 댓글 폼 -->
	<form class="m-3" action="commentOK.jsp" method="post" name="commentForm" id="commentForm">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">	
			<tr class="table-secondary" height="48px">
				<th colspan="4" style="font-size: 30px; text-align: center;"></th>
			</tr>
			
			<tr style="display: none;">
				<td colspan="4">
					evc_idx: <input type="text" name="evc_idx" value="${evc_vo.evc_idx}" size="4"/>
					ev_gup: <input type="text" name="evc_gup" value="${ev_vo.ev_idx}" size="4"/>
					mode: <input type="text" name="mode" value="1" size="4"/>
					currentPage: <input type="text" name="currentPage" value="${currentPage}" size="4"/>
					evc_content: <input type="text" id="editContent" name="evc_Content" value="${evc_vo.evc_content}" size="4"/>
				</td>
			</tr>
			
			<!-- 이 줄부터 댓글 입력, 수정, 삭제에 사용된다. -->
			<div class="card mb-2" style="width: 1000px; margin-left: auto; margin-right: auto;">
				<div class="card-header bg-light">
					<i class="bi bi-chat-dots"></i> Comment
				</div>
				<div class="card-body">
					<ul class="list-group list-group-flush">
					    <li class="list-group-item">
							<div class="form-inline mb-2">
								<img alt="Profile" src="../../../images/profile.jpg" width="30px"/> Nickname
							</div>
							<textarea class="form-control" id="evc_content" name="evc_content" rows="3" placeholder="욕설 x 비방 x" 
								style="resize: none;"></textarea>
							<div align="right">
								<input class="btn btn-dark mt-3" type="button" value="등록" name="commentBtn" onclick="commentEmptyChk()">
							</div>
					    </li>
					</ul>
				</div>
			</div>

			<!-- 댓글을 출력한다. -->
			<c:set var="comment" value="${eventboardCommentList.list}"></c:set>
			
			<!-- 댓글이 없는 경우 -->
			<c:if test="${comment.size() == 0}">
				<div class="card mb-2" style="width: 1000px; margin-left: auto; margin-right: auto;">
					<div class="card-header bg-light">
						<marquee>등록된 댓글이 없습니다.</marquee>
					</div>
				</div>
			</c:if>
			
			<!-- 댓글이 있는 경우 -->
			<c:if test="${comment.size() != 0}">
				<c:forEach var="evc_vo" items="${comment}">
					<div class="card mb-2" style="width: 1000px; margin-left: auto; margin-right: auto;">
						<div class="card-header bg-light">
							<img alt="Profile" src="../../../images/profile.jpg" width="30px"/> Nickname
							<div align="right">
								<c:set var="writeDate" value="${evc_vo.evc_date}"></c:set>
								<c:if test="${date.year == writeDate.year && date.month == writeDate.month 
									&& date.date == writeDate.date}">
									<fmt:formatDate value="${writeDate}" pattern="a hh:mm"/>
								</c:if>
								<c:if test="${date.year != writeDate.year || date.month != writeDate.month 
									|| date.date != writeDate.date}">
									<fmt:formatDate value="${writeDate}" pattern="yyyy.MM.dd(E)"/>
								</c:if>
							</div>
							<div>
								<c:set var="evc_content" value="${fn:replace(evc_vo.evc_content, '<', '&lt;')}"/>
								<c:set var="evc_content" value="${fn:replace(evc_content, '>', '&gt;')}"/>
								<c:set var="evc_content" value="${fn:replace(evc_content, enter, '<br/>')}"/>
									${evc_content}<br/>
							</div>	
							<div align="right">
								<input 
									class="btn btn-outline-primary btn-sm"
									type="button"
									value="수정"
									style="font-size: 13px;"
									onclick="updateComment(${evc_vo.evc_idx}, 2, '댓글수정', '${evc_content}')"
								/>	
								<input 
									class="btn btn-outline-danger btn-sm"
									type="button"
									value="삭제"
									style="font-size: 13px;"
									onclick="deleteComment(${evc_vo.evc_idx}, 3)"
								/>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</table>
	</form>
	
	
	<footer>
		<div class="container" style="background-color: #e7e7e7; color: #777;">
			<div class="row">
				<div class="col-sm-3">
					copyright 김철수 all rights reserved<br/>
					사업자 등록번호 123456-123-456789
				</div>
				<div class="col-sm-3">
					고객센터
					02-123-4567<br/>
				</div>
				<div class="col-sm-3">
					내용입니다.<br/>
					내용입니다.<br/>
					내용입니다.
				</div>
				<div class="col-sm-3">
					내용입니다.<br/>
					내용입니다.<br/>
					내용입니다.
				</div>
			</div>
		</div>
	</footer>
</body>
</html>








