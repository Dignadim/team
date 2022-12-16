function openWin() {	
	let url = 'itemImageInsert';
	let title = '사진 업로드';
	let option = 'top=100px, left=100px, width=800px, height=800px';
	window.open(url, title, option);
}

function thisClose() {
	opener.document.getElementsByName('itemImage')[0].value = document.querySelector('input[type=radio][name=itemImage]:checked').value;
	self.close();
}

//	controller로 넘기기전에 빈칸이 있지는 않은지 체크를 먼저 해준다음 cotroller로 넘겨준다.
function itemUpdateCheck()
{
	let idx = document.querySelector('input[type=hidden][name=idx]').value;
	let currentPage = document.querySelector('input[type=hidden][name=currentPage]').value;
	let itemImage = document.querySelector('input[type=text][name=itemImage]').value;
	let itemName = document.querySelector('input[type=text][name=itemName]').value;
	let itemPrice = document.querySelector('input[type=text][name=itemPrice]').value;
	let category = document.querySelector('select[name="category"] option:checked').innerText;
	let sellCVS = document.querySelector('select[name="sellCVS"] option:checked').innerText;
	let eventType = document.querySelector('select[name="eventType"] option:checked').innerText;
	
	if(itemImage == null || itemImage == '')
	{
		alert('이미지가 없습니다.')
		return;
	}
	if(itemName == null || itemName == '')
	{
		alert('상품명이 없습니다.')
		return;
	}
	if(itemPrice == null || itemPrice == '')
	{
		alert('상품원가가 없습니다.')
		return;
	}
//	update 인지 insert인지 구분해서 컨트롤러 요청을 다르게 한다.
	let locate = 'item' + document.querySelector('input[type=hidden][name=mode]').value + 'OK';
	location.href= locate + '?currentPage=' + currentPage + '&idx=' + idx + '&itemImage=' + itemImage + '&itemName=' + 
	itemName + '&itemPrice=' + itemPrice + '&category=' + category + '&sellCVS=' + sellCVS + '&eventType=' + eventType;
	
}



















