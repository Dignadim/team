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


function checkInfo()
{	
	let form = document.changeInfo;
	let nickname = form.nickname.value.trim();
	let email = form.email.value.trim();
	let password = form.password.value;
	let password2 = form.password2.value;
	
	if(nickname == null || nickname == ''){
		alert('변경할 닉네임을 입력해주세요');
		return false;
	}else if(email == null || email == ''){
		alert('변경할 이메일을 입력해주세요');
		return false;
	}else if(password == null || password == ''|| password2 == null || password2 == '') {
		alert('변경할 비밀번호를 입력해 주세요.')
		form.password.focus()
		return false;
	}else if(password != password2){
		alert('비밀번호가 일치하지 않습니다.');
		return false;
	}else{
		document.changeInfo.submit();
	}
	
}