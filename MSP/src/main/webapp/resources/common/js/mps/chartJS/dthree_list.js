/* 접속된 세션 아이디 입니다. */
//var sessionID = "${SessionID}"
	
//	alert("${SessionID}");
//if(sessionID == 'admin') {
////		 alert("관리자 권한으로 접속하셨습니다.");		
//} else {
//	alert(" ** 접근권한이 없습니다. ** \n ** 관리자 권한으로 로그인하세요. **\n ** 확인버튼 클릭 시. **\n ** 로그인화면으로 이동합니다. **");
//	location.href = "/";
//}
//
var dept_cd = "";
var save_cd = "";


$(function(){

	pageReady(true);
	
	//chart();
	//graph();
	
	/*검색버튼 클릭 시 처리 이벤트*/
	$("#dthree_inqr_fbtn").click(function(){
		dthreeListInqr(1);
	})
	
	$("#keyword").keypress(function(){
		enterSearch(event, dthreeListInqr);
	})
	
	/*area 클릭 시 상세정보 출력 이벤트*/
	$(document).on("click", ".open_detail", function(){
		area = $(this).attr("data_num");
		dthreeDetailInqr(area);
	})

/*추가버튼 클릭 시 처리 이벤트*/
$("#dthree_add_fbtn").click(function(){
	
	// 숨겨놓은 각각의 버튼을 보여준다.
	$("#dthreeDetail_resert_btn").show();
	$("#dthreeDetail_save_btn").show();
	
	dataReset();
	pageReady(false);
	$("#dept_nm").focus();
	save_cd = "insert";
	
})

/*삭제버튼 클릭 시 처리 이벤트*/
$("#dthree_del_fbtn").click(function(){
	dthreeDel();
})

/*편집버튼 클릭 시 처리 이벤트*/
$("#dthree_edit_nfbtn").click(function(){
	pageReady(false);
	$("#dept_nm").focus();
	save_cd = "update";
})
/*초기화버튼 클릭 시 처리 이벤트*/
$("#dthree_reset_nfbtn").click(function(){
	
	$("#korea").val("");
	$("#foreigner").val("");
				
	dataReset();
	save_cd = "";
	pageReady(true);
})

/*저장버튼 클릭 시 처리 이벤트*/
$("#dthree_save_fbtn").click(function(){
	if(save_cd == "insert"){
		dthreeSave();
		pageReady(true);
	}else if(save_cd == "update"){
		dthreeMdfy();
		pageReady(true);
	}
	//chart();
	//graph();
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


//조회 버튼기능
function dthree_goSearch(){
	
	var active_key = $("#active_key").val();
	var keyword = $("#keyword").val();
	var pageNum = $("#pageNum").val();
				
	$("#searchForm").submit();
		
}

/*리스트 출력및 페이징 처리 함수*/
function dthreeListInqr(pageNum){

	var keyword    = $("#keyword").val();
		
	$.post("/chart/search_list", {"keyword":keyword, "pageNum":pageNum}, function(data){
		$(".dthree_list").html("");
		console.log(data);
		$(data.dthree_list).each(function(){
			
			var area = this.area;
			var korea = this.korea;
			var foreigner = this.foreigner;
			var active_flg = this.active_flg;
			
			dthreeListOutput(area, korea, foreigner, active_flg);
		})
		paging(data,"#paging_div", "dthreeListInqr");
		//chart();		//페이지마다 리스트 새로 갱신
		//graph();
	}).fail(function(){
		alert("목록을 불러오는데 실패하였습니다.")
	})
}

/* 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.) */
function dthreeDetailInqr(area)  {	
	console.log(area);
	$.post("/chart/detail_list/"+area, function(data){
		console.log(data);
		
		$(data).each(function() {
			var area = this.area;
			var korea = this.korea;
			var foreigner = this.foreigner;
			var active_flg = this.active_flg;
			
			detailOutput(area, korea, foreigner, active_flg);
		});
		
	});
}	

/* 입력 요청 함수 */
function dthreeSave(){
	$.ajax({
		url:"/chart/insert",
		type:"post",
		contentType:"application/json; charset=UTF-8",
		dataType:"text",
		data:JSON.stringify({
			 area:$("#area").val(),
			 korea:$("#korea").val(),
			 foreigner:$("#foreigner").val(),
			 active_flg:$(".active_flg:checked").val()
		}),
		error:function(){
			alert("시스템 오류 입니다.");
		},
		success:function(resultData){
			if(resultData == "SUCCESS"){
				alert("등록이 완료되었습니다.");
				dataReset();
				dthreeListInqr(1);
			}
		}
	})
}

/*수정 요청 함수*/
function dthreeMdfy(){
	$.ajax({
		url:"/chart/update",
		type:"post",
		contentType:"application/json; charset=UTF-8",
		dataType:"text",
		data:JSON.stringify({
			 area:$("#area").val(),
			 korea:$("#korea").val(),
			 foreigner:$("#foreigner").val(),
			 active_flg:$(".active_flg:checked").val()
		}),
		error:function(){
			alert("시스템 오류 입니다. ");
		},
		success:function(resultData){
			if(resultData == "SUCCESS"){
				alert("수정이 완료되었습니다.");
				dataReset();
				dthreeListInqr(1);
			}
		}
	})
}

/* 삭제 요청 함수 */
function dthreeDel(){
	
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
			url:"/chart/delete/"+del_code,
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
					dthreeListInqr(1);
				}
			}
		})
	}
}

