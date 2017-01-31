// jsp파일에서 설정한 input의 아이디의 value값을 가져오는 역할.
$(function(){
	var ctx = $('#ctx').val();
	startCalendar(ctx); 
});

//버튼 클릭 시 input form의 readonly 상태를 변경하는 함수.
$(document).ready(function() {
	$('#selectbox').change(function () {
	var selectVal = $(this).find("option:selected").val();
	$("#contr_amt1").val(selectVal);
	var selectText = $(this).find("option:selected").text();
	$("#contr_amt2").val(selectText);

	});

    // 계약 리스트 체크박스 선택, 해제
	$("#contListCheck").click(function(){
		if($("#contListCheck").prop("checked")){
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
});

//전체 체크 해제
function contChkCancel() {
	$(document).ready(function() {
		$("#contListCheck").prop("checked", false);
	});
}

//달력띄우기
function startCalendar(ctx){
	$("#contr_d_list").datepicker({
	     changeMonth: true, //콤보 박스에 월 보이기
	     changeYear: true, // 콤보 박스에 년도 보이기
	     showOn: 'button', // 우측에 달력 icon 을 보인다.
	     buttonImage: ctx+'/resources/image/calendar.jpg',  // 우측 달력 icon 의 이미지 경로
	     buttonImageOnly: true //달력에 icon 사용하기
	 }); 
	
	 $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px', 'margin-bottom':'-6px'});
	 $.datepicker.setDefaults({dateFormat:'yy-mm-dd'});
	
	 $("#contr_d_detail").datepicker({
		 changeMonth: true, //콤보 박스에 월 보이기
		 changeYear: true, // 콤보 박스에 년도 보이기
		 showOn: 'button', // 우측에 달력 icon 을 보인다.
		 buttonImage: ctx+'/resources/image/calendar.jpg',  // 우측 달력 icon 의 이미지 경로
		 buttonImageOnly: true //달력에 icon 사용하기
	 }); 
	 $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px', 'margin-bottom':'-6px'});
	 $.datepicker.setDefaults({dateFormat:'yy-mm-dd'});
}

function contNameSend(contr_id) {
	$(document).ready(function() {
		 $("#contMdfyBtn").attr("disabled", false);
		 $("#contBaseBtnDiv").css("display", "block");
		 $("#contAddBtnDiv").css("display", "none");
		 $("#contMdfyBtnDiv").css("display", "none");
		var ctx = $("#ctx").val();
		
		$.ajax({
			url : ctx + '/contDetail', // 보낼URL= 컨트롤러에 있는 주소(내가 쓰고싶은 기능)
			dataType : 'json', // 응답 받을 데이터 형식
			type : 'POST', // 서버 요청 방식
			data : "contr_id=" + contr_id,// href 할때 주소 뒤에 ? 쓰는것과 같은 효과
			success : function(data) {
				$("#contr_nm").val(data.contr_nm);
				$("#cust_id").val(data.cust_id);
				$("#contr_id").val(data.contr_id);
				$("#cust_nm").val(data.cust_nm);
				$("#estim_lev_cd").val(data.estim_lev_cd);
				$("#sales_oppt_nm").val(data.sales_oppt_nm);
				$("#sales_oppt_id").val(data.sales_oppt_id);
				$("#estim_id").val(data.estim_id);
				$("#contr_qty").val(data.contr_qty);
				$("#contr_amt").val(data.contr_amt);
				$("#contr_d_detail").val(data.contr_d.substring(0, 10));
				$("#memo").val(data.memo);
				
				$("#hcontr_nm").val(data.contr_nm);
				$("#hcust_id").val(data.cust_id);
				$("#hcontr_id").val(data.contr_id);
				$("#hcust_nm").val(data.cust_nm);
				$("#hestim_lev_cd").val(data.estim_lev_cd);
				$("#hsales_oppt_nm").val(data.sales_oppt_nm);
				$("#hsales_oppt_id").val(data.sales_oppt_id);
				$("#hestim_id").val(data.estim_id);
				$("#hcontr_qty").val(data.contr_qty);
				$("#hcontr_amt").val(data.contr_amt);
				$("#hcontr_d_detail").val(data.contr_d.substring(0, 10));
				$("#hmemo").val(data.memo);
			},
			error : function() {
				alert("데이터 가져오기 실패");
			}
		});
	});
}

//계약 삭제
function contListDel(ctx){
	$(document).ready(function() {
		var chked_val = [];
		$(":checkbox[id='chk_cont_id']:checked").each(function(index, item){//체크박스 아이디
			chked_val[index] = item.value;
		});
		if(chked_val.length == 0){
			alert("삭제할 항목을 선택해 주세요");
		}else{
			var delChk = confirm("정말 삭제 하시겠습니까?");
			if(delChk){
				$.ajax({
					url : ctx+'/contListDelete',
					type : 'POST',
					data :  JSON.stringify(chked_val),
					dataType : 'json',
					contentType : 'application/json',
					success : function(data){
						alert(data.deleteResult);
						location.href = ctx + "/cont";
					},
					error : function(data){
						alert(data.deleteResult);
						location.href = ctx + "/cont";
					}
				});
			} else {
				location.href = ctx + "/cont";
				return;
			}
		}
	});
}

//계약입력
function insertCont(ctx){
	$(document).ready(function() {
		$.ajax({
			url : ctx + '/contInsert', // 보낼 URL=컨트롤러에 있는 주소(내가 쓰고싶은 기능)
			dataType : 'json', // 응답 받을 데이터 형식
			type : 'POST', // 서버 요청 방식
			data : $("#contForm").serialize(),//.serialize()직렬화하여 데이터를 싹다 가져옴
			success : function(data) {
				alert(data.insertResult);
				location.href =ctx + "/cont";// 등록 후 다시 페이지 불러온다.
			},
			error : function() {
				alert("데이터 입력 실패");
			}
		});
	});
}

//계약정보 수정
function updateCont(ctx){
	$(document).ready(function() {
		$.ajax({
			url : ctx + '/contUpdate', // 보낼 URL=컨트롤러에 있는 주소(내가 쓰고싶은 기능)
			dataType : 'text', // 응답 받을 데이터 형식
			type : 'POST', // 서버 요청 방식
			data : $("#contForm").serialize(),//.serialize()직렬화하여 데이터를 싹다 가져옴
			success : function(data) {
				alert(data);
				location.href =ctx + "/cont";// 등록 후 다시 페이지 불러온다.
			},
			error : function() {
				alert("데이터 수정 실패");
			}
		});
	});
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//페이징
function contPaging(pageNum) {
	$(document).ready(function() {
		var ctx = $("#ctx").val();
		var allData = {"pageNum": pageNum};
		var tbody = $('#contListTbody');
		var tbodyContent = "";
		
		$.ajax({
			url : ctx+'/contPaging',
			type : 'POST',
			data : allData,
			dataType : "json",
			success : function(data) {
				tbody.children().remove();
				
				for (var i = 0; i < data.contList.length; i++) {
					var contr_amt = comma(data.contList[i].contr_amt);
					tbodyContent = "<tr id='tabletoptr'>"
						+"<th><input type='checkbox' id='chk_cont_id' value='"+data.contList[i].contr_id+"' onclick='chkCancel();'></th>"
						+"<td style='text-align: left; padding-left: 8px'>"
						+"<a href='#' onclick=\"contNameSend('"+data.contList[i].contr_id+"');\" style='color: blue;' class='cntClick'>"+data.contList[i].contr_nm+"</a></td>"
						+"<td>"+data.contList[i].contr_num+"</td>" 
						+"<td style='text-align: right; padding-right: 8px'>"+data.contList[i].contr_qty+"</td>"
						+"<td style='text-align: right; padding-right: 8px'>"+contr_amt+"</td>"
						+"<td>"+data.contList[i].contr_d+"</td>"
						+"<td>"+data.contList[i].fst_reg_id_nm+"</td>"
						+"<td>"+data.contList[i].fst_reg_dt+"</td></tr>";
					tbody.append(tbodyContent);
					$("#ccListCheck").prop("checked", false);
				}
				
				if(data.contList.length < 5){
					for(var j = 0; j < 5-data.contList.length; j++){
						tbodyContent ="<tr style='height:23px;'>"
							+"<th></th>"
							+"<td></td><td></td><td></td><td></td>"
							+"<td></td><td></td><td></td></tr>";
						tbody.append(tbodyContent);
					}
				}
				var pageContent = "";
				// 페이징 다시그리기
				$("#pagingDiv").children().remove();
				
				if(data.page.startPageNum == 1 && data.page.endPageNum == 1){
					pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
					+"<a> ◀ </a><input type='text' id='contPageInput' readonly='readonly' value='"+data.page.startPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>" 
					+"<a> / "+data.page.endPageNum+"</a><a> ▶ </a>";
				} else if(data.pageNum == data.page.startPageNum){
					pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
					+"<a> ◀ </a><input type='text' id='contPageInput' value='"+data.page.startPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>" 
					+"<a href='#' onclick=contPaging("+data.page.endPageNum+") id='pNum' style='text-decoration: none; color: blue;'> / "+data.page.endPageNum+"</a>"
					+"<a href='#' onclick=contPaging("+(data.pageNum+1)+") id='pNum' style='text-decoration: none; color: blue;'> ▶ </a>";
				} else if(data.pageNum == data.page.endPageNum){
					pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
					+"<a href='#' onclick=contPaging("+(data.pageNum-1)+") id='pNum' style='text-decoration: none; color: blue;'> ◀ </a>"
					+"<input type='text' id='contPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>"
					+"<a> / "+data.page.endPageNum+"</a>"
					+"<a> ▶ </a>";
				} else {
					pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
					+"<a href='#' onclick=contPaging("+(data.pageNum-1)+") id='pNum' style='text-decoration: none; color: blue;'> ◀ </a>"
					+"<input type='text' id='contPageInput' value='"+data.ccPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>"
					+"<a href='#' onclick=contPaging("+data.page.endPageNum+") id='pNum' style='text-decoration: none;'> / "+data.page.endPageNum+"</a>"
					+"<a href='#' onclick=contPaging("+(data.pageNum+1)+") id='pNum' style='text-decoration: none; color: blue;'> ▶ </a>";
				}
				$("#pagingDiv").append(pageContent);
			},
			error : function() {
				alert("전송중 오류가 발생했습니다.");
			}
		});
	});
}

// 검색 페이징
function schContPaging(pageNum) {
	$(document).ready(function() {
		var ctx = $("#ctx").val();
		var sch_cont_nm = $("#sch_cont_nm").val();
		var sch_cont_num = $("#sch_cont_num").val();
		var sch_cont_amt = $("#sch_cont_amt").val();
		var sch_contr_d = $("#contr_d_list").val();
		
		if(sch_cont_nm == '' && sch_cont_num == '' && sch_cont_amt == 0 && sch_contr_d == ''){
			alert("검색어를 입력하세요.");
			return;
		} else{
			var allData = {"pageNum" : pageNum, "sch_cont_nm" : sch_cont_nm, "sch_cont_num" : sch_cont_num
							 , "sch_cont_amt" : sch_cont_amt, "sch_contr_d" : sch_contr_d};
			var tbody = $('#contListTbody');
			var tbodyContent = "";
			
			$.ajax({
				url : ctx+'/contPaging',
				type : 'POST',
				data : allData,
				dataType : "json",
				success : function(data) {
					if(data.contList.length == 0){
						alert("검색된 데이터가 없습니다.");
						location.href = ctx + "/cont";
					}else{
						tbody.children().remove();
						
						$("#sch_cont_nm").val(data.sch_cont_nm);
						$("#sch_cont_num").val(data.sch_cont_num);
						$("#sch_cont_amt").val(data.sch_cont_amt);
						$("#sch_contr_d").val(data.sch_contr_d);
						
						for (var i = 0; i < data.contList.length; i++) {
							var contr_amt = comma(data.contList[i].contr_amt);
							tbodyContent = "<tr id='tabletoptr'>"
								+"<th><input type='checkbox' id='chk_cont_id' value='"+data.contList[i].contr_id+"' onclick='chkCancel();'></th>"
								+"<td style='text-align: left; padding-left: 8px'>"
								+"<a href='#' onclick=\"contNameSend('"+data.contList[i].contr_id+"');\" style='color: blue;' class='cntClick'>"+data.contList[i].contr_nm+"</a></td>"
								+"<td>"+data.contList[i].contr_num+"</td>" 
								+"<td style='text-align: right; padding-right: 8px'>"+data.contList[i].contr_qty+"</td>"
								+"<td style='text-align: right; padding-right: 8px'>"+contr_amt+"</td>"
								+"<td>"+data.contList[i].contr_d+"</td>"
								+"<td>"+data.contList[i].fst_reg_id_nm+"</td>"
								+"<td>"+data.contList[i].fst_reg_dt+"</td></tr>";
							tbody.append(tbodyContent);
							$("#ccListCheck").prop("checked", false);
						}
						
						if(data.contList.length < 5){
							for(var j = 0; j < 5-data.contList.length; j++){
								tbodyContent ="<tr style='height:23px;'>"
									+"<th></th>"
									+"<td></td><td></td><td></td><td></td>"
									+"<td></td><td></td><td></td></tr>";
								tbody.append(tbodyContent);
							}
						}
						var pageContent = "";
						// 페이징 다시그리기
						$("#pagingDiv").children().remove();
						
						if(data.page.startPageNum == 1 && data.page.endPageNum == 1){
							pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
							+"<a> ◀ </a><input type='text' id='contPageInput' readonly='readonly' value='"+data.page.startPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>" 
							+"<a> / "+data.page.endPageNum+"</a><a> ▶ </a>";
						} else if(data.pageNum == data.page.startPageNum){
							pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
							+"<a> ◀ </a><input type='text' id='contPageInput' value='"+data.page.startPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>" 
							+"<a href='#' onclick=contPaging("+data.page.endPageNum+") id='pNum' style='text-decoration: none;'> / "+data.page.endPageNum+"</a>"
							+"<a href='#' onclick=contPaging("+(data.pageNum+1)+") id='pNum' style='text-decoration: none; color: blue;'> ▶ </a>";
						} else if(data.pageNum == data.page.endPageNum){
							pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
							+"<a href='#' onclick=contPaging("+(data.pageNum-1)+") id='pNum' style='text-decoration: none; color: blue;'> ◀ </a>"
							+"<input type='text' id='contPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>"
							+"<a> / "+data.page.endPageNum+"</a>"
							+"<a> ▶ </a>";
						} else {
							pageContent = "<input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>"
							+"<a href='#' onclick=contPaging("+(data.pageNum-1)+") id='pNum' style='text-decoration: none; color: blue;'> ◀ </a>"
							+"<input type='text' id='contPageInput' value='"+data.ccPageNum+"' onkeypress=\"pageInput(event);\" class='cont_page_txt'/>"
							+"<a href='#' onclick=contPaging("+data.page.endPageNum+") id='pNum' style='text-decoration: none;'> / "+data.page.endPageNum+"</a>"
							+"<a href='#' onclick=contPaging("+(data.pageNum+1)+") id='pNum' style='text-decoration: none; color: blue;'> ▶ </a>";
						}
						$("#pagingDiv").append(pageContent);
					}
				},
				error : function() {
					alert("전송중 오류가 발생했습니다.");
				}
			});
		}
	});
}