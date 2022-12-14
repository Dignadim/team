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
<link rel="icon" href="../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="../js/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript" src="../js/itemView.js" defer></script>
</head>
<body>

<!-- header -->
<%@ include file="../util/hfer/header.jsp" %>
	
	<input type="hidden" id="itemIdx" value="${vo.idx}">
	<div class="container" style="margin-top: 50px; width: 1200px">
		<table class="table table-bordered">
			<thead>
				<tr class="table-primary">
					<th class="info" colspan="2" style="text-align: left; vertical-align: middle;">
						<div style="vertical-align: middle; font-size: 30px; margin: 10px 5px;">
							선택 상품 보기
						</div>
					</th>
					<th colspan="1" style="text-align: right; vertical-align: middle;">
						<input type="hidden" value="1" id="myItemToggle">
						<c:if test="${id != null}">
							<a href="#" onclick="myItem('${id}', '${vo.idx}')" id="myItemInner">
								<img alt="찜" src="../images/heart-black.png" id="myItemOn" style="height: 35px; text-align: right; margin-right: 30px;">									
							</a>										
						</c:if>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="8" width="550px;" style="vertical-align: middle;">
						<c:if test="${vo.itemImage.indexOf('http') == -1}">
						<img alt="상품 이미지" src="..${vo.itemImage}" style="height: 500px; width: 500px; border-radius: 10px;">
						</c:if>
						<c:if test="${vo.itemImage.indexOf('http') != -1}">
						<img alt="상품 이미지" src="${vo.itemImage}" style="height: 500px;width: 500px;  border-radius: 10px;">
						</c:if>
					</td>
				</tr>
				<tr>
					<th width="200px" style="vertical-align: middle; text-align: center;">상품명</th>
					<td width="650px" style="padding: 10px 20px;">
						${vo.itemName}
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle; text-align: center;">카테고리</th>
					<td style="padding: 10px 20px;">
						${vo.category}
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle; text-align: center;">가격</th>
					<td  style="padding: 10px 20px;">
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
					<th style="vertical-align: middle; text-align: center;">판매 편의점</th>
					<td style="padding: 10px 20px;">
						<c:if test="${vo.sellCVS.trim() == 'CU'}">
							<img alt="CU logo" src="../images/cu.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.3821600492383!2d126.98137292694796!3d37.5696178151788!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8997954a9%3A0xa2ed1e3817e7b2d9!2zQ1Ug7KKF66Gc7KSR7JWZ7KCQ!5e0!3m2!1sko!2skr!4v1668227950249!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS == 'GS25'}">
							<img alt="GS logo" src="../images/gs25.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1935.4668399954119!2d126.98242737232472!3d37.569456602090085!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8dcae3cc9%3A0x94a435a373a6744!2zR1MyNSDsooXqsIHsoJA!5e0!3m2!1sko!2skr!4v1668228075583!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS == '세븐일레븐'}">
							<img alt="711 logo" src="../images/7eleven.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1581.2017416599197!2d126.98376299081372!3d37.56911559768425!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8cf20e3b9%3A0x89d788e635b74329!2z7IS467iQ7J2866CI67iQIOyiheqwgeygkA!5e0!3m2!1sko!2skr!4v1668228222061!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
								
						</c:if>
						<c:if test="${vo.sellCVS == 'ministop'}">
							<img alt="mini logo" src="../images/ministop.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1070.6773883622582!2d126.98381273587631!3d37.56899528979441!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e8d27b7071%3A0x6d7f39083e9cb50f!2z66-464uI7Iqk7YaxIOyyreqzhOyEvO2EsOygkA!5e0!3m2!1sko!2skr!4v1668228185522!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS == '이마트24'}">
							<img alt="emart logo" src="../images/emart24.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6324.67179741723!2d126.97837037619794!3d37.570707368254006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e91d47728f%3A0x4598afb5329bec27!2z7J2066eI7Yq4MjTsooXroZztg4Dsm4zsoJA!5e0!3m2!1sko!2skr!4v1668399063235!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
						<c:if test="${vo.sellCVS != 'CU' && vo.sellCVS != 'GS25' && vo.sellCVS != '세븐일레븐' && vo.sellCVS != 'ministop' && vo.sellCVS != '이마트24'}">
							<img alt="other logo" src="../images/other.png" height="25px"><br/>
							<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.3744758438597!2d126.98140911744352!3d37.56979879644267!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2e7a005c9c5%3A0xac4890a924a29f30!2z642U7KGw7J2A7Lu07ZOo7YSw7JWE7Lm0642w66-47ZWZ7JuQIOyiheuhnOy6oO2NvOyKpA!5e0!3m2!1sko!2skr!4v1668226910469!5m2!1sko!2skr" width="300" height="300" style="border:0; border-radius: 150px"  loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
						</c:if>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle; text-align: center;">행사</th>
					<td style="padding: 10px 20px;">
						${vo.eventType}
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle; text-align: center;">평점</th>
					<td style="padding: 10px 20px;">
						<input type="hidden" id="originalItemAverscore" value="${vo.averscore}">				
						<c:if test="${vo.averscore < 0.5}">
							${vo.averscore}/5.0
						</c:if>
						<c:if test="${vo.averscore >= 0.5 && vo.averscore < 1}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/halfstar.png" height="20px">)
						</c:if>						
						<c:if test="${vo.averscore >= 1 && vo.averscore < 1.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 1.5 && vo.averscore < 2}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 2 && vo.averscore < 2.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 2.5 && vo.averscore < 3}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 3 && vo.averscore < 3.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 3.5 && vo.averscore < 4}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 4 && vo.averscore < 4.5}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore >= 4.5 && vo.averscore < 5}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/halfstar.png" height="20px">)
						</c:if>
						<c:if test="${vo.averscore == 5}">
							${vo.averscore}/5.0(<img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px"><img alt="별점" src="../images/star.png" height="20px">)						
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
									<input type="button" class="btn btn-outline-success btn-sm" value="확인" onclick="updateAverscore()" style="width: 60px;">
								</td>
								</c:if>						
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th align="center" style="vertical-align: middle; text-align: center;">해시태그</th>
					<td align="center">
						<div style="padding: 8px;">${vo.hashTag}</div>
						<div style="color: gray; font-size: 12px;">해시태그를 클릭하면 랜덤 상품을 추천해드려요!</div>
						<div id="hashItem">
							<c:set var="hitem" value="${itemList.list}"/>
							<table>
								<tr>
									<c:forEach var="h" items="${hitem}" varStatus="i">
									<th style="margin: 5px; padding: 2px 5px;">
										<div id="hov_item" style="padding: 3px; margin: 3px;" align="center">										
											<a href="increment?idx=${h.idx}&currentPage=${itemList.currentPage}&job=itemView">
												<img alt="이미지" src="${h.itemImage}" style="width: 100px; height: 100px;">
												<br/>${h.itemName}																					
											</a>
										</div>
									</th>
									</c:forEach>
								</tr>
							</table>								
						</div>
					</td>
				</tr>				
				<tr>
					<td colspan="1" align="left">
						<c:if test="${grade == 'y'}">
							<button class="btn btn-outline-info" onclick="location.href='itemUpdate?idx=${vo.idx}&currentPage=${currentPage}'">수정</button>
							<button class="btn btn-outline-info" onclick="location.href='itemDelete?idx=${vo.idx}&currentPage=${currentPage}'">삭제</button>
						</c:if>
					</td>
					<td colspan="2" align="right">
						<button class="btn btn-outline-secondary" onclick="location.href='list?currentPage=${currentPage}'">돌아가기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div><br/>
	
	<div align="center">
		<c:if test="${maxidx > vo.idx}">
			<button class="btn btn-outline-primary" title="이전 상품" onclick="location.href='?idx=${vo.idx+1}&currentPage=1&job=itemView'">＜</button>	
		</c:if>
		<c:if test="${vo.idx > 1}">
			<button class="btn btn-outline-primary" title="다음 상품" onclick="location.href='?idx=${vo.idx-1}&currentPage=1&job=itemView'">＞</button>	
		</c:if>
	</div>
	
	<hr style="width: 1000px; margin-left: auto; margin-right: auto;"/><br/>
	
	<c:set var="comment" value="${itemCommentList.list}"/>
	<form class="m-3" action="itemCommentOK" method="post" name="itemCommentForm">
		<table class="table" style="width: 1200px; margin-left: auto; margin-right: auto;">
			<!-- 댓글 입력, 수정, 삭제 -->
			<tr class="table-primary">
				<th colspan="4">댓글(${comment.size()})</th>
			</tr>			
			<!-- <tr style="display: none;"> -->
			<tr>
				<td colspan="4" style="display: none;">
					itemIdx: <input type="text" name="itemIdx" value="${vo.idx}" size="1">
					gup: <input type="text" id="itemCommentGup" name="gup" value="${vo.idx}" size="1">
					currentPage: <input type="text" id="itemCommentCurrentPage" name="currentPage" value="${currentPage}" size="1">
					nickname: <input type="text" name="nickname" value="${nickname}">
					id: <input type="text" name="ID" value="${id}">
					mode: <input type="text" name="mode" value="1">
				</td>
			</tr>
			
			<tr>
				<th colspan="1" class="align-middle" style="width: 150px; text-align: center;">
					<label for="content">내용</label>
				</th>
				<th colspan="2" style="width: 550px;">
					<c:if test="${nickname != null}">
						<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;" placeholder="댓글을 입력해주세요."></textarea>
					</c:if>
					<c:if test="${nickname == null}">						
						<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;" placeholder="로그인을 해야 댓글을 입력할 수 있습니다." disabled></textarea>
					</c:if>
				</th>
				<th colspan="1" style="width: 200px; vertical-align: middle;" align="center">
					<c:if test="${nickname != null}">
						<input class="btn btn-outline-primary" type="button" name="insertBtn" value="저장" style="margin: auto;" onclick="commentEmptyChk()"/>				
					</c:if>
					<c:if test="${nickname == null}">
						<input class="btn btn-outline-secondary" type="button" name="insertBtn" value="저장" style="margin: auto;" disabled/>					
					</c:if>						
				</th>
			</tr>
		</table><br/>
		<table class="table" style="width: 1200px; margin-left: auto; margin-right: auto;">	
			<tr class="table table-light">
				<th width="150px" style="vertical-align: middle; text-align: center;">닉네임(아이디)</th>
				<th width="80px" style="vertical-align: middle; text-align: center;">평가</th>			
				<th width="720px" style="vertical-align: middle; text-align: center;">내용</th>
				<th width="350px" style="vertical-align: middle;text-align: center;" >작성시각</th>
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
						<td style="vertical-align: middle; text-align: center;">${co.nickname}(${co.ID})</td>
						<td style="vertical-align: middle; text-align: center;">
							<c:forEach var="ao" items="${ao.list}">
								<c:if test="${ao.ID == co.ID}">
									${ao.averscore}점
								</c:if>
							</c:forEach>
						</td>
						<c:set var="content" value="${fn:replace(co.content, '<', '&lt;')}"/>
						<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
						<c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
						<td style="vertical-align: middle; text-align: left; max-width: 650px;">${content}</td>
						<td style="vertical-align: middle;">
							<input type="hidden" id="itemCommentIdx" name="idx" value="${co.idx}" size="1"> 
							<input type="hidden" name="comment" value="${content}" size="1"> 
							<fmt:formatDate value="${co.writeDate}" pattern="yyyy.MM.dd(E) a h:mm:ss"/>	
							<c:if test="${id == co.ID && id != null}">
								<input type="button" class="btn btn-outline-warning btn-sm" onclick="test('${co.idx}', 2, '수정', '${content}')" value="수정" style="display: inline !important;"/>
								<input type="button" class="btn btn-outline-danger btn-sm" onclick="deleteItemComment('${co.idx}', 3)" value="삭제" style="display: inline !important;"/>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</form>

<!-- footer  -->
<%@ include file="../util/hfer/footer.jsp" %>

</body>
</html>