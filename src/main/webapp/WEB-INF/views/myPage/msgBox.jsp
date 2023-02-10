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

	<div class="m-3 p-3 container" align="center">
		<div align="right">
			<input type="button" style="margin: 5px; width: 25px;" class="btn btn-close" onclick="self.close()">
		</div>		
		<table>
			<tr>
				<th>
					<span class="tog tog1" onclick="tog1()">받은 쪽지함</span>
				</th>
				<th>
					<span class="tog tog2" onclick="tog2()">보낸 쪽지함</span>
				</th>
				<th>
					<span class="tog tog3" onclick="tog3()">휴지통</span>
				</th>
			</tr>
		</table>
		<div class="mlist" id="mlist" style="display: block; overflow: auto;">
			<div style="font-size: 30px; margin: 50px 10px 20px 10px;;">받은 쪽지함</div>
			<c:if test="${grade != 'b'}">
				<div style="font-size: 13px; margin: 10px 3px;">메시지를 클릭하면 바로 답장을 보낼 수 있습니다!</div>
			</c:if>
			<c:if test="${grade == 'b'}">
				<div style="font-size: 13px; margin: 10px 3px;">차단당한 회원은 답장을 보낼 수 없습니다!</div>
			</c:if>
			<table class="table table-border">
				<tbody>
					<tr class="bg-light">
						<th width="100px;" style="vertical-align: middle; text-align: center">보낸 사람</th>
						<th width="300px;" style="vertical-align: middle; text-align: center">내용</th>
						<th width="100px;" style="vertical-align: middle; text-align: center">보낸 시각</th>
					</tr>
					<c:set var="mlist" value="${msgList.list}"/>
					<c:forEach var="mvo" items="${mlist}">
						<tr>
							<td style="vertical-align: middle;">
								<a class="profileView" onclick="profileView('${mvo.mid}')">
									${mvo.mid}
								</a>						
							</td>
							<td style="vertical-align: middle;">
							<c:if test="${grade != 'b'}">
								<a onclick="opmd('${mvo.mid}', '${id}')">
								<c:if test="${mvo.notice == 'y'}">
								[공지]
								</c:if>
								${mvo.msg}
								</a>
							</c:if>
							<c:if test="${grade == 'b'}">
								<c:if test="${mvo.notice == 'y'}">
								[공지]
								</c:if>
								${mvo.msg}							
							</c:if>							
							</td>
							<td style="vertical-align: middle;">
								<fmt:formatDate value="${mvo.msgDate}" pattern="yyyy.MM.dd(E) a h:mm"/>&nbsp;&nbsp;&nbsp;<img src="../images/bin.png" class="goTrash" onclick="goTrash('${mvo.msgIdx}', '${mvo.fid}', 1)" style="width: 16px;">
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<form action="goMsg" method="post" name="insertMsg">
				<div class="modal-dialog" style="display: none; margin: 20px; padding: 10px;">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="staticBackdropLabel">답장 보내기</h1>
							<button type="button" class="btn-close" onclick="clmd()"></button>
						</div>
						<div class="modal-body">
							<div>보내는 사람: ${nickname}(${id})</div>
							<input type="hidden" id="mid" name="mid">
							<input type="hidden" id="fid" name="fid">
							<textarea rows="10" class="form-control form-control-sm" name="msg" style="resize: none;" id="msg"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" onclick="goMsg()">전송</button>
						</div>
					</div>
				</div>
			</form>		
		</div>	
		<div class="tlist" id="tlist" style="display: none; overflow: auto;">
			<div style="font-size: 30px; margin: 50px 10px;">보낸 쪽지함</div>
			<table class="table table-border">
				<tbody>
					<tr class="bg-light">
						<th width="100px;" style="vertical-align: middle; text-align: center">받은 사람</th>
						<th width="300px;" style="vertical-align: middle; text-align: center">내용</th>
						<th width="100px;" style="vertical-align: middle; text-align: center">보낸 시각</th>
					</tr>
					<c:set var="tlist" value="${toList.list}"/>
					<c:forEach var="tvo" items="${tlist}">
						<tr>
							<td style="vertical-align: middle;">
								<a class="profileView" onclick="profileView('${tvo.fid}')">
									${tvo.fid}
								</a>						
							</td>
							<td style="vertical-align: middle;">${tvo.msg}</td>
							<td style="vertical-align: middle;">
								<fmt:formatDate value="${tvo.msgDate}" pattern="yyyy.MM.dd(E) a h:mm"/>&nbsp;&nbsp;&nbsp;<img src="../images/bin.png" class="goTrash" onclick="goTrash('${tvo.msgIdx}', '${tvo.mid}', 2)"  style="width: 16px;">
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="trashlist" id="trashlist" style="display: none; overflow: auto;">
			<div style="font-size: 30px; margin: 50px 10px;">휴지통</div>
			<table class="table table-border">
				<tbody>
					<tr class="bg-light">
						<th width="100px;" style="vertical-align: middle; text-align: center">보낸 -> 받은</th>
						<th width="300px;" style="vertical-align: middle; text-align: center">내용</th>
						<th width="100px;" style="vertical-align: middle; text-align: center">보낸 시각</th>
					</tr>
					<c:set var="trashlist" value="${trashList.list}"/>
					<c:forEach var="trashvo" items="${trashlist}">
						<tr>
							<td style="vertical-align: middle;">
								<a class="profileView" onclick="profileView('1, ${trashvo.fid}')">
									${trashvo.mid} -> ${trashvo.fid}
								</a>						
							</td>
							<td style="vertical-align: middle;">${trashvo.msg}</td>
							<td style="vertical-align: middle;">
								<fmt:formatDate value="${trashvo.msgDate}" pattern="yyyy.MM.dd(E) a h:mm"/>&nbsp;&nbsp;&nbsp;<img src="../images/recover.png" class="goTrash" onclick="recover('${trashvo.msgIdx}', '${id}')"  style="width: 16px;">
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
</body>
</html>