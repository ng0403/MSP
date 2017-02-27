
/* 접속된 세션 아이디 입니다. */
var sessionID = "${SessionID}"
	
//	alert("${SessionID}");
if(sessionID == 'admin') {
//		 alert("관리자 권한으로 접속하셨습니다.");		
} else {
	alert(" ** 접근권한이 없습니다. ** \n ** 관리자 권한으로 로그인하세요. **\n ** 확인버튼 클릭 시. **\n ** 로그인화면으로 이동합니다. **");
	location.href = "/";
}

var dept_cd = "";
var save_cd = "";

$(function(){

	pageReady(true);
	
	/*검색버튼 클릭 시 처리 이벤트*/
	$("#auth_inqr_fbtn").click(function(){
		authListInqr(1);
	})
	
	$("#keyword").keypress(function(){
		enterSearch(event, authListInqr(1));
	})
	
	/*권한ID 클릭 시 상세정보 출력 이벤트*/
	$(document).on("click", ".open_detail", function(){
		auth_id = $(this).attr("data_num");
		authDetailInqr(auth_id);
	})

/*추가버튼 클릭 시 처리 이벤트*/
$("#auth_add_fbtn").click(function(){
	
	// 숨겨놓은 각각의 버튼을 보여준다.
	$("#authDetail_resert_btn").show();
	$("#authDetail_save_btn").show();
	
	dataReset();
	pageReady(false);
	$("#dept_nm").focus();
	save_cd = "insert";
	
})

/*삭제버튼 클릭 시 처리 이벤트*/
$("#auth_del_fbtn").click(function(){
	authDel();
})

/*편집버튼 클릭 시 처리 이벤트*/
$("#auth_edit_nfbtn").click(function(){
	pageReady(false);
	$("#dept_nm").focus();
	save_cd = "update";
})
/*초기화버튼 클릭 시 처리 이벤트*/
$("#auth_reset_nfbtn").click(function(){
	
	$("#auth_nm").val("");
				
	dataReset();
	save_cd = "";
	pageReady(true);
})

/*저장버튼 클릭 시 처리 이벤트*/
$("#auth_save_fbtn").click(function(){
	if(save_cd == "insert"){
		authSave();
		pageReady(true);
	}else if(save_cd == "update"){
		authMdfy();
		pageReady(true);
	}
})

/* 체크박스 전체선택, 전체해제 */
$("#checkall").on("click", function(){
      if( $("#checkall").is(':checked') ){
        $("input[name=del_code]").prop("checked", true);
      }else{
        $("input[name=del_code]").prop("checked", false);
	      }
	})
})


/*//페이지 엔터키 기능
function authpageNumEnter(event) {
	$(document).ready(function() {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
		var pageNum = parseInt($("#pageInput").val());
		if (pageNum == '') {
			alert("페이지 번호를 입력하세요.")
			$("#pageInput").focus();
		} else if(pageNum > parseInt($("#endPageNum").val())) {
			alert("페이지 번호가 너무 큽니다.");
			$("#pageInput").val($("#authPageNum").val());
			$("#pageInput").focus();
		} else {
			authPaging(pageNum);
		}
	}
	event.stopPropagation();
});
}

//권한관리 페이징
function authPaging(pageNum) {
	$(document).ready(function() {
		var ctx = $("#ctx").val();
		var $form = $('#authlistPagingForm');
	    
	    var pageNum_input = $('<input type="hidden" value="'+ pageNum +'" name="pageNum">');

	    $form.append(pageNum_input);
	    $form.submit();
	});
}

//검색 엔터키
function authEnterSearch(event) {
	$(document).ready(function() {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			auth_goSearch();
		}
	});
}*/

//조회 버튼기능
function auth_goSearch(){
	
	var active_key = $("#active_key").val();
	var keyword = $("#keyword").val();
	var pageNum = $("#pageNum").val();
				
	$("#searchForm").submit();
		
}

