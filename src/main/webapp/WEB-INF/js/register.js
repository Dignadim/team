// 로그인
function loginChk() {
	let userID = $('input[name=userID]').val();
	let userPW = $('input[name=userPW]').val();
	
	$.ajax({
		type: 'POST',
		url: 'loginChk',
		data: {
			userID: userID,
			userPW: userPW,
		},
		success: response => {
			// console.log('연결성공')
			switch(response) {
				case '1':
					$('#cautionMsg').html('아이디와 비밀번호를 입력해주세요.');
					break;
				case '2':
					$('#cautionMsg').html('등록되지 않은 아이디입니다.');
					break;
				case '3':
					$('#cautionMsg').html('비밀번호가 일치하지 않습니다.');
					break;
				case '4':
					$('form[name=login_form]').submit();
					break;
			}
		},
		// ajax 요청이 실패하면 에러 정보가 콜백 함수의 인수로 넘어온다.
		error: error => { // ajax 요청이 실패하면 실행할 콜백 함수
			console.log('요청실패: ', error.status);
		}
	});
	
}

// ====================================================================================
// 회원 가입

//	모달 관련
var modalOpen  = document.getElementById('modal-open');
var modalClose = document.getElementById('modal-close');

// modal 창을 감춤
var closeRtn = () =>
{
	var modal = document.getElementById('modal');
	modal.style.display = 'none';
}

var closeRtnRegiSucc = () =>
{
	alert('회원가입에 성공하셨습니다. 환영합니다.');
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
//	console.log('아이디를 체크합니다.');
	
	let id = $('input[name=regiid]').val().trim();
	//	console.log(id);
	if(id == null || id == '')
	{
		$('#idChkMsg').html('아이디를 입력하고 중복 체크 버튼을 누르세요.');
		
		//return result;
		return;
	} else if (regtest() == false) {
		return;
	}
	//	console.log(id.toLowerCase());

	
	
	//	jQuery ajax
	$.ajax(
		{
			type: 'POST',
			url: 'register',
			data: 
			{
				userID: id.toLowerCase(),
				SvtKind: 'idChk'
			},
			success: response =>
			{
				// console.log('연결성공');
				switch(response)
				{
					case '0':
						$('#idChkMsg').html('사용중인 아이디 입니다.');
						$('input[name=regiid]').val('');
						break;
					case '1':
						$('#idChkMsg').html('사용 가능한 아이디입니다.');
						//result = 'true';
						break;
				}
				
			},
			error: e =>
			{
				console.log('요청 실패: ', e.status);
			}
		});
		
}

//	비밀번호와 비밀번호 확인이 같은지 확인하는 함수
function pssChk()
{
	let pss1 = $('input[name=regipassword]').val();
	let pss2 = $('input[name=regipasswordCh]').val();
	
	// 숫자와 문자 포함 형태의 6~12자리 이내의 암호 정규식
	const regpwd = /^[A-Za-z0-9]{6,12}$/;
	if(regpwd.test(pss1) == false) {
		$('#pssChkMsg').html('숫자와 문자를 포함해서 6~12자 이내로 입력해주세요.');
		return;
	} else {
		$('#pssChkMsg').html('');		
	}
	
	if(pss1 == null || pss1 == ''
	 || pss2 == null || pss2 == '') return;
	
	if(pss1 != pss2)
	{
		$('#pssChkMsg').html('비밀번호가 일치하지 않습니다.');
		return;
	}
	else
	{
		$('#pssChkMsg').html('');
		return true;
	}
	
}

function register()
{
	//	비밀번호 검사를 통과 못하면 종료
	if(!pssChk())
	{
		$('#idChkMsg').html('빈칸을 모두 채워주세요.');
		return;
	}
	
	if(!regtestEmail()) {
		return;
	}
	
	let id = $('input[name=regiid]').val().trim();
	let pss = $('input[name=regipassword]').val().trim();
	let nick = $('input[name=reginickname]').val().trim();
	let email = $('input[name=regiemail]').val().trim();
	
	if(id == null || id == '' ||
		nick == null || nick == '' ||
		email == null || email == '')
	{
		$('#idChkMsg').html('빈칸을 모두 채워주세요.');
		return;
	}


	$.ajax(
		{
			type: 'POST',
			url: 'register',
			data: 
			{
				userID: id.toLowerCase(),
				userPSS: pss,
				userNick: nick,
				userEmail: email,
				SvtKind: 'regiChk'
			},
			success: response =>
			{
				switch(response)
				{
					case '0':
						$('#idChkMsg').html('사용중인 아이디 입니다.');
						$('input[name=regiid]').val('');
						break;
					case '1':
						$('input[type=text]').val('');
						$('input[type=password]').val('');
						$('input[type=email]').val('');
						$('#idChkMsg').html('');
						$('#pssChkMsg').html('');
						closeRtnRegiSucc();
						break;
				}
				
			},
			error: e =>
			{
				console.log('요청 실패: ', e.status);
			}
		});

}

function regtest() {
	
	let id = document.getElementById('regiid').value
	let idChkMsg = document.getElementById('idChkMsg')
	
	const regiid = /^[a-zA-Z0-9]*$/;
	if (regiid.test(id) == false) {
		idChkMsg.innerHTML = '영문자 또는 숫자만 입력하세요.'
		return false
	} else {
		idChkMsg.innerHTML = ''
		return true
	}

}


function regtestEmail() {
	
	let regiemail = document.getElementById('regiemail').value
	let emlMsg = document.getElementById('emlMsg')
	
	const regeml = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if (regeml.test(regiemail) == false) {
		emlMsg.innerHTML = '이메일 형식에 맞지 않습니다.'
		return false
	} else {
		emlMsg.innerHTML = ''
		return true
	}
	
}