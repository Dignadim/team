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


function memberCheck() {
	let frm = document.mbChkForm;
	let mode = frm.selectMember.value;
	frm.mode.value = mode;
	frm.submit();	
	}

function fixSelected() {
	let before = document.getElementById('mode').value;
	let options = document.getElementsByTagName('option')
	for (let i=0; i<options.length; i++) {
		if(before.trim() == options[i].value.trim()) {
			options[i].selected = true;
		}
	} 
}


//function block(Type){
//	let banType = Type.value;
	
//   location.href='adminBlock.jsp?blockType='+blockType+'&vo='vo;
//}