/*리스트 출력및 페이징 처리 함수*/
function authListInqr(pageNum){

	var active_key = $("#active_key").val();
	var keyword    = $("#keyword").val();
		
	$.post("/auth/search_list",{/*"active_key":active_key,*/ "keyword":keyword, "pageNum":pageNum}, function(data){
		$(".auth_list").html("");
		$(data.auth_list).each(function(){
			var auth_id = this.auth_id;
			var auth_nm = this.auth_nm;
			var active_flg = this.active_flg;
			authListOutput(auth_id, auth_nm, active_flg);
		})
		paging(data,"#paging_div", "authListInqr");
	}).fail(function(){
		alert("목록을 불러오는데 실패하였습니다.")
	})
}

/* 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.) */
function authDetailInqr(auth_id)  {				
	$.post("/auth/detail_list/"+auth_id, function(data){
		$(data).each(function() {
			var auth_id = this.auth_id;
			var auth_nm = this.auth_nm;
			var active_flg = this.active_flg;
			$(".active_flg:radio[value='Y']").attr("checked", true);
			$("#auth_id").val(auth_id);
			$("#auth_nm").val(auth_nm);
			$(".active_flg:radio[value='"+active_flg+"']").prop("checked", true);
			detailOutput(auth_id, auth_nm, active_flg);
		});
		
	});
}	

/* 입력 요청 함수 */
function authSave(){
	$.ajax({
		url:"/auth/insert",
		type:"post",
		contentType:"application/json; charset=UTF-8",
		dataType:"text",
		data:JSON.stringify({
			auth_nm:$("#auth_nm").val(),
			active_flg:$(".active_flg:checked").val()
		}),
		error:function(){
			alert("시스템 오류 입니다.");
		},
		success:function(resultData){
			if(resultData == "SUCCESS"){
				alert("등록이 완료되었습니다.");
				dataReset();
				authListInqr(1);
			}
		}
	})
}

/*수정 요청 함수*/
function authMdfy(){
	$.ajax({
		url:"/auth/update",
		type:"post",
		contentType:"application/json; charset=UTF-8",
		dataType:"text",
		data:JSON.stringify({
			auth_id:$("#auth_id").val(),
			auth_nm:$("#auth_nm").val(),
			active_flg:$(".active_flg:checked").val()
		}),
		error:function(){
			alert("시스템 오류 입니다. ");
		},
		success:function(resultData){
			if(resultData == "SUCCESS"){
				alert("수정이 완료되었습니다.");
				dataReset();
				authListInqr(1);
			}
		}
	})
}

/* 삭제 요청 함수 */
function authDel(){
	
	var del_code = "";
	
	$( "input[name='del_code']:checked" ).each (function (){
		  del_code = del_code + $(this).val()+"," ;
	});
	
	var delCode = del_code.split(","); //맨끝 콤마 지우기
	
	console.log("### del_code => {}" + del_code);
	if (confirm("정보를 삭제 하시겠습니까?")) {
	
	}
	
	if(delCode == ""){
		alert("삭제할 대상을 선택해 주세요");
		return false;
	} else{
		$.ajax({
			url:"/auth/delete/"+del_code,
			type:"post",
			contentType:"application/json; charset=UTF-8",
			dataType:"text",
			error:function(){
				alert("시스템 오류 입니다. ");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("삭제가 완료되었습니다.");
					dataReset();
					authListInqr(1);
				}
			}
		})
	}
}



/* 리스트 출력 함수 */
function authListOutput(auth_id, auth_nm, active_flg){

	var auth_tr = $("<tr>");
	auth_tr.addClass("open_detail");
	auth_tr.attr("data_num",auth_id);
	
	var del_code_td = $("<td>");
	del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + auth_id + "'>");
	
	var auth_id_td = $("<td>");
	auth_id_td.html(auth_id);
	
	var auth_nm_td = $("<td>");
	auth_nm_td.html(auth_nm);
	
	var active_flg_td = $("<td>");
	if(active_flg=='Y'){
		active_flg_td.html("활성화");
	}else if(active_flg=='N'){
		active_flg_td.html("비활성화");
	}
	
	auth_tr.append(del_code_td).append(auth_id_td).append(auth_nm_td).append(active_flg_td);
			
	$(".auth_list").append(auth_tr);
		
}

