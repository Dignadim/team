function openWin() {	
	let url = 'itemImageInsert';
	let title = '사진 업로드';
	let option = 'top=100px, left=100px, width=800px, height=800px';
	window.open(url, title, option);
}

var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
return new bootstrap.Tooltip(tooltipTriggerEl)
})