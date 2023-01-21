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

				myItem.innerHTML = '<div>찜한 상품이 존재하지 않습니다.</div>'

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

function goMsg() {
	// 내 아이디, 상대 아이디, 보낼 내용을 받아와서 ajax로 넘겨준다.
	let mid = document.getElementById('mid').value // 내 아이디
	let fid = document.getElementById('fid').value // 쪽지를 받을 사람 아이디
	
	let msg = document.getElementById('msg') // 메시지 내용
	let frm = document.getElementsByName('insertMsg')[0]
	$.ajax({
		type: 'POST',
		url: 'isAdmin',
		data: {
			id: fid
		},
		success: res => {				

			if (res == 1 || fid.includes('admin')) {
				alert('관리자에게 쪽지를 보낼 수 없습니다!')
			} else {

				if (msg.value.length >= 250) {
					alert('250자까지만 입력 가능합니다.')
					msg.focus()
				} else {
					frm.submit();	
					alert('쪽지 발송 완료!')
				}			
	
			}
	
		},
		error: e => {
			console.log(e)
		}
	})			
	
}

function deleteMe(id) {
	let cfm = confirm('경고! 삭제한 회원 정보는 복구할 수 없습니다. 정말 탈퇴하시겠습니까?')
	if (cfm == true) {
		location.href='deleteMe?id=' + id
	}
}

function msgBox() {
	let id = document.getElementById('id').value
	let url = '../member/msgBox?id=' + id;
	let title = '쪽지함 보기';
	let option = 'top=200px, left=200px, width=600px, height=600px';
	window.open(url, title, option);
}
	
function tog1() {
	let mlist = document.getElementById('mlist')
	let tlist = document.getElementById('tlist')
	let trashlist = document.getElementById('trashlist')
	let tog1 = document.getElementsByClassName('tog')[0]
	let tog2 = document.getElementsByClassName('tog')[1]
	let tog3 = document.getElementsByClassName('tog')[2]
	
	mlist.style.display = 'block'
	tlist.style.display = 'none'
	trashlist.style.display = 'none'
	tog1.style.backgroundColor = '#0d6efd'
	tog2.style.backgroundColor = '#f8f9fa'
	tog3.style.backgroundColor = '#f8f9fa'
	tog1.style.color = '#f8f9fa'
	tog2.style.color = '#0d6efd'
	tog3.style.color = 'darkgray'
}

function tog2() {
	let mlist = document.getElementById('mlist')
	let tlist = document.getElementById('tlist')
	let trashlist = document.getElementById('trashlist')
	let tog1 = document.getElementsByClassName('tog')[0]
	let tog2 = document.getElementsByClassName('tog')[1]
	let tog3 = document.getElementsByClassName('tog')[2]
	
	mlist.style.display = 'none'
	tlist.style.display = 'block'
	trashlist.style.display = 'none'
	tog1.style.backgroundColor = '#f8f9fa'
	tog2.style.backgroundColor = '#0d6efd'
	tog3.style.backgroundColor = '#f8f9fa'
	tog1.style.color = '#0d6efd'
	tog2.style.color = '#f8f9fa'
	tog3.style.color = 'darkgray'
}

function tog3() {
	let mlist = document.getElementById('mlist')
	let tlist = document.getElementById('tlist')
	let trashlist = document.getElementById('trashlist')
	let tog1 = document.getElementsByClassName('tog')[0]
	let tog2 = document.getElementsByClassName('tog')[1]
	let tog3 = document.getElementsByClassName('tog')[2]
	
	mlist.style.display = 'none'
	tlist.style.display = 'none'
	trashlist.style.display = 'block'
	tog1.style.backgroundColor = '#f8f9fa'
	tog2.style.backgroundColor = '#f8f9fa'
	tog3.style.backgroundColor = 'darkgray'
	tog1.style.color = '#0d6efd'
	tog2.style.color = '#0d6efd'
	tog3.style.color = 'white'
}

function goTrash(msgIdx, id, mode) {
	alert('쪽지를 휴지통에 넣습니다.')
	location.href='../member/goTrash?msgIdx=' + msgIdx + '&id=' + id + '&mode=' + mode
}

function recover(msgIdx, id) {
	alert('쪽지를 복구합니다.')
	location.href='../member/recover?msgIdx=' + msgIdx + '&id=' + id
}
			
//프로필을 연다.
function profileView(id) {
	
	$.ajax({
		type: 'POST',
		url: 'isAdmin',
		data: {
			id: id
		},
		success: res => {				

			if (res == 1) {
				alert('관리자의 프로필은 볼 수 없습니다!')

			} else {
				let url = '../member/profileView?id=' + id;
				let title = '프로필 보기';
				let option = 'top=100px, left=100px, width=800px, height=800px';
				window.open(url, title, option);				
			}

		},
		error: e => {
			console.log(e)
		}
	})		
	
}

function updateIntro() {
	var introduce = document.getElementById('selfIntroduce').value;
//	console.log(introduce)
	document.getElementById('introduce').value = introduce;
//	console.log(document.getElementById('introduce').value)

}

function opmd(fid, mid) {
	document.getElementsByClassName('modal-dialog')[0].style.display = 'block'
	document.getElementsByName('msg')[0].focus()
	document.getElementById('mid').value = mid
	document.getElementById('fid').value = fid
}

function clmd() {
	document.getElementsByClassName('modal-dialog')[0].style.display = 'none'	
}
