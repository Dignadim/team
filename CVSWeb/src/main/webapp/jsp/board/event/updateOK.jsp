<%@page import="project.util.calendar.ScheduleManager"%>
<%@page import="project.util.calendar.ScheduleVO"%>
<%@page import="project.board.event.EventboardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
%>

	<jsp:useBean id="ev_vo" class="project.board.event.EventboardVO">
		<jsp:setProperty property="*" name="ev_vo"/>
	</jsp:useBean>
	
<%	
	//우선 startSch를 받아와서 -기준으로 잘라서 배열에 담아준다.
	String[] startSch = request.getParameter("startSch").split("-");
	//	endSch는 null 빈칸이 들어올수도 있으니까 먼저 따로 받아서 검사를 해준다.
	String temp = request.getParameter("endSch");
	String[] endSch = {"0", "0", "0"};
	//out.println(endSch[0]);
	//out.println("endSch 받아온거: " + temp + "<br/>");

	endSch = temp.split("-");
	
	
	String event = request.getParameter("contentSch");
	
	
	//	받아온 값들을 인수로 스케쥴vo를 만들고
	ScheduleVO vo = new ScheduleVO(
			Integer.parseInt(startSch[0].trim()),
			Integer.parseInt(startSch[1].trim()),
			Integer.parseInt(startSch[2].trim()),
			Integer.parseInt(endSch[0].trim()),
			Integer.parseInt(endSch[1].trim()),
			Integer.parseInt(endSch[2].trim()),
			event,
			ev_idx
			);
	//	그걸 db에 입력하라고 넘겨준다.
	ScheduleManager.getInstance().updateSched(vo);

	out.println("<script>");
	EventboardService.getInstance().evUpdate(ev_vo);	
	out.println("alert('게시글이 성공적으로 수정되었습니다.')");
	out.println("location.href='list.jsp?currentPage=" + currentPage + "'");
	out.println("location.href='selectByIdx.jsp?ev_idx="+ev_idx+"&currentPage="+currentPage+"&job=contentView'");
	out.println("</script>");
%>

</body>
</html>