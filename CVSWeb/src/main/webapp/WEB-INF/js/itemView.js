function updateAverscore() {
	let itemIdx = document.getElementById('itemIdx').value;
	let updateScore = document.getElementById('updateAverscore').value
	let originalScore = document.getElementById('originalItemAverscore').value;
	let ID = document.getElementsByName('ID')[0].value;
	let currentPage = document.getElementById('itemCommentCurrentPage').value;
	location.href='updateAverscoreOK?averscore=' + originalScore + '&itemIdx=' + itemIdx + '&updateScore=' + updateScore + '&ID=' + ID + '&currentPage=' + currentPage;		
	
}

function test(idx, mode, title, content) {
	let frm = document.itemCommentForm
	
	// console.log(idx);
	
	document.getElementById('itemCommentIdx').value = idx;
	
	// console.log(document.getElementById('itemCommentIdx').value);
	
	frm.mode.value = mode;
	frm.insertBtn.value = title;
	while (content.indexOf('<br/>') != -1) {
		content = content.replace('<br/>', '\r\n');
	}
	frm.content.value = content;
	frm.content.focus();			
		
}

function commentEmptyChk() {
	let content = $('#content').val();
	// console.log(content)
	
	$.ajax({
		type: 'POST',
		url: 'commentEmptyCheck',
		data: { 
			content: content,
		},
		success: response => {
			switch(response) {
				case '1':
					alert('내용을 입력해주세요.');
					break;
				case '2':
					document.itemCommentForm.submit();
					break
			}
		},
		error: error => {
			console.log('요청실패: ', error.status);
		}
	});
}

function deleteItemComment(idx, mode) {
	let frm = document.itemCommentForm
	
	document.getElementById('itemCommentIdx').value = idx;
	frm.mode.value = mode;
	
	let b = confirm('댓글을 삭제하시겠습니까?')
	if (b == true) {
		frm.submit();
	} else {
		frm.content.value = '';
		frm.insertBtn.value = '등록';
		frm.mode.value = 1;
	}
}