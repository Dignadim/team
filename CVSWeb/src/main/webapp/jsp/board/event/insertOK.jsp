<%@page import="project.util.calendar.ScheduleManager"%>
<%@page import="project.util.calendar.ScheduleVO"%>
<%@page import="project.board.event.EventboardVO"%>
<%@page import="project.board.event.EventboardService"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
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
	
%>

	<jsp:useBean id="ev_vo" class="project.board.event.EventboardVO">
		<jsp:setProperty property="*" name="ev_vo"/>
	</jsp:useBean>
	<%-- ${ev_vo} --%>
	<jsp:useBean id="mb_vo" class="project.member.MemberVO">
		<jsp:setProperty property="*" name="mb_vo"/>
	</jsp:useBean>
	<%-- ${mb_vo} --%>
	
<%	
	ev_vo.setId(mb_vo.getId());
	ev_vo.setNickname(mb_vo.getNickname());
	
//	우선 startSch를 받아와서 -기준으로 잘라서 배열에 담아준다.
	String[] startSch = request.getParameter("startSch").split("-");
	//	endSch는 null 빈칸이 들어올수도 있으니까 먼저 따로 받아서 검사를 해준다.
	String temp = request.getParameter("endSch");
	String[] endSch = {"0", "0", "0"};
	//out.println(endSch[0]);
	//out.println("endSch 받아온거: " + temp + "<br/>");
	if(temp != null && temp != "")
	{
		endSch = temp.split("-");
	}
	String event = request.getParameter("contentSch");
	
	
	//out.println(endSch[2]);
	//out.println(startSch[0]);
	

	//	받아온 값들을 인수로 스케쥴vo를 만들고
	ScheduleVO vo = new ScheduleVO(
			Integer.parseInt(startSch[0]),
			Integer.parseInt(startSch[1]),
			Integer.parseInt(startSch[2]),
			Integer.parseInt(endSch[0]),
			Integer.parseInt(endSch[1]),
			Integer.parseInt(endSch[2]),
			event,
			-1
			);
	//	그걸 db에 입력하라고 넘겨준다.
	ScheduleManager.getInstance().insertSched(vo);
	
	

	out.println("<script>");
	out.println("alert('게시글이 등록되었습니다.')");
	EventboardService.getInstance().evInsert(ev_vo);
	out.println("location.href='list.jsp'");
	out.println("</script>"); 
%>

</body>
</html>