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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
						<c:if test="${id == null}">
							<div style="color: gray; margin-right: 30px;">찜 기능은 로그인한 회원만 가능합니다.</div>
						</c:if>
						<c:if test="${id != null}">
							<c:if test="${grade.trim() == null || grade.trim() != 'y'}">
								<a href="#" onclick="myItem('${id}', '${vo.idx}')" id="myItemInner">
									<img alt="찜" src="../images/heart-black.png" id="myItemOn" style="height: 35px; text-align: right; margin-right: 30px;">									
								</a>										
							</c:if>
						</c:if>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<c:if test="${vo.eventType != '덤증정'}">
						<td rowspan="8" width="550px;" style="vertical-align: middle;">
					</c:if>					
					<c:if test="${vo.eventType == '덤증정'}">
						<td rowspan="9" width="550px;" style="vertical-align: middle;">
					</c:if>					
						<c:if test="${vo.itemImage.indexOf('http') == -1}">
							<c:if test="${vo.sellCVS == 'CU'}">		
								<img alt="상품 이미지" src="https://${vo.itemImage}" style="height: 500px; width: 500px; border-radius: 10px;">
							</c:if>
							<c:if test="${vo.sellCVS != 'CU'}">		
								<img alt="상품 이미지" src="${vo.itemImage}" style="height: 500px; width: 500px; border-radius: 10px;">
							</c:if>
						</c:if>
						<c:if test="${vo.itemImage.indexOf('http') != -1}">
						<img alt="상품 이미지" src="${vo.itemImage}" style="height: 500px;width: 500px;  border-radius: 10px;">
						</c:if>
					</td>
				</tr>
				<tr>
					<th width="250px" style="vertical-align: middle; text-align: center;">상품명</th>
					<td width="600px" style="padding: 10px 20px;">
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
						<c:if test="${vo.eventType == '할인'}">
							할인가:&nbsp;
						</c:if>
						<fmt:formatNumber value="${vo.itemPrice}" pattern="#,###원"/>&nbsp;
						<c:if test="${vo.eventType == '1+1'}">
							<span style="font-size: 14px;"><fmt:formatNumber value="${vo.itemPrice / 2}" pattern="(개당 #,###.0원)"/></span>
						</c:if>
						<c:if test="${vo.eventType == '2+1'}">
							<span style="font-size: 14px;"><fmt:formatNumber value="${vo.itemPrice / 3 * 2}" pattern="(개당 #,###.0원)"/></span>
						</c:if>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle; text-align: center;">근처<br/>${vo.sellCVS}</th>
					<td style="padding: 10px 20px;">
						<input type="hidden" value="${vo.sellCVS}" id="CVSforMapSearch">
						<c:if test="${vo.sellCVS.trim() == 'CU'}">
							<img alt="CU logo" src="../images/cu.png" class="logoImg"><br/>
						</c:if>
						<c:if test="${vo.sellCVS == 'GS25'}">
							<img alt="GS logo" src="../images/gs25.png" class="logoImg"><br/>
						</c:if>
						<c:if test="${vo.sellCVS == '세븐일레븐'}">
							<img alt="711 logo" src="../images/7eleven.png" class="logoImg"><br/>
						</c:if>
						<c:if test="${vo.sellCVS == 'ministop'}">
							<img alt="mini logo" src="../images/ministop.png" class="logoImg"><br/>
						</c:if>
						<c:if test="${vo.sellCVS == '이마트24'}">
							<img alt="emart logo" src="../images/emart24.png" class="logoImg"><br/>
						</c:if>
						<c:if test="${vo.sellCVS == 'C·SPACE'}">
							<img alt="other logo" src="../images/other.png" class="logoImg"><br/>
						</c:if>
						<div class="map_wrap">
							<div id="map" style="width: 450px; height: 300px; border-radius: 10px; padding: 15px; margin: 10px 5px;"></div>				    
						    <div class="hAddr">
						        <span class="title">현재 위치 주소 정보</span>
						        <span id="centerAddr"></span>
						    </div>			
					    </div>		
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=36e39b3dce6c1f9eab9b68b6fbfd8144&libraries=services"></script>
						<div style="color: gray; font-size: 14px;">* 확대/축소/이동이 불가능한 지도입니다.
						<br/> 자세한 편의점 위치 정보는 <a href="../map" style="color: dodgerblue; font-weight: bold; font-size: 16px;">여기</a>에서 확인하세요!
						</div>
						<input type="hidden" id="whichCVS" value="${vo.sellCVS}">	
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle; text-align: center;">행사 유형</th>
					<td style="padding: 10px 20px;">
						${vo.eventType}
					</td>
				</tr>
				<c:if test="${vo.eventType == '덤증정'}">
				<tr>
					<th style="vertical-align: middle; text-align: center;">
						<div>증정 상품</div>
					</th>
					<td style="padding: 10px 20px;">
						<c:if test="${vo.addItemImage == null || vo.addItemName == null}">
							<div style="text-align: left; color: grey;">증정 상품 정보가 없습니다.</div>
						</c:if>
						<c:if test="${vo.addItemImage != null}">
							<img src="${vo.addItemImage}" width="200px" height="200px;"><br/>							
							${vo.addItemName}
						</c:if>
					</td>
				</tr>
				</c:if>						
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
									<c:if test="${grade.trim() != 'b'}">
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
									<c:if test="${grade.trim() == 'b'}">
										<span style="color: gray;">(차단된 회원은 평점을 등록할 수 없습니다.)</span>									
									</c:if>	
								</c:if>						
							</tr>
						</table>
					</td>
				</tr>		
				<tr align="center">
					<th style="vertical-align: middle;">
						<div>가격 비교</div>
					</th>
					<td style="padding: 15px; vertical-align: middle;">
						<div>
							<input type="hidden" value="${vo.itemName}" id="itemName">
							<div id="chart_div"></div>
							<div id="noChart" style="text-align: left; color: grey;">이름이 같은 상품이 없습니다.</div>
 						</div>		
					</td>
				</tr>
				<tr>
					<td colspan="1">
						<span>
							<c:if test="${grade == 'y'}">
								<button class="btn btn-outline-info" onclick="location.href='itemUpdate?idx=${vo.idx}&currentPage=${currentPage}'">수정</button>
								<button class="btn btn-outline-info" onclick="location.href='itemDelete?idx=${vo.idx}&currentPage=${currentPage}'">삭제</button>
							</c:if>
						</span>
					<td>
					<td colspan="2" align="right">
						<span>
							<button class="btn btn-outline-secondary" onclick="location.href='list?currentPage=${currentPage}'">돌아가기</button>
						</span>
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
						<c:if test="${grade.trim() != 'b'}">
							<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;" placeholder="댓글을 입력해주세요."></textarea>
						</c:if>
						<c:if test="${grade.trim() == 'b'}">
							<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;" disabled placeholder="차단된 회원은 댓글을 작성할 수 없습니다."></textarea>
						</c:if>
					</c:if>
					<c:if test="${nickname == null}">						
						<textarea class="form-control form-control-sm" id="content" name="content" rows="3" style="resize: none;" placeholder="댓글 등록은 로그인한 회원만 가능합니다." disabled></textarea>
					</c:if>
				</th>
				<th colspan="1" style="width: 200px; vertical-align: middle;" align="center">
					<c:if test="${nickname != null}">
						<c:if test="${grade.trim() != 'b'}">					
							<input class="btn btn-outline-primary" type="button" name="insertBtn" value="저장" style="margin: auto;" onclick="commentEmptyChk()"/>				
						</c:if>
						<c:if test="${grade.trim() == 'b'}">					
							<input class="btn btn-outline-secondary" type="button" name="insertBtn" disabled value="저장" style="margin: auto;"/>				
						</c:if>				
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
						<td style="vertical-align: middle; text-align: center;">
							<a class="profileView" onclick="profileView('${co.ID}')">
								${co.nickname}(${co.ID})
							</a>
						</td>
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

<!-- Modal -->
<div class="modal" tabindex="-1" id="itemModal" style="display: none;">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">찜 완료</h5>
			</div>
			<div class="modal-body">
				<p>찜한 상품을 보러가시겠습니까?</p>
			<div class="modal-footer">
			<button type="button" onclick="location.href='../member/myPage'" class="btn btn-primary" >네</button>
			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="modalClose()">아니오</button>
			</div>      
			</div>
		</div>
	</div>
</div>
<!-- footer  -->
<%@ include file="../util/hfer/footer.jsp" %>

</body>
</html>