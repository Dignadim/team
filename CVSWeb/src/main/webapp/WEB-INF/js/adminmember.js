function memberCheck() {
	let frm = document.mbChkForm
	let mode = frm.selectMember.value;
	frm.mode.value = mode;
	
	frm.submit();	
	}

function fixSelected() {
	let before = document.getElementById('mode').value;
	let options = document.getElementsByTagName('option')
	for (let i=0; i<options.length; i++) {
		if(before.trim() == options[i].value.trim()) {
			options[i].selected = true;
		}
	} 
}

function reload() {
	opener.location.reload();
}

//function block(Type){
//	let banType = Type.value;
	
//   location.href='adminBlock.jsp?blockType='+blockType+'&vo='vo;
//}

function memberAdministrate() {
	let id = document.getElementById('msrch').value
	location.href='../member/admin?id=' + id + '&mode=' + 5
}

function goNotice() {
	let id = document.getElementById('mid').value
	let msg = document.getElementById('msg').value
	location.href='../member/goNotice?id =' + id + '&msg=' + msg
}

function goMsg() {
	// 내 아이디, 상대 아이디, 보낼 내용을 받아와서 ajax로 넘겨준다.
	let mid = document.getElementById('mid').value // 내 아이디
	let fid = document.getElementById('fid').value // 쪽지를 받을 사람 아이디
	
	let msg = document.getElementById('msg') // 메시지 내용
	let frm = document.getElementsByName('insertMsg')[0]
	$.ajax({
		type: 'POST',
		url: 'isAdmin',
		data: {
			id: fid
		},
		success: res => {				

			if (res == 1 || fid.includes('admin')) {
				alert('관리자에게 쪽지를 보낼 수 없습니다!')
			} else {

				if (msg.value.length >= 250) {
					alert('250자까지만 입력 가능합니다.')
					msg.focus()
				} else {
					frm.submit();	
					alert('쪽지 발송 완료!')
				}			
	
			}
	
		},
		error: e => {
			console.log(e)
		}
	})			
	
}

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	
	// 구글 차트 api 사용방법
	// 먼저 ajax로 원하는 데이터를 가져온다.
	// 여기서는 'select sellCVS, count(itemName) as averscore, round(avg(itemPrice)) as itemPrice from item group by sellCVS' 를 통해서 편의점별 이번 달 상품 개수와 평균 가격 정보를 가져옴
	$.ajax({
		type: 'POST',
		url: 'adminChart',
		data: {	},
		success: res => {		
			
			// json 형태로 얻어온 res값을 parsing 한다.
			let object = eval('(' + res + ')')
			let result = object.result;
			
			// 들어갈 컬럼의 개수만큼 []안에 ''를 적는다. 여기서는 편의점명, 행사 상품 개수, 행사 상품 평균 가격 이렇게 총 3개이므로 ''도 3개
			var temp = ['', '', '']
			// 반복문을 이용해서 temp 배열에 데이터를 넣어준다.
			for (let j = 0; j < result.length; j++) {	
				// 첫 번째 행에는 열의 이름들을 적어준다.
				if (j == 0) {
					temp[j] = ['편의점', '행사 상품 개수', '행사 상품 평균 가격']					
				}
				// 두 번째 행부터는 데이터를 넣어준다.
				// result값을 하나하나 순서대로 indexing한다. 이 때, 얻어온 데이터는 기본적으로 문자열이기 때문에 숫자 형식으로 들어가야 하는 경우는 *1을 한다.
				temp[j+1] = [result[j][0].value,  result[j][2].value * 1, result[j][1].value * 1]				
			}			
			
			// 완성된 temp 배열을 구글 api를 통해 data에 넣는다.
			var data =  google.visualization.arrayToDataTable(temp);	
			
			// 차트의 옵션을 설정한다. (옵션이 매우 많음 / 그때그때 맞춰서 수정)
	        var options = {
	        		// 차트 제목
	                title: '편의점별 이번 달 행사 상품 개수 및 평균 가격',
	                // 차트 제목 스타일
	                titleTextStyle: {
	                    fontSize: 20
	                  },
	                // 선형 차트 굴곡 부드럽게
	                curveType: 'function',
	                // 범례 스타일
	                legend: { position: 'bottom' },
	                // 기본 차트 타입(콤보 차트 한정)
			        seriesType: 'bars',
			        // 세로축 설정
			        series: {0: {targetAxisIndex:0}, 1: {type: 'line', targetAxisIndex:1}},
			          vAxes: {0: {format:'#,###개'}, 1: {format:'#,###원'}}
	              };
			
	        // visualization. 뒤에 있는 ~Chart 부분이 차트의 형태(원 차트, 기둥 차트 등)를 정한다.
			var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			// 차트 div 위치에 차트를 그린다.
			chart.draw(data, options);	
			
		},
		error: e => {
			console.log(e.status)
		}
	})		
  
}