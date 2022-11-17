<%@page import="project.board.event.EventboardService"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로드 페이지</title>
<script type="text/javascript" src="../../../js/eventboard.js" defer="defer"></script>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="ev_vo" class="project.board.event.EventboardVO">
		<jsp:setProperty property="*" name="ev_vo"/>
	</jsp:useBean>	
<%
	try {
	MultipartRequest mr = new MultipartRequest(
			request,
			application.getRealPath("/eventUpload"),
			5 * 1024 * 1024 * 1024,
			"UTF-8",
			new DefaultFileRenamePolicy()
	);		
	String filename = mr.getOriginalFileName("ev_filename");
	// out.println("원본 파일 이름: "+filename + "<br/>");
	File realFile = mr.getFile("ev_filename");
	// out.println("업로드된 파일 이름: "+realFile.getName() + "<br/>");
	
	long fileLength = realFile.length();
	// out.println("파일의 크기: " + fileLength + "<br/>");
	
 	if (fileLength > 5 * 1024 * 1024) { // 용량 제한
		out.println("<script>");
		out.println("alert('업로드 용량 초과, 5MB까지 업로드 가능')");
		realFile.delete();
		out.println("location.href='eventImageInsert.jsp'");
		out.println("</script>");
	} else if (!realFile.getName().endsWith(".png") && !realFile.getName().endsWith(".jpg") // 파일 종류 제한
			&& !realFile.getName().endsWith(".gif")) { 
		out.println("<script>");
		out.println("alert('업로드할 수 있는 형식의 파일이 아닙니다.\\n*.png, *.jpg, *.gif 파일만 가능합니다.')");			
		realFile.delete();
		out.println("location.href='eventImageInsert.jsp'");
		out.println("</script>");
	}  else {
		ev_vo.setEv_filename(realFile+"");
	} 
	} catch(NullPointerException e) {
		out.println("<script>");
		out.println("alert('파일이 첨부되지 않았습니다.')");			
		out.println("location.href='eventImageInsert.jsp'");
		out.println("</script>");
	}
%>
	<div align="center">
		<h1 style="font-weight: bold;">사진 업로드 완료!</h1><br/><br/><br/>
		※돌아가기 버튼을 눌러주세요.<br/><br/><br/>
		<span style="color: red;">버튼을 누르지 않으면 업로드한 사진이 게시되지 않습니다.</span>
	</div>
	<div style="position: relative;; top: 130px;" align="right">
		<input type="button" class="btn btn-outline-secondary" value="돌아가기" onclick="thisClose('${ev_vo.ev_filename}')"/>
	</div>


</body>
</html>