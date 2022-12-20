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
</head>
<body>
	<jsp:useBean id="date" class="java.util.Date"/>
	<!-- header -->
	<%@ include file="./util/hfer/headerOnlyMain.jsp" %>
	
	<div class="container">
		<div class="panel-heading">
			<h3 class="panel-title">
				&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 행사 목록
			</h3>
		</div>
		<div class="container">
			<div style="height: 400px; overflow: auto;">
				<table class="table">
					<thead class="table-primary">
						<tr>
							<td align="center" width="250px">편의점</td>
							<td align="center">행사 내용</td>
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
			<button type="button" class="btn btn-primary" onclick="location.href='./event/list'">모든 행사 보러가기</button>
		</div><br/><br/><br/><br/>
			
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 행사 상품
				</h3>
			</div>
			<div class="container"  style="margin-top: 20px; padding: 5px 20px;">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<div style="width: 1200px; padding: 30px; overflow: auto"  align="center" class="bg-light"> <!-- 스크롤 -->
								<table class="table">
									<c:set var="eventItemList" value="${eventItemList.list}"/>
									<tr>
										<c:forEach var="evItemVO" items="${eventItemList}">
											<td style="padding: 20px">
												<c:if test="${vo.itemImage.indexOf('http') == -1}">
												<img alt="alt" src=".${evItemVO.itemImage}" style="width: 150px; height: 150px; border-radius: 5px; margin: 5px;">
												</c:if>
												<c:if test="${vo.itemImage.indexOf('http') != -1}">
												<img alt="alt" src="${evItemVO.itemImage}" style="width: 150px; height: 150px; border-radius: 5px; margin: 5px;">
												</c:if>
											</td>
										</c:forEach>
										<td style="padding: 20px; width: 150px; vertical-align: middle;">	
											<div align="center">
												<button class="btn btn-outline-success" type="button" onclick="location.href='./item/list'">→</button>
											</div>
										</td>
									</tr>
									<tr>
										<c:forEach var="evItemVO" items="${eventItemList}">
											<td style="padding: 20px;">
												<h5>
													<a href="./item/increment?idx=${evItemVO.idx}&job=itemView">${evItemVO.itemName}</a>
												</h5>
												${evItemVO.eventType}
												<span>
													<c:if test="${evItemVO.sellCVS.trim() == 'CU'}">
														<img alt="CU" src="./images/cu.png" height="20px;" align="right"><br/>
													</c:if>
													<c:if test="${evItemVO.sellCVS.trim() == 'GS25'}">
														<img alt="GS25" src="./images/gs25.png" height="20px;" align="right"><br/>
													</c:if>
													<c:if test="${evItemVO.sellCVS.trim() == '세븐일레븐'}">
														<img alt="711 logo" src="./images/7eleven.png" height="20px;" align="right"><br/>						
													</c:if>
													<c:if test="${evItemVO.sellCVS.trim() == 'ministop'}">
														<img alt="mini logo" src="./images/ministop.png" height="20px;" align="right"><br/>
													</c:if>
													<c:if test="${evItemVO.sellCVS.trim() == '이마트24'}">
														<img alt="emart logo" src="./images/emart24.png" height="20px;" align="right"><br/>
													</c:if>
													<c:if test="${evItemVO.sellCVS.trim() != 'CU' && evItemVO.sellCVS.trim() != 'GS25' && evItemVO.sellCVS.trim() != '세븐일레븐' && evItemVO.sellCVS.trim() != 'ministop' && evItemVO.sellCVS.trim() != '이마트24'}">
														<img alt="other logo" src="./images/other.png" height="20px;" align="right"><br/>
													</c:if>
												</span>
											</td>
										</c:forEach>
										<td align="center" style="vertical-align: middle;">
											<h5>더보기</h5>
										</td>
									</tr>
								</table>
							</div><br/>								
						</div>
					</div>
					<div align="left">
						<button type="button" class="btn btn-primary" onclick="location.href='./item/list'">모든 상품 보러가기</button>
					</div>
				</div>	
			</div>
			
			<br/><br/><br/><br/>

			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 인기 상품 TOP5
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
											<td>${i.count}위</td>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
									<tr>
										<c:forEach var="vo" items="${list}">
											<c:if test="${vo.itemImage.indexOf('http') == -1}">
											<td><img style="border-radius: 10px;" alt="alt" src=".${vo.itemImage}" height="150px" width="150px;"></td>
											</c:if>
											<c:if test="${vo.itemImage.indexOf('http') != -1}">
											<td><img style="border-radius: 10px;" alt="alt" src="${vo.itemImage}" height="150px" width="150px;"></td>
											</c:if>
										</c:forEach>
									</tr>
									<tr>
										<c:forEach var="vo" items="${list}">
										<td>
											<h5><a href="./item/increment?idx=${vo.idx}&job=itemView">${vo.itemName}</a></h5>
											${vo.eventType}
										</td>
										</c:forEach>									
									</tr>
								</tbody>
							</table>
						</div>
						<div align="left">
							<button type="button" class="btn btn-primary" onclick="location.href='./rank/view'">인기 상품 보러가기</button>
						</div>
					</div>
				</div>	
			</div><br/><br/><br/><br/>
		
			<div class="panel-heading">
				<h3 class="panel-title">
					&nbsp;&nbsp;&nbsp;${date.year + 1900}년 ${date.month +1}월 ${date.date}일 인기 게시글
				</h3>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-primary">
							<table class="table" style="margin-top: 20px;">
								<thead class="table-primary">
									<tr>
										<td width="200px">인기 순위</td>
										<td width="300px">닉네임</td>
										<td width="800px">제목</td>
									</tr>
								</thead>
								<tbody>
									<c:set var="freeHitList" value="${freeHitList.list}"/>
									<c:forEach var="fb_vo" items="${freeHitList}" varStatus="i">
										<tr>
											<td>${i.count}</td>
											<td>${fb_vo.nickname}</td>
											<td>
												<a href="./free/increment?fb_idx=${fb_vo.fb_idx}&currentPage=1">${fb_vo.fb_subject}</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<button type="button" class="btn btn-primary" onclick="location.href='./free/list'" align="right">인기글 보러가기</button>
					</div>
				</div>	
		</div><br/><br/><br/><br/>
	</div>
	<div>
		<iframe src="./calendar" width="1300" height="900" style="border:0; overflow: visible;"></iframe>
	</div>
	</div>
	
	<!-- footer  -->
	<%@ include file="./util/hfer/footerOnlyMain.jsp" %>

</body>
</html>