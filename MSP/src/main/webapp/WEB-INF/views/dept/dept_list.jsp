<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" /> --%>
<title>부서관리화면</title>
<style type="text/css">
	@media screen and (min-width:1100px){
		.list_div{
			position:relative;
			width:100%;
			overflow:auto;
		}
		.list2_div{
			/* position:float; */
			padding: 10px;	
			float: left;
			width: 58%;
		}
		.list3_div{
			padding: 10px;
			margin-top: 35px; 
			margin-left: 20px;
			width: 38%;
			display: inline-block;
		}
	}
	.checkall {
		text-align: center;
		vertical-align: middle;
	}
	.paging_div {
		width: 100%;
		height: auto;
		text-align: center;
		margin-top: 5px;
		clear: both;
	}
	.left {
		float: left;
		vertical-align: top;
		margin:0;
	}

	.page {
		width: auto;
		clear: both;
		display: inline-block;
		text-align: center;
		vertical-align: top;
		margin:0 auto;
	}
	
	.right {
		float: right;
		vertical-align: top;
	}
	
	.pNum{
		width: 25%;
	}
</style>
<script type="text/javascript">
	var dept_cd = "";
	var save_cd = "";
	
	$(function(){
		/* $(".dept_list").load(function(){
			deptListInqr(active_key, dept_nm_key);
		}) */
		
		/* 검색 후 검색 대상과 검색 단어 출력 */
		/* if("<c:out value='${data.active_key}'/>" != ""){
			$("#active_key").val("<c:out value='${data.active_key}'/>").attr("selected","selected");
		}
		if("<c:out value='${data.dept_nm_key}'/>" != ""){
			$("#dept_nm_key").val("<c:out value='${data.dept_nm_key}'/>");
		} */
		pageReady(true);
		
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#dept_inqr_fbtn").click(function(){
			deptListInqr(1);
		})
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			dept_cd = $(this).attr("data_num");
			deptDetailInqr(dept_cd);
		})
		/*추가버튼 클릭 시 처리 이벤트*/
		$("#dept_add_fbtn").click(function(){
			dataReset();
			pageReady(false);
			$("#dept_nm").focus();
			save_cd = "insert";
		})
		/*삭제버튼 클릭 시 처리 이벤트*/
		$("#dept_del_fbtn").click(function(){
			deptDel();
		})
		/*편집버튼 클릭 시 처리 이벤트*/
		$("#dept_edit_nfbtn").click(function(){
			pageReady(false);
			$("#dept_nm").focus();
			save_cd = "update";
		})
		/*초기화버튼 클릭 시 처리 이벤트*/
		$("#dept_reset_nfbtn").click(function(){
			dataReset();
			save_cd = "";
			pageReady(true);
		})
		/*저장버튼 클릭 시 처리 이벤트*/
		$("#dept_save_fbtn").click(function(){
			if(save_cd == "insert"){
				deptSave();
				pageReady(true);
			}else if(save_cd == "update"){
				deptMdfy();
				pageReady(true);
			}
		})
		/* 체크박스 전체선택, 전체해제 */
		$("#allCheck").on("click", function(){
		      if( $("#allCheck").is(':checked') ){
		        $("input[name=del_code]").prop("checked", true);
		      }else{
		        $("input[name=del_code]").prop("checked", false);
		      }
		})
	})
	
	/*부서 리스트 출력및 페이징 처리 함수*/
	function deptListInqr(pageNum){
		/* $("#searchForm").attr({
			"method":"post",
			"action":"list"
		})
		$("#searchForm").submit(); */
		var active_key = $("#active_key").val();
		var dept_nm_key = $("#dept_nm_key").val();
		
		$.post("/dept/search_list",{"active_key":active_key, "dept_nm_key":dept_nm_key, "pageNum":pageNum}, function(data){
			$(".dept_list").html("");
			$(data.dept_list).each(function(){
 				var dept_cd = this.dept_cd;
				var dept_nm = this.dept_nm;
				var dept_num1 = this.dept_num1;
				var dept_num2 = this.dept_num2;
				var dept_num3 = this.dept_num3;
				var user_nm = this.user_nm;
				var active_flg = this.active_flg;
				deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm, active_flg);
			})
			$("#paging_div").html("");
			$(data).each(function(){
				var pageNum = this.pageNum;
				var totalCount = this.page.totalCount;
				var pageSize = this.page.pageSize;
				var pageBlockSize = this.page.pageBlockSize;
				var startRow = this.page.startRow;
				var endRow = this.page.endRow;
				var startPageNum = this.page.startPageNum;
				var endPageNum = this.page.endPageNum;
				var currentPageNum = this.page.currentPageNum;
				var totalPageCount = this.page.totalPageCount;
				pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount);
			})
		}).fail(function(){
			alert("부서 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*부서 상세정보 요청 함수*/
	function deptDetailInqr(dept_cd){
		$.post("/dept/detail_list/"+dept_cd, function(data){
			$(data).each(function(){
				var dept_cd = this.dept_cd;
				var dept_nm = this.dept_nm;
				var dept_num1 = this.dept_num1;
				var dept_num2 = this.dept_num2;
				var dept_num3 = this.dept_num3;
				var dept_fnum1 = this.dept_fnum1;
				var dept_fnum2 = this.dept_fnum2;
				var dept_fnum3 = this.dept_fnum3;
				var active_flg = this.active_flg;
				detailOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, dept_fnum1, dept_fnum2, dept_fnum3, active_flg);
			})
		}).fail(function(){
			alert("부서 상세정보를 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*부서 입력 요청 함수*/
	function deptSave(){
		$.ajax({
			url:"/dept/insert",
			type:"post",
			contentType:"application/json; charset=UTF-8",/* "X-HTTP-Method-Override":"POST" */
			dataType:"text",
			data:JSON.stringify({
				dept_nm:$("#dept_nm").val(),
				dept_num1:$("#dept_num1 option:selected").val(),
				dept_num2:$("#dept_num2").val(),
				dept_num3:$("#dept_num3").val(),
				dept_fnum1:$("#dept_fnum1 option:selected").val(),
				dept_fnum2:$("#dept_fnum2").val(),
				dept_fnum3:$("#dept_fnum3").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("부서 등록이 완료되었습니다.");
					dataReset();
					deptListInqr(1);
				}
			}
		})
	}
	/*부서 수정 요청 함수*/
	function deptMdfy(){
		$.ajax({
			url:"/dept/update",
			type:"post",
			/* header:{
				"Content-type":"application/json","X-HTTP-Method-Override":"POST"
			}, */
			contentType:"application/json; charset=UTF-8",
			dataType:"text",
			data:JSON.stringify({
				dept_cd:$("#dept_cd").val(),
				dept_nm:$("#dept_nm").val(),
				dept_num1:$("#dept_num1 option:selected").val(),
				dept_num2:$("#dept_num2").val(),
				dept_num3:$("#dept_num3").val(),
				dept_fnum1:$("#dept_fnum1 option:selected").val(),
				dept_fnum2:$("#dept_fnum2").val(),
				dept_fnum3:$("#dept_fnum3").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("부서 수정이 완료되었습니다.");
					dataReset();
					deptListInqr(1);
				}
			}
		})
	}
	/*부서 삭제 요청 함수*/
	function deptDel(){
		var del_code = "";
		$( "input[name='del_code']:checked" ).each (function (){
			  del_code = del_code + $(this).val()+"," ;
		});
		
		var delCode = del_code.split(","); //맨끝 콤마 지우기
		
		if(delCode == ""){
			alert("삭제할 대상을 선택해 주세요");
			return false;
		}else{
			/* $("#delAll_form").attr({
				"method":"post",
				"action":"delete"
			});
			$("#delAll_form").submit(); */
			/* console.log(delCode);
			console.log(del_code); */
			$.ajax({
				url:"/dept/delete/"+del_code,
				type:"post",
				contentType:"application/json; charset=UTF-8",
				dataType:"text",
				//data:JSON.stringify({del_code : del_code}),
				error:function(){
					alert("시스템 오류 입니다. 관리자에게 문의하세요.");
				},
				success:function(resultData){
					if(resultData == "SUCCESS"){
						alert("부서 수정이 완료되었습니다.");
						dataReset();
						deptListInqr(1);
					}
				}
			})
		}
	}
	/*부서 리스트 출력 함수*/
	function deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm, active_flg){
		
		var dept_tr = $("<tr>");
		dept_tr.addClass("open_detail");
		dept_tr.attr("data_num",dept_cd);
		
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + dept_cd + "'>");
		
		var dept_nm_td = $("<td>");
		dept_nm_td.html(dept_nm);
		
		var dept_num_td = $("<td>");
		dept_num_td.html(dept_num1 + "-" + dept_num2 + "-" + dept_num3);
		
		var user_nm_td = $("<td>");
		user_nm_td.html(user_nm);
		
		var active_flg_td = $("<td>");
		if(active_flg=='Y'){
			active_flg_td.html("활성화");
		}else if(active_flg=='N'){
			active_flg_td.html("비활성화");
		}
		
		dept_tr.append(del_code_td).append(dept_nm_td).append(dept_num_td).append(user_nm_td).append(active_flg_td);
				
		$(".dept_list").append(dept_tr);
			
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
			+"<a style='cursor: pointer;' onclick=deptListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrt("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=deptListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"pageInputRepDept(event);\"/>"
			+"<a style='cursor: pointer;' onclick=deptListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=deptListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		$("#paging_div").append(pageContent);

	}
	/*부서 상세정보 출력 함수*/
	function detailOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, dept_fnum1, dept_fnum2, dept_fnum3, active_flg){
		dataReset();
		
		$("#dept_cd").val(dept_cd);
		$("#dept_nm").val(dept_nm);
		$("#dept_num1").val(dept_num1).attr("selected","selected");
		$("#dept_num2").val(dept_num2);
		$("#dept_num3").val(dept_num3);
		$("#dept_fnum1").val(dept_fnum1).attr("selected","selected");
		$("#dept_fnum2").val(dept_fnum2);
		$("#dept_fnum3").val(dept_fnum3);
		$(".active_flg:radio[value='"+active_flg+"']").prop("checked", "checked");
	}
	/*상세정보 초기화*/
	function dataReset(){
		$("#dept_cd").val("");
		$("#dept_nm").val("");
		$("#dept_num1").index(0);
		$("#dept_num2").val("");
		$("#dept_num3").val("");
		$("#dept_fnum1").index(0);
		$("#dept_fnum2").val("");
		$("#dept_fnum3").val("");
		$("input:radio[name='active_flg']").removeAttr("checked");
	}
	//페이지 처음 출력시 이벤트
	function pageReady(boolean){
		if(boolean == true){
			$("#dept_save_fbtn").hide();
			$("#dept_edit_nfbtn").show();
		}else if(boolean == false){
			$("#dept_save_fbtn").show();
			$("#dept_edit_nfbtn").hide();
		}
		$("#dept_cd").attr("readonly",true);
		$("#dept_nm").attr("readonly",boolean);
		$("#dept_num1").attr("readonly",boolean);
		$("#dept_num2").attr("readonly",boolean);
		$("#dept_num3").attr("readonly",boolean);
		$("#dept_fnum1").attr("readonly",boolean);
		$("#dept_fnum2").attr("readonly",boolean);
		$("#dept_fnum3").attr("readonly",boolean);
		$(".active_flg").attr("disabled",boolean);
	}
	
	// 검색 페이징 엔터키
    function pageInputRepDept(event) {	
    	$(document).ready(function() {
    		var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
    			var pageNum = parseInt($("#pageInput").val());
    			if ($("#pageInput").val() == '') {
    				alert("Input page number.")
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else if(pageNum > parseInt($("#endPageNum").val())) {
    				alert("The page number is too large.");
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else if (1 > pageNum) {
    				alert("The page number is too small.");
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else {
    				deptListInqr(pageNum);
    			}
    		}
    		event.stopPropagation();
    	});
    }
	
  //검색 엔터키
    function enterSearch(event) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		deptListInqr(1);
    	}
    	event.stopPropagation();
    }

</script>
</head>
<body>
<%@include file="../include/header.jsp"%>
	<div class="main_div">
		<div class="navi_div">
			사용자 > 부서관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<form id="searchForm" name="searchForm">
					<label>활성상태</label>
					<select id="active_key" name="active_key" class="selectField">
						<option value="" selected="selected">전체</option>
						<option value="Y">활성화</option>
						<option value="N">비활성화</option>
					</select>
					<label>부서명</label>
					<input type="text" id="dept_nm_key" name="dept_nm_key" > &nbsp;
					<input type="button" id="dept_inqr_fbtn" class="btn btn-default btn-sm" value="검색">
				</form>
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<form id="delAll_form" name="delAll_form">
					<table summary="dept_list_tb" class="table table-hover">
						<colgroup>
							<col width="5%">
							<col width="35%">
							<col width="25%">
							<col width="15%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="checkall"></th>
								<th>부서명</th>
								<th>연락처</tH>
								<th>대표자명</tH>
								<tH>활성화여부</tH>
							</tr>
						</thead>
						<tbody class="dept_list">
							<c:choose>
								<c:when test="${not empty dept_list}">
									<c:forEach var="dept_list" items="${dept_list}">
										<tr class="open_detail" data_num="${dept_list.dept_cd}">
											<td>
												<input type="checkbox" class="del_point" name="del_code" value="${dept_list.dept_cd}">
											</td>
											<td>${dept_list.dept_nm}</td>
											<td>${dept_list.dept_num1}-${dept_list.dept_num2}-${dept_list.dept_num3}</td>
											<td>${dept_list.user_nm}</td>
											<td>
												<c:if test="${dept_list.active_flg eq 'Y'}">활성화</c:if>
												<c:if test="${dept_list.active_flg eq 'N'}">비활성화</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">등록된 부서가 존재하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</form>
			<!-- </div> -->
			<div class="paging_div">
				<div class="left">
					<input type="button" id="dept_add_fbtn" class="btn btn-primary btn-sm" value="추가">
					<input type="button" id="dept_del_fbtn" class="btn btn-primary btn-sm" value="삭제">
				</div>
				<div class="page" id="paging_div">	
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="PageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1}">
							<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/>  
							<a style="color: black;"> / ${page.endPageNum}</a>
							<a style="color: black;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="deptListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
							<a href="#" onclick="deptListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="deptListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="deptListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
						</c:when>
						<c:otherwise>
							<a href="#" onclick="deptListInqr('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" value="${pageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="deptListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
							<a href="#" onclick="deptListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="right">
					<input type="button" id="dept_exIm_fbtn" class="btn btn-primary btn-sm" value="excel입력">
					<input type="button" id="dept_exEx_fbtn" class="btn btn-primary btn-sm" value="excel출력">
				</div>
			</div>
			</div>
			<div id="dept_detail_div" class="list3_div">
				<form id="dept_detail_form" name="dept_detail_form">
					<table summary="dept_detail" class="table table-hover">
						<colgroup>
							<col width="35%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<th class="dc">부서코드</th>
								<td>
									<input type="text" id="dept_cd" name="dept_cd">
								</td>
							</tr>
							<tr>
								<th class="dc">부서명</th>
								<td>
									<input type="text" id="dept_nm" name="dept_nm">
								</td>
							</tr>
							<tr>
								<th class="dc">부서전화</th>
								<td>
									<select id="dept_num1" name="dept_num1">
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
									</select>
									<label>-</label>
									<input type="text" id="dept_num2" name="dept_num2" class="pNum">
									<label>-</label>
									<input type="text" id="dept_num3" name="dept_num3" class="pNum">
								</td>
							</tr>
							<tr>
								<th class="dc">팩스번호</th>
								<td>
									<select id="dept_fnum1" name="dept_fnum1">
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
									</select>
									<label>-</label>
									<input type="text" id="dept_fnum2" name="dept_fnum2" class="pNum">
									<label>-</label>
									<input type="text" id="dept_fnum3" name="dept_fnum3" class="pNum">
								</td>
							</tr>
							<tr>
								<th class="dc">활성화여부</th>
								<td>
									<input type="radio" class="active_flg" name="active_flg" value="Y"/>Y
									<input type="radio" class="active_flg" name="active_flg" value="N"/>N
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_div">
						<div class="right">
							<input type="button" id="dept_save_fbtn" class="btn btn-primary btn-sm" value="저장">
							<input type="button" id="dept_edit_nfbtn" class="btn btn-primary btn-sm" value="편집">
							<input type="button" id="dept_reset_nfbtn" class="btn btn-info btn-sm" value="초기화">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
<%@include file="../include/footer.jsp"%>