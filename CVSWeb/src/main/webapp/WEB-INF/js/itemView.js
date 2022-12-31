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

/*
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
 */

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

onload = () => {
	let id = document.getElementsByName('ID')[0].value 
	let itemIdx = document.getElementsByName('itemIdx')[0].value
	$.ajax({
		type: 'POST',
		url: 'isMyItem',
		data: {
			id: id,
			itemIdx: itemIdx
		},
		success: res => {
			if (res == 2) {
				// 찜한 적 있음
				document.getElementById('myItemToggle').value = res;
			} else {
				// 찜한 적 없음
				document.getElementById('myItemToggle').value = res;
			}
		},
		error: e => {
			console.log(e)
		}
	})
	
};

function myItem(id, idx) {
	mit = document.getElementById('myItemToggle');
	if (mit.value == 1) {
		$.ajax({
			type: 'POST',
			url: 'myItem',
			data: { 
				id: id,
				idx: idx,
				mit: mit.value
			},
			success: res => {
			},
			error: error => {
				console.log('요청실패: ', error.status);
			}
		});		
		mit.value = 2				
		document.getElementById('myItemInner').innerHTML = 
			'<img alt="찜" src="../images/heart-red.png" id="myItemOff" style="height: 35px; margin-right: 30px;">'
	} else if (mit.value == 2) {
		$.ajax({
			type: 'POST',
			url: 'myItem',
			data: { 
				id: id,
				idx: idx,
				mit: mit.value
			},
			success: res => {
			},
			error: error => {
				console.log('요청실패: ', error.status);
			}
		});		
		mit.value = 1		
		document.getElementById('myItemInner').innerHTML = 
			'<img alt="찜" src="../images/heart-black.png" id="myItemOn" style="height: 35px; margin-right: 30px;">'
	}
	
}






