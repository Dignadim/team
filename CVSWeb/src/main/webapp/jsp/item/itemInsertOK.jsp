<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="project.item.ItemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemInsertOK</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
<script type="text/javascript" src="./js/main.js" defer></script>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
	%>

	<jsp:useBean id="vo" class="project.item.ItemVO">
		<jsp:setProperty property="*" name="vo"/>
	</jsp:useBean>
	
	<%
	/*
	// itemInsert.jsp에서 넘어온 데이터를 메인글 테이블에 저장하는 메소드를 실행한다.
		MultipartRequest multipartRequest = new MultipartRequest(request, application.getRealPath("/upload"), 5 * 1024 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
		// getOriginalFileName(): 사용자가 업로드한 파일 이름을 얻어온다.		
		String filename = multipartRequest.getOriginalFileName("itemImage");
		// getFilesystemName(): 업로드되어 실제 디스크에 저장된 파일 이름을 얻어온다.
		String fileRealname = multipartRequest.getFilesystemName("itemImage");
		
		File realFile = multipartRequest.getFile("itemImage");
		// length(): 파일의 크기를 얻어온다.		
		long fileLength = realFile.length();	
		
		if (fileLength > 5 * 1024 * 1024) { // 용량 제한
			out.println("<script>");
			out.println("alert('용량 초과: 5MB까지만 업로드 가능합니다.')");
			out.println("</script>");
			// 업로드된 파일 삭제
			File file = new File(application.getRealPath("/upload/") + fileRealname);
			// delete(): 파일을 삭제한다.
			file.delete();
		} else if (!fileRealname.endsWith(".png") && !fileRealname.endsWith(".jpg")) { // 파일 종류 제한
			out.println("<script>");
			out.println("alert('.png 또는 .jpg 확장자만 업로드 가능합니다.')");			
			out.println("</script>");
			File file = new File(application.getRealPath("/upload/") + fileRealname);
			file.delete();
		} else {
			String itemRealPath = application.getRealPath("/upload") + "/" + fileRealname;
			vo.setItemImage(itemRealPath);
		}
		System.out.println(vo);
		*/
		try {
			ItemService.getInstance().itemInsert(vo);		
		} catch (Exception e) {
			out.println("<script>");
			out.println("alert('모든 정보를 입력하세요.')");			
			out.println("</script>");	
		}
		
		// 메인글 1페이지 분량의 글 목록을 얻어오는 페이지(itemList.jsp)로 넘겨준다.
		response.sendRedirect("itemList.jsp");	
		
	%>	
</body>
</html>