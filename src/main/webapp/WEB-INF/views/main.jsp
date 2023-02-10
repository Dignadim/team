<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="icon" href="./images/favicon.png"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
<script	src="./js/main.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

</head>
<body>
	<jsp:useBean id="date" class="java.util.Date"/>
	<!-- header -->
	<%@ include file="./util/hfer/headerOnlyMain.jsp" %>
	
	<div class="container">
		<div class="panel-heading">
			<h3 class="panel-title">
				&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 행사 목록&nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onclick="location.href='./event/list'" style="display: inline !important;">모든 행사 보러가기</button>
			</h3>
		</div>
		<div class="container">
			<div style="height: 400px; overflow: auto;">
				<table class="table">
					<thead class="table-primary">
						<tr>
							<th align="center" width="250px" style="text-align: center !important;">편의점</th>
							<th align="center" style="text-align: center !important;">행사 내용</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="evList" value="${evList.list}"/>
						<c:forEach var="ev_vo" items="${evList}">
							<tr>
								<td align="center">
									<c:if test="${ev_vo.ev_sellcvs.trim() == 'CU'}">
										<img alt="CU" src="./images/cu.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == 'GS25'}">
										<img alt="GS25" src="./images/gs25.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == '세븐일레븐'}">
										<img alt="711 logo" src="./images/7eleven.png" height="25px"><br/>						
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == 'ministop'}">
										<img alt="mini logo" src="./images/ministop.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() == '이마트24'}">
										<img alt="emart logo" src="./images/emart24.png" height="25px"><br/>
									</c:if>
									<c:if test="${ev_vo.ev_sellcvs.trim() != 'CU' && ev_vo.ev_sellcvs.trim() != 'GS25' && ev_vo.ev_sellcvs.trim() != '세븐일레븐' && ev_vo.ev_sellcvs.trim() != 'ministop' && ev_vo.ev_sellcvs.trim() != '이마트24'}">
										<img alt="other logo" src="./images/other.png" height="25px"><br/>
									</c:if>
								</td>
								<td><a href="./event/increment?ev_idx=${ev_vo.ev_idx}&currentPage=1">${ev_vo.ev_subject}</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div><br/>
			
		</div><br/><br/><br/><br/>
	
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 행사 상품&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" onclick="location.href='./item/list'" style="display: inline !important;">모든 상품 보러가기</button>
				</h3>
			</div>
			<div class="container"  style="margin-top: 20px; padding: 5px 20px;">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<div style="width: 1200px; padding: 30px;" align="center" class="bg-light">
								<table class="table">
									<c:set var="eventItemList" value="${eventItemList.list}"/>
									<tr>
										<td style="padding: 20px" colspan="11">
										
										<!-- 캐러셀 -->
										<div id="demo" class="carousel slide" data-bs-ride="carousel">
										
											<div class="carousel-indicators">
												<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="5"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="6"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="7"></button>
												<button type="button" data-bs-target="#demo" data-bs-slide-to="8"></button>												
												<button type="button" data-bs-target="#demo" data-bs-slide-to="9"></button>												
											</div>
										
												<div class="carousel-inner" align="center">
													<c:forEach var="evItemVO" items="${eventItemList}" varStatus="i">
														<c:if test="${i.count == 1}">
															<div class="carousel-item active">
														</c:if>													
														<c:if test="${i.count != 1}">
															<div class="carousel-item">
														</c:if>
															<c:if test="${evItemVO.itemImage.indexOf('http') == -1}">
																<a href="./item/increment?idx=${evItemVO.idx}&job=itemView">
																<c:if test="${evItemVO.sellCVS != 'CU'}">	
																	<img alt="alt" src=".${evItemVO.itemImage}" class="d-block" style="width: 40%; border-radius: 15px;">
																</c:if>
																<c:if test="${evItemVO.sellCVS == 'CU'}">	
																	<img alt="alt" src="https://${evItemVO.itemImage}" class="d-block" style="width: 40%; border-radius: 15px;">																
																</c:if>																
																</a>
															</c:if>
															<c:if test="${evItemVO.itemImage.indexOf('http') != -1}">
																<a href="./item/increment?idx=${evItemVO.idx}&job=itemView"><img alt="alt" src="${evItemVO.itemImage}" class="d-block" style="width: 40%;border-radius: 15px;"></a>
															</c:if>
															<div class="carousel-caption">
																<p style="font-size: 20px; color: white; text-shadow:2px 2px 2px gray;">
																	<a href="./item/increment?idx=${evItemVO.idx}&job=itemView">${evItemVO.itemName}</a>
																	<b style="color: black;">${evItemVO.eventType}</b>
																	<c:if test="${evItemVO.sellCVS.trim() == 'CU'}">
																		<img alt="CU" src="./images/cu.png" style="vertical-align: middle; height: 25px;"><br/>
																	</c:if>
																	<c:if test="${evItemVO.sellCVS.trim() == 'GS25'}">
																		<img alt="GS25" src="./images/gs25.png" style="vertical-align: middle; height: 25px;"><br/>
																	</c:if>
																	<c:if test="${evItemVO.sellCVS.trim() == '세븐일레븐'}">
																		<img alt="711 logo" src="./images/7eleven.png" style="vertical-align: middle; height: 25px;"><br/>						
																	</c:if>
																	<c:if test="${evItemVO.sellCVS.trim() == 'ministop'}">
																		<img alt="mini logo" src="./images/ministop.png" style="vertical-align: middle; height: 25px;"><br/>
																	</c:if>
																	<c:if test="${evItemVO.sellCVS.trim() == '이마트24'}">
																		<img alt="emart logo" src="./images/emart24.png" style="vertical-align: middle; height: 25px;"><br/>
																	</c:if>
																	<c:if test="${evItemVO.sellCVS.trim() != 'CU' && evItemVO.sellCVS.trim() != 'GS25' && evItemVO.sellCVS.trim() != '세븐일레븐' && evItemVO.sellCVS.trim() != 'ministop' && evItemVO.sellCVS.trim() != '이마트24'}">
																		<img alt="other logo" src="./images/other.png" style="vertical-align: middle; height: 25px;"><br/>
																	</c:if>	
																</p>
															</div>
														</div>
													</c:forEach>
												</div>
 
											<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">

												<span class="carousel-control-prev-icon"></span>
											</button>
											<button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
												<span class="carousel-control-next-icon"></span>
											</button>
										</div>
										</td>
									</tr>
								</table>
							</div><br/>								
						</div>
					</div>
				</div>	
			</div>
			
			<br/><br/><br/><br/>	
	

			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 인기 상품 TOP5&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" onclick="location.href='./rank/view'">인기 상품 보러가기</button>
					<c:set var="list" value="${itemTOP5.list}"/>
				</h3>				
			</div>
			<div class="container"  style="margin-top: 20px; padding: 5px 20px;"  align="center">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<table class="table bg-light">
								<thead class="table-primary">
									<tr>
										<c:forEach var="vo" items="${list}" varStatus="i">
											<th style="text-align: center !important;">${i.count}위</th>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
									<tr>
										<c:forEach var="vo" items="${list}">
											<c:if test="${vo.itemImage.indexOf('http') == -1}">
											<td style="text-align: center !important;">
												<c:if test="${vo.sellCVS != 'CU'}">	
													<img style="border-radius: 10px;" alt="alt" src=".${vo.itemImage}" height="150px" width="150px;">
												</c:if>
												<c:if test="${vo.sellCVS == 'CU'}">	
													<img style="border-radius: 10px;" alt="alt" src="https://${vo.itemImage}" height="150px" width="150px;">
												</c:if>
											</td>
											</c:if>
											<c:if test="${vo.itemImage.indexOf('http') != -1}">
											<td style="text-align: center !important;"><img style="border-radius: 10px;" alt="alt" src="${vo.itemImage}" height="150px" width="150px;"></td>
											</c:if>
										</c:forEach>
									</tr>
									<tr>
										<c:forEach var="vo" items="${list}">
										<td width="150px;">
											<h5><a href="./item/increment?idx=${vo.idx}&job=itemView">${vo.itemName}</a></h5>
											${vo.eventType}
										</td>
										</c:forEach>									
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>	
			</div><br/><br/><br/><br/>
		
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 ${date.date}일 인기 게시글&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" onclick="location.href='./free/list'" style="display: inline !important;">인기글 보러가기</button>
				</h3>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<table class="table" style="margin-top: 20px;">
								<thead class="table-primary">
									<tr>
										<th width="100px" style="text-align: center !important;">인기 순위</th>
										<th width="300px" style="text-align: center !important;">닉네임</th>
										<th width="900px" style="text-align: center !important;">제목</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="freeHitList" value="${freeHitList.list}"/>
									<c:forEach var="fb_vo" items="${freeHitList}" varStatus="i">
										<tr>
											<td style="text-align: center !important;">${i.count}</td>
											<td style="text-align: center !important;">${fb_vo.nickname}</td>
											<td>
												<a href="./free/increment?fb_idx=${fb_vo.fb_idx}&currentPage=1">${fb_vo.fb_subject}</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>	
		</div><br/><br/><br/><br/>
	</div>
	<div>
		<iframe src="./calendar" width="1300" height="1000" style="border:0; overflow: visible;"></iframe>
	</div>
	</div>
	
	<a href="#" class="btn_gotop">↑</a>
	
	<!-- footer  -->
	<%@ include file="./util/hfer/footerOnlyMain.jsp" %>

</body>
</html>