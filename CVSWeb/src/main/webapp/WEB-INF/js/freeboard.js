$(function()
{
//	onload함수로 alert창을 띄울 메시지가 있으면 띄우고 아니면 띄우지않음
	if(document.getElementById('msg').value != null && document.getElementById('msg').value != '')
	{
		funcAlert(document.getElementById('msg').value);
	}
	console.log(document.getElementById('msg').value);
}); 

function funcAlert(msg)
{
	alert(msg);
}

//=========================insert========================

//	게시글 작성 시, 제목과 내용이 비어있으면 alert를 날려주는 함수(서블릿 연결)
function insertEmptyChk() {
	let fb_subject = $('#fb_subject').val().trim();
	let fb_content = $('#fb_content').val().trim();
	
	let id = $('#memberID').val().trim();
	let nickname = $('#nickname').val().trim();
	let notice = document.querySelector('#fb_notice');
	let fb_notice = notice.checked ? 'yes' : 'no';
	
	let fb_idx = 1;
	let currentPage = 1;
	
	let job = document.querySelector('input[type=hidden][name=mode]').value;
	
	if(fb_subject == null || fb_subject == "") {
		alert('제목을 입력해주세요.');
		return;
	}
	else if(fb_content == null || fb_content == "") {
		alert('내용을 입력해주세요.');
		return;
	}
	else
	{
		let locate = 'fb' + job + 'OK';
		if(job == 'Update')
		{
			currentPage = document.querySelector('input[type=hidden][name=currentPage]').value;
			fb_idx = document.querySelector('input[type=hidden][name=fb_idx]').value;
			
		}
		location.href= locate + '?currentPage=' + currentPage + '&fb_subject=' + fb_subject + '&fb_notice=' + fb_notice +  
		'&fb_content=' + fb_content + '&id=' + id + '&nickname=' + nickname + '&fb_idx=' + fb_idx;
	}
	
	
}

function cautionMsg() {
	let returnValue = confirm('로그인 후 이용 가능합니다.\n로그인페이지로 이동하시겠습니까?');
		if (returnValue == true) {
			location.href='login_form'
		}
}

//=========================Comment========================

//	댓글 작성 시, 내용이 비어있으면 alert를 날려주는 함수(서블릿 연결)
function commentEmptyChk() {
	let fbc_content = $('#fbc_content').val();
	
	if(fbc_content == null || fbc_content == "") {
		alert('내용을 입력해주세요.');
		return;
	} else {
		document.commentForm.submit();
		return;
	}
	
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

	























