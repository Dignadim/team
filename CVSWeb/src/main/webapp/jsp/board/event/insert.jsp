<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 정보 작성</title>
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
<body>
	
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
	
	<form class="m-3" action="insertOK.jsp" method="post" name='insertForm'>
		<table class="table" style="width: 900px; height: 450px; margin-left: auto; margin-right: auto; margin-top: 80px;">
			<tr class="table-secondary" style="height: 30px;">
				<th class="align-middle table-secondary" style="padding: 10px; text-align: center;">
					<label for="ev_sellcvs">머리말</label>
				</th>
				<td style="display: none;">
					ev_notice: <input id="noticeOn" name="ev_notice" type="text" value="no"/>
					id: <input type="text" id="id" name="id" value="${id}">
					nickname: <input type="text" id="nickname" name="nickname" value="${nickname}">
				</td>
				<td colspan="2">
					<select id="ev_sellcvs" name="ev_sellcvs" class="form-control form-control-sm" style="width: 95px;"
						onchange="notice()">
						<option>-머리말선택-</option>
						<option>GS25</option>
						<option>CU</option>
						<option>7-Eleven</option>
						<option>ministop</option>
						<option>emart24</option>
						<option>기타편의점</option>
						<option>공지</option>
					</select>
				</td>
			</tr>		
			<tr class="table-secondary">
				<th class="align-middle table-secondary" style="padding: 10px; text-align: center;">
					<label for="ev_subject">제목</label>
				</th>
				<td>
					<input id="ev_subject" class="form-control form-control-sm" type="text" name="ev_subject"
						placeholder="제목을 입력해주세요."/>
				</td>
				<td></td>
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
			<tr class="table-secondary">
				<th class="align-top table-secondary" style="padding: 10px; text-align: center;">
					<label for="content">내용</label>
				</th>
				<td>
					<textarea id="ev_content" class="form-control form-control-sm" rows="15" name="ev_content" 
					 	style="resize: none;" placeholder="내용을 입력해주세요."></textarea>
				</td>
				<th></th>				
			</tr>
			<tr class="table-secondary">
				<td colspan="4" align="right">
					<input class="btn btn-primary btn-lg" type="button" value="등록"
						style="font-size: 13px;" onclick="insertEmptyChk()"/>
				</td>
			</tr>		
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark" type="button" value="목록보기" onclick="location.href='list.jsp'"/>
				</td>
			</tr>	
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