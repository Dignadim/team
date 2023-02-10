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
<script	src="./js/map.js" defer></script>
</head>
<body>
	<!-- header -->
	<%@ include file="../util/hfer/headerOnlyMain.jsp" %>
	
	<div class="container">
		<div class="left">
		<div id="map"></div>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=36e39b3dce6c1f9eab9b68b6fbfd8144&libraries=services"></script>
		</div>
		<div class="right bg-light" style="padding: 20px;">
			<table style="margin-bottom: 30px;">
				<tr>
					<td>
						<select class="form-select" name="CVS" id="scvs">
							<option>GS25</option>
							<option>CU</option>
							<option>세븐일레븐</option>
							<option>이마트24</option>
							<option>ministop</option>
							<option>C·SPACE</option>
						</select>					
					</td>
					<td>
						<select class="form-select" name="sido" onchange="selectSido()" id="ssido">
							<option selected>(시도 선택)</option>
							<option>강원</option>
							<option>경기</option>
							<option>경남</option>
							<option>경북</option>
							<option>광주</option>
							<option>대구</option>
							<option>대전</option>
							<option>부산</option>
							<option>서울</option>
							<option>세종</option>
							<option>울산</option>
							<option>인천</option>
							<option>전북</option>
							<option>전남</option>
							<option>제주</option>
							<option>충남</option>
							<option>충북</option>
						</select>					
					</td>
					<td>
						<select class="form-select" name="gugun" onchange="selectGugun()" id="sgugun">
							<option selected>(구군 선택)</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input class="form-control" type="text" placeholder="지점명을 입력해주세요." id="searchAdd" onkeyup="searchAdd()">
					</td>
				</tr>
			</table>
			<div  style="overflow:auto; height: 300px;">
			<table class="table">
				<thead class="table-primary">
					<tr style="vertical-align: middle;">
						<th width="200px;">지점명</th>
						<th>주소</th>
						<th>
							<c:if test="${grade.trim() != null && grade.trim() == 'y'}">
								<input type="button" class="form-control btn btn-primary" value="자동 지도 등록" style="display: inline !important;" onclick="mapCrawling()">
							</c:if>
						</th>					
					</tr>
				</thead>
				<!-- select에 ajax 걸어서 나올 결과가 출력되는 곳 -->
				<tbody id="tbody"></tbody>
			</table>
			</div>
			<div style="font-size: 13px; margin-top: 20px; text-align: right; vertical-align: bottom;">검색 후 <kbd>Ctrl</kbd>+<kbd>F</kbd>로 원하는 지점을 찾아보세요!&nbsp;&nbsp;</div>
		</div>	
	</div>
	<div class="clear"></div>
	<div>
	<br/>&nbsp;
	<br/>&nbsp;
	<br/>&nbsp;
	</div>

	<!-- 로딩 스피너 -->
	<div class="layerPopup">
	    <div class="spinner"></div>
	</div>	
	
	<!-- footer  -->
	<%@ include file="../util/hfer/footerOnlyMain.jsp" %>
</body>
</html>