/*페이징 출력 함수*/
function pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount){
	if(endPageNum == 1)
	{
		pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress='pageInputRepDept(event);'/>"  
		+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
		+"<a style='color:black; text-decoration: none;'>▶</a>"
	}
	else if(startPageNum == endPageNum)
	{
		pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
		+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
		+"<a style='cursor: pointer;' onclick=authListInqrt("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='color:black; text-decoration: none;'>▶</a>";
	}
	else if(pageNum == 1)
	{
		pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
		+"<a style='cursor: pointer;' onclick=authListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
	}
	else if(pageNum == endPageNum)
	{
		pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
		+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
		+"<a style='cursor: pointer;' onclick=authListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='color:black; text-decoration: none;'>▶</a>";
	}
	else
	{
		pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
		+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"pageInputRepDept(event);\"/>"
		+"<a style='cursor: pointer;' onclick=authListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
	}
	$("#paging_div").append(pageContent);

}

/*상세정보 출력 함수*/
function detailOutput(auth_id, auth_nm, active_flg){
	
	dataReset();
	
	$("#auth_id").val(auth_id);
	$("#auth_nm").val(auth_nm);
	$(".active_flg:radio[value='"+active_flg+"']").prop("checked", "checked");
	
}

/*상세정보 초기화*/
function dataReset(){
	$("#auth_id").val("");
	$("#auth_nm").val("");
	$("input:radio[name='active_flg']").removeAttr("checked");
}

// 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.)
$(function(){
	$(document).on("click", ".open_detail", function() {	// ajax일 경우 이런 식으로 사용해야한다.
		auth_id = $(this).attr("data_num");
		
		authDetailInqr(auth_id);
		
		// 숨겨놓은 각각의 버튼을 보여준다.
		$("#auth_menu").show();
		$("#auth_user").show();
		$("#authDetail_resert_btn").show();
		$("#authDetail_save_btn").show();
		
		// 상세보기로 내용이 있을 경우 reset해준다.
		$("#joinform").each(function(){
			this.reset();
		})
	});
});

//페이지 처음 출력시 이벤트
function pageReady(boolean){
	if(boolean == true){
		$("#auth_save_fbtn").hide();
		$("#auth_reset_nfbtn").hide();
		$("#auth_edit_nfbtn").show();
	}else if(boolean == false){
		$("#auth_save_fbtn").show();
		$("#auth_reset_nfbtn").show();
		$("#auth_edit_nfbtn").hide();
	}
	$("#auth_id").attr("readonly",true);
	$("#auth_nm").attr("readonly",boolean);
	$(".active_flg").attr("disabled",boolean);
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
   	auth_goSearch();
    //opener.document.location.href="/auth/authInqr";
}
 
//AS-ID 엑셀 다운로드 적용 함수
function download_list_Excel(formID){
	
	var ctx = $("#ctx").val();
	var form = $("#"+formID);
	var excel = $('<input type="hidden" value="true" name="excel">');
	form.append(excel);
	form.submit();
	$("input[name=excel]").val("");
}

function authAdd() {
	
	// 숨겨놓은 각각의 버튼을 보여준다.
	$("#authDetail_resert_btn").show();
	$("#authDetail_save_btn").show();
	
	// 상세보기로 내용이 있을 경우 reset해준다.
	$("#joinform").each(function(){
		this.reset();
	})
}
	
//상세정보 저장버튼
function saveDetail() {
	
	if($("#auth_nm").val() == "" || $("#auth_nm").val() == null) {
			alert("권한명를 입력해주세요");
			return false;
	} else {	 
		alert("권한이 저장 되었습니다.");
		$("#joinform").submit();
	}
}

function resertDetail() {
	
	$("#auth_nm").val("");
	$(".active_flg:radio[value='Y']").attr("checked", "checked");
}