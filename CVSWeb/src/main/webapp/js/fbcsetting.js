function fbcsetting(fbc_idx, mode, title, fbc_content) {
	// console.log(fbc_idx, mode, title, fbc_content)

	let frm = document.commentForm;
	frm.fbc_idx.value = fbc_idx;
	frm.mode.value = mode;
	frm.commentBtn.value = title;	
	while (fbc_content.indexOf('<br/>') != -1) {
		fbc_content = fbc_content.replace('<br/>', '\r\n');
	}
	frm.fbc_content.value = fbc_content;		
}
