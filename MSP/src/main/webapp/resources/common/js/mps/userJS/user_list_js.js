//delay
function sleep(ms){
  ts1 = new Date().getTime() + ms;
  do ts2 = new Date().getTime(); while (ts2<ts1);
}
/*사용자 리스트 출력및 페이징 처리 함수*/
	function userListInqr(pageNum){
		var active_key = $("#active_key").val();
		var user_sch_key = $("#user_sch_key").val();
		var values=[];
		viewLoadingShow();
		$.post("/user/userAjax_list",
				{"active_key":active_key
			, "user_sch_key":user_sch_key
			, "pageNum":pageNum}
		, function(data){
			values = data.user_list;
			$(".user_list").html("");
			$(data.user_list).each(function(){
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
			viewLoadingHide();
			paging(data,"#paging_div", "userListInqr");
		}).fail(function(){
			alert("사용자 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*사용자 리스트 출력 함수*/
	function userListOutput(user_id, user_nm, dept_nm, email_id, email_domain, cphone_num1 ,cphone_num2, cphone_num3, auth_nm, active_flg){
		
		var user_tr = $("<tr>");
		user_tr.addClass("open_detail");
		user_tr.attr("data_num",user_id);
		
		var del_code_td = $("<td class='thth'>");
		del_code_td.html("<input type='checkbox' class='del_code' name='del_code' value='" + user_id + "'>");
		
		var user_id_td = $("<td onclick='onPopup(this.id)' id="+user_id+">");
		user_id_td.html(user_id);
		
		var user_nm_td = $("<td>");
		user_nm_td.html(user_nm);
		
		var dept_td = $("<td>");
		dept_td.html(dept_nm);

		var email_td = $("<td>");
		email_td.html(email_id + "@" + email_domain);
		
		var cphone_num1_td = $("<td>");
		cphone_num1_td.html(cphone_num1 + "-" + cphone_num2 + "-" + cphone_num3);
		
		var auth_td = $("<td>");
		if(auth_nm != null){
			auth_td.html(auth_nm);
		}else if(auth_nm == null){
			auth_td.html("권한없음");
		}
		
		var active_flg_td = $("<td>");
		if(active_flg=='Y'){
			active_flg_td.html("활성화");
		}else if(active_flg=='N'){
			active_flg_td.html("비활성화");
		}
		
		user_tr.append(del_code_td).append(user_id_td).append(user_nm_td).append(dept_td).append(email_td).append(cphone_num1_td).append(auth_td).append(active_flg_td);
				
		$(".user_list").append(user_tr);
			
	}
//엑셀 Import 팝업	
function excelImportOpen() {
	var popWidth  = '520'; // 파업사이즈 너비
	var popHeight = '160'; // 팝업사이즈 높이
	var winHeight = document.body.clientHeight;	// 현재창의 높이
	var winWidth = document.body.clientWidth;	// 현재창의 너비
	var winX = window.screenLeft;	// 현재창의 x좌표
	var winY = window.screenTop;	// 현재창의 y좌표

	var popX = winX + (winWidth - popWidth)/2;
	var popY = winY + (winHeight - popHeight)/2;
	var popUrl = "excelImportTab";
	var popOption = "width=520, height=160, resize=no, scrollbars=no, status=no, location=no, directories=no; ,top=pop,left=popX";
	window.open(popUrl, "_blank","width="+popWidth+"px,height="+popHeight+"px,top="+popY+",left="+popX);
}
//사용자 신규등록 팝업	
function userTabOpen() {
	popByMask("userTabMask", "userTabWindow");
	}


//사용자 정보 수정 팝업
function onPopup(user_id) {
	$.post("userMdfyPop/"+user_id, function(data){
		console.log(data);
		$(data).each(function(){
			var user_id = this.user_id;
			var user_nm = this.user_nm;
			var user_pwd = this.user_pwd;
			var emp_no = this.emp_no;
			var rank_cd = this.rank_cd;
			var rank_nm = this.rank_nm;
			var duty_cd = this.duty_cd;
			var duty_nm = this.duty_nm;
			var dept_nm = this.dept_nm;
			var dept_cd = this.dept_cd;
			var cphone_num1 = this.cphone_num1;
			var cphone_num2 = this.cphone_num2;
			var cphone_num3 = this.cphone_num3;
			var phone_num1 = this.phone_num1;
			var phone_num2 = this.phone_num2;
			var phone_num3 = this.phone_num3;
			var email_id = this.email_id;
			var email_domain = this.email_domain;
			var active_flg = this.active_flg;
			userDetailOutput(user_id, user_nm, user_pwd,emp_no, rank_cd, rank_nm, duty_cd, duty_nm, dept_nm, dept_cd, cphone_num1,cphone_num2,cphone_num3,phone_num1,phone_num2,phone_num3,email_id, email_domain, active_flg);
		})
		popByMask("userDetailMask", "userDetailWindow");
	}).fail(function(){
		alert("사용자 상세정보를 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		$('#userTabMask, #userTabWindow').hide();
		$('#userDetailMask, #userDetailWindow').hide();
		userListInqr(1);
	})
}

/*메뉴 상세정보 출력 함수*/
function userDetailOutput(user_id, user_nm, user_pwd, emp_no
		, rank_cd, rank_nm, duty_cd, duty_nm, dept_nm
		, dept_cd, cphone_num1,cphone_num2,cphone_num3
		,phone_num1,phone_num2,phone_num3
		,email_id, email_domain, active_flg){

	userDataReset();
	
	$("#Duser_id").val(user_id);
	$("#Duser_nm").val(user_nm);
	$("#Demp_no").val(emp_no);
	$("#Duser_pwd").val(user_pwd);
	$("#Demp_no").val(emp_no);
	$("#Drank_cd").val(rank_cd).prop("selected","selected");
	$("#Drank_nm").val(rank_nm);
	$("#Dduty_cd").val(duty_cd).prop("selected","selected");
	$("#Dduty_nm").val(duty_nm);
	$("#Ddept_nm").val(dept_nm);
	$("#Ddept_cd").val(dept_cd);
	$("#Dcphone_num1").val(cphone_num1).prop("selected","selected");
	$("#Dcphone_num2").val(cphone_num2);
	$("#Dcphone_num3").val(cphone_num3);
	$("#Dphone_num1").val(phone_num1).prop("selected","selected");
	$("#Dphone_num2").val(phone_num2);
	$("#Dphone_num3").val(phone_num3);
	$("#Demail_id").val(email_id);
	$("#Demail_domain").val(email_domain);
	$("#Dactive_flg").val(active_flg);
//	$(".active_flg:radio[value='"+active_flg+"']").prop("checked", "checked");
}
/*상세정보 초기화*/
function userDataReset(){
	$("#Duser_id").val("");
	$("#Duser_nm").val("");
	$("#Duser_pwd").val("");
	$("#Demp_no").val("");
	$("#Drank_cd").find("option:eq(0)").prop("selected","selected");
	$("#Drank_nm").val("");
	$("#Dduty_cd").find("option:eq(0)").prop("selected","selected");
	$("#Dduty_nm").val("");
	$("#Ddept_nm").val("");
	$("#Ddept_cd").val("");
	$("#Dcphone_num1").find("option:eq(0)").prop("selected","selected");
	$("#Dcphone_num2").val("");
	$("#Dcphone_num3").val("");
	$("#Dphone_num1").find("option:eq(0)").prop("selected","selected");
	$("#Dphone_num2").val("");
	$("#Dphone_num3").val("");
	$("#Demail_id").val("");
	$("#Demail_domain").val("");
	$("#Dactive_flg").val("");
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
                
        }
/*부서 삭제 요청 함수*/
function userDel(){
	var del_code = "";
	$( "input[name='del_code']:checked" ).each (function (){
		  del_code = del_code + $(this).val()+"," ;
	});
	
	var delCode = del_code.split(","); //맨끝 콤마 지우기
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
	if(confirm("리스트를 출력하시겠습니까? 대량의 경우 대기시간이 필요합니다.")){
		form.append(excel);
		form.submit();
	}
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
