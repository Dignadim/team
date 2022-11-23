<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개별 페이지</title>
<link rel="icon" href="../../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="../../js/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript" src="../../js/itemView.js" defer></script>
</head>
<body>

	<!-- header -->
	<header>
		<div class="container-fluid">
			<nav class="navbar navbar-expand-sm bg-light">
				<div class="col-sm-2">
					<a href="../connectMain.jsp"><img src="../../images/teamlogo.png" style="width: 30px;"></a>
				</div>
				<div class="container-fluid col-sm-5">
					<ul class="navbar-nav">
						<li class="nav-item" style="padding-right: 70px;">
					    	<a class="nav-link" href="itemList.jsp?">모든 상품 보기</a>
					    </li>					
						<li class="nav-item dropdown" style="padding-right: 70px;">
							<a class="nav-link" href=".././board/event/list.jsp">모든 행사 보기</a>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" role="button"	data-bs-toggle="dropdown">게시판</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="../board/free/list.jsp">자유게시판</a></li>
								<li><a class="dropdown-item" href="../board/rank/rank.jsp">랭킹게시판</a></li>
								<li><a class="dropdown-item" href="../new/new.jsp">신상게시판</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- 검색은 추후 구현 -->
				<div class="col-sm-2">
					<input type="text" class="form-control" placeholder="검색할 내용을 입력하세요." style="width: 200px; display: none;">
				</div> 
				<div class="col-sm-1">
					<button type="button" class="btn btn-primary" onclick="#" style="display:none;">검색</button>
				</div>
				<div class="col-sm-2">
					<c:if test="${id == null}">
						<button type="button" class="btn btn-primary" onclick="location.href='../logRegi/login_form.jsp'">로그인</button>	
					</c:if>				
					<c:if test="${id != null}">
						<button type="button" class="btn btn-danger" onclick="location.href='../logRegi/login_out.jsp'">로그아웃</button>
						<c:if test="${grade.trim() != null && grade.trim() == 'y'}">
							<button class="btn btn-info" style="padding: 6px;" onclick="location.href='../admin/connectadmin.jsp'">관리 페이지로</button>	
						</c:if>
						<c:if test="${grade.trim() == null || grade.trim() != 'y'}">
							<button type="button" class="btn btn-warning" onclick="location.href='../myPage/myPageView.jsp'">마이페이지</button>	
							<input type="hidden" value="${grade}">
						</c:if>
					</c:if>					
				</div>
			</nav>
		</div>
	</header>
	<br/><br/>
	
	<input type="hidden" id="itemIdx" value="${vo.idx}">
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
						<img alt="상품 이미지" src="${vo.itemImage}" style="height: 500px; border-radius: 10px;">
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
						<fmt:formatNumber value="${vo.itemPrice}" pattern="#,###원"/>
						<c:if test="${vo.eventType == '1+1'}">
							<br/><fmt:formatNumber value="${vo.itemPrice / 2}" pattern="(개당 #,###.0원)"/>
						</c:if>
						<c:if test="${vo.eventType == '2+1'}">
							<br/><fmt:formatNumber value="${vo.itemPrice / 3 * 2}" pattern="(개당 #,###.0원)"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>판매 편의점</th>
					<td>
						<c:if test="${vo.sellCVS.trim() == 'CU'}">
							<img alt="CU logo" src="../../images/cu.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.3821600492383!2d126.98137292694796!3d37.5696178151788!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8997954a9%3A0xa2ed1e3817e7b2d9!2zQ1Ug7KKF66Gc7KSR7JWZ7KCQ!5e0!3m2!1sko!2skr!4v1668227950249!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS == 'GS25'}">
							<img alt="GS logo" src="../../images/gs25.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1935.4668399954119!2d126.98242737232472!3d37.569456602090085!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8dcae3cc9%3A0x94a435a373a6744!2zR1MyNSDsooXqsIHsoJA!5e0!3m2!1sko!2skr!4v1668228075583!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS == '세븐일레븐'}">
							<img alt="711 logo" src="../../images/7eleven.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1581.2017416599197!2d126.98376299081372!3d37.56911559768425!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8cf20e3b9%3A0x89d788e635b74329!2z7IS467iQ7J2866CI67iQIOyiheqwgeygkA!5e0!3m2!1sko!2skr!4v1668228222061!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
								
						</c:if>
						<c:if test="${vo.sellCVS == 'ministop'}">
							<img alt="mini logo" src="../../images/ministop.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1070.6773883622582!2d126.98381273587631!3d37.56899528979441!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8d27b7071%3A0x6d7f39083e9cb50f!2z66-464uI7Iqk7YaxIOyyreqzhOyEvO2EsOygkA!5e0!3m2!1sko!2skr!4v1668228185522!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS == '이마트24'}">
							<img alt="emart logo" src="../../images/emart24.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6324.67179741723!2d126.97837037619794!3d37.570707368254006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e91d47728f%3A0x4598afb5329bec27!2z7J2066eI7Yq4MjTsooXroZztg4Dsm4zsoJA!5e0!3m2!1sko!2skr!4v1668399063235!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS != 'CU' && vo.sellCVS != 'GS25' && vo.sellCVS != '세븐일레븐' && vo.sellCVS != 'ministop' && vo.sellCVS != '이마트24'}">
							<img alt="other logo" src="../../images/other.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.3744758438597!2d126.98140911744352!3d37.56979879644267!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e7a005c9c5%3A0xac4890a924a29f30!2z642U7KGw7J2A7Lu07ZOo7YSw7JWE7Lm0642w66-47ZWZ7JuQIOyiheuhnOy6oO2NvOyKpA!5e0!3m2!1sko!2skr!4v1668226910469!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
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
						<input type="hidden" id="originalItemAverscore" value="${vo.averscore}">				
						<c:if test="${vo.averscore < 0.5}">
							${vo.averscore}/5.0
						</c:if>
						<c:if test="${vo.averscore >= 0.5 && vo.averscore < 1}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/halfstar.png" height="20px">)
						</c:if>						
						<c:if test="${vo.averscore >= 1 && vo.averscore < 1.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 1.5 && vo.averscore < 2}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 2 && vo.averscore < 2.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 2.5 && vo.averscore < 3}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 3 && vo.averscore < 3.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 3.5 && vo.averscore < 4}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 4 && vo.averscore < 4.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 4.5 && vo.averscore < 5}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore == 5}">
							${vo.averscore}/5.0(<img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px"><img alt="별점" src="../../images/star.png" height="20px">)						
						</c:if>
						<br/>
						<table>
							<tr>
								<c:if test="${nickname == null}">
									<span style="color: gray;">(평점 등록은 로그인한 회원만 가능합니다.)</span>
								</c:if>
								<c:if test="${nickname != null}">
								<td style="vertical-align: middle;">
									평점 등록:
								</td>
								<td>
									<input type="number" class="form-control" max="5" min="0" id="updateAverscore" style="height: 30px; width: 70px; margin: 3px 15px; "> 
								</td>
								<td>
									<input type="button" class="btn btn-outline-success" value="확인" onclick="updateAverscore()" style="width: 60px;">
								</td>
								</c:if>						
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="1" align="left">
						<c:if test="${grade == 'y'}">
							<button class="btn btn-outline-info" onclick="location.href='itemSelectByIdx.jsp?idx=${vo.idx}&currentPage=${currentPage}&job=itemUpdate'">수정</button>
							<button class="btn btn-outline-info" onclick="location.href='itemSelectByIdx.jsp?idx=${vo.idx}&currentPage=${currentPage}&job=itemDelete'">삭제</button>
						</c:if>
					</td>
					<td colspan="2" align="right">
						<button class="btn btn-outline-secondary" onclick="location.href='itemList.jsp?currentPage=${currentPage}'">돌아가기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div><br/>
	
	<hr style="width: 1000px; margin-left: auto; margin-right: auto;"/><br/>
	
	<c:set var="comment" value="${itemCommentList.list}"/>
	<form class="m-3" action="itemCommentOK.jsp" method="post" name="itemCommentForm">
		<table class="table" style="width: 1400px; margin-left: auto; margin-right: auto;">
			<!-- 댓글 입력, 수정, 삭제 -->
			<tr class="table-primary">
				<th colspan="4">댓글(${comment.size()})</th>
			</tr>			
			<!-- <tr style="display: none;"> -->
			<tr>
				<td colspan="4" style="display: none;">
					gup: <input type="text" id="itemCommentGup" name="gup" value="${vo.idx}" size="1">
					currentPage: <input type="text" id="itemCommentCurrentPage" name="currentPage" value="${currentPage}" size="1">
					nickname: <input type="text" name="nickname" value="${nickname}">
					id: <input type="text" name="ID" value="${id}">
					mode: <input type="text" name="mode" value="1">
				</td>
			</tr>
			
			<tr>
				<th colspan="1" class="align-middle" style="width: 100px; text-align: center;">
					<label for="content">내용</label>
				</th>
				<th colspan="2" style="width: 600px;">
					<c:if test="${nickname != null}">
						<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;" placeholder="댓글을 입력해주세요."></textarea>
					</c:if>
					<c:if test="${nickname == null}">						
						<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;" placeholder="로그인을 해야 댓글을 입력할 수 있습니다." disabled></textarea>
					</c:if>
				</th>
				<th colspan="1" style="width: 200px; vertical-align: middle;" align="center">
					<c:if test="${nickname != null}">
						<input class="btn btn-outline-primary btn-sm" type="button" name="insertBtn" value="저장" style="margin: auto;" onclick="commentEmptyChk()"/>				
					</c:if>
					<c:if test="${nickname == null}">
						<input class="btn btn-outline-secondary btn-sm" type="button" name="insertBtn" value="저장" style="margin: auto;" disabled/>					
					</c:if>						
				</th>
			</tr>
		</table>
		<table class="table" style="width: 1400px; margin-left: auto; margin-right: auto;">	
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
						<td>${co.nickname}(${co.ID})</td>
						<c:set var="content" value="${fn:replace(co.content, '<', '&lt;')}"/>
						<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
						<c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
						<td> ${content}</td>
						<td>
							<input type="hidden" id="itemCommentIdx" name="idx" value="${co.idx}" size="1"> 
							<fmt:formatDate value="${co.writeDate}" pattern="yyyy.MM.dd(E) a h:mm:ss"/>	
							<c:if test="${id == co.ID && id != null}">
							<span>
								<input type="button" class="btn btn-outline-warning" onclick="test('${co.idx}', 2, '수정', '${content}')" value="수정"/>
							</span>
							<span>
								<input type="button" class="btn btn-outline-danger" onclick="deleteItemComment('${co.idx}', '${currentPage}', '${vo.idx}')" value="삭제"/>
							</span>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</form>

	<!-- footer  -->
	<footer>
		<div class="container-fluid" style="background-color: #f8f9fa; color: #777;">
			<div class="row" style="padding: 30px; font-size: 16px;" align="center">
				<div class="col-sm-3">
					&nbsp;
				</div>
				<div class="col-sm-6">
					<br/>
					&copy;4조&nbsp;&nbsp;최성민&nbsp;&nbsp;길동현&nbsp;&nbsp;김민주&nbsp;&nbsp;신수혁&nbsp;&nbsp;최형록
					&nbsp;<br/>
				</div>
				<div class="col-sm-3">
					&nbsp;
				</div>
			</div>
		</div>
	</footer>

</body>
</html>