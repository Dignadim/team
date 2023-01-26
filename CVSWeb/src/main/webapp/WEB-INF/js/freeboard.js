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


function insertItem() {
	let modal = document.getElementById('itemModal')
	modal.style.display = 'block';
}

function fb_search() {
	let fb_search_item = document.getElementById('fb_search_item')
	let fb_tbody = document.getElementById('fb_tbody')
	if (fb_search_item.value.trim() != null) {
		
	$.ajax({
		type: 'POST',
		url: 'fbSearchItem',
		data: {
			itemName: fb_search_item.value
		},
		success: res => {
			
			let object = eval('(' + res + ')')
			let result = object.result;
			
			fb_tbody.innerHTML = '';
			
			let row = fb_tbody.insertRow(0);		
			for (let i = 0; i < result.length; i++) {
				let cell = row.insertCell(0);
				cell.innerHTML = result[i][1].value + '<br/><img class="fbInsertItem" src="' + result[i][2].value + '" onclick="fbInsertItem(' + result[i][0].value + ')"/>';
			}			
			
		},
		error: e => {
			console.log(e.status)
		}
	})
	
	}
}


function fbInsertItem(idx) {
	let fb_content = document.getElementById('fb_content')
	let org = fb_content.value
	
	$.ajax({
		type: 'POST',
		url: 'getImgLink',
		data: {
			idx: idx
		},
		success: res => {		
			console.log(org)
			console.log(res)	
			fb_content.value = org + '[[[' + res + ']]]'		
		},
		error: e => {
			console.log(e.status)
		}
	})	
	modalClose();
}

function modalClose() {
	document.getElementById('itemModal').style.display = 'none'
}

