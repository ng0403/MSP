<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" /> 
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>Auth List</title>

<script type="text/javascript">
	
	var dept_cd = "";
	var save_cd = "";

	$(function(){

		pageReady(true);
		
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#auth_inqr_fbtn").click(function(){
			authListInqr(1);
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
		$("#allCheck").on("click", function(){
		      if( $("#allCheck").is(':checked') ){
		        $("input[name=del_code]").prop("checked", true);
		      }else{
		        $("input[name=del_code]").prop("checked", false);
		      }
		})
	})
	
	//페이지 엔터키 기능
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
		}
		
		//조회 버튼기능
		function auth_goSearch(){
			
			var keyword = $("#keyword").val();
						
			$("#searchForm").submit();
				
		}
		
		/*리스트 출력및 페이징 처리 함수*/
		function authListInqr(pageNum){

			var active_key = $("#active_key").val();
			var keyword    = $("#keyword").val();
			
			$.post("/auth/search_list",{"active_key":active_key, "keyword":keyword, "pageNum":pageNum}, function(data){
				$(".auth_list").html("");
				$(data.auth_list).each(function(){
	 				var auth_id = this.auth_id;
					var auth_nm = this.auth_nm;
					var active_flg = this.active_flg;
					authListOutput(auth_id, auth_nm, active_flg);
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
							alert("부서 수정이 완료되었습니다.");
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
		
		
</script>
</head>
<body>
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<%@include file="../include/header.jsp" %>
<!--Main_Div  -->
<div class="main_div">

	<!-- Navigation Div -->
	<div class="navi_div">권한관리</div>
		
	<!-- Search Cover Div -->
	<div class="search_div">
		<div class="search2_div">
			<form id="searchForm" name="searchForm">
					<label>활성상태</label>
					<select id="active_key" name="active_key" class="selectField">
						<option value="" selected="selected">전체</option>
						<option value="Y">활성화</option>
						<option value="N">비활성화</option>
					</select>
					<label>권한명</label>&nbsp;
					<input type="text" id="keyword" name="keyword" class="int_search"> 
					&nbsp;&nbsp;
					<input type="button" id="auth_inqr_fbtn" class="btn btn-default btn-sm" value="검색">
			</form>
			<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/auth/list" id="authlistPagingForm" method="post">
				<input type="hidden" name="active_key" value="${active_key}"/>
				<input type="hidden" name="keyword" value="${keyword}"/>
			</form>
			
		</div>
		<div class="search3_div">
			
			
		</div>
	</div>
	
	<!-- List Cover Div -->
	<div class="list_div">
		<div class="list2_div">
			<form name="delAllForm" id ="delAllForm" >	
			<table summary="auth_list_tb" class="table table-hover">
				<thead>
					<tr style="width:100%;">
						<th><input type="checkbox" id="checkall" ></th>
						<td style="width:35%; font-weight: bold;">권한ID</td>
						<td style="width:30%; font-weight: bold;">권한명</td>
						<td style="width:20%; font-weight: bold;">활성화여부</td>
					</tr>
				</thead>
				<tbody class="auth_list" >
					<c:choose>
						<c:when test="${not empty auth_list}">
							<c:forEach var="auth_list" items="${auth_list}" >
								<tr class="open_detail" data_num="${auth_list.auth_id}" >
									<td>
										<input type="checkbox" class="del_point" name="del_code" value="${auth_list.auth_id}">
									</td>
									<td style="width:30%; cursor: pointer;">
										${auth_list.auth_id}
									</td> 
									<td style="width:30%;">${auth_list.auth_nm}</td>
									<td>
										<c:if test="${auth_list.active_flg eq 'Y'}">활성화</c:if>
										<c:if test="${auth_list.active_flg eq 'N'}">비활성화</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
					<c:if test="${auth_list.size() == 0}">
						<tr style="cursor: default; background-color: white;">
							<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
						</tr>
					</c:if>
				</tbody>
			</table>
			</form>
			
			<div class="btn01">
				<div class="left">
					<input type="button" id="auth_add_fbtn" class="btn btn-primary btn-sm" value="추가"/>
		  			<input type="button" id="auth_del_fbtn" class="btn btn-primary btn-sm" value="삭제"/>
				</div>
				
				<div class="page" id="paging_div">	
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="PageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1}">
							<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;"/>  
							<a style="color: black;"> / ${page.endPageNum}</a>
							<a style="color: black;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;"/> /&nbsp;
							<a href="#" onclick="authListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
							<a href="#" onclick="authListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="authListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;"/> /&nbsp;
							<a href="#" onclick="authListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
						</c:when>
						<c:otherwise>
							<a href="#" onclick="authListInqr('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" value="${pageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;" /> /&nbsp;
							<a href="#" onclick="authListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
							<a href="#" onclick="authListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div class="right">
					<input type="button" id="excelImport" class="btn btn-info btn-sm" value="excel입력"/>
		  			<input type="button" id="excelExport" class="btn btn-info btn-sm" value="excel출력"/>
				</div>
				
			</div>
		</div>
		
		
		<div class="list3_div">
			<form id="auth_detail_form" name="auth_detail_form">
				<table summary="auth_detail" class="table table-hover">
					<tbody id="tbody1">
						<tr>
							<th style="font-weight: bold;">권한ID</th>
							<td><input type="text" style="padding-left: 6px;" name="auth_id" id="auth_id" class="txt" value="${auth_id}" readonly="readonly" ></input></td>
						</tr>
						<tr>
							<th style="font-weight: bold;">권한명</th>
							<td><input type="text" style="padding-left: 6px;" name="auth_nm" id="auth_nm" class="txt" value="${auth_nm}"></input></td>
						</tr>
						<tr>
							<th style="font-weight: bold;">활성화여부</th>
							<td>
								<input type="radio" class="active_flg" name="active_flg" value="Y"/>Y &nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" class="active_flg" name="active_flg" value="N"/>N
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			
			<div class="btn02">
				<input type="button" id="auth_menu" class="btn btn-primary btn-sm" value="메뉴권한" style="display:none" >
				<input type="button" id="auth_user" class="btn btn-primary btn-sm" value="사용자권한" style="display:none" >
				
				<div class="right">
					<input type="button" id="auth_reset_nfbtn" class="btn btn-primary btn-sm" value="초기화" style="display:none"  />
					<input type="button" id="auth_edit_nfbtn"  class="btn btn-primary btn-sm" value="편집" style="display:none" />
	  				<input type="button" id="auth_save_fbtn"   class="btn btn-primary btn-sm" value="저장" style="display:none" />
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>
<%@include file="../include/footer.jsp"%>
</body>
</html>
