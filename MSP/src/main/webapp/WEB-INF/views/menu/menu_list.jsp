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
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />
<script src="${ctx}/resources/common/js/common.js"></script>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" /> --%>
<title>메뉴관리화면</title>
<!-- <style type="text/css">
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
	
</style> -->
<script type="text/javascript">
	var menu_cd = "";
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
		//팝업찬 숨기기
		//$('#menuMask, #menuWindow').hide();
		
		/*테스트 입력제어*/
		pageReady(true);
		
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#menu_inqr_fbtn").click(function(){
			menuListInqr(1);
		})
		$("#menu_nm_key").keypress(function(){
			enterSearch(event, menuListInqr);
		})
		
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			menu_cd = $(this).attr("data_num");
			menuDetailInqr(menu_cd);
		})
		/*추가버튼 클릭 시 처리 이벤트*/
		$("#menu_add_nfbtn").click(function(){
			dataReset();
			pageReady(false);
			$("#menu_nm").focus();
			save_cd = "insert";
		})
		/*삭제버튼 클릭 시 처리 이벤트*/
		$("#menu_del_fbtn").click(function(){
			menuDel();
		})
		/*편집버튼 클릭 시 처리 이벤트*/
		$("#menu_edit_nfbtn").click(function(){
			pageReady(false);
			$("#menu_nm").focus();
			save_cd = "update";
		})
		/*초기화버튼 클릭 시 처리 이벤트*/
		$("#menu_reset_nfbtn").click(function(){
			dataReset();
			save_cd = "";
			pageReady(true);
		})
		/*저장버튼 클릭 시 처리 이벤트*/
		$("#menu_save_fbtn").click(function(){
			if(save_cd == "insert"){
				menuSave();
				pageReady(true);
			}else if(save_cd == "update"){
				menuMdfy();
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
		//메뉴검색 버튼 클릭시 이벤트
		$("#menuInqr_popup_fbtn").click(function(){
			menuListInqrPop(1);
			popByMask("menuMask", "menuWindow");
		})
		$(document).on("keypress","#pageInput",function(){
			var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
				pageInputRep(event, menuListInqr);
    		}
		})
		
	})
	
	/*메뉴 리스트 출력및 페이징 처리 함수*/
	function menuListInqr(pageNum){
		/* $("#searchForm").attr({
			"method":"post",
			"action":"list"
		})
		$("#searchForm").submit(); */
		var active_key = $("#active_key").val();
		var menu_nm_key = $("#menu_nm_key").val();
		
		$.post("/menu/search_list",{"active_key":active_key, "menu_nm_key":menu_nm_key, "pageNum":pageNum}, function(data){
			$(".menu_list").html("");
			$(data.menu_list).each(function(){
 				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var up_menu_nm = this.up_menu_nm;
				var active_flg = this.active_flg;
				menuListOutput(menu_cd, menu_nm, menu_url, up_menu_nm, active_flg);
			})
			paging(data,"#paging_div", "menuListInqr");
		}).fail(function(){
			alert("부서 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*메뉴 상세정보 요청 함수*/
	function menuDetailInqr(menu_cd){
		$.post("/menu/detail_list/"+menu_cd, function(data){
			$(data).each(function(){
				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var menu_level = this.menu_level;
				var up_menu_cd = this.up_menu_cd;
				var up_menu_nm = this.up_menu_nm;
				var active_flg = this.active_flg;
				detailOutput(menu_cd, menu_nm, menu_url, menu_level, up_menu_cd, up_menu_nm, active_flg);
			})
		}).fail(function(){
			alert("부서 상세정보를 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*메뉴 입력 요청 함수*/
	function menuSave(){
		$.ajax({
			url:"/menu/insert",
			type:"post",
			contentType:"application/json; charset=UTF-8",/* "X-HTTP-Method-Override":"POST" */
			dataType:"text",
			data:JSON.stringify({
				menu_nm:$("#menu_nm").val(),
				menu_url:$("#menu_url").val(),
				menu_level:$("#menu_level").val(),
				up_menu_cd:$("#up_menu_cd").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("메뉴 등록이 완료되었습니다.");
					dataReset();
					menuListInqr(1);
				}
			}
		})
	}
	/*메뉴 수정 요청 함수*/
	function menuMdfy(){
		$.ajax({
			url:"/menu/update",
			type:"post",
			/* header:{
				"Content-type":"application/json","X-HTTP-Method-Override":"POST"
			}, */
			contentType:"application/json; charset=UTF-8",
			dataType:"text",
			data:JSON.stringify({
				menu_cd:$("#menu_cd").val(),
				menu_nm:$("#menu_nm").val(),
				menu_url:$("#menu_url").val(),
				menu_level:$("#menu_level").val(),
				up_menu_cd:$("#up_menu_cd").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("메뉴 수정이 완료되었습니다.");
					dataReset();
					menuListInqr(1);
				}
			}
		})
	}
	/*메뉴 삭제 요청 함수*/
	function menuDel(){
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
				url:"/menu/delete/"+del_code,
				type:"post",
				contentType:"application/json; charset=UTF-8",
				dataType:"text",
				//data:JSON.stringify({del_code : del_code}),
				error:function(){
					alert("시스템 오류 입니다. 관리자에게 문의하세요.");
				},
				success:function(resultData){
					if(resultData == "SUCCESS"){
						alert("메뉴 삭제가 완료되었습니다.");
						dataReset();
						menuListInqr(1);
					}
				}
			})
		}
	}
	/*메뉴 리스트 출력 함수*/
	function menuListOutput(menu_cd, menu_nm, menu_url, up_menu_nm, active_flg){
		
		var menu_tr = $("<tr>");
		menu_tr.addClass("open_detail");
		menu_tr.attr("data_num",menu_cd);
		
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + menu_cd + "'>");
		
		var menu_nm_td = $("<td>");
		menu_nm_td.html(menu_nm);
		
		var up_menu_nm_td = $("<td>");
		up_menu_nm_td.html(up_menu_nm);
		
		var menu_url_td = $("<td>");
		menu_url_td.html(menu_url);
		
		var active_flg_td = $("<td>");
		if(active_flg=='Y'){
			active_flg_td.html("활성화");
		}else if(active_flg=='N'){
			active_flg_td.html("비활성화");
		}
		
		menu_tr.append(del_code_td).append(menu_nm_td).append(up_menu_nm_td).append(menu_url_td).append(active_flg_td);
				
		$(".menu_list").append(menu_tr);
			
	}
	
	/*메뉴 상세정보 출력 함수*/
	function detailOutput(menu_cd, menu_nm, menu_url, menu_level, up_menu_cd, up_menu_nm, active_flg){
		dataReset();
		
		$("#menu_cd").val(menu_cd);
		$("#menu_nm").val(menu_nm);
		$("#menu_url").val(menu_url);
		$("#menu_level").val(menu_level).prop("selected","selected");
		$("#up_menu_cd").val(up_menu_cd);
		$("#up_menu_nm").val(up_menu_nm);
		$(".active_flg:radio[value='"+active_flg+"']").prop("checked", "checked");
	}
	/*상세정보 초기화*/
	function dataReset(){
		$("#menu_cd").val("");
		$("#menu_nm").val("");
		$("#menu_url").val("");
		$("#menu_level").find("option:eq(0)").prop("selected","selected");
		$("#up_menu_cd").val("");
		$("#up_menu_nm").val("");
		$("input:radio[name='active_flg']").removeAttr("checked");
	}
	//페이지 처음 출력시 이벤트
	function pageReady(boolean){
		if(boolean == true){
			$("#menu_save_fbtn").hide();
			$("#menu_edit_nfbtn").show();
		}else if(boolean == false){
			$("#menu_save_fbtn").show();
			$("#menu_edit_nfbtn").hide();
		}
		$("#menu_cd").attr("readonly",true);
		$("#menu_nm").attr("readonly",boolean);
		$("#menu_url").attr("readonly",boolean);
		$("#menu_level").attr("disabled",boolean);
		$("#up_menu_cd").attr("readonly",true);
		$("#up_menu_nm").attr("readonly",true);
		$(".active_flg").attr("disabled",boolean);
	}
	
	

</script>
</head>
<body>
<%-- <%@include file="../include/header.jsp"%> --%>
	<div class="main_div">
		<div class="navi_div">
			마스터 > 메뉴관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<!-- <form id="searchForm" name="searchForm"> -->
					<label>활성상태</label>
					<select id="active_key" name="active_key" class="selectField">
						<option value="" selected="selected">전체</option>
						<option value="Y">활성화</option>
						<option value="N">비활성화</option>
					</select>
					<label>메뉴명</label>
					<input type="text" id="menu_nm_key" name="menu_nm_key" > &nbsp;
					<input type="button" id="menu_inqr_fbtn" class="btn btn-default btn-sm" value="검색">
				<!-- </form> -->
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<div class="table_div">
					<form id="delAll_form" name="delAll_form">
						<table summary="menu_list_tb" class="table table-hover">
							<colgroup>
								<col width="5%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="checkall"></th>
									<th>메뉴명</th>
									<th>상위메뉴명</th>
									<th>URL</tH>
									<tH>활성화여부</th>
								</tr>
							</thead>
							<tbody class="menu_list">
								<c:choose>
									<c:when test="${not empty menu_list}">
										<c:forEach var="menu_list" items="${menu_list}">
											<tr class="open_detail" data_num="${menu_list.menu_cd}">
												<td>
													<input type="checkbox" class="del_point" name="del_code" value="${menu_list.menu_cd}">
												</td>
												<td>${menu_list.menu_nm}</td>
												<td>${menu_list.up_menu_nm}</td>
												<td>${menu_list.menu_url}</td>
												<td>
													<c:if test="${menu_list.active_flg eq 'Y'}">활성화</c:if>
													<c:if test="${menu_list.active_flg eq 'N'}">비활성화</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5">등록된 메뉴가 존재하지 않습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</form>
				</div>
			<div class="paging_div">
				<div class="left">
					<input type="button" id="menu_add_nfbtn" class="btn btn-primary btn-sm" value="추가">
					<input type="button" id="menu_del_fbtn" class="btn btn-primary btn-sm" value="삭제">
				</div>
				<div class="page" id="paging_div">	
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="PageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1}">
							<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/>  
							<a style="color: black;"> / ${page.endPageNum}</a>
							<a style="color: black;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="menuListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
							<a href="#" onclick="menuListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="menuListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="menuListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
						</c:when>
						<c:otherwise>
							<a href="#" onclick="menuListInqr('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" value="${pageNum}" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="menuListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
							<a href="#" onclick="menuListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="right">
					<input type="button" id="menu_exIm_fbtn" class="btn btn-primary btn-sm" value="excel입력">
					<input type="button" id="menu_exEx_fbtn" class="btn btn-primary btn-sm" value="excel출력">
				</div>
			</div>
			</div>
			<div id="menu_detail_div" class="list3_div">
				<form id="menu_detail_form" name="menu_detail_form">
					<table summary="menu_detail" class="table table-hover">
						<colgroup>
							<col width="35%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<th class="dc">메뉴ID</th>
								<td>
									<input type="text" id="menu_cd" name="menu_cd">
								</td>
							</tr>
							<tr>
								<th class="dc">메뉴명</th>
								<td>
									<input type="text" id="menu_nm" name="menu_nm">
								</td>
							</tr>
							<tr>
								<th class="dc">메뉴URL</th>
								<td>
									<input type="text" id="menu_url" name="menu_url">
								</td>
							</tr>
							<tr>
								<th class="dc">메뉴레벨</th>
								<td>
									<select id="menu_level" name="menu_level">
										<option value="0">메뉴 계층을 선택해주세요.</option>
										<c:choose>
											<c:when test="${not empty level_list}">
												<c:forEach var="level_list" items="${level_list}">
													<option value="${level_list.code1 }">${level_list.code_txt }</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option>공통코드 목록이 존재하지 않습니다.</option>
											</c:otherwise>
										</c:choose>
									</select>
								</td>
							</tr>
							<tr>
								<th class="dc">상위메뉴ID</th>
								<td>
									<input type="text" id="up_menu_cd" name="up_menu_cd">
									<input type="button" id="menuInqr_popup_fbtn" class="btn btn-default btn-sm" value="메뉴검색">
								</td>
							</tr>
							<tr>
								<th class="dc">상위메뉴명</th>
								<td>
									<input type="text" id="up_menu_nm" name="up_menu_nm">
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
							<input type="button" id="menu_save_fbtn" class="btn btn-primary btn-sm" value="저장">
							<input type="button" id="menu_edit_nfbtn" class="btn btn-primary btn-sm" value="편집">
							<input type="button" id="menu_reset_nfbtn" class="btn btn-info btn-sm" value="초기화">
						</div>
					</div>
				</form>
			</div>
		</div>
		<div id="viewLoadingImg" style="display: none;">
			<img src="${ctx}/resources/image/viewLoading.gif">
		</div> 
		<jsp:include page="../menu/menulist_pop.jsp"/>
	</div>
</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>