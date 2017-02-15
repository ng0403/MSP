<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>부서관리화면</title>

<script type="text/javascript">
	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#dept_inqr_fbtn").click(function(){
			deptListInqrPop(1);
		})
		
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			var dept_cd_pop = $(this).attr("dept_cd_pop");
			var dept_nm_pop = $(this).attr("dept_nm_pop");
			$('#dept_cd').val(dept_cd_pop);
			$('#dept_nm').val(dept_nm_pop);
			//deptDetailInqr(dept_cd);
			hideModal();
		})
	})
	/*부서 리스트 출력및 페이징 처리 함수*/
	function deptListInqrPop(pageNum){

		var dept_nm_key = $("#dept_nm_key").val();
		
		$.post("/dept/search_list_pop",{"dept_nm_key":dept_nm_key, "pageNum":pageNum}, function(data){
			$(".dept_list").html("");
			$(data.dept_list).each(function(){
 				var dept_cd = this.dept_cd;
				var dept_nm = this.dept_nm;
				var dept_num1 = this.dept_num1;
				var dept_num2 = this.dept_num2;
				var dept_num3 = this.dept_num3;
				var user_nm = this.user_nm;
				deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm);
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
	/*부서 리스트 출력 함수*/
	function deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm, active_flg){
		
		var dept_tr = $("<tr>");
		dept_tr.addClass("open_detail");
		dept_tr.attr("dept_cd_pop",dept_cd);
		dept_tr.attr("dept_nm_pop",dept_nm);
		
		
		var dept_nm_td = $("<td>");
		dept_nm_td.html(dept_nm);
		
		var dept_num_td = $("<td>");
		dept_num_td.html(dept_num1 + "-" + dept_num2 + "-" + dept_num3);
		
		var user_nm_td = $("<td>");
		user_nm_td.html(user_nm);
		
		dept_tr.append(dept_nm_td).append(dept_num_td).append(user_nm_td);
				
		$(".dept_list").append(dept_tr);
			
	}
	/*페이징 출력 함수*/
	function pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount){
		if(endPageNum == 1)
		{
			pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 10%; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress='pageInputRepDept(event);'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
		}
		else if(startPageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 10%; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrtPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 10%; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 10%; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 10%; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"pageInputRepDept(event);\"/>"
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=deptListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		$("#paging_div").append(pageContent);

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
    				deptListInqrPop(pageNum);
    			}
    		}
    		event.stopPropagation();
    	});
    }
	
/*    //검색 엔터키
    function enterSearch(event) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		deptListInqrPop(1);
    	}
    	event.stopPropagation();
    }  */

</script>
</head>
<body>
	<div class="main_div" style=" background: beige;">
		<div class="navi_div">
			부서검색
		</div>
		<div class="search_div">
			<div class="search2_div">
				<form id="searchForm" name="searchForm">
					<label>부서명</label>
					<input type="text" id="dept_nm_key" name="dept_nm_key" onkeypress="deptListInqrPop(1);"> &nbsp;
					<input type="button" id="dept_inqr_fbtn" class="search_btn" value="검색">
				</form>
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<form id="delAll_form" name="delAll_form">
					<table summary="dept_list_tb" class="table table-bordered" style ="width: 100%;">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="40%">
						</colgroup>
						<thead>
							<tr style="width: 100%;">
								<th>부서명</th>
								<th>연락처</th>
								<th>대표자명</th>
							</tr>
						</thead>
						<tbody class="dept_list">

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