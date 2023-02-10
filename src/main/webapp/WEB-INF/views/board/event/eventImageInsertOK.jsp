<%@page import="com.project.board.event.EventboardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로드 페이지</title>
<script type="text/javascript" src="../js/eventboard.js" defer="defer"></script>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="ev_vo" class="com.project.board.event.EventboardVO">
		<jsp:setProperty property="*" name="ev_vo"/>
	</jsp:useBean>	
	
<%
	ev_vo.setEv_filename((String) request.getAttribute("ev_filename")); 
%>	
	
	<div align="center">
		<input type="hidden" name="ev_filename" value="${ev_vo.ev_filename}"/>	
		<input type="hidden" name="fileRealname" value="${fileRealname}"/>	
		<h1 style="font-weight: bold;">사진 업로드 완료!</h1><br/><br/><br/>
		※돌아가기 버튼을 눌러주세요.<br/><br/><br/>
		<span style="color: red;">버튼을 누르지 않으면 업로드한 사진이 게시되지 않습니다.</span>
	</div>
	<div style="position: relative;; top: 130px;" align="right">
		<input type="button" class="btn btn-outline-secondary" value="돌아가기" onclick="thisClose('${ev_vo.ev_filename}', '${fileRealname}')"/>
	</div>

</body>
</html>