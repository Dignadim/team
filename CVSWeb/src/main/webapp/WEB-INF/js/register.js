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
	}
	//	console.log(id.toLowerCase());

	
	
	//	jQuery ajax
	$.ajax(
		{
			type: 'POST',
			url: 'register',
			//url: 'http://localhost:/CVSWeb/svtRegi',
			//url: './SvtRegister',
			//url: 'CVSWeb/java/project/member/controller/SvtRegister',
			data: 
			{
				userID: id.toLowerCase(),
				SvtKind: 'idChk'
			},
			success: res =>
			{
				switch(res)
				{
					case '0':
						$('#idChkMsg').html('사용중인 아이디 입니다~~~');
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
		$('#idChkMsg').html('빈칸을 다 채워주세요.');
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
		$('#idChkMsg').html('빈칸을 다 채워주세요.');
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
			success: res =>
			{
				switch(res)
				{
					case '0':
						$('#idChkMsg').html('사용중인 아이디 입니다~~~');
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


