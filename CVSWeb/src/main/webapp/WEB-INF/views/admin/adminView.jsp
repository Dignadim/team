<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="icon" href="../images/favicon.png"/>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/adminpage.css">
<script type="text/javascript" src="../js/adminmember.js" defer></script>
</head>
<body onload="fixSelected()">

	<jsp:useBean id="date" class="java.util.Date" />

<!-- header -->
<%@ include file="../util/hfer/header.jsp" %>

	<c:if test="${id == null}">
		<script type="text/javascript">
			alert('적절하지 않은 접근입니다.');
			location.href='../';
		</script>
	</c:if>
	<c:if test="${grade.trim() == null || grade.trim() != 'y'}">
		<script type="text/javascript">
			alert('일반 회원은 접근할 수 없습니다.');
			location.href='../';
		</script>		
	</c:if>
	<c:if test="${id != null && grade.trim() != null && grade.trim() == 'y'}">
	
	<div id="contentLeft" style="padding: 30px;">
		<div class="body1 container" style= "overflow: auto">
		
			<c:set var="memberListSort" value="${memberListSort.list}" />
					
			<table class="table table-bordered" style="width: 100%;">

				<tr class="table-primary">
					<th colspan="5" style="font-size: 20px; text-align: center;">회원관리</th>

				</tr>
				<tr>
					<th colspan="5">
						<form action="admin" method="post" name="mbChkForm">
							<input type="hidden" name="mode" value="${mode}" id="mode"/>
							<select class="form-select" width="100"	onchange="memberCheck()" name="selectMember">
								<option value="1">모든회원</option>
								<option value="2">관리자</option>
								<option value="3">일반회원</option>
								<option value="4">차단회원</option>
							</select>
						</form>
					</th>
				</tr>

				<tr align="center" class="table-light">
					<th>아이디</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>가입일</th>
					<th>상태</th>
				</tr>
				<c:forEach var="memberListSort" items="${memberListSort}">

					<tr>
			
						<td align= center>
							<a href="../member/management?id=${memberListSort.id}"  onClick="window.open(this.href, '', 'width=600, height=600'); return false;">${memberListSort.id}</a>
						</td>
						<td align="center">
							${memberListSort.nickname}
						</td>
						<td align="center">
							${memberListSort.email}
						</td>
						<td align="center">
							<fmt:formatDate value="${memberListSort.signupdate}" pattern="yyyy.MM.dd"/>
						</td>
						<td align="center">
							<c:if test="${memberListSort.grade eq 'n'}">
								정상
							</c:if>
							<c:if test="${memberListSort.grade eq 'y'}">
								관리자
							</c:if>
							<c:if test="${memberListSort.grade eq 'b'}">
								차단
							</c:if>
						</td>	
						
								
								
								
								
					</tr>
				</c:forEach>
				
				
				<tr>
					<td colspan="4" align="right">
						<input type="text" class="form-control" placeholder="아이디를 입력하세요." style="width: 200px;">
					</td>
					<td colspan="1">
						<button type="button" class="btn btn-primary btn-modal"	onclick="memberAdministrate()">검색</button>
					</td>
				</tr>
			</table>
		
		
		</div><br/>

		<div class="body1 container" style= "overflow: auto">
			<!-- 회원 관리  -->
<c:set var="memberList" value="${memberList.list}" />

			<table class="table" style="width: 100%; padding-top: 20px;">
				<tr class="table-primary">
					<th colspan="2" style="font-size: 20px; text-align: center;">신규가입</th>
				</tr>
				<c:forEach var="mb_vo" items="${memberList}">
					<c:if
						test="${date.year == mb_vo.signupdate.year && date.month == mb_vo.signupdate.month}">
						<tr>
							<th align="center" width="70px;">
								<img style="width: 30px;" alt="프로필사진"	src="../images/profile.jpg">
							</th>
							<th align="center" style="vertical-align: middle;">${mb_vo.nickname}님이 새로 가입하셨습니다.</th>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div><br/>

		</div>
	
		<!-- 공지글 -->
<div id="contentRight" style="padding: 30px;">
		<div class="body3 container" style= "overflow: auto">
			
			<table class="table" style="margin-left: auto; margin-right: auto; max-width: 700px; width: 700px;">
				<tr class="table-primary">
					<th colspan="5" style="font-size: 20px; text-align: center;">공지글</th>
				</tr>

				<tr class="table-light">
					<th style="width: 120px; text-align: center;">게시판 이름</th>
					<th style="width: 390px; text-align: center;">제목</th>
					<th style="width: 90px; text-align: center;">닉네임</th>
					<th style="width: 100px; text-align: center;">작성일</th>
				</tr>




				<c:set var="list" value="${freeboardList.list}" />

				<c:if test="${list.size() == 0}">
					<tr>
						<td colspan="5"><marquee>테이블에 저장된 글이 없습니다.</marquee></td>
					</tr>
				</c:if>

				<c:if test="${list.size() != 0}">

					<c:forEach var="fb_vo" items="${list}">
						<tr>
							<td align="center">자유게시판</td>
							<td align="center"><i class="bi bi-tags"></i> 
							<c:set var="fb_subject"	value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}" /> 
							<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}" />
							<a href="../free/contentView?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">${fb_subject} (${fb_vo.fb_commentCount})</a>
								<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
									<img alt="New" src="../images/ic_new.gif" />
								</c:if>
							</td>
							<td align="center">${nickname}</td>
							<td align="center"><c:if
									test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
									<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm" />
								</c:if> <c:if
									test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
									<fmt:formatDate value="${fb_vo.fb_date}"
										pattern="yyyy.MM.dd(E)" />
								</c:if></td>

						</tr>

					</c:forEach>
				</c:if>

					<tr>
		 
				 <c:set var="list" value="${eventboardList.list}" />


				<c:if test="${list.size() != 0}">

					<c:forEach var="ev_vo" items="${list}">
						<tr>
							<td align="center">이벤트게시판</td>
							<td align="center"><i class="bi bi-tags"></i> 
							<c:set var="ev_subject"	value="${fn:replace(ev_vo.ev_subject, '<', '&lt;')}" /> 
							<c:set var="ev_subject" value="${fn:replace(ev_subject, '>', '&gt;')}" />
							<a href="../event/contentView?ev_idx=${ev_vo.ev_idx}&currentPage=${eventboardList.currentPage}">${ev_subject} (${ev_vo.ev_commentCount})</a>
								<c:if test="${date.year == ev_vo.ev_date.year && date.month == ev_vo.ev_date.month && date.date == ev_vo.ev_date.date}">
									<img alt="New" src="../images/ic_new.gif" />
								</c:if>
							</td>
							<td align="center">${nickname}</td>
							<td align="center"><c:if
									test="${date.year == ev_vo.ev_date.year && date.month == ev_vo.ev_date.month && date.date == ev_vo.ev_date.date}">
									<fmt:formatDate value="${ev_vo.ev_date}" pattern="a h:mm" />
								</c:if> <c:if
									test="${date.year != ev_vo.ev_date.year || date.month != ev_vo.ev_date.month || date.date != ev_vo.ev_date.date}">
									<fmt:formatDate value="${ev_vo.ev_date}"
										pattern="yyyy.MM.dd(E)" />
								</c:if></td>

						</tr>

					</c:forEach>
				</c:if>
 

					</table>

		</div>
	</div>




	<div class="body2 container" style= "display:none">
		<!--  월 방문자 표시 그래프 -->
		그래프 구현
	</div>
	</c:if>

<!-- footer  -->
<%@ include file="../util/hfer/footer.jsp" %>



</body>
</html>