function memberCheck() {
	let selectMember = document.getElementById('memberCheck').value;
	if (selectMember == '모든 회원') {
		let mode =1
	} else if (selectMember == '관리자') {
		let mode =2
	} else if (selectMember == '일반회원') {
		let mode =3
	} else if (selectMember == '경고회원') {
		let mode =4
	} else if (selectMember == '차단회원') {
		let mode =5
	}
	
	location.href='adminMemberSort.jsp?mode=' + mode 
	
	}

