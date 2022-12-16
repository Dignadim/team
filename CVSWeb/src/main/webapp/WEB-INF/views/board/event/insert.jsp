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
<link rel="icon" href="./images/favicon.png"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/freeboard.css"/>
<script type="text/javascript" src="./js/eventboard.js" defer="defer"></script>
<style type="text/css">
	body {
		font-family: "Pretendard";
	}
</style>
</head>
<body>
	

   <br/><br/>
	<!-- alert창을 띄울 메시지가 있으면 여기에 받아짐 -->
	<input type="hidden" id="msg" value="${msg}">
	<form class="m-3" method="post" name='insertForm'>
		<table class="table" style="width: 900px; height: 450px; margin-left: auto; margin-right: auto; margin-top: 80px;">
			<tr class="table-light" style="height: 30px;">
				<th class="align-middle table-primary" style="padding: 10px; text-align: center;">
					<label for="ev_sellcvs">머리말</label>
				</th>
				<td style="display: none;">
					ev_notice: <input id="noticeOn" name="ev_notice" type="text" value="no"/>
					id: <input type="text" id="memberID" name="id" value="${id}">
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
			<tr class="table-light">
				<th class="align-middle table-primary" style="padding: 10px; text-align: center;">
					<label for="ev_subject">제목</label>
				</th>
				<td>
					<input id="ev_subject" class="form-control form-control-sm" type="text" name="ev_subject"
						placeholder="제목을 입력해주세요."/>
				</td>
				<td></td>
			</tr>		
			<tr class="table-light">
				<th class="align-middle table-primary" style="padding: 10px; text-align: center;">
					<label for="ev_file">파일첨부</label>
				</th>
				<td colspan="2">
					<i style="color: red;">
						<input type="text" name="ev_filename" value="" id="ev_filename" disabled="disabled"/>
						<button class="btn btn-outline-success btn-sm" type="button" onclick="uploadWin()">이미지 불러오기</button>
						&nbsp;&nbsp;5MB 이하, *.jpg, *.png, *.gif 파일만 업로드 가능합니다.
					</i>
				</td>
			</tr>		
			<!-- 이벤트 기간과 내용을 적어주는 공간 -->
			<tr class="table-light">
				<th class="align-middle table-primary" style="padding: 10px; text-align: center;">
					<label>행사정보</label>
				</th>
				<td colspan="3">
					시작일: <input type="text" id="startSch" name="startSch" placeholder="ex)2022-11-19"/>&nbsp;&nbsp;
					종료일: <input type="text" id="endSch" name="endSch" placeholder="하루만 하는 행사는 적을필요X."/><br/>
					내용: <input type="text" id="contentSch" name="contentSch" placeholder="행사내용 간략히"/>
				</td>	
			
			</tr>
			<tr class="table-light">
				<th class="align-top table-primary" style="padding: 10px; text-align: center;">
					<label for="content">내용</label>
				</th>
				<td>
					<textarea id="ev_content" class="form-control form-control-sm" rows="15" name="ev_content" 
					 	style="resize: none;" placeholder="내용을 입력해주세요."></textarea>
				</td>
				<th></th>				
			</tr>
			<tr class="table-light">
				<td colspan="4" align="right">
					<input class="btn btn-outline-primary btn-lg" type="button" value="등록"
						style="font-size: 13px;" onclick="insertEmptyChk()"/>
				</td>
			</tr>		
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark" type="button" value="목록보기" onclick="location.href='evList'"/>
				</td>
			</tr>	
		</table>	
		<input type="hidden" name="mode" value="Insert"/>
	</form>	
	
	
</body>
</html>