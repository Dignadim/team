//=========================insert========================

//	게시글 작성 시, 제목과 내용이 비어있으면 alert를 날려주는 함수(서블릿 연결)
function insertEmptyChk() {
	let fb_subject = $('#fb_subject').val();
	let fb_content = $('#fb_content').val();
	
	$.ajax({
		type: 'POST', // 요청 방식
		url: 'insertEmptyChk', // 요청할 서블릿
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

function cautionMsg() {
	let returnValue = confirm('로그인 후 이용 가능합니다.\n로그인페이지로 이동하시겠습니까?');
		if (returnValue == true) {
			location.href='../member/login'
		}
}

//=========================Comment========================

//	댓글 작성 시, 내용이 비어있으면 alert를 날려주는 함수(서블릿 연결)
function commentEmptyChk() {
	let fbc_content = $('#fbc_content').val();
	
	$.ajax({
		type: 'POST',
		url: 'commentEmptyChk',
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

//	댓글 수정 시, 입력폼을 수정폼으로 바꿔주는 함수
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

//	댓글 삭제 시, confilm을 통해 경고 메시지를 띄우고 확인 버튼 시 삭제를 진행시켜주는 함수
function deleteComment(fbc_idx, mode) {
	let frm = document.commentForm;
	frm.fbc_idx.value = fbc_idx; 
	frm.mode.value = mode;
	let returnValue = confirm('삭제된 댓글은 복구가 어렵습니다.\n그래도 삭제하시겠습니까?');
	if(returnValue == true){
		frm.submit();
	} else {
		frm.fbc_content.value = '';
		frm.commentBtn.value = '등록';
		frm.mode.value = 1;
	}
	
}

	























