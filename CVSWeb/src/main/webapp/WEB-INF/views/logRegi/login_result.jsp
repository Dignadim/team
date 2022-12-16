<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인아웃/회원가입 처리화면</title>
</head>
<body>
<%-- ${result}
${msg}
${ogUrl} --%>

	Response.Write("<script>alert('${msg}');</script>");
	
	<!-- 로그인 실패 -->
	<c:if test="${result eq 'fail'}">
		Response.Write("<script>location.href='login_form?ogUrl=${ogUrl}';</script>");	
	</c:if>
	<!-- 로그인 성공 -->
	<c:if test="${result eq 'success'}">
		Response.Write("<script>location.href='${ogUrl}';</script>");	
	</c:if>
	<!-- 로그아웃 -->
	<c:if test="${result eq 'logout'}">
		Response.Write("<script>location.href='${ogUrl}';</script>");	
	</c:if>
	
	
	
</body>
</html>