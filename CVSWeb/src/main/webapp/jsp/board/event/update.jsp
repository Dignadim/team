<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="icon" href="../../../images/favicon.png"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="../../../css/freeboard.css"/>
<script type="text/javascript" src="../../../js/eventboard.js" defer="defer"></script>
<style type="text/css">
	body {
		font-family: 'Pretendard Variable';
	}
</style>
</head>
<body onload="fixSelected()">
	
   <!-- header -->
   <header>
      <div class="container-fluid">
         <nav class="navbar navbar-expand-sm bg-light">
            <div class="col-sm-2">
               <a href="../../connectMain.jsp"><img src="../../../images/teamlogo.png" style="width: 30px;"></a>
            </div>
            <div class="container-fluid col-sm-5">
               <ul class="navbar-nav">
                  <li class="nav-item" style="padding-right: 70px;">
                      <a class="nav-link" href="../../item/itemList.jsp?">모든 상품 보기</a>
                   </li>               
                  <li class="nav-item dropdown" style="padding-right: 70px;">
                     <a class="nav-link dropdown-toggle" href="#" role="button"   data-bs-toggle="dropdown">행사 보기</a>
                     <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="./list.jsp">모든 행사 보기</a></li>
                        <li><a class="dropdown-item" href="#">GS25</a></li>
                        <li><a class="dropdown-item" href="#">CU</a></li>
                        <li><a class="dropdown-item" href="#">세븐일레븐</a></li>
                        <li><a class="dropdown-item" href="#">ministop</a></li>
                        <li><a class="dropdown-item" href="#">이마트24</a></li>
                        <li><a class="dropdown-item" href="#">기타 편의점</a></li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="#" role="button"   data-bs-toggle="dropdown">게시판</a>
                     <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="../free/list.jsp">자유게시판</a></li>
                        <li><a class="dropdown-item" href="../rank/rank.jsp">랭킹게시판</a></li>
                        <li><a class="dropdown-item" href="#">신상게시판</a></li>
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
                  <button type="button" class="btn btn-primary" onclick="location.href='../../logRegi/login_form.jsp'">로그인</button>   
               </c:if>            
               <c:if test="${id != null}">
                  <button type="button" class="btn btn-danger" onclick="location.href='../../logRegi/login_out.jsp'">로그아웃</button>
                  <c:if test="${grade.trim() != null && grade.trim() == 'y'}">
                     <button class="btn btn-info" style="padding: 6px;" onclick="../../item/itemInsert.jsp">관리 페이지로</button>   
                  </c:if>
                  <c:if test="${grade.trim() == null || grade.trim() != 'y'}">
                     <button type="button" class="btn btn-warning" onclick="location.href='../../myPage/myPageView.jsp'">마이페이지</button>   
                     <input type="hidden" value="${grade}">
                  </c:if>
               </c:if>               
            </div>
         </nav>
      </div>
   </header>
	
	<form class="m-3" action="updateOK.jsp" method="post">
		<table class="table" style="width: 900px; height: 450px; margin-left: auto; margin-right: auto; margin-top: 80px;">
			<tr class="table-secondary" style="height: 30px;">
				<th class="align-middle table-secondary" style="padding: 10px; text-align: center;">
					<label for="ev_sellcvs">머리말</label>
				</th>
				<td colspan="2">
					<input id="noticeOn" name="ev_notice" type="hidden" value="no"/>
					<input id="beforeCvs" type="hidden" name="ev_sellcvs" value="${ev_vo.ev_sellcvs}"/>
					<select id="ev_sellcvs" name="ev_sellcvs" class="form-control form-control-sm" style="width: 95px;"
					onchange="notice()">
						<option disabled="disabled">-머리말선택-</option>
						<option>GS25</option>
						<option>CU</option>
						<option>세븐일레븐</option>
						<option>ministop</option>
						<option>이마트24</option>
						<option>기타편의점</option>
						<option>공지</option>
					</select>
				</td>
			</tr>
			<tr class="table-secondary">
				<th class="align-middle table-secondary" style="padding: 10px; text-align: center;">
					<label for="ev_subject">제목</label>
				</th>
				<td colspan="2">
					<input id="ev_subject" class="form-control form-control-sm" type="text" name="ev_subject"
						value="${ev_vo.ev_subject}"/>
				</td>
			</tr>
			<tr class="table-secondary">
				<th class="align-middle table-secondary" style="padding: 10px; text-align: center;">
					<label for="ev_file">파일첨부</label>
				</th>
				<td colspan="2">
					<i style="color: red;">
						<input type="text" name="ev_filename" value="" id="ev_filename" disabled="disabled"/>
						<button class="btn btn-outline-secondary btn-sm" type="button" onclick="uploadWin()">이미지 불러오기</button>
						&nbsp;&nbsp;5MB 이하, *.jpg, *.png, *.gif 파일만 업로드 가능합니다.
					</i>
				</td>
			</tr>			
			
			<!-- 이벤트 기간과 내용을 적어주는 공간 -->
			<tr class="table-secodary">
				<th class="align-middle table-secondary" style="padding: 10px; text-align: center;">
					<label>행사정보</label>
				</th>
				<td colspan="3">
					시작일: <input type="text" name="startSch" placeholder="ex)2022-11-19" value=" ${schedVO.sYear}-${schedVO.sMonth}-${schedVO.sDay}"/>&nbsp;&nbsp;
					종료일: <input type="text" name="endSch" placeholder="하루만 하는 행사는 적을필요X." value=" ${schedVO.eYear}-${schedVO.eMonth}-${schedVO.eDay}"/><br/>
					내용: <input type="text" name="contentSch" placeholder="행사내용 간략히" value=" ${schedVO.event}"/>
				</td>	
			
			</tr>
						
			<tr class="table-secondary">
				<th class="align-top table-secondary" style="padding: 10px; text-align: center;">
					<label for="ev_content">내용</label>
				</th>
				<td>
					<textarea id="ev_content" class="form-control form-control-sm" rows="15" name="ev_content" 
					 	style="resize: none;">${ev_vo.ev_content}</textarea>
				</td>
				<th></th>
			</tr>
			<tr class="table-secondary">
				<td colspan="4" align="right">
					<button type="button" class="btn btn-light" style="font-size: 15px;" data-bs-toggle="modal" data-bs-target="#update">
	 				 		수정</button>
	 				<!-- The Modal -->
					<div class="modal" id="update">
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
						    	이대로 수정하시겠습니까?
						    </div>
							
						    <!-- Modal footer -->
						    <div class="modal-footer">
						    	<input class="btn btn-secondary" value="예" type="submit" data-bs-dismiss="modal"/>
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
						    </div>
							</div>
						</div>
					</div>	
				</td>
			</tr>		
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark" type="button" value="목록보기" onclick="location.href='list.jsp'"/>
				</td>
			</tr>	
		</table>	
		<input type="hidden" name="ev_idx" id="ev_idx" value="${ev_vo.ev_idx}">
		<input type="hidden" name="currentPage" value="${currentPage}">
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