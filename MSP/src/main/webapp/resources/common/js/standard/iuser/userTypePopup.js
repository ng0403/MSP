$(function() {
	allChecked();
	checkCount();
	codeChoice();
	checkClear();
});

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
	$('#codeClear').click(function(){
		$('#allCheck').prop('checked',false);
		$('.ab').prop('checked',false);
	});
}

function codeChoice() {
	$('#codeChoice').click(function() {
		if (checkCount() == 0) {
			alert("선택할 항목을 선택해주세요.");
		}else if(checkCount()>1){
			alert("한가지 항목을 선택해주세요.");
		}  		
		else {
			var node = searchCheckNode();
			var confi = confirm("정말 선택하시겠습니까??");
			if(confi){
				var code = $(node).val();
				$(opener.document).find('#user_type_cd').val(code);
				self.close();
			}			
		}
	});
}
