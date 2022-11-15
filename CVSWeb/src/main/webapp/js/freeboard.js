//	제목, 내용의 빈칸을 확인하는 함수
function insertEmptyChk() {
	let fb_subject = $('#fb_subject').val();
	let fb_content = $('#fb_content').val();
	
	$.ajax({
		type: 'POST', // 요청 방식
		url: '../../../FreeInsertEmptyCheck', // 요청할 서블릿
		data: { // 서블릿으로 전송할 데이터
			// 변수명: 값
			fb_subject: fb_subject,
			fb_content: fb_content,
		},
		// ajax 요청이 성공하면 response.getWriter().write(문자열)의 문자열이 콜백 함수의 인수로 넘어온다.
		success: response => { // ajax 요청이 성공하면 실행할 콜백 함수
			// console.log('요청성공: ', response);
			
			// 서블릿 응답에 따른 작업을 실행한다.
			switch(response) {
				case '1':
					alert('제목을 입력해주세요.');
					break;
				case '2':
					alert('내용을 입력해주세요.');
					break;
				case '3':
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

function updateComment(fbc_idx, mode, title, fbc_content) {

	let frm = document.commentForm;
	frm.fbc_idx.value = fbc_idx;
	frm.mode.value = mode;
	frm.commentBtn.value = title;	
	while (fbc_content.indexOf('<br/>') != -1) {
		fbc_content = fbc_content.replace('<br/>', '\r\n');
	}
	frm.fbc_content.value = fbc_content;	
	frm.fbc_content.focus();	
}

function deleteComment(fbc_idx, mode) {
	let frm = document.commentForm;
	frm.fbc_idx.value = fbc_idx; 
	frm.mode.value = mode;
	let returnValue = confirm('삭제된 댓글은 복구가 어렵습니다.\n그래도 삭제하시겠습니까?');
	if(returnValue == true){
		frm.submit();
	}
	
}



function commentEmptyChk() {
	let fbc_content = $('#fbc_content').val();
	
	$.ajax({
		type: 'POST',
		url: '../../../FreeCommentEmptyCheck',
		data: { 
			fbc_content: fbc_content,
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


























