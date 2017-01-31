$(function() {
	allChecked();
	orgIdChoice();
	checkClear();
});

//체크박스에 선택된 체크박스값구하기
function searchCheckNode(){
	var node;
	var checkList = $('.ab');
	
	for(var i=0; i<checkList.size(); i++){
		if($(checkList[i]).is(':checked')){
			node = checkList[i];
		}
	}
	return node;
}

//체크박스 개수 세기
function checkCount() {
	var count = 0;
	var checkList = $('.ab');
	for (var i = 0; i < checkList.size(); i++) {
		if ($(checkList[i]).is(':checked')) {
			count++;
		}
	}
	return count;
};

function allChecked(){
	$('#allCheck').click(function(){
		if($('#allCheck').is(':checked')){
			$('.ab').prop('checked',true);
		}else{
			$('.ab').prop('checked',false);
		}
	});
}

function checkClear(){
	$('#orgClear').click(function(){
		$('#allCheck').prop('checked',false);
		$('.ab').prop('checked',false);
	});
}

function orgIdChoice() {
	$('#orgChoice').click(function() {
		if (checkCount() == 0) {
			alert("선택할 항목을 선택해주세요.");
		}else if(checkCount()>1){
			alert("한가지 항목을 선택해주세요.");
		} 
		else {
			var node = searchCheckNode();
			var confi = confirm("정말 선택하시겠습니까??");
			if(confi){
				var org_id = $(node).val();
				$(opener.document).find('#org_id').val(org_id); //부모에서 org_id를 찾고 org_id를 넣어준담.
				self.close();
			}
		}
	});
}
