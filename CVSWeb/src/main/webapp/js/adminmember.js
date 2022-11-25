function memberCheck() {
	let frm = document.mbChkForm
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