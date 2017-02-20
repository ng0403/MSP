<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>권한 등록</title>
<script type="text/javascript">
var save_cd = "";

$(function(){
	/*검색버튼 클릭 시 처리 이벤트*/
	$("#auth_inqr_fbtn").click(function(){
		authListInqrPop(1);
	})
	
	/*검색창 엔터 시 처리 이벤트*/
	$("#keyword_pop").keypress(function(){
		enterSearchPop(event);
	})
	
	//검은 막을 눌렀을 때
	$('#authMask').click(function() {
		$(this).hide();
		$('#authWindow').hide();
	});
	/*부서명 클릭 시 상세정보 출력 이벤트*/
	$(document).on("click", ".open_authList", function(){
		if(save_cd == "insert"||save_cd == "update"){
			var auth_id = $(this).attr("data_num");
			var auth_nm = $(this).children("td").eq(1).html();
			$('#auth_id').val(auth_id);
			$('#auth_nm').val(auth_nm);
			$('.auth_list_pop, #paging_authPop_div').html("");
			$('#authMask, #authWindow').hide();
		}
	})
	//닫기 버튼을 눌렀을 때
	$('#authInpr_close_nfbtn').click(function(e) {
		$('.auth_list_pop, #paging_authPop_div').html("");
		$('#authMask, #authWindow').hide();
	});
})

	// 검색 페이징 엔터키
    function authPageInputRepPop(event) {	
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
    				authListInqrPop(pageNum);
    			}
    		}
    		event.stopPropagation();
    	});
    }
	
  	//검색 엔터키
    function authEnterSearchPop(event) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		authListInqrPop(1);
    	}
    	event.stopPropagation();
    }
	
	/*리스트 출력및 페이징 처리 함수*/
	function authListInqrPop(pageNum){
		var keyword    = $("#keyword_pop").val();
		viewLoadingShow();
		$.post("/auth/search_list_pop",{"keyword":keyword, "pageNum":pageNum}, function(data){
			$(".auth_list_pop").html("");
			$(data.auth_list).each(function(){
 				var auth_id = this.auth_id;
				var auth_nm = this.auth_nm;
				authListPopOutput(auth_id, auth_nm);
			})
			$("#paging_authPop_div").html("");
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
				authPagePopOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount);
			})
		}).fail(function(){
			alert("목록을 불러오는데 실패하였습니다.")
		})
		viewLoadingHide();
	}
		
	/* 리스트 출력 함수 */
	function authListPopOutput(auth_id, auth_nm){
	
		var auth_tr = $("<tr>");
		auth_tr.addClass("open_authList");
		auth_tr.attr("data_num",auth_id);

		var auth_id_td = $("<td>");
		auth_id_td.html(auth_id);
		
		var auth_nm_td = $("<td>");
		auth_nm_td.html(auth_nm);
				
		auth_tr.append(auth_id_td).append(auth_nm_td);
				
		$(".auth_list_pop").append(auth_tr);
			
	}
	
	/*페이징 출력 함수*/
	function authPagePopOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount){
		if(endPageNum == 1)
		{
			pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress='pageInputRepAuth(event);'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
			+"<a style='color:black; text-decoration: none;'>▶</a>"
		}
		else if(startPageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepAuth(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=authListInqrtPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"pageInputRepAuth(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepAuth(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"pageInputRepAuth(event);\"/>"
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=authListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		$("#paging_authPop_div").append(pageContent);

	}
	

</script>
</head>
<body>
<div id="authMask" class="mask_div"></div>
<div class="pop_main_div" id="authWindow">
	<!-- Navigation Div -->
	<div class="navi_div">권한관리
		<div>
			<input type="button" id="authInpr_close_nfbtn" class="func_btn" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
		</div>
	</div>
	<div class="block_div"></div><div class="block_div"></div>
	<!-- Search Cover Div -->
	<div class="search_div">
		<div class="modal_search_div">
			<!-- <form id="searchForm" name="searchForm"> -->
				<label>권한명</label>&nbsp;
				<input type="text" id="keyword_pop" name="keyword_pop" class="int_search"> 
				&nbsp;&nbsp;
				<input type="button" id="authInqr_pop_fbtn" class="btn btn-default btn-sm" value="검색">
			<!-- </form> -->
		</div>
	</div>
	
	<!-- List Cover Div -->
	<div class="list_div">
		<div class="modal_list_div">
			<table summary="auth_list_tb" class="table table-hover">
				<colgroup>
					<col width="50%">
					<col width="50%">
				</colgroup>
				<thead>
					<tr>
						<td>권한ID</td>
						<td>권한명</td>
					</tr>
				</thead>
				<tbody class="auth_list_pop" >
					
				</tbody>
			</table>
			<div class="modal_paging_div">
				<div class="page" id="paging_authPop_div">	
				
				</div>
			</div>
		</div>
	</div>
</div></body>
</html>