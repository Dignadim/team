$(function()
{
//	onload함수로 alert창을 띄울 메시지가 있으면 띄우고 아니면 띄우지않음
	if(document.getElementById('msg').value != null && document.getElementById('msg').value != '')
	{
		funcAlert(document.getElementById('msg').value);
	}
}); 

function funcAlert(msg)
{
	alert(msg);
}


// ajax 검색 요청 함수
function searchFunction() {	
	
//	jQuery ajax
	$.ajax(
		{
			type: 'POST',
			url: 'AjaxSearch',
			data: 
			{
				searchWord: document.getElementById('itemName').value,
				mode: 1
			},
			success: res =>
			{
//				console.log(res);
				searchProcess(res);
			},
			error: e =>
			{
				console.log('요청 실패: ', e.status);
			}
		});
	
}

function searchProcess(res) {
	// 서블릿에서 리턴된 문자열을 javascript 객체로 변환하기 위해 괄호를 붙여 eval() 함수로 실행해 객체에 저장한다.
	let object = eval('(' + res + ')')
	// javascript 객체에서 result라는 key에 할당된 데이터를 얻어온다 => 화면에 출력할 데이터 
	let result = object.result;
	// console.log(result);
	
	// 서블릿에서 수신된 데이터를 출력하기 위해 <tbody> 태그를 얻어온다.
	let tbody = document.getElementById('ajaxTable');
	// 새로 검색되는 데이터가 표시되어야 하므로 이전에 <tbody> 태그에 들어있던 내용은 지운다.
	tbody.innerHTML = '';
	
	// 데이터의 개수만큼 반복하며 <tbody>에 행을 만들어 추가한다.
	for (let i = 0; i < result.length; i++) {
		// <tbody>에 넣어줄 행을 만든다.
		let row = tbody.insertRow(i);
		// 한 행에 출력할 열의 개수만큼 반복하며 행에 열을 추가한다.
		for (let j = 0; j < result[i].length; j++) {
			// 행에 넣어줄 열을 만든다.
			let cell = row.insertCell(j);
			// 열에 화면에 표시할 데이터를 넣어준다.
			cell.innerHTML = result[i][j].value;
//			console.log(result[i][j].value);
		}
	}
}


function itemSelectChange() {
	let selectChange = document.getElementById('selectChange').value;
	if (selectChange == '카테고리별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemSelect(2)"><option selected>전체</option><option>간편식품</option><option>가공식품</option><option>즉석조리</option><option>신선식품</option><option>과자/빵</option><option>아이스크림</option><option>음료</option><option>잡화</option><option>기호식품</option><option>기타상품</option></select>'
	} else if (selectChange == '편의점별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemSelect(3)"><option selected>전체</option><option>CU</option><option>GS25</option><option>세븐일레븐</option><option>ministop</option><option>이마트24</option><option>기타 편의점</option></select>'		
	} else if (selectChange == '행사별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemSelect(4)"><option selected>전체</option><option>1+1</option><option>2+1</option><option>카드사 할인</option><option>포인트 적립</option></select>'				
	} else if (selectChange == '가격별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemSelect(5)"><option selected>전체</option><option>~1,000원</option><option>~5,000원</option><option>~10,000원</option><option>~50,000원</option></select>'						
	} else {
		document.getElementById('subSelectChange').innerHTML =
		'<select class="form-select" width="100"><option selected>(상위 항목 선택)</option></select>'
	}	

}

function itemSelect(mode) {
	
	$.ajax(
			{
				type: 'POST',
				url: 'AjaxSearch',
				data: 
				{
					searchWord: document.getElementById('itemSubSelect').value,
					mode: mode
				},
				success: res =>
				{
					searchProcess(res);
					
				},
				error: e =>
				{
					console.log('요청 실패: ', e.status);
				}
			});
}

function sort(currentPage, mode){
	location.href='itemListSort?currentPage=' + currentPage + '&mode=' + mode
}


