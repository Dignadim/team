
//=========================insert========================

//	게시글 작성 시, 제목과 내용이 비어있으면 alert를 날려주는 함수(서블릿 연결)
function insertEmptyChk() {
	let ev_sellcvs = $('#ev_sellcvs').val();
	let ev_subject = $('#ev_subject').val();
	let ev_content = $('#ev_content').val();
	
	$.ajax({
		type: 'POST', // 요청 방식
		url: 'insertEmptyChk', // 요청할 서블릿
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

//	게시글 작성 시, 머리말을 [공지]로 설정하면 일반글에서 공지글로 바뀌게 해주는 함수(수정에도 적용)
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

function uploadWin() {
	let url = '../event/eventImageInsert';
	let title = '이미지 업로드';
	let option = 'top=50px, left=100px, width=500px, height=600px';
	window.open(url, title, option);
}

function thisClose(ev_filename, fileRealname) {
	opener.document.getElementById('ev_filename').value = ev_filename;
	opener.document.getElementById('fileRealname').value = fileRealname;
	
	self.close();
}

//=========================Board========================

//	게시글 수정 시, 기존에 머리말 옵션에 selected를 걸어주는 함수
function fixSelected() {
	let before = document.getElementById('beforeCvs').value;
	let options = document.getElementsByTagName('option')
	for (let i=0; i<options.length; i++) {
		if(before.trim() == options[i].value.trim()) {
			options[i].selected = true;
		}
	} 
}

// 게시판 검색기능 사용 시, 돌아가기 버튼을 누르면 값을 초기화 시켜주는
function backPage() {
	let frm = document.searchForm;
	frm.category.value ='전체';
	frm.searchText.value = '';
	frm.submit();
}

//=========================Comment========================

//	댓글 작성 시, 내용이 비어있으면 alert를 날려주는 함수(서블릿 연결)
function commentEmptyChk() {
	let evc_content = $('#evc_content').val();
	
	$.ajax({
		type: 'POST',
		url: 'commentEmptyChk',
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

//	댓글 수정 시, 입력폼을 수정폼으로 바꿔주는 함수
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

//	댓글 삭제 시, confilm을 통해 경고 메시지를 띄우고 확인 버튼 시 삭제를 진행시켜주는 함수
function deleteComment(evc_idx, mode) {
	let frm = document.commentForm;
	frm.evc_idx.value = evc_idx; 
	frm.mode.value = mode;
	let returnValue = confirm('삭제된 댓글은 복구가 어렵습니다.\n그래도 삭제하시겠습니까?');
	if(returnValue == true){
		frm.submit();
	} else {
	frm.evc_content.value = '';
	frm.commentBtn.value = '등록';
	frm.mode.value = 1;
	}
	
}




























