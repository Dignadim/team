<%@page import="project.util.calendar.ScheduleVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="project.util.calendar.ScheduleManager"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="project.util.calendar.MyCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만년 달력</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<!-- 내장된 css -->
<style type="text/css">

	table {
		border: 0px solid tomato;
	}

	tr {
		height: 90px;
		border-width: 0px;
	}

	th {
		font-size: 20pt;
		width: 100px;
		border-width: 0px;
	}

	th#title {
		font-size: 30pt;
		font-family: D2Coding;
		font-weight: bold;
		color: tomato;
	}
	
	th#sunday {
		color: red;
	}
	
	th#saturday {
		color: blue;
	}
	
	td {
		text-align: right;
		vertical-align: top;
		border: 1px solid black;
		border-radius: 10px;
	}
	
	td.sun {
		color: red;
	}
	
	td.sat {
		color: blue;
	}
	
	td#beforesun {
		color: red;
		font-size: 10pt;
		background-color: lavender;
	}
	
	td.before {
		font-size: 10pt;
		background-color: lavender;
	}
	
	td#aftersat {
		color: blue;
		font-size: 10pt;
		background-color: yellowgreen;
	}
	
	td.after {
		font-size: 10pt;
		background-color: yellowgreen;
	}
	
	td#choice {
		text-align: left;
		vertical-align: middle;
	}
	
	td.event {
		background-color: orange;
		color: GhostWhite;
		font-weight: bold;
	}
	
	span {
		font-size: 6pt;
	}

	a {
		color: black;
		text-decoration: none;
	}

	a:hover {
		color: lime;
		text-decoration: overline;
	}

	a:active {
		color: DodgerBlue;
		text-decoration: underline;
	}

	.button {
	  background-color: #4CAF50; /* Green */
	  border: none;
	  color: white;
	  padding: 5px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  margin: 0;
	  transition-duration: 0.4s;
	  cursor: pointer;
	}
	
	.button1 {
	  background-color: white; 
	  color: black; 
	  border: 2px solid #4CAF50;
	}
	
	.button1:hover {
	  background-color: #4CAF50;
	  color: white;
	}
	
	.select {
		width: 100px;
		height: 30px;
	}
	
	fieldset {
		width: 105px;
		height: 50px;
		display: inline;
		border: none;
	}
	
</style>

</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	

	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
	
	
	//year = Integer.parseInt(request.getParameter("category"));

	try {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		// month 13이 넘어왔으면 달력에는 다음해 1월을 표시해야 하고 month에 0이 넘어왔으면 달력에는
		// 전년도 12월을 표시해야 한다.
		if (month >= 13) {
			year++;
			month = 1;
		} else if (month <= 0) {
			year--;
			month = 12;
		}
		
	} catch (NumberFormatException e) { }
	
//	달력을 출력할 달 1일의 요일을 계산해둔다.
	int week = MyCalendar.weekDay(year, month, 1);

//	빈 칸에 출력할 전달 날짜의 시작일을 계산한다.
	int start = 0;
	if (month == 1) {
		start = MyCalendar.lastDay(year - 1, 12) - week; // 1월
	} else {
		start = MyCalendar.lastDay(year, month - 1) - week; // 2 ~ 12월
	}
	
//	빈 칸에 출력할 다음달 1일의 요일을 계산한다.
	int nWeek = month == 12 ? MyCalendar.weekDay(year + 1, 1, 1) : MyCalendar.weekDay(year, month + 1, 1);
	
//	이전달
	int lastMonth = month > 1 ? month - 1 : 12;
//	다음달
	int nextMonth = month < 12 ? month + 1 : 1;

//	스케줄이 담긴 리스트
	ArrayList<ScheduleVO> list = ScheduleManager.getInstance().getList();

	 request.setAttribute("year", year);
	 request.setAttribute("month", month);
	 request.setAttribute("lMonth", lastMonth);
	 request.setAttribute("nMonth", nextMonth);
	 request.setAttribute("week", week);
	 request.setAttribute("nWeek", nWeek);
	 request.setAttribute("start", start);
	 request.setAttribute("list", list);
%>

<table width="700" border="1" align="center" cellpadding="5" cellspacing="0">

	<tr>
		<th>
			<input class="button button1" type="button" value="이전달"
				onclick="location.href='?year=${year}&month=${month - 1}'">
		</th>
		<th id="title" colspan="5">
			${year}년 ${month}월
		</th>
		<th>
			<button class="button button1" type="button" 
				onclick="location.href='?year=${year}&month=${month + 1}'">
				다음달
			</button>
		</th>
	</tr>
	
	<tr>
		<th id="sunday">일</th>
		<th>월</th>
		<th>화</th>
		<th>수</th>
		<th>목</th>
		<th>금</th>
		<th id="saturday">토</th>
	</tr>

	<!-- 달력에 날짜를 출력한다. -->
	<tr>
		<!-- 이전달 날짜를 출력 -->
		<c:forEach var="i" begin="0" end="${week}">
		<c:if test="${i < week}">
			<c:if test="${i == 0}">
				<td id="beforesun">${lMonth} / ${start + i + 1}</td>
			</c:if>
			<c:if test="${i != 0}">
				<td class="before">${lMonth} / ${start + i + 1}</td>
			</c:if>
		</c:if>
		</c:forEach>

