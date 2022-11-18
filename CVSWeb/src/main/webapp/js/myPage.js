function checkInfo(form)
{	
	let id = form.id.value.trim();
	let nickname = form.nickname.value.trim();
	let email = form.email.value.trim();
	let password = form.password.value;
	let password2 = form.password2.value;
	
	if(nickname == null || nickname == ''){
		alert('변경할 닉네임을 입력해주세요');
		return false;
	}else if(email == null || email == ''){
		alert('변경할 닉네임을 입력해주세요');
		return false;
	}else if(password == null || password == ''|| password2 == null || password2 == '') {
		alert('변경할 비밀번호를 입력해 주세요.')
		form.password.focus()
		return false;
	}else if(password != password2){
		alert('비밀번호가 일치하지 않습니다.');
		return false;
	}else{
		var sessionData = "sessionData";
		sessionStorage.setItem("mineSession", sessionData ); // 저장
		sessionStorage.getItem("mineSession");
		return true;
	}
	
}