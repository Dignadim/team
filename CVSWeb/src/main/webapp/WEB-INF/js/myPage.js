/*
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
*/

function showMyItem(id) {
	let myItemToggle = document.getElementById('myItemToggle')
	let myItemBtn = document.getElementById('myItemBtn')
	let myItem = document.getElementById('myItem')
	
	if (myItemToggle.value == 1) {
		$.ajax({
			type: 'POST',
			url: 'myPageMyItem',
			data: { 
				id: id
			},
			success: res => {
				
				let object = eval('(' + res + ')')
				let result = object.result;
				
				myItem.innerHTML = '';
				
				let row = myItem.insertRow(0);		
				for (let i = 0; i < result.length; i++) {
					let cell = row.insertCell(0);
					cell.innerHTML = '<a href="../item/increment?idx=' + result[i][0].value + '&currentPage=1&job=itemView"><img class="myItemList" src="' + result[i][1].value + '"/></a>';
				}
								
			},
			error: error => {
				console.log('요청실패: ', error.status);
			}
		});	
		
		
		myItem.style.display = 'block'
		myItemToggle.value = 2;
		myItemBtn.value = '닫기'
	} else if (myItemToggle.value == 2 ){
		
		myItem.style.display = 'none'
		myItemToggle.value = 1;
		myItemBtn.value = '보기'
	}
	
	
	
}