/* 리스트 출력 함수 */
function dthreeListOutput(area, korea, foreigner, active_flg){

	var dthree_tr = $("<tr>");
	dthree_tr.addClass("open_detail");
	dthree_tr.attr("data_num",area);
	
	var del_code_td = $("<td>");
	del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + area + "'>");
	
	var area_td = $("<td>");
	area_td.html(area);
	
	var korea_td = $("<td>");
	korea_td.html(korea);
	
	var foreigner_td = $("<td>");
	foreigner_td.html(foreigner);
	
	var active_flg_td = $("<td>");
		if(active_flg=='Y'){
			active_flg_td.html("활성화");
		}else if(active_flg=='N'){
			active_flg_td.html("비활성화");
		}
	
	dthree_tr.append(del_code_td).append(area_td).append(korea_td).append(foreigner_td).append(active_flg_td);
			
	$(".dthree_list").append(dthree_tr);
		
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
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
		+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
		+"<a style='cursor: pointer;' onclick=dthreeListInqrt("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='color:black; text-decoration: none;'>▶</a>";
	}
	else if(pageNum == 1)
	{
		pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
	}
	else if(pageNum == endPageNum)
	{
		pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
		+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='color:black; text-decoration: none;'>▶</a>";
	}
	else
	{
		pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
		+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"pageInputRepDept(event);\"/>"
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
		+"<a style='cursor: pointer;' onclick=dthreeListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
	}
	$("#paging_div").append(pageContent);

}

/*상세정보 출력 함수*/
function detailOutput(area, korea, foreigner, active_flg){
	
	dataReset();
	
	$("#area").val(area);
	$("#korea").val(korea);
	$("#foreigner").val(foreigner);
	$(".active_flg:radio[value='"+active_flg+"']").prop("checked", "checked");
}

/*상세정보 초기화*/
function dataReset(){
	$("#area").val("");
	$("#korea").val("");
	$("#foreigner").val("");
	$("input:radio[name='active_flg']").removeAttr("checked");
}

// 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.)
//$(function(){
//	$(document).on("click", ".open_detail", function() {	// ajax일 경우 이런 식으로 사용해야한다.
//		area = $(this).attr("data_num");
//		
//		dthreeDetailInqr(area);
//		
//		// 숨겨놓은 각각의 버튼을 보여준다.
//		$("#dthreeDetail_resert_btn").show();
//		$("#dthreeDetail_save_btn").show();
//		
//		// 상세보기로 내용이 있을 경우 reset해준다.
//		$("#joinform").each(function(){
//			this.reset();
//		})
//	});
//});

//페이지 처음 출력시 이벤트
function pageReady(boolean){
	if(boolean == true){
		$("#dthree_save_fbtn").hide();
		$("#dthree_reset_nfbtn").hide();
		$("#dthree_edit_nfbtn").show();
	}else if(boolean == false){
		$("#dthree_save_fbtn").show();
		$("#dthree_reset_nfbtn").show();
		$("#dthree_edit_nfbtn").hide();
	}
	$("#area").attr("readonly",boolean);
	$("#korea").attr("readonly",boolean);
	$("#foreigner").attr("readonly",boolean);
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
   	dthree_goSearch();
    //opener.document.location.href="/dthree/dthreeInqr";
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

function dthreeAdd() {
	
	// 숨겨놓은 각각의 버튼을 보여준다.
	$("#dthreeDetail_resert_btn").show();
	$("#dthreeDetail_save_btn").show();
	
	// 상세보기로 내용이 있을 경우 reset해준다.
	$("#joinform").each(function(){
		this.reset();
	})
}
	
//상세정보 저장버튼
function saveDetail() {
	
	if($("#korea").val() == "" || $("#korea").val() == null) {
			alert("값을 입력해주세요");
			return false;
	} else {	 
		alert("저장 되었습니다.");
		$("#joinform").submit();
	}
}

function resertDetail() {
	
	$("#korea").val("");
	$("#foreigner").val("");
	$(".active_flg:radio[value='Y']").attr("checked", "checked");
}






