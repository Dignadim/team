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

function updateAverscore() {
	let itemIdx = document.getElementById('itemIdx').value;
	let updateScore = document.getElementById('updateAverscore').value
	let originalScore = document.getElementById('originalItemAverscore').value;
	let ID = document.getElementsByName('ID')[0].value;
	let currentPage = document.getElementsByName('currentPage')[0].value;
	
	if (updateScore == null || updateScore > 5 || updateScore < 0) 
	{		
		funcAlert('0 ~ 5 사이의 값을 입력하세요.');
		return;
	}
	
	$.ajax(
			{
				type: 'POST',
				url: 'updateAverscore',
				data: 
				{
					averscore: originalScore,
					itemIdx: itemIdx,
					updateScore: updateScore,
					ID: ID,
					currentPage: currentPage
				},
				success: res =>
				{
					switch(res)
					{
						case '0':
							funcAlert('평점을 이미 등록했습니다.');
							break;
						case '1':
							funcAlert('평점을 등록했습니다.');
							break;
					}
					
				},
				error: e =>
				{
					console.log('요청 실패: ', e.status);
				}
			});
	
}

function test(idx, mode, title, content) {
	let frm = document.itemCommentForm
	frm.idx.value = idx;
	frm.mode.value = mode;
	frm.submit.value = title;
//	console.log(idx)
	
	if (mode == 2) {
		while (content.indexOf('<br/>') != -1) {
			content = content.replace('<br/>', '\r\n');
		}
		frm.content.value = content;
		frm.content.focus();			
	}
	
}

function commentEmptyChk() {
	let content = $('#content').val();
	// console.log(content)
	
	if(content == null || content == "") {
		alert('내용을 입력해주세요.');
		return;
	} else {
		document.itemCommentForm.submit();
	}
	
}

function deleteItemComment(idx, currentPage, gup) {
	let b = confirm('댓글을 삭제하시겠습니까?')
	if (b == true) {
		location.href='itemCommentOK?mode=3&idx=' + idx +'&currentPage=' + currentPage + '&gup=' + gup
	}
}