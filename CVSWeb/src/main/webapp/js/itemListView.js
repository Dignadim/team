const searchRequest = new XMLHttpRequest(); // 검색용
const clickRequest = new XMLHttpRequest(); // 클릭검색용

// ajax 검색 요청 함수
function searchFunction() {	
	let url = '../.././AjaxSearch?itemName=' + encodeURIComponent(document.getElementById('itemName').value);
	searchRequest.open('GET', url, true);	
	// send() 함수로 서버에 요청(서블릿을 호출)한다.
	// 데이터를 url의 일부인 쿼리 스트링(?~~~~)으로 전송할 경우 send() 함수의 인수로 null을 사용한다.
	searchRequest.send(null);
	
	// onreadystatechange를 사용해서 ajax 요청이 완료되면 실행할 콜백 함수 이름을 지정한다.
	searchRequest.onreadystatechange = searchProcess; // ()를 쓰면 안 된다. 
	
}

function searchProcess() {
	if (searchRequest.readyState == 4 && searchRequest.status == 200) {
		// 서블릿에서 리턴된 문자열을 javascript 객체로 변환하기 위해 괄호를 붙여 eval() 함수로 실행해 객체에 저장한다.
		let object = eval('(' + searchRequest.responseText + ')')
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
			}
		}
	}
}

function clickFunction() {
	let url = '../.././AjaxClick?category=' + encodeURIComponent(document.getElementById('itemCategory').value);
	console.log(document.getElementById('itemCategory').value);
	searchRequest.open('GET', url, true);	
	searchRequest.send(null);

	searchRequest.onreadystatechange = categorySearchProcess;
}

function categorySearchProcess() {
		if (searchRequest.readyState == 4 && searchRequest.status == 200) {
		// 서블릿에서 리턴된 문자열을 javascript 객체로 변환하기 위해 괄호를 붙여 eval() 함수로 실행해 객체에 저장한다.
		let object = eval('(' + searchRequest.responseText + ')')
		// javascript 객체에서 result라는 key에 할당된 데이터를 얻어온다 => 화면에 출력할 데이터 
		let result = object.result;
		console.log(result);
		
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
			}
		}
	}
}

function itemSelectChange() {
	let selectChange = document.getElementById('selectChange').value;
	if (selectChange == '카테고리별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemCategorySelect()"><option selected>전체</option><option>간편식품</option><option>가공식품</option><option>즉석조리</option><option>신선식품</option><option>과자/빵</option><option>아이스크림</option><option>음료</option><option>잡화</option><option>기호식품</option><option>기타상품</option></select>'
	} else if (selectChange == '편의점별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemCVSSelect()"><option selected>전체</option><option>CU</option><option>GS25</option><option>세븐일레븐</option><option>ministop</option><option>이마트24</option><option>기타 편의점</option></select>'		
	} else if (selectChange == '행사별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemEventSelect()"><option selected>전체</option><option>1+1</option><option>2+1</option><option>카드사 할인</option><option>포인트 적립</option></select>'				
	} else if (selectChange == '가격별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemPriceSelect()"><option selected>전체</option><option>~1,000원</option><option>~5,000원</option><option>~10,000원</option><option>~50,000원</option></select>'						
	} else {
		document.getElementById('subSelectChange').innerHTML =
		'<select class="form-select" width="100"><option selected>(상위 항목 선택)</option></select>'
	}	

}

function itemCategorySelect() {
	let url = '../.././AjaxCategoryClick?category=' + encodeURIComponent(document.getElementById('itemSubSelect').value);
	searchRequest.open('GET', url, true);	
	searchRequest.send(null);
	searchRequest.onreadystatechange = categorySearchProcess;
}

function itemCVSSelect() {
	let url = '../.././AjaxCVSClick?SellCVS=' + encodeURIComponent(document.getElementById('itemSubSelect').value);
	searchRequest.open('GET', url, true);	
	searchRequest.send(null);
	searchRequest.onreadystatechange = categorySearchProcess;	
}

function itemEventSelect() {
	let url = '../.././AjaxEventClick?eventType=' + encodeURIComponent(document.getElementById('itemSubSelect').value);
	searchRequest.open('GET', url, true);	
	searchRequest.send(null);
	searchRequest.onreadystatechange = categorySearchProcess;
}

function itemPriceSelect() {
	let url = '../.././AjaxPriceClick?itemPrice=' + encodeURIComponent(document.getElementById('itemSubSelect').value);
	searchRequest.open('GET', url, true);	
	searchRequest.send(null);
	searchRequest.onreadystatechange = categorySearchProcess;	
}

function sort(currentPage, mode){
	location.href='itemListSort.jsp?currentPage=' + currentPage + '&mode=' + mode
}


