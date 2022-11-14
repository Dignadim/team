function thisClose(link) {
	opener.document.getElementsByName('itemImage')[0].value = link;
	self.close();
}