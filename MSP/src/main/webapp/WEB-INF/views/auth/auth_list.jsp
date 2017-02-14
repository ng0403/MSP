<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" /> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<title>Auth List</title>

<script type="text/javascript">
	
	$("#navisub11").show();
	$("#naviuser").css("font-weight", "bold");
	
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
			
			if (del_code == '') {
				alert("삭제할 대상을 선택하세요.");
				return false;
			}
	 
			if (confirm("정보를 삭제 하시겠습니까?")) {

				//삭제처리 후 다시 불러올 리스트 url
				$("form[name='delAllForm']").prop("action", "${ctx}/auth/auth_delete").submit();
			}
		}
		
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
			var keyword = $("#keyword").val();
			
			$.post("search_list",{"active_key":active_key, "keyword":keyword, "pageNum":pageNum}, function(data){
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
		
		// 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.)
		function authDetailInqr(auth_id)  {				
			//$.getJSON("codeDetail_list/"+code1, function(data){	// 와 같이 써도 똑같다. (get이냐 post냐의 차이)
			$.post("authDetail_list/"+auth_id, function(data){
				$(data).each(function() {
					var auth_id = this.auth_id;
					var auth_nm = this.auth_nm;
					var active_flg = this.active_flg;
					$(".active_flg:radio[value='Y']").attr("checked", true);
					$("#auth_id").val(auth_id);
					$("#auth_nm").val(auth_nm);
					$(".active_flg:radio[value='"+active_flg+"']").prop("checked", true);
				});
				
			});
		}	
		
		function authSave(){
			$.ajax({
				url:"insert",
				type:"post",
				contentType:"application/json; charset=UTF-8",/* "X-HTTP-Method-Override":"POST" */
				dataType:"text",
				data:JSON.stringify({
					auth_id:$("#auth_id").val(),
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
						deptListInqr(1);
					}
				}
			})
		}

		/*수정 요청 함수*/
		function authMdfy(){
			$.ajax({
				url:"update",
				type:"post",
				/* header:{
					"Content-type":"application/json","X-HTTP-Method-Override":"POST"
				}, */
				contentType:"application/json; charset=UTF-8",
				dataType:"text",
				data:JSON.stringify({
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
		
		function authAdd() {
			
			// 숨겨놓은 각각의 버튼을 보여준다.
			$("#auth_menu").show();
			$("#auth_user").show();
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
			<form name="searchForm"  method="post" action="${ctx}/auth/authlist">
					<select id="active_key" name="active_key" >
						<option value="" selected="selected">전체</option>
						<option value="Y">활성화</option>
						<option value="N">비활성화</option>
					</select>
					<span>권한명</span>
						<input id="keyword" type="text" name="keyword" class="int_search" value="${keyword}" onkeypress="authEnterSearch(event);" > 
						&nbsp;
					<button id="search_fbtn" class="btn btn-default btn-sm">검색</button>
			</form>
			<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/auth/authlist" id="authlistPagingForm" method="post">
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
			<form name="delAllForm" id ="delAllForm" method="post" action="${ctx}/auth_delete" >	
			<table id="mastertable" class="table table-hover">
				<thead>
					<tr style="width:100%;">
						<th><input id="checkall" name="checkAll" type="checkbox" onclick="allChk();"/></th>
						<td style="width:35%; font-weight: bold;">권한ID</td>
						<td style="width:30%; font-weight: bold;">권한명</td>
						<td style="width:20%; font-weight: bold;">활성화여부</td>
					</tr>
				</thead>
				<tbody id="usertbody" >
					<c:if test="${not empty list}">
					<c:forEach var="list" items="${list}" >
					<tr class="open_detail" data_num="${list.auth_id}" >
						<th scope="row"><input type="checkbox" class="ab" id="del_code" name="del_code" value="${list.auth_id}" ></th>
						<td style="width:30%; cursor: pointer;" class="user_name_tag" id = "${list.auth_id}"  >
							${list.auth_id}
						</td> 
						<td style="width:30%;" class="user_name_tag">${list.auth_nm}</td>
						<td>
							<c:if test="${list.active_flg eq 'Y'}">활성화</c:if>
							<c:if test="${list.active_flg eq 'N'}">비활성화</c:if>
						</td>
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${list.size() == 0}">
						<tr style="cursor: default; background-color: white;">
							<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
						</tr>
					</c:if>
				</tbody>
			</table>
			</form>
			
			<div class="btn01">
				<div class="left">
					<input type="button" id="auth_add_btn" class="btn btn-primary btn-sm" onclick="authAdd()" value="추가"/>
		  			<input type="button"  class="btn btn-primary btn-sm" onclick="deleteAction()" value="삭제"/>
				</div>
				
				<div class="page">
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="authPageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
							<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="authPageInput" value="${page.startPageNum}" onkeypress="authpageNumEnter(event);" style="width: 10%;"/>  
							<a style="color: black; text-decoration: none;"> / 1</a>
							<a style="color: black; text-decoration: none;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="authPageInput" value="${page.startPageNum}" onkeypress="authpageNumEnter(event);" style="width: 10%;"/>  
							<a href="#" onclick="authPaging('${page.endPageNum}');" id="pNum" > / ${page.endPageNum}</a>
							<a href="#" onclick="authPaging('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="authPaging('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" class="authPageInput" value="${page.endPageNum}" onkeypress="authpageNumEnter(event);" style="width: 10%;"/> 
							<a href="#" onclick="authPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
							<a style="color: black; text-decoration: none;"> ▶ </a>
						</c:when>
						<c:otherwise>
							<a href="#" onclick="authPaging('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" class="authPageInput" value="${pageNum}" onkeypress="(event);" style="width: 10%;"/>  
							<a href="#" onclick="authPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
							<a href="#" onclick="authPaging('${pageNum+1}');" id="pNum"> ▶ </a>
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
			<form method="post" id="joinform" action="authMasterAdd" >
				<table class="table table-hover">
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
					<input type="button" id="authDetail_resert_btn"class="btn btn-primary btn-sm" value="초기화" style="display:none" onclick="resertDetail()" />
	  				<input type="button" id="authDetail_save_btn"  class="btn btn-primary btn-sm" value="저장" style="display:none" onclick="saveDetail()"/>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>
<%@include file="../include/footer.jsp"%>
</body>
</html>
