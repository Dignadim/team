function thisClose() {
	let itemImage = document.getElementsByName('itemImage')[0].value
	let fileRealname = document.getElementsByName('fileRealname')[0].value
	
	opener.document.getElementById('itemImage').value = itemImage;
	opener.document.getElementById('fileRealname').value = fileRealname;	
	
	self.close();
}