<%
//	1일부터 달력을 출력할 달의 마지막 날짜까지 반복하며 날짜를 출력한다.
	for (int i=1; i<=MyCalendar.lastDay(year, month); i++) {
		boolean check = false;
		
		//	이벤트 리스트의 크기만큼 반복을 돌려준다.
		for(int j = 0; j < list.size(); j++)
		{
			//	끝나는 년도가 0이면 당일하루 이벤트이다.
			if(list.get(j).geteYear() == 0)
			{
				//	리스트에 있는 날짜와 일치하면
				if (year == list.get(j).getsYear() && month == list.get(j).getsMonth() && 
					i == list.get(j).getsDay() ) 
				{
					//	이미 그 날짜에 스케줄을 적었으면
					if(check)
					{
						out.println("<br><span>==" + list.get(j).getEvent() + "==</span>");
					}
					else
					{
						//	이벤트 내용을 출력하고 bool을 true로 한다
						out.println("<td class='event'>" + i + "<br><span>==" + list.get(j).getEvent() + "==</span>");
						check = true;
					}
					
				}
			}
			//	아니면 기간이 있는 이벤트이다.
			else
			{
				// 시작하는 날짜가 이번달 i날짜 이전이고
				if(MyCalendar.totalDay(year, month, i) >= MyCalendar.totalDay
						(
						list.get(j).getsYear(), 
						list.get(j).getsMonth(),
						list.get(j).getsDay()
						))
				{
						//	끝나는 날짜가 이번달 i 날짜 보다 이상이면
						if(MyCalendar.totalDay(year, month, i) <= MyCalendar.totalDay
						(
							list.get(j).geteYear(), 
							list.get(j).geteMonth(),
							list.get(j).geteDay()
						))
						{
							//	이미 그 날짜에 스케줄을 적었으면
							if(check)
							{
								out.println("<br><span>==" + list.get(j).getEvent() + "==</span>");
							}
							else
							{
								//	이벤트라고 찍어준다.
								out.println("<td class='event'>" + i + "<br><span>==" + list.get(j).getEvent() + "==</span>");
								check = true;
							}
						}
				}
				
			}
			
		}
		//	해당 날짜에 대해 스케줄이 있는 for(j)를 다 돌았으면 <td>태그를 닫아준다.
		out.println("</td>");
		//	check가 true이면 그 날짜는 이미 출력했으므로 뒤는 실행x
		if(check)
		{
			//	하기전에 혹시 토요일인지 물어봐서 맞다하면 줄을 바꿔준다.
			if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
				out.println("</tr><tr>");
			}
			continue;
		}
		switch (MyCalendar.weekDay(year, month, i)) 
		{
			case 0: // 일요일
				out.println("<td class='sun'>" + i + "</td>");
				break;
			case 6: // 토요일
				out.println("<td class='sat'>" + i + "</td>");
				break;
			default:
				out.println("<td>" + i + "</td>");
				break;
		}
		// 출력한 날짜가 토요일이고 그 달의 마지막 날짜가 아니면 줄을 바꾼다.
		if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
			out.println("</tr><tr>");
		}
	}


%>	

		<!-- 다음달 날짜를 출력 -->
		<!-- 다음달 1일이 일요일이면 다음달 날짜 출력 X다 -->
		<c:if test="${nWeek != 0}">
			<c:set var="j" value="1" />
			<c:forEach var="i" begin="${nWeek}" end="6">
				<c:if test="${i == 6}">
					<td id="aftersat">${nMonth} / ${j}</td>
				</c:if>
				<c:if test="${i != 6}">
					<td class="after">${nMonth} / ${j}</td>
				</c:if>
				<c:set var="j" value="${j + 1}"/>
			</c:forEach>
		</c:if>

	</tr>
	
	<!-- 년, 월을 선택하고 보기 버튼을 클릭하면 선택된 달의 달력으로 한번에 넘어가게 한다. -->
	<tr>
		<td id="choice" colspan="7">
		
			<form action="?" method="post">
			<fieldset>
				<legend>년</legend>
				<select class="select" name="year"> <!-- 1900 ~ 2100 -->
				
<%
	for (int i=1900; i<=2100; i++) {
		if (i == calendar.get(Calendar.YEAR)) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				
				</select>
			</fieldset>
			
			<fieldset>
				<legend>월</legend>
				<select class="select" name="month"> <!-- 1 ~ 12 -->
				
<%
	for (int i=1; i<=12; i++) {
		if (i == calendar.get(Calendar.MONTH) + 1) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				
				</select>
			</fieldset>

			<input class="select" type="submit" value="보기">
			</form>

		</td>
	</tr>

</table>

</body>
</html>