function fixSelected() {
	let before = document.getElementById('beforeCategory').value;
	let options = document.getElementsByTagName('option')
	for (let i=0; i<options.length; i++) {
		if(before.trim() == options[i].value.trim()) {
			options[i].selected = true;
		} else if(before.trim() == '제목 내용') {
			options[2].selected = true;
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
	let fbc_content = $('#fbc_content').val();
	let nickname = $('#nickname').val();
	
	$.ajax({
		type: 'POST',
		url: 'commentEmptyChk',
		data: { 
			fbc_content: fbc_content
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
function updateComment(mode) {

	let frm = document.commentForm;
	frm.fbc_idx.value = document.querySelector('#edit-comment-idx').value;
	frm.mode.value = mode;
	frm.fbc_content.value = document.querySelector('#edit-comment-content').value;	
	frm.submit();
}

//	댓글 삭제 시, confilm을 통해 경고 메시지를 띄우고 확인 버튼 시 삭제를 진행시켜주는 함수
function deleteComment(fbc_idx, mode) {
	let frm = document.commentForm;
	frm.fbc_idx.value = fbc_idx; 
	frm.mode.value = mode;
	let returnValue = confirm('해당 댓글을 삭제하시겠습니까?');
	if(returnValue == true){
		frm.submit();
	} else {
		frm.fbc_content.value = '';
		frm.commentBtn.value = '등록';
		frm.mode.value = 1;
	}
	
}

// 답글버튼을 클릭하면 해당 댓글의 대댓글리스트가 토글형식으로 나오게 해주는 함수
function replyList(idx, replyCount) {
	
	let replySwitch = document.getElementById('replySwitch').value;
	let divs = document.querySelectorAll('div#replyNo'+idx);
	
	$.ajax({
		type: 'POST',
		url: 'commentReply',
		data: {
			replySwitch: replySwitch,
		},
		success: response => {
			// console.log('요청성공: ', response);
			
			switch(response) {
				case '1':
					document.getElementById('replySwitch').value = 'on';
					document.getElementById('replyBtn'+idx).innerText = '답글 ('+replyCount+')▲';
					for(let i=0; i<divs.length; i++) {
						divs[i].style.display='block';
					}
					break;
				case '2':
					document.getElementById('replySwitch').value = 'off';
					document.getElementById('replyBtn'+idx).innerText = '답글 ('+replyCount+')▼';
					for(let i=0; i<divs.length; i++) {
						divs[i].style.display='none';
					}
					break;
			}
		},
		error: error => {
			console.log('요청실패: ', error.status);
		}
	});
	
}

// 답글창이 비어있는지 확인 후, 답글을 등록하는 함수
function reply(idx, mode) {
	
	let parent = document.querySelector('.reIns'+idx);
	
	let fbc_gup = document.getElementById('fbc_gup').value;
	let reply_content = parent.getElementsByClassName('reply_content').item(0).value;
	let reGup = parent.getElementsByClassName('reGupNo').item(0).value;
	
	console.log(userImage);
	
	$.ajax({
		type: 'POST',
		url: 'replyInsert',
		data: { 
			reply_content: reply_content,
		},
		success: response => {
			// console.log('연결성공')
			switch(response) {
			case '1':
				alert('내용을 입력해주세요.');
				break;
			case '2':
				let frm = document.commentForm;
				frm.fbc_idx.value = reGup; 
				frm.mode.value = mode;
				frm.reGup.value = reGup;
				frm.fbc_content.value = reply_content;	
				frm.submit();
				break;
			}
		},
		error: error => {
			console.log('요청실패: ', error.status);
		}
	});
	
}

// 신고버튼 활성화
const id = document.getElementById('id').value;
const reportBtn = document.getElementById('reportBtn');
const realReport = document.getElementById('realReport');
reportBtn.addEventListener('click', function () {
	if(id == null || id == '') {
		let returnValue = confirm('로그인 후 이용 가능합니다.\n로그인페이지로 이동하시겠습니까?');
		if (returnValue == true) {
			location.href='../member/login'
		}
	} else {
		realReport.click();
	}
});

const reportModal = document.getElementById('report-modal');
reportModal.addEventListener('show.bs.modal', function (event) {
	const triggerBtn = event.relatedTarget;
	const title = triggerBtn.getAttribute('data-bs-title');
	const nickname = triggerBtn.getAttribute('data-bs-nickname');
	const content = triggerBtn.getAttribute('data-bs-content');
	const idx = triggerBtn.getAttribute('data-bs-idx');
	const location = triggerBtn.getAttribute('data-bs-location');
	const subject = triggerBtn.getAttribute('data-bs-subject');
	
	document.getElementById('modal-titlename').innerText = title;
	document.getElementById('writer').innerText = nickname;
	document.getElementById('report_content').innerText = content;
	document.getElementById('report_idx').value = idx;
	document.getElementById('report_location').value = location;
	document.getElementById('report_subject').value = subject;
	
	console.log(document.getElementById('report_idx').value);
});

// 신고접수 버튼이 눌렸을 때
const reportOK = document.getElementById('reportOK');
reportOK.addEventListener('click', function () {
	let report_reason = document.getElementById('report_reason').value;
	let report_comment = document.getElementById('report_comment').value;
	if(report_comment == null || report_comment == '') {
		report_comment = '내용없음';
	}
	
	if(report_reason == '==신고사유==') {
		alert('신고사유를 선택해주세요.')
	} else {
		let returnValue = confirm('신고사유: '+report_reason+'\n내용: '+report_comment
				+'\n\n위 내용으로 신고접수 진행하시겠습니까?\n(허위신고 시, 서비스 활동이 제한될 수 있습니다.)');
		if (returnValue == true) {
			document.reportFrm.submit();
		}
	}
});

//댓글 신고
//신고버튼 활성화
const reportCommentBtn = document.getElementById('reportCommentBtn');
const realReportComment = document.getElementById('realReportComment')
reportCommentBtn.addEventListener('click', function () {
	if(id == null || id == '') {
		let returnValue = confirm('로그인 후 이용 가능합니다.\n로그인페이지로 이동하시겠습니까?');
		if (returnValue == true) {
			location.href='../member/login'
		}
	} else {
		realReportComment.click();
	}
});

//대댓글 신고
//신고버튼 활성화
const reportReplyBtn = document.getElementById('reportReplyBtn');
const realReportReply = document.getElementById('realReportReply')
reportReplyBtn.addEventListener('click', function () {
	if(id == null || id == '') {
		let returnValue = confirm('로그인 후 이용 가능합니다.\n로그인페이지로 이동하시겠습니까?');
		if (returnValue == true) {
			location.href='../member/login'
		}
	} else {
		realReportReply.click();
	}
});

// <댓글, 대댓글 수정>

//모달 요소 선택
const commentEditModal = document.querySelector('#comment-edit-modal');
//모달 이벤트 감지
commentEditModal.addEventListener('show.bs.modal', function (event) {
	// console.log('모달 창이 열림')
	// 모달이 열릴 때 event에서 트리거 버튼을 선택한다.
	const triggerBtn = event.relatedTarget;
	// 수정 버튼이 클릭될 때 data-bs-* 데이터 가져오기
	const idx = triggerBtn.getAttribute('data-bs-idx');
	const nickname = triggerBtn.getAttribute('data-bs-nickname');
	const content = triggerBtn.getAttribute('data-bs-content');
	// 수정 폼에 데이터를 반영한다.
	document.querySelector('#edit-comment-idx').value = idx;
	document.querySelector('#edit-comment-nickname').value = nickname;
	document.querySelector('#edit-comment-content').value = content;
});


// 프로필을 연다.
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
