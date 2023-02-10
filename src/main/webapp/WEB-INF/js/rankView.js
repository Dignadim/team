//	선택된 옵션을 넘겨주는 용도
function categorySelect()
{
	let option = $("#category option:selected").val();
	location.href='view?category=' + option;
}