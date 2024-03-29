<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든 상품 페이지</title>
<link rel="icon" href="../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript" src="../js/itemListView.js" defer></script>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	%>
<!-- header -->
<%@ include file="../util/hfer/header.jsp" %>

	<div align="center">
		<input type="text" class="form-control" id="itemName" placeholder="검색할 내용을 입력하세요." style="display: inline !important; width: 800px;">
		<button type="button" class="btn btn-primary" onclick="searchFunction()" style="display: inline !important">검색</button>
	</div>
	<div align="center" style="padding: 10px; margin-top: 15px;">
		<c:if test="${searchList != null}">
			<span style="font-size: 18px; font-weight: bold; vertical-align: middle;">현재 인기 검색어:</span>
			<c:set var="slist" value="${searchList.list}"/>
			<c:forEach var="s_vo" items="${slist}" varStatus="i">
				<span style=" padding: 5px; vertical-align: middle;">
					<a style="color: #198754; font-size: 18px; padding: 5px 10px;" href="itemListSort?itemName=${s_vo.keyword}&currentPage=${itemList.currentPage}&mode=11">${s_vo.keyword}&nbsp;</a>	
				</span>
			</c:forEach>
		</c:if>
	</div>
	
	<div class="m-3">
		<table class="table" style="width: 1200px; margin-left: auto; margin-right: auto; box-sizing: border-box;">
			<tr class="table-primary" style="box-sizing: border-box;">
				<th colspan="4" style="font-size: 20px; text-align: center; padding: 10px; margin: 10px; font-size: 25px;" id="allItemShow">모든 상품 보기</th>
			</tr>			
			<tr>
				<td colspan="1">
					<select class="form-select" width="100" onchange="itemSelectChange()" id="selectChange">
						<option selected>전체</option>
						<option>편의점별</option>
						<option>행사별</option>
						<option>가격별</option>
						<option>카테고리별</option>
					</select>
				</td>
				<td colspan="1"id="subSelectChange">
					<select class="form-select" width="100">
						<option selected>(상위 항목 선택)</option>
					</select>
				</td>
				<td colspan="2" align="right">
					&nbsp;
				</td>
			</tr>
			
			<tr>
				<td colspan="3" align="left">
					<input type="hidden" value="0" name="mode" id="beforeSort"/>
					<input type="button" class="btn btn-outline-success" value="최신순" onclick="sort('${itemList.currentPage}', 1)">
					<input type="button" class="btn btn-outline-success" value="오래된순" onclick="sort('${itemList.currentPage}', 2)">
					<input type="button" class="btn btn-outline-success" value="높은 가격 순" onclick="sort('${itemList.currentPage}', 3)">
					<input type="button" class="btn btn-outline-success" value="낮은 가격 순" onclick="sort('${itemList.currentPage}', 4)"> 
					<input type="button" class="btn btn-outline-success" value="평점 높은 순" onclick="sort('${itemList.currentPage}', 5)"> 
					<input type="button" class="btn btn-outline-success" value="평점 낮은 순" onclick="sort('${itemList.currentPage}', 6)"> 
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-outline-secondary" value="되돌리기" onclick="location.href='list?currentPage=1'">
				</td>
				<td colspan="1" align="right" style="vertical-align: middle;">
					${itemList.totalCount} 건 (${itemList.currentPage} / ${itemList.totalPage})<br/>	
				</td>
			</tr>
			<tr class="table table-light">
				<th colspan="4" style="text-align: center; font-size: 20px; padding: 18px">상품 목록</th>
			</tr>		
		
			<tbody id="ajaxTable">
			<!-- 상품 목록을 출력한다. -->
			<!-- itemList.jsp에서 request 영역에 저장한 itemList에서 1페이지 분량의 글이 저장된 ArrayList를 꺼내온다. -->
			<c:set var="list" value="${itemList.list}"/>
			
			<!-- 상품 목록이 1건도 없으면 글이 없다고 출력한다. -->
			<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="6" align="center">
					<h2>테이블에 저장된 상품이 없습니다.</h2>			
				</td>
			</tr>
			</c:if>
			
			<c:if test="${list.size() != 0}">
				<tr>
					<c:forEach var="vo" items="${list}" varStatus="i">
						<td>
							<div style="box-sizing: border-box;">
								<div style="padding: 30px 10px; box-sizing: border-box;" id="hov_item">
									<a href="increment?idx=${vo.idx}&currentPage=${itemList.currentPage}">
										<c:if test="${vo.itemImage.indexOf('http') == -1}">
											<c:if test="${vo.sellCVS == 'CU'}">											
												<img alt="상품 이미지" src="https://${vo.itemImage}" style="height: 230px; width: 230px; margin: 15px; padding: 5px 5px; border-radius: 20px; align-content: center;"><br/>
											</c:if>
											<c:if test="${vo.sellCVS != 'CU'}">											
												<img alt="상품 이미지" src="${vo.itemImage}" style="height: 230px; width: 230px; margin: 15px; padding: 5px 5px; border-radius: 20px; align-content: center;"><br/>
											</c:if>
										</c:if>
										<c:if test="${vo.itemImage.indexOf('http') != -1}">
											<img alt="상품 이미지" src="${vo.itemImage}" style="height: 230px; width: 230px; margin: 15px; padding: 5px 5px; border-radius: 20px; align-content: center;"><br/>
										</c:if>
										&nbsp;&nbsp;&nbsp;<span style="font-size: 20px;">${vo.itemName}</span>
									</a><br/>
									&nbsp;&nbsp;&nbsp;<span style="font-weight: bold; font-size: 18px"><fmt:formatNumber value="${vo.itemPrice}" pattern="#,###원"/></span>
									<c:if test="${vo.eventType == '1+1'}">
										<img alt="1on1" src="../images/1on1.png" height="35px"><span style="font-size: 14px;"><fmt:formatNumber value="${vo.itemPrice / 2}" pattern="(개당 #,###.0원)"/></span>
									</c:if>
									<c:if test="${vo.eventType == '2+1'}">
										<img alt="2on1" src="../images/2on1.png" height="35px"><span style="font-size: 14px;"><fmt:formatNumber value="${vo.itemPrice / 3 * 2}" pattern="(개당 #,###.0원)"/></span>
									</c:if>
									<br/>
									<c:if test="${vo.sellCVS.trim() == 'CU'}">
										<img alt="CU logo" src="../images/cu.png" height="25px" align="right"><br/>
									</c:if>
									<c:if test="${vo.sellCVS == 'GS25'}">
										<img alt="GS logo" src="../images/gs25.png" height="25px" align="right"><br/>
									</c:if>
									<c:if test="${vo.sellCVS == '세븐일레븐'}">
										<img alt="711 logo" src="../images/7eleven.png" height="25px" align="right"><br/>
									</c:if>
									<c:if test="${vo.sellCVS == 'ministop'}">
										<img alt="mini logo" src="../images/ministop.png" height="25px" align="right"><br/>
									</c:if>
									<c:if test="${vo.sellCVS == '이마트24'}">
										<img alt="emart logo" src="../images/emart24.png" height="25px" align="right"><br/>
									</c:if>
									<c:if test="${vo.sellCVS != 'CU' && vo.sellCVS != 'GS25' && vo.sellCVS != '세븐일레븐' && vo.sellCVS != 'ministop' && vo.sellCVS != '이마트24'}">
										<img alt="other logo" src="../images/other.png" height="25px" align="right"><br/>
									</c:if>
								</div>
							</div>
						</td>				
					<c:if test="${i.count % 4 == 0}">
							<tr style="border-color: transparent;">
							</tr>
					</c:if>
					</c:forEach>
				</tr>
			</c:if>
	
			<!-- 페이지 이동 버튼 -->
			<tr align="center" class="table table-light">
				<td colspan="5"  style="padding: 20px 10px !important;">
				
				<!-- 처음으로 -->
				<c:if test="${itemList.currentPage > 1 && mode == 0}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage > 1 && mode >= 1 && mode <= 6}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1&mode=${mode}'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage > 1 && mode == 7}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1&mode=${mode}&category=${category}'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage > 1 && mode == 8}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1&mode=${mode}&sellCVS=${sellCVS}'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage > 1 && mode == 9}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1&mode=${mode}&eventType=${eventType}'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage > 1 && mode == 10}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1&mode=${mode}&itemPrice=${itemPrice}'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage > 1 && mode == 11}">
					<button class="btn btn-outline-primary" title="첫 번째 페이지로 이동합니다." onclick="location.href='?currentPage=1&mode=${mode}&itemName=${itemName}'">≪</button>							
				</c:if>
				<c:if test="${itemList.currentPage <= 1}">
					<button class="btn btn-outline-secondary" disabled title="첫 번째 페이지입니다.">≪</button>						
				</c:if>

				<!-- 10페이지 앞으로 -->
				<c:if test="${itemList.startPage > 1 && mode == 0}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage > 1 && mode >= 1 && mode <= 6}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}&mode=${mode}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage > 1 && mode == 7}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}&mode=${mode}&category=${category}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage > 1 && mode == 8}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}&mode=${mode}&sellCVS=${sellCVS}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage > 1 && mode == 9}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}&mode=${mode}&eventType=${eventType}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage > 1 && mode == 10}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}&mode=${mode}&itemPrice=${itemPrice}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage > 1 && mode == 11}">
					<button class="btn btn-outline-primary" title=" 10페이지 앞으로 이동합니다." onclick="location.href='?currentPage=${itemList.startPage-1}&mode=${mode}&itemName=${itemName}'">＜</button>							
				</c:if>
				<c:if test="${itemList.startPage <= 1}">
					<button class="btn btn-outline-secondary" disabled title="첫 10페이지입니다.">＜</button>				
				</c:if>
												
				<!-- 페이지 선택 -->
				<c:forEach var="i" begin="${itemList.startPage}" end="${itemList.endPage}" step="1">
					<c:if test="${itemList.currentPage == i}">
						<input class="btn btn-outline-secondary" type="button" value="${i}" disabled/>	
					</c:if>
					<c:if test="${itemList.currentPage != i && mode == 0}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}'" value="${i}"/>	
					</c:if>							
					<c:if test="${itemList.currentPage != i && mode >= 1 && mode <= 6}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}&mode=${mode}'" value="${i}"/>	
					</c:if>							
					<c:if test="${itemList.currentPage != i && mode == 7}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}&mode=${mode}&category=${category}'" value="${i}"/>	
					</c:if>							
					<c:if test="${itemList.currentPage != i && mode == 8}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}&mode=${mode}&sellCVS=${sellCVS}'" value="${i}"/>	
					</c:if>							
					<c:if test="${itemList.currentPage != i && mode == 9}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}&mode=${mode}&eventType=${eventType}'" value="${i}"/>	
					</c:if>							
					<c:if test="${itemList.currentPage != i && mode == 10}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}&mode=${mode}&itemPrice=${itemPrice}'" value="${i}"/>	
					</c:if>							
					<c:if test="${itemList.currentPage != i && mode == 11}">
						<input class="btn btn-outline-primary" type="button" value="${i}" onclick="location.href='?currentPage=${i}&mode=${mode}&itemName=${itemName}'" value="${i}"/>	
					</c:if>							
				</c:forEach>

				<!-- 10페이지 뒤로 -->
				<c:if test="${itemList.endPage < itemList.totalPage && mode == 0}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage < itemList.totalPage && mode >= 1 && mode <= 6}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}&mode=${mode}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage < itemList.totalPage && mode == 7}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}&mode=${mode}&category=${category}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage < itemList.totalPage && mode == 8}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}&mode=${mode}&sellCVS=${sellCVS}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage < itemList.totalPage && mode == 9}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}&mode=${mode}&eventType=${eventType}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage < itemList.totalPage && mode == 10}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}&mode=${mode}&itemPrice=${itemPrice}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage < itemList.totalPage && mode == 11}">
					<button class="btn btn-outline-primary" title=" 10페이지 뒤로 이동합니다." onclick="location.href='?currentPage=${itemList.endPage+1}&mode=${mode}&itemName=${itemName}'">＞</button>								
				</c:if>
				<c:if test="${itemList.endPage >= itemList.totalPage}">
					<button class="btn btn-outline-secondary" disabled title="마지막 10페이지입니다.">＞</button>							
				</c:if>
				
				<!-- 마지막으로 -->
				<c:if test="${itemList.currentPage < itemList.totalPage && mode == 0}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage < itemList.totalPage && mode >= 1 && mode <= 6}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}&mode=${mode}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage < itemList.totalPage && mode == 7}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}&mode=${mode}&category=${category}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage < itemList.totalPage && mode == 8}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}&mode=${mode}&sellCVS=${sellCVS}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage < itemList.totalPage && mode == 9}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}&mode=${mode}&eventType=${eventType}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage < itemList.totalPage && mode == 10}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}&mode=${mode}&itemPrice=${itemPrice}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage < itemList.totalPage && mode == 11}">
					<button class="btn btn-outline-primary" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${itemList.totalPage}&mode=${mode}&itemName=${itemName}'">≫</button>								
				</c:if>
				<c:if test="${itemList.currentPage >= itemList.totalPage}">
					<button class="btn btn-outline-secondary" disabled title="마지막 페이지입니다.">≫</button>						
				</c:if>
				</td>	
				
				<!-- 상품 입력 버튼 -->
			</tr>
			<tr>
				<td align="right" colspan="4" class="table-light">
					<c:if test="${grade == 'y'}">
						<input class="btn btn-outline-primary" type="button" value="자동 상품 등록" onclick="itemCrawling()"/>
						<input class="btn btn-outline-primary" type="button" value="수동 상품 등록" onclick="location.href='insert'"/>
					</c:if>
				</td>					
			</tr>
			</tbody>
		</table>
		<br/><br/>
	</div>	
	
	<!-- 로딩 스피너 -->
	<div class="layerPopup">
	    <div class="spinner"></div>
	</div>

<!-- footer  -->
<%@ include file="../util/hfer/footer.jsp" %>

</body>
</html>