function memberCheck() {
	let selectMember = document.getElementById('memberCheck').value;
	let mode = 1;
	if (selectMember == '모든회원') {
		mode = 1;
	} else if (selectMember == '관리자') {
		mode = 2;
	} else if (selectMember == '일반회원') {
		mode = 3;
	} else if (selectMember == '경고회원') {
		mode = 4;
	} else if (selectMember == '차단회원') {
		mode = 5;
	}
	
	location.href='connectadmin.jsp?mode=' + mode 
	
	}

