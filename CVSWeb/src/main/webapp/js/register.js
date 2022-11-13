var modalOpen  = document.getElementById('modal-open');
var modalClose = document.getElementById('modal-close');

// modal 창을 감춤
var closeRtn = () =>
{
	var modal = document.getElementById('modal');
	modal.style.display = 'none';
}


// modal 창을 보여줌
modalOpen.onclick = () =>
{
	var modal = document.getElementById('modal');
	modal.style.display = 'block';
}

modalClose.onclick = closeRtn;


//	아이디 중복 검사를 실행하는 함수
function idChk()
{
	
	console.log('아이디를 체크합니다.');
	
}

function register()
{
	
}






