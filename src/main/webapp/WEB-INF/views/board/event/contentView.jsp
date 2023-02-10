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

					
					[${ev_vo.ev_sellcvs.trim()}] ${ev_subject}<br/> 
					<c:if test="${schedVO.eYear < 1}">
						${schedVO.sYear}-${schedVO.sMonth}-${schedVO.sDay}
					</c:if>
					<c:if test="${schedVO.eYear > 1}">
						${schedVO.sYear}-${schedVO.sMonth}-${schedVO.sDay} ~ ${schedVO.eYear}-${schedVO.eMonth}-${schedVO.eDay}
					</c:if>

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
						<img alt="이미지" src="${ev_vo.ev_filename}"><br/><br/>
						</c:if>
						<c:if test="${ev_content != '.'}">
							${ev_content}
						</c:if>
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
 					<!-- Modal start -->
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
					<!-- Modal end -->
				</td>
				</c:if>
			</tr>	
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<button 
						class="btn btn-danger btn-lg reportBtn" 
						type="button" 
						id = "reportBtn"
						style="font-size: 13px; float: left;"
					>오류/신고</button>
					<span style="display: none;">
						<input 
							type="button"
						 	id="realReport" 
						 	data-bs-toggle="modal" 
						 	data-bs-target="#event-report-modal" 
						 	data-bs-idx="${ev_vo.ev_idx}"
							data-bs-nickname="${ev_vo.nickname}" 
							data-bs-location="eventboard"
							data-bs-title="오류/신고" 
							data-bs-subject="${ev_vo.ev_subject}"
							data-bs-cvs="${ev_vo.ev_sellcvs}"
						>
					</span>
					<input class="btn btn-dark btn-lg" type="button" value="목록보기"
						style="font-size: 13px;" onclick="location.href='list?currentPage=${currentPage}'"/>
					<input type="hidden" id="id" name="id" value="${id}" size="4" /> 
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
						<div class="card-header bg-light">

							<img alt="Profile" src="${evc_vo.userImage}" width="30px" id="profile"/>
							<a class="profileView" onclick="profileView('${evc_vo.id}')">
								${evc_vo.nickname}
							</a>		
						
							<div align="right" style="margin-bottom: 5px;">
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
								<i style="color: grey">(삭제된 댓글입니다.)</i><br/><br/>
							</c:if>
							<c:if test="${evc_vo.del.equals('c')}">
								<i style="color: red">(관리자에 의해 삭제된 댓글입니다.)</i><br/><br/>
							</c:if>
							<c:if test="${!evc_vo.del.equals('y') && !evc_vo.del.equals('c')}">
								<div style="padding-right: 70px;">
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
										style="font-size: 15px; margin-left: 15px; margin-top: 15px; margin-bottom: 5px; float: left;"
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
									<c:if test="${!id.equals(evc_vo.id)}">
									<button 
										class="btn btn-danger btn-sm reportCommentBtn" 
										type="button" 
										id = "reportCommentBtn"
										style="font-size: 13px;"
									><i class="bi bi-exclamation-diamond-fill"></i> 신고</button>
									<span style="display: none;">
										<input 
											type="button" 
											id="realReportComment" 
											data-bs-toggle="modal" 
											data-bs-target="#report-modal" 
											data-bs-idx="${evc_vo.evc_idx}"
											data-bs-nickname="${evc_vo.nickname}" 
											data-bs-content="${evc_vo.evc_content}" 
											data-bs-location="eventboardComment"
											data-bs-title="댓글 신고" 
											data-bs-subject="${evc_vo.evc_content}"
										>
									</span>
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
										<div class="card-header bg-light">
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
												<span style="margin-left: 35px"><i style="color: grey">(삭제된 댓글입니다.)</i></span><br/><br/>
											</c:if>
											<c:if test="${reply_vo.del.equals('c')}">
												<span style="margin-left: 35px"><i style="color: red">(관리자에 의해 삭제된 댓글입니다.)</i></span><br/><br/>
											</c:if>
											<c:if test="${!reply_vo.del.equals('y') && !reply_vo.del.equals('c')}">
												<div style="padding-right: 70px; margin-left: 35px;">
													<c:set var="evc_content" value="${fn:replace(reply_vo.evc_content, '<', '&lt;')}"/>
													<c:set var="evc_content" value="${fn:replace(evc_content, '>', '&gt;')}"/>
													<c:set var="evc_content" value="${fn:replace(evc_content, enter, '<br/>')}"/>
													${evc_content}<br/>
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
												<c:if test="${!id.equals(reply_vo.id)}">
												<button 
													class="btn btn-danger btn-sm reportCommentBtn" 
													type="button" 
													id = "reportReplyBtn"
													style="font-size: 13px;"
												><i class="bi bi-exclamation-diamond-fill"></i> 신고</button>
												<span style="display: none;">
													<input 
														type="button" 
														id="realReportReply" 
														data-bs-toggle="modal" 
														data-bs-target="#report-modal" 
														data-bs-idx="${reply_vo.evc_idx}"
														data-bs-nickname="${reply_vo.nickname}" 
														data-bs-content="${reply_vo.evc_content}" 
														data-bs-location="eventboardComment"
														data-bs-title="댓글 신고" 
														data-bs-subject="${reply_vo.evc_content}"
													>
												</span>
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
	
	<!-- 오류/신고모달 Start -->
	<div class="modal" id="event-report-modal" tabindex="-1">
		<form action="reportOK" method="post" name="eventReportFrm" id="eventReportFrm">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h2 class="modal-title" id="modal-titlename"></h2>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<dl>
							<dt><span>편의점</span></dt>
							<dd id=cvs></dd>
							<dt><span>행사제목</span></dt>
							<dd id=eventSubject></dd>
						</dl>
						<!-- 신고 사유 선택 -->
						<dl>
							<dt><span>오류/신고사유</span></dt>
							<dd>
								<select class="form-select" id="event_report_reason" name="report_reason" style="width: 70%; display: inline !important;">
									<option selected="selected">==신고사유==</option>
									<option>잘못된 정보입니다.</option>
									<option>편의점명과 행사정보가 일치하지 않습니다.</option>
									<option>내용(혹은 이미지)가 제대로 나오지 않습니다.</option>
									<option>유해한 정보가 포함되어있습니다.</option>
									<option>기타</option>
								</select>
							</dd>
						</dl>
						<!-- 내용 입력 -->
						<dl>
							<dt><span>내용</span></dt>
							<dd>
								<textarea id="event_report_comment" name="report_comment"
									class="form-control form-control-sm" rows="5" placeholder="허위신고 시, 신고자의 서비스 활동이 제한될 수 있습니다."
									style="resize: none;"></textarea>
							</dd>
						</dl>
						<div style="display: none;">
							<input type="text" id="event_report_idx" name="report_idx"/>
							<input type="text" name="ev_idx" value="${ev_vo.ev_idx}"/>
							<input type="text" name="currentPage" value="${currentPage}"/>
							<input type="text" name="report_id" value="${id}"/>
							<input type="text" name="report_subject" id="event_report_subject">
							<input type="text" name="report_location" id="event_report_location">
						</div>
						<!-- 전송 버튼 -->
						<dl>
							<dd>
								<div align="right">
									<input type="button" class="btn btn-danger b=tn-sm" value="신고접수" id="eventReportOK"/>
								</div>
							</dd>
						</dl>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- 신고모달 End -->
	
	<!-- 신고모달 Start -->
	<div class="modal" id="report-modal" tabindex="-1">
		<form action="reportOK" method="post" name="reportFrm" id="reportFrm">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h2 class="modal-title" id="modal-title"></h2>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<dl>
							<dt><span>작성자</span></dt>
							<dd id=writer></dd>
							<dt><span>내용</span></dt>
							<dd id=report_content></dd>
						</dl>
						<!-- 신고 사유 선택 -->
						<dl>
							<dt><span>신고사유</span></dt>
							<dd>
								<select class="form-select" id="report_reason" name="report_reason" style="width: 70%; display: inline !important;">
									<option selected="selected">==신고사유==</option>
									<option>스팸홍보/도배글입니다.</option>
									<option>음란물입니다.</option>
									<option>불법정보를 포함하고 있습니다.</option>
									<option>욕설/혐오 등을 포함하고 있습니다.</option>
									<option>명예훼손 또는 저작권이 침해되었습니다.</option>
									<option>불법촬영물 등이 포함되어있습니다.</option>
									<option>기타</option>
								</select>
							</dd>
						</dl>
						<!-- 내용 입력 -->
						<dl>
							<dt><span>내용</span></dt>
							<dd>
								<textarea id="report_comment" name="report_comment"
									class="form-control form-control-sm" rows="5" placeholder="허위신고 시, 신고자의 서비스 활동이 제한될 수 있습니다."
									style="resize: none;"></textarea>
							</dd>
						</dl>
						<div style="display: none;">
							<input type="text" id="report_idx" name="report_idx"/>
							<input type="text" name="ev_idx" value="${ev_vo.ev_idx}"/>
							<input type="text" name="currentPage" value="${currentPage}"/>
							<input type="text" name="writer_id"/><!-- 추가할지는 고민해봐야함 -->
							<input type="text" name="report_id" value="${id}"/>
							<input type="text" name="report_subject" id="report_subject">
							<input type="text" name="report_location" id="report_location">
						</div>
						<!-- 전송 버튼 -->
						<dl>
							<dd>
								<div align="right">
									<input type="button" class="btn btn-danger b=tn-sm" value="신고접수" id="reportOK"/>
								</div>
							</dd>
						</dl>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- 신고모달 End -->
	
	
<!-- footer  -->
<%@ include file="../../util/hfer/footer.jsp" %>
	
	
</body>
</html>








