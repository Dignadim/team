//	제목, 내용의 빈칸을 확인하는 함수
function insertEmptyChk() {
	let ev_sellcvs = $('#ev_sellcvs').val();
	let ev_subject = $('#ev_subject').val();
	let ev_content = $('#ev_content').val();
	
	$.ajax({
		type: 'POST', // 요청 방식
		url: '../../../EventInsertEmptyCheck', // 요청할 서블릿
		data: { // 서블릿으로 전송할 데이터
			// 변수명: 값
			ev_sellcvs: ev_sellcvs,
			ev_subject: ev_subject,
			ev_content: ev_content
		},
		// ajax 요청이 성공하면 response.getWriter().write(문자열)의 문자열이 콜백 함수의 인수로 넘어온다.
		success: response => { // ajax 요청이 성공하면 실행할 콜백 함수
			// console.log('요청성공: ', response);
			
			// 서블릿 응답에 따른 작업을 실행한다.
			switch(response) {
				case '1':
					alert('머리말을 선택해주세요.')
					break;
				case '2':
					alert('제목을 입력해주세요.');
					break;
				case '3':
					alert('내용을 입력해주세요.');
					break;
				case '4':
					document.insertForm.submit();
					break;
			}
		},
		// ajax 요청이 실패하면 에러 정보가 콜백 함수의 인수로 넘어온다.
		error: error => { // ajax 요청이 실패하면 실행할 콜백 함수
			console.log('요청실패: ', error.status);
		}
	});
}

function notice() {
	let ev_sellcvs = $('#ev_sellcvs').val()
	let noticeOn = document.getElementById('noticeOn');
	 console.log(ev_sellcvs);
	if(ev_sellcvs.trim() == '공지') {
		noticeOn.value = 'yes'
	} else {
		noticeOn.value = 'no'
	}
	console.log(noticeOn.value);
}

function fixSelected() {
	let before = document.getElementById('beforeCvs').value;
	let options = document.getElementsByTagName('option')
	for (let i=0; i<options.length; i++) {
		if(before.trim() == options[i].value.trim()) {
			options[i].selected = true;
		}
	} 
}

function commentEmptyChk() {
	let evc_content = $('#evc_content').val();
	
	$.ajax({
		type: 'POST',
		url: '../../../EventCommentEmptyCheck',
		data: { 
			evc_content: evc_content,
		},
		success: response => {
			switch(response) {
				case '1':
					alert('내용을 입력해주세요.');
					break;
				case '2':
					document.commentForm.submit();
					break
			}
		},
		error: error => {
			console.log('요청실패: ', error.status);
		}
	});
}

function updateComment(evc_idx, mode, title, evc_content) {

	let frm = document.commentForm;
	frm.evc_idx.value = evc_idx;
	frm.mode.value = mode;
	frm.commentBtn.value = title;	
	while (evc_content.indexOf('<br/>') != -1) {
		evc_content = evc_content.replace('<br/>', '\r\n');
	}
	frm.evc_content.value = evc_content;	
	frm.evc_content.focus();	
}

function deleteComment(evc_idx, mode) {
	let frm = document.commentForm;
	frm.evc_idx.value = evc_idx; 
	frm.mode.value = mode;
	let returnValue = confirm('삭제된 댓글은 복구가 어렵습니다.\n그래도 삭제하시겠습니까?');
	if(returnValue == true){
		frm.submit();
	}
	
}




























