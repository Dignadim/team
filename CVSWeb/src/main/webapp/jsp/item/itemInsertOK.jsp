<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="project.item.ItemService"%>
<%@ page import="java.util.Enumeration" %>
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
		/* String realFolder="";
		String saveFolder = "images";		//사진을 저장할 경로
		String encType = "UTF-8";				//변환형식
		int maxSize=5*1024*1024;
		
		ServletContext context = this.getServletContext(); // 절대 경로를 얻는다.
		realFolder = context.getRealPath(saveFolder); // saveFolder의 절대 경로를 얻는다
		
		MultipartRequest multi = null;
		
		// 파일 업로드를 직접적으로 담당
		multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		// form으로 전달받은 데이터를 가져온다.
		String itemImage = multi.getFilesystemName("itemImage");
		String itemName = multi.getParameter("itemName");
		int itemPrice = Integer.parseInt(multi.getParameter("itemPrice"));
		String category = multi.getParameter("category");
		String sellCVS = multi.getParameter("sellCVS");
		String eventType = multi.getParameter("eventType");
		
		vo.setItemName(itemName);
		vo.setItemPrice(itemPrice);
		vo.setCategory(category);
		vo.setSellCVS(sellCVS);
		vo.setEventType(eventType);
		
		if (itemImage != null) {
			File oldFile = new File(realFolder + "\\" + itemImage);
			File newFile = new File(realFolder + "\\" + vo.getIdx() + "사진.jpg");
			oldFile.renameTo(newFile);
		}  */
				
		out.println("<script>");
		try {
			ItemService.getInstance().itemInsert(vo);		
			out.println("alert('상품을 입력했습니다.')");						
		} catch (NullPointerException e) {
			out.println("alert('모든 정보를 입력하세요.')");			
		}
		// 메인글 1페이지 분량의 글 목록을 얻어오는 페이지(itemList.jsp)로 넘겨준다.
		out.println("location.href='itemList.jsp'");	
		out.println("</script>");	
		
	%>	
</body>
</html>