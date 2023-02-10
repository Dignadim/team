<%@page import="com.project.util.calendar.ScheduleManager"%>
<%@page import="com.project.util.calendar.ScheduleVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.project.util.calendar.MyCalendar"%>
<%@page import="java.util.Calendar"%>
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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
<!-- 내장된 css -->
<style type="text/css">
	* {
		font-family: Pretendard;
	}
	
	table {
		border-radius: 10px;
	}

	tr {
		height: 90px;
		border-width: 0px;
	}

	th {
		font-size: 20pt;
		width: 100px;
		border-width: 0px;
		text-align: center;
		vertical-align: middle;
	}

	th#title {
		font-size: 20pt;
	}
	
	th#sunday {
		color: orangered;
	}
	
	th#saturday {
		color: skyblue;
	}
	
	td {
		text-align: left;
		vertical-align: top;
		box-sizing: border-box;
		width: 100px;
		height: 90px;
	}
	
	td.sun {
		color: orangered;
	}
	
	td.sat {
		color: skyblue;
	}
	
	td#beforesun {
		color: orangered;
		font-size: 10pt;
	}
	
	td.before {
		font-size: 10pt;
	}
	
	td#aftersat {
		color: skyblue;
		font-size: 10pt;
	}
	
	td.after {
		font-size: 10pt;
	}
	
	td#choice {
		text-align: left;
		vertical-align: middle;
	}
	
	td.event {
		background-color: cornflowerblue;
		color: GhostWhite;
	}
	
	span {
		font-size: 12pt;
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
	
	.myModal:hover {
		cursor: pointer;
	}
	
	.modalTr {
		height: 50px !important;
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
	 
	 String gs = "<div style='width: 12px; height: 12px; border-radius: 50%; background-color: green; display: inline-block; vertical-align: middle;'></div>";
	 String cu = "<div style='width: 12px; height: 12px; border-radius: 50%; background-color: purple; display: inline-block; vertical-align: middle;'></div>";
	 String se = "<div style='width: 12px; height: 12px; border-radius: 50%; background-color: orangered; display: inline-block; vertical-align: middle;'></div>";
	 String ms = "<div style='width: 12px; height: 12px; border-radius: 50%; background-color: yellow; display: inline-block; vertical-align: middle;'></div>";
	 String em = "<div style='width: 12px; height: 12px; border-radius: 50%; background-color: gray; display: inline-block; vertical-align: middle;'></div>";
	 String cs = "<div style='width: 12px; height: 12px; border-radius: 50%; background-color: blue; display: inline-block; vertical-align: middle;'></div>";
	 
%>

<table class="table table-bordered" width="1200" cellpadding="5" cellspacing="0">
	<tr class="table-borderless" style="height: 30px !important;">
		<td colspan="7" style=" vertical-align: bottom;">
			※ 날짜를 클릭하면 상시 진행 행사도 확인 가능합니다. <br/>
			<div style="width: 15px; height: 15px; border-radius: 50%; background-color: green; display: inline-block; vertical-align: middle;"></div> &nbsp;GS25&nbsp;
			<div style="width: 15px; height: 15px; border-radius: 50%; background-color: purple; display: inline-block; vertical-align: middle;"></div> &nbsp;CU&nbsp;
			<div style="width: 15px; height: 15px; border-radius: 50%; background-color: orangered; display: inline-block; vertical-align: middle;"></div> &nbsp;세븐일레븐&nbsp;
			<div style="width: 15px; height: 15px; border-radius: 50%; background-color: yellow; display: inline-block; vertical-align: middle;"></div> &nbsp;ministop&nbsp;
			<div style="width: 15px; height: 15px; border-radius: 50%; background-color: gray; display: inline-block; vertical-align: middle;"></div> &nbsp;이마트24&nbsp;
			<div style="width: 15px; height: 15px; border-radius: 50%; background-color: blue; display: inline-block; vertical-align: middle;"></div> &nbsp;C·SPACE&nbsp;
		</td>
	</tr>
	<tr class="table-light">
		<th>
			<input class="btn btn-outline-primary" type="button" value="이전 달"
				onclick="location.href='?year=${year}&month=${month - 1}'">
		</th>
		<th class="table-primary" id="title" colspan="5" style="text-align: center; vertical-align: middle;">
			${year}년 ${month}월 행사
		</th>
		<th>
			<button class="btn btn-outline-primary" type="button" 
				onclick="location.href='?year=${year}&month=${month + 1}'">
				다음 달
			</button>
		</th>
	</tr>
	
	<tr class="table-light" style="height: 20px; vertical-align: middle; font-size: 16px;">
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
				<td id="beforesun" class="table-secondary">${lMonth} / ${start + i + 1}</td>
			</c:if>
			<c:if test="${i != 0}">
				<td class="before table-secondary">${lMonth} / ${start + i + 1}</td>
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
			//	끝나는 연도가 0이면 당일하루 이벤트이다.
			if(list.get(j).geteYear() == 0)
			{
				//	리스트에 있는 날짜와 일치하면
				if (year == list.get(j).getsYear() && month == list.get(j).getsMonth() && 
					i == list.get(j).getsDay() ) 
				{
					//	이미 그 날짜에 스케줄을 적었으면
					if(check)
					{
						out.println("<span>");
						if (list.get(j).getCVS().equals("세븐일레븐")) {
							out.println(se);
						}
						if (list.get(j).getCVS().equals("CU")) {
							out.println(cu);
						}
						if (list.get(j).getCVS().equals("GS25")) {
							out.println(gs);
						}
						if (list.get(j).getCVS().equals("ministop")) {
							out.println(ms);
						}
						if (list.get(j).getCVS().equals("이마트24")) {
							out.println(em);
						}
						if (list.get(j).getCVS().equals("C·SPACE")) {
							out.println(cs);
						}								
						out.println("</span>");
					}
					else
					{
						//	이벤트 내용을 출력하고 bool을 true로 한다
						out.println("<td class='table-warning myModal' data-bs-toggle='modal' data-bs-target='#myModal' data-bs-day='" + i +"'>" + 
						i + "<br><span class='myModal' data-bs-toggle='modal' data-bs-target='#myModal'>");
						if (list.get(j).getCVS().equals("세븐일레븐")) {
							out.println(se);
						}
						if (list.get(j).getCVS().equals("CU")) {
							out.println(cu);
						}
						if (list.get(j).getCVS().equals("GS25")) {
							out.println(gs);
						}
						if (list.get(j).getCVS().equals("ministop")) {
							out.println(ms);
						}
						if (list.get(j).getCVS().equals("이마트24")) {
							out.println(em);
						}
						if (list.get(j).getCVS().equals("C·SPACE")) {
							out.println(cs);
						}							
						out.println("</span>");
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
								out.println("<span>");
								if (list.get(j).getCVS().equals("세븐일레븐")) {
									out.println(se);
								}
								if (list.get(j).getCVS().equals("CU")) {
									out.println(cu);
								}
								if (list.get(j).getCVS().equals("GS25")) {
									out.println(gs);
								}
								if (list.get(j).getCVS().equals("ministop")) {
									out.println(ms);
								}
								if (list.get(j).getCVS().equals("이마트24")) {
									out.println(em);
								}
								if (list.get(j).getCVS().equals("C·SPACE")) {
									out.println(cs);
								}								
								out.println("</span>");
							}
							else
							{
								//	이벤트라고 찍어준다.
								out.println("<td class='table-warning myModal' data-bs-toggle='modal' data-bs-target='#myModal' data-bs-day='" + i +"'>" + i + "<br><span>");
								if (list.get(j).getCVS().equals("세븐일레븐")) {
									out.println(se);
								}
								if (list.get(j).getCVS().equals("CU")) {
									out.println(cu);
								}
								if (list.get(j).getCVS().equals("GS25")) {
									out.println(gs);
								}
								if (list.get(j).getCVS().equals("ministop")) {
									out.println(ms);
								}
								if (list.get(j).getCVS().equals("이마트24")) {
									out.println(em);
								}
								if (list.get(j).getCVS().equals("C·SPACE")) {
									out.println(cs);
								}				
								out.println("</span>");
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
				out.println("<td class='sun myModal' data-bs-toggle='modal' data-bs-target='#myModal' data-bs-day='" + i +"'>" + i + "</td>");
				break;
			case 6: // 토요일
				out.println("<td class='sat myModal' data-bs-toggle='modal' data-bs-target='#myModal' data-bs-day='" + i +"'>" + i + "</td>");
				break;
			default:
				out.println("<td class='myModal' data-bs-toggle='modal' data-bs-target='#myModal' data-bs-day='" + i +"'>" + i + "</td>");
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
					<td id="aftersat" class="table-secondary">${nMonth} / ${j}</td>
				</c:if>
				<c:if test="${i != 6}">
					<td class="after table-secondary">${nMonth} / ${j}</td>
				</c:if>
				<c:set var="j" value="${j + 1}"/>
			</c:forEach>
		</c:if>

	</tr>
	
	<!-- 년, 월을 선택하고 보기 버튼을 클릭하면 선택된 달의 달력으로 한번에 넘어가게 한다. -->
	<tr class="table-light" style="height: 50px !important;">
		<td id="choice" colspan="7">
		
			<form action="?" method="post">
				<select class="form-select" name="year" style="width: 100px !important; display: inline !important;"> <!-- 1900 ~ 2100 -->
				
<%
	for (int i=1900; i<=2100; i++) {
		if (i == calendar.get(Calendar.YEAR)) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}
%>
				
				</select> 년&nbsp;

				<select class="form-select" name="month" style="width: 100px !important; display: inline !important;"> <!-- 1 ~ 12 -->
				
<%

	for (int i=1; i<=12; i++) {
		if (i == calendar.get(Calendar.MONTH) + 1) {
			out.println("<option selected='selected'>" + i + "</option>");
		} else {
			out.println("<option>" + i + "</option>");
		}
	}

%>
				
				</select> 월&nbsp;

			<input class="btn btn-dark" type="submit" value="보기">
			</form>

		</td>
	</tr>

</table>

<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><span id="modalYear" style="font-size: 25px;"></span>년 <span id="modalMonth" style="font-size: 25px;"></span>월 <span id="modalDay" style="font-size: 25px;"></span>일 행사</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
		<table class="table table-borderless" style="width: 750px;">
			<tbody id="tbody"></tbody>
		</table>
      </div>

    </div>
  </div>
</div>

<script>

const myModal = document.querySelector('#myModal');
myModal.addEventListener('show.bs.modal', function (event) {
	
	// 모달이 열릴 때 event에서 트리거 버튼을 선택한다.
	const triggerBtn = event.relatedTarget;

	let title = document.getElementById('title').innerText;
	const regex = /[^0-9]/g;
	
	let year = title.replace(regex, "").substring(0,4)
	let month = title.replace(regex, "").substring(4)
	
	document.getElementById('modalMonth').innerText = month
	document.getElementById('modalYear').innerText = year
	
	// 수정 버튼이 클릭될 때 data-bs-* 데이터 가져오기
	let day = triggerBtn.getAttribute('data-bs-day');	
	document.getElementById('modalDay').innerText = day
	
	let tbody = document.getElementById('tbody')
	$.ajax({
		type: 'POST',
		url: 'detailedSchedule',
		data: { 
			sYear: year,
			sMonth: month,
			sDay: day
		},
		success: res => {
			let object = eval('(' + res + ')')
			let result = object.result;
			
			tbody.innerHTML = '';
			
			if (result.length != 0) {
				
				for (let i = 0; i < result.length; i++) {

					if ((result[i][1].value == 0 && result[i][4].value == 0) || result[i][0].value == null) {
						// 공지
						tbody.innerHTML += '<tr><td>[공지]</td><td colspan="5">' +  result[i][7].value + '</td></tr>';												
					} else if (result[i][1].value != 0 && result[i][4].value == 0) {
						// 기간 없는 이벤트
						tbody.innerHTML += '<tr><td>[' + result[i][0].value + ']</td><td colspan="3">' +  result[i][7].value + '</td><td colspan="2">' + month+'월 상시 진행</td></tr>';												
					} else {
						// 기간 이벤트
						tbody.innerHTML += '<tr><td>[' + result[i][0].value + ']</td><td colspan="3">' +  result[i][7].value + '</td><td colspan="2">' + result[i][1].value + '/' + result[i][2].value + '/'
						+ result[i][3].value + ' ~ ' + result[i][4].value + '/' + result[i][5].value + '/' + result[i][6].value +'</td></tr>';						
					}					
				}
				
			} else {
				tbody.innerHTML = '<h2>해당 일자 행사가 없습니다.</h2>';
			}
			
		},
		error: e => {
			console.log('요청 실패: ', e.status);
		}
	});
	
});


</script>

</body>
</html>