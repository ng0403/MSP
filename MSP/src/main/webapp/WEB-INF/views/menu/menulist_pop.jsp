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
<title>메뉴관리화면</title>
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
	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#menu_inqr_fbtn").click(function(){
			menuListInqrPop(1);
		})
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			var menu_cd = $(this).attr("data_num");
			var menu_nm = $(this).children().eq(0).val();
			$('#menu_cd').val(menu_cd);
			$('#menu_nm').val(menu_nm);
		})		
	})
	
	/*메뉴 리스트 출력및 페이징 처리 함수*/
	function menuListInqrPop(pageNum){
		var menu_nm_key = $("#menu_nm_key").val();
		
		$.post("/menu/search_list_Pop",{"menu_nm_key":menu_nm_key, "pageNum":pageNum}, function(data){
			$(".menu_list").html("");
			$(data.menu_list).each(function(){
 				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var up_menu_nm = this.up_menu_nm;
				menuListOutput(menu_cd, menu_nm, menu_url, up_menu_nm);
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
			alert("메뉴 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*메뉴 리스트 출력 함수*/
	function menuListOutput(menu_cd, menu_nm, menu_url, up_menu_nm){
		
		var menu_tr = $("<tr>");
		menu_tr.addClass("open_detail");
		menu_tr.attr("data_num",menu_cd);
		
		var menu_nm_td = $("<td>");
		menu_nm_td.html(menu_nm);
		
		var up_menu_nm_td = $("<td>");
		up_menu_nm_td.html(up_menu_nm);
		
		var menu_url_td = $("<td>");
		menu_url_td.html(menu_url);
		
		menu_tr.append(menu_nm_td).append(up_menu_nm_td).append(menu_url_td);
		
		$(".menu_list").append(menu_tr);
			
	}
	/*페이징 출력 함수*/
	function pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount){
		if(endPageNum == 1)
		{
			pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress='pageInputRepMenu(event);'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
			+"<a style='color:black; text-decoration: none;'>▶</a>"
		}
		else if(startPageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrtPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"pageInputRepMenu(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepMenu(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"pageInputRepMenu(event);\"/>"
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		$("#paging_div").append(pageContent);

	}
	// 검색 페이징 엔터키
    function pageInputRepMenu(event) {	
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
    				menuListInqr(pageNum);
    			}
    		}
    		event.stopPropagation();
    	});
    }
	
  //검색 엔터키
    function enterSearch(event) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		menuListInqr(1);
    	}
    	event.stopPropagation();
    }

</script>
</head>
<body>
	<div class="main_div">
		<div class="navi_div">
			마스터 > 메뉴관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<form id="searchForm" name="searchForm">
					<label>메뉴명</label>
					<input type="text" id="menu_nm_key" name="menu_nm_key" > &nbsp;
					<input type="button" id="menu_inqr_fbtn" class="btn btn-default btn-sm" value="검색">
				</form>
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
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
								<th>메뉴명</th>
								<th>상위메뉴명</th>
								<th>URL</th>
							</tr>
						</thead>
						<tbody class="menu_list">
							
						</tbody>
					</table>
				</form>
				<div class="paging_div">
					<div class="page" id="paging_div">	
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>