	let originalIdx = document.getElementById('itemCommentIdx').value; 
	let itemComment = document.getElementsByClassName('itemComment' + originalIdx)[0];
	let originalComment = itemComment.innerHTML;	
	let newComment = document.getElementById('itemCommentNew').value;
	let currentPage = document.getElementById('itemCommentCurrentPage').value;	
	let originalGup = document.getElementById('itemCommentGup').value;

function updateAverscore() {
	let itemIdx = document.getElementById('itemIdx').value;
	let averscore = document.getElementById('updateAverscore').value
	location.href='updateAverscoreOK.jsp?averscore=' + averscore + '&idx=' + itemIdx
}
	
function itemCommentUpdate1() {
	itemComment.innerHTML = '<textarea id="itemCommentNew" class="form-control form-control-sm" rows="3" style="resize: none;">' + originalComment + '</textarea>';
	document.getElementById('itemCommentUpdateButton').innerHTML = 
	'<input type="button" class="btn btn-outline-primary" value="저장" onclick="itemCommentUpdate2()"/>';
}

function itemCommentUpdate2() {
	let originalIdx = document.getElementById('itemCommentIdx').value;
	document.getElementById('itemCommentUpdateButton').innerHTML = 
	'<input type="button" class="btn btn-outline-warning" value="수정" onclick="itemCommentUpdate1()"/>';	
	
	location.href='itemCommentUpdateOK.jsp?currentPage=' + currentPage + '&idx=' + originalIdx + '&gup=' + originalGup + '&content=' + newComment;
}