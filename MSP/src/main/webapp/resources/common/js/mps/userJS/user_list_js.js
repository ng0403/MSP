////엑셀 Import 팝업	
//function excelImportOpen() {
//	var popUrl = "excelImportTab";
//	var popOption = "width=300, height=100, resize=no, scrollbars=no, status=no, location=no, directories=no;";
//	window.open(popUrl, "", popOption);
//}
//사용자 신규등록 팝업	
function userTabOpen() {
		var popUrl = "userTab";
		var popOption = "width=650, height=450, resize=no, scrollbars=no, status=no, location=no, directories=no;";
		window.open(popUrl, "", popOption);
	}
//사용자 정보 수정 팝업
function onPopup(id) {
	var tmp = id;//$("#user_id_h").val();
	var popUrl = "userMdfyPop?user_id=" + tmp; //팝업창에 출력될 페이지 URL
	var popOption = "width=650, height=450, resize=no, scrollbars=no, status=no, location=no, directories=no;"; //팝업창 옵션(optoin)

	window.open(popUrl, "", popOption);
}

//엑셀 파일 추가 fucntion
function checkFileType(filePath) {
               var fileFormat = filePath.split(".");
               if (fileFormat.indexOf("xlsx") > -1) {
                   return true;
               } else {
                   return false;
               }

           }

//엑셀파일 insert
function check() {
    var excelFile = $("#excelFile").val();
    alert(excelFile);
    if (excelFile == "" || excelFile == null) {
        alert("파일을 선택해주세요.");
        return false;
    } else if (!checkFileType(excelFile)) {
        alert("엑셀 파일만 업로드 가능합니다.");
        return false;
    }

    if (confirm("업로드 하시겠습니까?")) {
              $("#excelUploadForm").append(excelFile);
              $("#excelUploadForm").submit();
 
                };
              alert("모든 데이터가 업로드 되었습니다.");
                user_goSearch();
        }
 
//AS-ID 엑셀 다운로드 적용 함수
function download_list_Excel(formID){
	var ctx = $("#ctx").val();
	var form = $("#"+formID);
	var excel = $('<input type="hidden" value="true" name="excel">');
	form.append(excel);
	form.submit();
		alert("submit 지남.");
	$("input[name=excel]").val("");
	}
	// 1.모두 체크
	/* 체크박스 전체선택, 전체해제 */
function allChk() {
	if ($("#checkall").is(':checked')) {
		$("input[name=del_code]").prop("checked", true);
	} else {
		$("input[name=del_code]").prop("checked", false);
	}
}

	/* 삭제(체크박스된 것 전부) */
function deleteAction() {
	var del_code = "";
	$("input[name='del_code']:checked").each(function() {
		del_code = del_code + $(this).val() + ",";
	});
	del_code = del_code.substring(0, del_code.lastIndexOf(",")); //맨끝 콤마 지우기

	if (del_code == '') {
		alert("삭제할 대상을 선택하세요.");
		return false;
	}
	console.log("### del_code => {}" + del_code);

	if (confirm("정보를 삭제 하시겠습니까?")) {

		//삭제처리 후 다시 불러올 리스트 url      

		location.href = "${ctx}/user/userDel?user_id=" + del_code;
	}
}
	
	//페이지 엔터키 기능
function userpageNumEnter(event) {
	$(document).ready(function() {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			var pageNum = parseInt($("#pageInput").val());
			if (pageNum == '') {
				alert("페이지 번호를 입력하세요.")
				$("#pageInput").focus();
			} else if(pageNum > parseInt($("#endPageNum").val())) {
				alert("페이지 번호가 너무 큽니다.");
				$("#pageInput").val($("#userPageNum").val());
				$("#pageInput").focus();
			} else {
				userPaging(pageNum);
			}
		}
		event.stopPropagation();
	});
}
	
	
	
	//사용자관리 페이징
function userPaging(pageNum) {
	$(document).ready(function() {
		var ctx = $("#ctx").val();
		var $form = $('#userlistPagingForm');
	    
	    var pageNum_input = $('<input type="hidden" value="'+pageNum+'" name="pageNum">');

	    $form.append(pageNum_input);
	    $form.submit();
	});
}
	//검색 엔터키
function userEnterSearch(event) {
	$(document).ready(function() {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			user_goSearch();
		}
	});
}
	
	//사용자관리 조회 버튼기능
function user_goSearch(){
	
	var user_id_sch = $("#user_id_sch").val();
	var user_nm_sch = $("#user_nm_sch").val();
	var dept_cd_sch = $("#dept_cd_sch").val();
	var pageNum = $("#pageNum").val();
	
	$("#userSearchForm").submit();
		
}
