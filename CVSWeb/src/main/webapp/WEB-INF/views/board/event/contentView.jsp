<%@page import="java.io.File"%>
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
<link rel="icon" href="../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<script type="text/javascript" src="../js/eventboard.js" defer="defer"></script>

<style type="text/css">
	* {
		font-family: "Pretendard";
	}
	.replyView{
		padding: 0;
		border: none;
		background: none;
	}
	#profile {
		background-image: linear-gradient(#444444, #444444), linear-gradient(to right, #fbfcb9be, #ffcdf3aa, #65d3ffaa);
	    background-origin: border-box;
	    background-clip: content-box, border-box;
		border-radius: 100%; 
		width: 34px; 
		padding: 0px;
	}
</style>

</head>
<body>
	
<!-- header -->
<%@ include file="../../util/hfer/header.jsp" %>
	
	<div class="m-5">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">			
			<tr class="table-primary">
				<th style="width: 70px; text-align: center;">닉네임</th>
				<th style="width: 150px; text-align: center;">제목</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>	
			<tr class="table-light">
				<td align="center">				
					<a class="profileView" onclick="profileView('${ev_vo.id}')">
						${ev_vo.nickname}
					</a>					
				</td>
				<td align="center">
					<c:set var="ev_subject" value="${fn:replace(ev_vo.ev_subject, '<', '&lt;')}"/>
					<c:set var="ev_subject" value="${fn:replace(ev_subject, '>', '&gt;')}"/>

					[${ev_vo.ev_sellcvs.trim()}] ${ev_subject}<br/> ${schedVO.sYear}-${schedVO.sMonth}-${schedVO.sDay} ~ ${schedVO.eYear}-${schedVO.eMonth}-${schedVO.eDay}

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
			<tr class="table-light">
				<th style="text-align: center;">내용</th>
				<td colspan="3" height="400" style="background-color: white;" >
					<c:set var="ev_content" value="${fn:replace(ev_vo.ev_content, '<', '&lt;')}"/>
					<c:set var="ev_content" value="${fn:replace(ev_content, '>', '&gt;')}"/>
					<c:set var="ev_content" value="${fn:replace(ev_content, enter, '<br/>')}"/>
					<div style="margin: 10px 15px;">
						<c:if test="${ev_vo.ev_filename != null}">
						<img alt="이미지" src="${ev_vo.ev_filename}"><br/>
						</c:if>
						${ev_content}
					</div>
				</td>
			</tr>	
			<tr class="table-light">
				<c:if test="${!grade.trim().equals('y')}">
				<td colspan="4" height="45px"></td>
				</c:if>
				<c:if test="${grade.trim().equals('y')}">
				<td colspan="4" align="right">
					<input class="btn btn-light btn-sm" type="button" value="수정하기" style="font-size: 13px;" 
						onclick="location.href= 'update?ev_idx=${ev_vo.ev_idx}&currentPage=${currentPage}'"/>
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
					      		onclick="location.href= 'deleteOK?ev_idx=${ev_vo.ev_idx}&currentPage=${currentPage}'"/>
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
					      </div>
					
					    </div>
					  </div>
					</div>		
				</td>
				</c:if>
			</tr>	
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark btn-lg" type="button" value="목록보기"
						style="font-size: 13px;" onclick="location.href='list?currentPage=${currentPage}'"/>
					<input id="ev_sellcvs" type="hidden" value="${ev_vo.ev_sellcvs}">
				</td>
			</tr>
		</table>
	</div>
	
 	
	<!-- 댓글 폼 -->
	<form class="m-3" action="commentOK" method="post" name="commentForm" id="commentForm">
		<table class="table" style="width: 1000px; margin-left: auto; margin-right: auto;">	
			<tr class="table-secondary" height="48px">
				<th colspan="4" style="font-size: 30px; text-align: center;"></th>
			</tr>
			
			<tr style="display: none;">
				<td colspan="4">
					ev_idx: <input type="text" name="ev_idx" value="${ev_vo.ev_idx}" size="4"/>
					evc_idx: <input type="text" name="evc_idx" value="${ev_vo.ev_idx}" size="4"/>
					ev_gup: <input type="text" name="evc_gup" value="${ev_vo.ev_idx}" size="4"/>
					mode: <input type="text" name="mode" value="1" size="4"/>
					currentPage: <input type="text" name="currentPage" value="${currentPage}" size="4"/>
					evc_content: <input type="text" id="editContent" name="evc_Content" value="${evc_vo.evc_content}" size="4"/>
					id: <input type="text" id="id" name="id" value="${id}" size="4"/>
					nickname: <input type="text" id="nickname" name="nickname" value="${nickname}" size="4"/>
					userImage: <input type="text" id="userImage" name="userImage" value="${image}" size="4"/>
					reGup: <input type="text" name="reGup" value="0" size="4"/>
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
					    	<c:if test="${id == null}">
							<div class="form-inline mb-2"></div>
							<textarea class="form-control" id="evc_content" name="evc_content" rows="3" placeholder="로그인 후 이용 가능합니다." 
								style="resize: none;" disabled="disabled"></textarea>
							<div align="right">
								<input class="btn btn-dark mt-3" type="button" value="로그인하러가기" name="commentBtn" 
									onclick="location.href='../member/login'">
							</div>
							</c:if>		
							<c:if test="${id != null}">			    
							<div class="form-inline mb-2">
								<img alt="Profile" src="${image}" width="30px" id="profile"/> ${nickname}
							</div>
							<textarea class="form-control" id="evc_content" name="evc_content" rows="3" placeholder="욕설 x 비방 x" 
								style="resize: none;"></textarea>
							<div align="right">
								<input class="btn btn-dark mt-3" type="button" value="등록" name="commentBtn" onclick="commentEmptyChk()">
							</div>
							</c:if>
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
						<div class="card-header bg-light" style="height: 132px;">

							<img alt="Profile" src="${evc_vo.userImage}" width="30px" id="profile"/>
							<a class="profileView" onclick="profileView('${evc_vo.id}')">
								${evc_vo.nickname}
							</a>		
						
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
							<c:if test="${evc_vo.del.equals('y')}">
								<i style="color: grey">(삭제된 댓글입니다.)</i>
							</c:if>
							<c:if test="${!evc_vo.del.equals('y')}">
								<div>
									<c:set var="evc_content" value="${fn:replace(evc_vo.evc_content, '<', '&lt;')}"/>
									<c:set var="evc_content" value="${fn:replace(evc_content, '>', '&gt;')}"/>
									<c:set var="evc_content" value="${fn:replace(evc_content, enter, '<br/>')}"/>
										${evc_content}<br/>
								</div>	
								<c:set var="reply" value="${replyCommentList.list}"/>
								<div align="right">
									<button
										class="replyView"
										id="replyBtn${evc_vo.evc_idx}"
										type="button"
										style="font-size: 15px; margin: 15px; float: left;"
										onclick="replyList(${evc_vo.evc_idx}, ${evc_vo.replyCount})"
									>답글 (${evc_vo.replyCount})▼</button>
									<input type="hidden" value="off" id="replySwitch" name="replySwitch"/>
									<c:if test="${id.equals(evc_vo.id)}">
									<button 
										type="button" 
										class="btn btn-outline-primary btn-sm" 
										data-bs-toggle="modal" 
										data-bs-target="#comment-edit-modal" 
										data-bs-nickname="${nickname}"
										data-bs-content="${evc_content}"
										data-bs-idx="${evc_vo.evc_idx}"
										style="font-size: 13px;"
									>수정</button>
									<input 
										class="btn btn-outline-danger btn-sm"
										type="button"
										value="삭제"
										style="font-size: 13px;"
										onclick="deleteComment(${evc_vo.evc_idx}, 3)"
									/>
									</c:if>
								</div>
							</c:if>
						</div>
						<!-- 여기부터 대댓글 -->
						<!-- 댓글창에서 답글 버튼을 클릭하면 해당 댓글에 대댓글 리스트 -->
						<c:if test="${reply.size() != 0}">
							<c:forEach var="reply_vo" items="${reply}">
								<c:if test="${reply_vo.reGup == evc_vo.evc_idx}">
									<div id="replyNo${evc_vo.evc_idx}" style="display: none;">
										<div class="card-header bg-light" style="height: 132px;">
											<span style="margin-left: 10px;"><img alt="Reply" src="../images/reply.png" width="15px"/></span>&nbsp;&nbsp;
											<img alt="Profile" src="${reply_vo.userImage}" width="30px" id="profile"/> ${reply_vo.nickname}
											<div align="right">
												<c:set var="writeDate" value="${reply_vo.evc_date}"></c:set>
												<c:if test="${date.year == writeDate.year && date.month == writeDate.month 
													&& date.date == writeDate.date}">
													<fmt:formatDate value="${writeDate}" pattern="a hh:mm"/>
												</c:if>
												<c:if test="${date.year != writeDate.year || date.month != writeDate.month 
													|| date.date != writeDate.date}">
													<fmt:formatDate value="${writeDate}" pattern="yyyy.MM.dd(E)"/>
												</c:if>
											</div>
											<c:if test="${reply_vo.del.equals('y')}">
												<span style="margin-left: 35px"><i style="color: grey">(삭제된 댓글입니다.)</i></span>
											</c:if>
											<c:if test="${!reply_vo.del.equals('y')}">
												<div>
													<c:set var="evc_content" value="${fn:replace(reply_vo.evc_content, '<', '&lt;')}"/>
													<c:set var="evc_content" value="${fn:replace(evc_content, '>', '&gt;')}"/>
													<c:set var="evc_content" value="${fn:replace(evc_content, enter, '<br/>')}"/>
													<span style="margin-left: 35px">${evc_content}</span><br/>
												</div>
												<div align="right">
												<c:if test="${id.equals(reply_vo.id)}">
													<button 
														type="button" 
														class="btn btn-outline-primary btn-sm" 
														data-bs-toggle="modal" 
														data-bs-target="#comment-edit-modal" 
														data-bs-nickname="${nickname}"
														data-bs-content="${reply_vo.evc_content}"
														data-bs-idx="${reply_vo.evc_idx}"
														style="font-size: 13px;"
														>수정</button>
													<input 
														class="btn btn-outline-danger btn-sm"
														type="button"
														value="삭제"
														style="font-size: 13px;"
														onclick="deleteComment(${reply_vo.evc_idx}, 3)"
													/>
												</c:if>
												</div>
											</c:if>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
						<div class="card-body reIns${evc_vo.evc_idx}" id="replyNo${evc_vo.evc_idx}" style="display: none;">
							<div style="display: block;">
								<div style="colspan: 4; display: none;">
									reGupNo: <input type="text" name="reGupNo" class="reGupNo" value="${evc_vo.evc_idx}" size="4"/>
									evc_gup: <input type="text" name="evc_gup" id="evc_gup" value="${evc_vo.evc_gup}" size="4"/>
								</div>
							</div>
					    	<c:if test="${id == null}">
								<div class="form-inline mb-2"></div>
								<textarea class="form-control" id="evc_content" name="evc_content" rows="3" placeholder="로그인 후 이용 가능합니다." 
									style="resize: none;" disabled="disabled"></textarea>
								<div align="right" style="padding">
									<input class="btn btn-dark mt-3" type="button" value="로그인하러가기" name="commentBtn" 
										onclick="location.href='../member/login'">
								</div>
							</c:if>
							<c:if test="${id != null}">
								<div class="form-inline mb-2">
									<img alt="Profile" src="${image}" width="30px" id="profile"/> ${nickname}
								</div>
								<textarea class="form-control reply_content" name="reply_content" rows="3" placeholder="욕설 x 비방 x" 
									style="resize: none;"></textarea>
								<div align="right">
									<input class="btn btn-dark mt-3" type="button" value="답글등록" onclick="reply(${evc_vo.evc_idx}, 4)">
								</div>
							</c:if>
						</div>
					</div>
					<!-- Modal Start -->
					<div class="modal" id="comment-edit-modal" tabindex="-1">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title" id="exampleModalLabel">댓글 수정</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<!-- 닉네임 -->
									<div class="mb-3">
										<label for="edit-comment-nickname" class="form-label">닉네임</label>
										<input id="edit-comment-nickname"
											class="form-control-plaintext" readonly>
									</div>
									<!-- 댓글 입력 -->
									<div class="mb-3">
										<label for="edit-comment-content" class="form-label">댓글</label>
										<textarea id="edit-comment-content"
											class="form-control form-control-sm" rows="5"
											style="resize: none;"></textarea>
									</div>
									<!-- 전송 버튼 -->
									<div align="right">
										<!-- 수정하는 댓글의 idx를 히든으로 전달한다. -->
										<input type="hidden" id="edit-comment-idx"/><!-- 댓글 idx -->
										<input type="button" class="btn btn-outline-primary btn-sm" value="수정완료"
											onclick="updateComment(2)"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal End -->
				</c:forEach>
			</c:if>
		</table>
	</form>
	
	
<!-- footer  -->
<%@ include file="../../util/hfer/footer.jsp" %>
	
	
</body>
</html>








