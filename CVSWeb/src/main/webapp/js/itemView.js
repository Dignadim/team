function updateAverscore() {
	let itemIdx = document.getElementById('itemIdx').value;
	let updateScore = document.getElementById('updateAverscore').value
	let originalScore = document.getElementById('originalItemAverscore').value;
	let ID = document.getElementsByName('ID')[0].value;
	
	location.href='updateAverscoreOK.jsp?averscore=' + originalScore + '&itemIdx=' + itemIdx + '&updateScore=' + updateScore + '&ID=' + ID;
}

function test(idx, mode, title, content) {
	let frm = document.itemCommentForm
	frm.idx.value = idx;
	frm.mode.value = mode;
	frm.submit.value = title;
	console.log(idx)
	
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
	
	$.ajax({
		type: 'POST',
		url: '../../ItemCommentEmptyCheck',
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

function deleteItemComment(idx, currentPage, gup) {
	let b = confirm('댓글을 삭제하시겠습니까?')
	if (b == true) {
		location.href='itemCommentOK.jsp?mode=3&idx=' + idx +'&currentPage=' + currentPage + '&gup=' + gup
	}
}