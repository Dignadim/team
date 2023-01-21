onload = () => {
	hideSpinner()
}

function sort(currentPage, mode){
	document.getElementById('beforeSort').value = mode;
	location.href='itemListSort?currentPage=' + currentPage + '&mode=' + mode;
}

function searchFunction() {	
	let itemName = document.getElementById('itemName').value;
	location.href = 'itemListSort?itemName=' + itemName + '&mode=11&currentPage=1';
}

function itemSelectChange() {
	let selectChange = document.getElementById('selectChange').value;
	if (selectChange == '카테고리별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemCategorySelect()"><option selected>전체</option><option>식품</option><option>음료/아이스크림</option><option>과자/빵</option><option>잡화</option><option>기타상품</option></select>'
	} else if (selectChange == '편의점별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemCVSSelect()"><option selected>전체</option><option>CU</option><option>GS25</option><option>세븐일레븐</option><option>ministop</option><option>이마트24</option><option>C·SPACE</option></select>'		
	} else if (selectChange == '행사별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemEventSelect()"><option selected>전체</option><option>원플러스원</option><option>투플러스원</option><option>덤증정</option><option>할인</option><option>기타행사</option></select>'				
	} else if (selectChange == '가격별') {
		document.getElementById('subSelectChange').innerHTML =
		'<select id="itemSubSelect" class="form-select" width="100" onchange="itemPriceSelect()"><option selected>전체</option><option>1000</option><option>5000</option><option>10000</option><option>50000</option></select>'						
	} else {
		document.getElementById('subSelectChange').innerHTML =
		'<select class="form-select" width="100"><option selected>(상위 항목 선택)</option></select>'
	}	

}


function itemCategorySelect() {
	location.href = 'itemListSort?category=' + document.getElementById('itemSubSelect').value + '&currentPage=1&mode=7';
}

function itemCVSSelect() {
	location.href = 'itemListSort?sellCVS=' + document.getElementById('itemSubSelect').value + '&currentPage=1&mode=8';	
}

function itemEventSelect() {	
	location.href = 'itemListSort?eventType=' + document.getElementById('itemSubSelect').value + '&currentPage=1&mode=9';	
}

function itemPriceSelect() {
	location.href = 'itemListSort?itemPrice=' + document.getElementById('itemSubSelect').value + '&currentPage=1&mode=10';		
}


function itemCrawling() {
	showSpinner()
	location.href='itemCrawling';
}


function showSpinner() {
    document.getElementsByClassName('layerPopup')[0].style.display='block';
}
function hideSpinner() {
    document.getElementsByClassName('layerPopup')[0].style.display='none';
}




