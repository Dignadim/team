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

//=========================insert========================

//	게시글 작성 시, 제목과 내용이 비어있으면 alert를 날려주는 함수(서블릿 연결)
function insertEmptyChk() {
	let ev_sellcvs = $('#ev_sellcvs').val().trim();
	let ev_subject = $('#ev_subject').val().trim();
	let ev_content = $('#ev_content').val().trim();
	let startSch = $('#startSch').val().trim();
	let endSch = $('#endSch').val().trim();
	let contentSch = $('#contentSch').val().trim();
	
	let ev_idx = 1;
	let currentPage = 1;
	
	let job = document.querySelector('input[type=hidden][name=mode]').value;
	
	let id = $('#memberID').val().trim();
	let nickname = $('#nickname').val().trim();
	let ev_notice = $('#noticeOn').val().trim();
	
	if(ev_sellcvs == null || ev_sellcvs == "-머리말선택-") {
		alert('머리말을 선택해주세요.');
		return;
	}
	else if(ev_subject == null || ev_subject == "") {
		alert('제목을 입력해주세요.');
		return;
	}
	else if(ev_content == null || ev_content == "") {
		alert('내용을 입력해주세요.');
		return;
	}
	else if(startSch == null || startSch == "")
	{
		alert('행사정보 날짜를 입력해주세요.');
	}
	else if(contentSch == null || contentSch == "")
	{
		alert('행사정보 간략내용을 적어주세요.');
	}
	else
	{
		let locate = 'ev' + job + 'OK';
		if(job == 'Update')
		{
			currentPage = document.querySelector('input[type=hidden][name=currentPage]').value;
			ev_idx = document.querySelector('input[type=hidden][name=ev_idx]').value;
			
		}
		location.href= locate + '?currentPage=' + currentPage + '&ev_subject=' + ev_subject + '&ev_notice=' + ev_notice +  
		'&ev_content=' + ev_content + '&id=' + id + '&nickname=' + nickname + '&ev_idx=' + ev_idx +
		'&ev_sellcvs=' + ev_sellcvs +
		'&startSch=' + startSch + '&endSch=' + endSch + '&contentSch=' + contentSch;
	}
}

//	게시글 작성 시, 머리말을 [공지]로 설정하면 일반글에서 공지글로 바뀌게 해주는 함수(수정에도 적용)
function notice() {
	let ev_sellcvs = $('#ev_sellcvs').val()
	let noticeOn = document.getElementById('noticeOn');
//	 console.log(ev_sellcvs);
	if(ev_sellcvs.trim() == '공지') {
		noticeOn.value = 'yes'
	} else {
		noticeOn.value = 'no'
	}
//	console.log(noticeOn.value);
}

function uploadWin() {
//	let url = './eventImageInsert.jsp';
//	let title = '이미지 업로드';
//	let option = 'top=50px, left=100px, width=500px, height=600px';
//	window.open(url, title, option);
	alert('미구현 입니다.');
}

function thisClose(ev_filename) {
	opener.document.getElementById('ev_filename').value = ev_filename;
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
	
	if(evc_content == null || evc_content == "") {
		alert('내용을 입력해주세요.');
		return;
	} else {
		document.commentForm.submit();
		return;
	}
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




























