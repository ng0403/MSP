/**
 * 키맨추가 관련 js파일
 */
function keymanListRefresh(cust_id) {
	window.opener.keymanList(cust_id);
	self.close();
}

function keymanAdd() {
	$(document).ready(function() {
	var ctx = $("#ctx").val();
	var cust_id = $("#cust_id").val();
	var keymanData = { "cust_id": cust_id, "kmn_nm": $("#kmn_nm").val(), "pos_nm": $("#pos_nm").val()
				, "ph1":$("#ph1").val(), "ph2":$("#ph2").val(),"ph3":$("#ph3").val()
				,"cell_ph1":$("#cell_ph1").val(), "cell_ph2":$("#cell_ph2").val(),"cell_ph3":$("#cell_ph3").val()
				,"email1":$("#email1").val(), "email2":$("#email2").val(), "memo":$("#memo").val()};
	
		$.ajax({
			url : ctx+'/addKeyman.do',
			data : keymanData,
			type : 'POST',
			dataType : "json",
			success : function(data){
				if(data.addResult == 'standard/home/session_expire'){
					alert("세션이 만료되었습니다.");
					alert("로그인 페이지로 이동합니다.");
					location.href = ctx + '/';
				} else {
					alert(data.addResult);
					keymanListRefresh(cust_id);
				}
			}, error : function(data){
				alert(data.addResult);
			}
		});
	});
}

function keymanMdfy() {
	$(document).ready(function() {
		var ctx = $("#ctx").val();
		var keymanData = { "kmn_id": $("#kmn_id").val(), "kmn_nm": $("#kmn_nm").val(), "pos_nm": $("#pos_nm").val()
				, "ph1":$("#ph1").val(), "ph2":$("#ph2").val(),"ph3":$("#ph3").val()
				,"cell_ph1":$("#cell_ph1").val(), "cell_ph2":$("#cell_ph2").val(),"cell_ph3":$("#cell_ph3").val()
				,"email1":$("#email1").val(), "email2":$("#email2").val(), "memo":$("#memo").val()};
		
		var cust_id = $("#cust_id").val();
		
		$.ajax({
			url : ctx+'/mdfyKeyman.do',
			data : keymanData,
			type : 'POST',
			dataType : "json",
			success : function(data){
				if(data.mdfyResult == 'standard/home/session_expire'){
					alert("세션이 만료되었습니다.");
					alert("로그인 페이지로 이동합니다.");
					location.href = ctx + '/';
				} else {
					alert(data.mdfyResult);
					keymanListRefresh(cust_id);
				}
			}, error : function(data){
				alert(data.mdfyResult);
			}
		});
	});
}

//전체 체크 해제
function kmchkCancel() {
	$(document).ready(function() {
		$("#keymanListCheck").prop("checked", false);
	});
}

$(document).ready(function() {
	// 기업고객 리스트 체크박스 선택, 해제
	$("#keymanListCheck").click(function(){
		// 만약 전체 선택 체크박스가 체크된 상태일 경우
		if($("#keymanListCheck").prop("checked")){
			// 해당화면 전체 checkbox들을 체크해준다.
			$("input[id=kmChkbox]").prop("checked", true);
		// 전체선택 체크박스가 해제된 경우
		} else {
			// 해당화면에 모든 checkbox들의 체크를 해제시킨다.
			$("input[id=kmChkbox]").prop("checked", false);
		}
	});
});