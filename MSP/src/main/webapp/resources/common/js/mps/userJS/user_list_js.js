/*사용자 리스트 출력및 페이징 처리 함수*/
	function userListInqr(pageNum){
		var active_key = $("#active_key").val();
		var user_sch_key = $("#user_sch_key").val();
		var values=[];
		$.post("/user/userAjax_list",
				{"active_key":active_key
			, "user_sch_key":user_sch_key
			, "pageNum":pageNum}
		, function(data){
			alert(data);
			values = data.user_list;
			$(".user_list").html("");
			alert(data.toSource());
//			$(data.user_list).each(function(){
			$(values).each(function(){
				alert(data.user_list);
				alert(this.User_ID);
				alert(data.user_list.User_ID);
 				var user_id = this.USER_ID;
				var user_nm = this.USER_NM;
				var dept_nm = this.DEPT_NM;
				var cphone_num1 = this.CPHONE_NUM1;
				var cphone_num2 = this.CPHONE_NUM2;
				var cphone_num3 = this.CPHONE_NUM3;
				var email_id = this.EMAIL_ID;
				var email_domain = this.EMAIL_DOMAIN;			
				var auth_nm = this.AUTH_NM;			
				var active_flg = this.ACTIVE_FLG;
				userListOutput(user_id, user_nm, dept_nm, email_id, email_domain, cphone_num1 ,cphone_num2, cphone_num3, auth_nm, active_flg);  
			})
//			paging(data,"#paging_div", "userListInqr");
		}).fail(function(){
			alert("사용자 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*사용자 리스트 출력 함수*/
	function userListOutput(user_id, user_nm, dept_nm, email_id, email_domain, cphone_num1 ,cphone_num2, cphone_num3, auth_nm, active_flg){
		
		var user_tr = $("<tr>");
		user_tr.addClass("open_detail");
		user_tr.attr("data_num",user_id);
		
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + menu_cd + "'>");
		
		var user_id_td = $("<td>");
		user_id_td.html("<input type='text' onclick='' name='user_id' value='" + user_id + "'>");
		
		var user_nm_td = $("<td>");
		user_nm_td.html(user_nm);
		
		var dept_td = $("<td>");
		dept_td.html(dept_cd);
		
		var cphone_num1_td = $("<td>");
		cphone_num1_td.html(cphone_num1 + "-" + cphone_num2 + "-" + cphone_num3);
		
		var auth_td = $("<td>");
		auth_td.html(auth_nm);
		
		var active_flg_td = $("<td>");
		if(active_flg=='Y'){
			active_flg_td.html("활성화");
		}else if(active_flg=='N'){
			active_flg_td.html("비활성화");
		}
		
		user_tr.append(del_code_td).append(user_id_td).append(user_nm_td).append(dept_td).append(cphone_num1_td).append(auth_td).append(active_flg_td);
				
		$(".user_list").append(user_tr);
			
	}
//엑셀 Import 팝업	
function excelImportOpen() {
	var popUrl = "excelImportTab";
	var popOption = "width=300, height=100, resize=no, scrollbars=no, status=no, location=no, directories=no;";
	window.open(popUrl, "", popOption);
}
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
                opener.parent.location.reload();
                user_goSearch();
//                window.open("about:blank","_self").close();
                
        }
/*부서 삭제 요청 함수*/
function userDel(){
	var del_code = "";
	$( "input[name='del_code']:checked" ).each (function (){
		  del_code = del_code + $(this).val()+"," ;
	});
	
	var delCode = del_code.split(","); //맨끝 콤마 지우기
	alert(delCode);
	if(delCode == ""){
		alert("삭제할 대상을 선택해 주세요");
		return false;
	}else{
		
		$.ajax({
			url:"/user/userDel/"+del_code,
			type:"post",
			contentType:"application/json; charset=UTF-8",
			dataType:"text",
			//data:JSON.stringify({del_code : del_code}),
			error:function(){
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("사용자 삭제가 완료되었습니다.");
					userListInqr(1);
				}
					
			}
		})
	}
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

		location.href = "userDel?user_id=" + del_code;
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
