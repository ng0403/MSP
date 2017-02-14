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
		/*검색조건 엔터 시 처리 이벤트*/
		$("#dept_nm_key").keypress(function(){
			enterSearch(event);
		})
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			dept_cd = $(this).attr("data_num");
			//deptDetailInqr(dept_cd);
		})
		/*초기화버튼 클릭 시 처리 이벤트*/
		$("#dept_reset_nfbtn").click(function(){
			dataReset();
			save_cd = "";
		})
		/*저장버튼 클릭 시 처리 이벤트*/
		$("#dept_save_fbtn").click(function(){
			if(save_cd == "insert"){
				deptSave();
			}else if(save_cd == "update"){
				deptMdfy();
			}
		})
		
	})
	/*부서 리스트 출력및 페이징 처리 함수*/
	function deptListInqrPop(pageNum){
		/* $("#searchForm").attr({
			"method":"post",
			"action":"list"
		})
		$("#searchForm").submit(); */
		var active_key = $("#active_key").val();
		var dept_nm_key = $("#dept_nm_key").val();
		
		$.post("search_list_pop",{"dept_nm_key":dept_nm_key, "pageNum":pageNum}, function(data){
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
		dept_tr.attr("data_num",dept_cd);
		
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + dept_cd + "'>");
		
		var dept_nm_td = $("<td>");
		dept_nm_td.html(dept_nm);
		
		var dept_num_td = $("<td>");
		dept_num_td.html(dept_num1 + "-" + dept_num2 + "-" + dept_num3);
		
		var user_nm_td = $("<td>");
		user_nm_td.html(user_nm);
		
		dept_tr.append(del_code_td).append(dept_nm_td).append(dept_num_td).append(user_nm_td);
				
		$(".dept_list").append(dept_tr);
			
	}
	/*페이징 출력 함수*/
	function pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount){
		if(endPageNum == 1)
		{
			pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress='pageInputRepDept(event);'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
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
	/* function detailOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, dept_fnum1, dept_fnum2, dept_fnum3, active_flg){
		dataReset();
		
		$("#dept_cd").val(dept_cd);
		$("#dept_nm").val(dept_nm);
		$("#dept_num1").val(dept_num1).attr("selected","selected");
		$("#dept_num2").val(dept_num2);
		$("#dept_num3").val(dept_num3);
		$("#dept_fnum1").val(dept_fnum1).attr("selected","selected");
		$("#dept_fnum2").val(dept_fnum2);
		$("#dept_fnum3").val(dept_fnum3);
	} */
	/*상세정보 초기화*/
	/* function dataReset(){
		$("#dept_cd").val("");
		$("#dept_nm").val("");
		$("#dept_num1").index(0);
		$("#dept_num2").val("");
		$("#dept_num3").val("");
		$("#dept_fnum1").index(0);
		$("#dept_fnum2").val("");
		$("#dept_fnum3").val("");
	} */
	
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
	
  //검색 엔터키
    function enterSearch(event) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		deptListInqrPop(1);
    	}
    	event.stopPropagation();
    }

</script>
</head>
<body>
	<div class="main_div">
		<div class="navi_div">
			사용자 > 부서관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<form id="searchForm" name="searchForm">
					<label>부서명</label>
					<input type="text" id="dept_nm_key" name="dept_nm_key" > &nbsp;
					<input type="button" id="dept_inqr_fbtn" class="search_btn" value="검색">
				</form>
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<form id="delAll_form" name="delAll_form">
					<table summary="dept_list_tb" class="table table-bordered" style ="width: 45%">
						<colgroup>
							<col width="10%">
							<col width="35%">
							<col width="20%">
							<col width="15%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<td>부서명</td>
								<td>연락처</td>
								<td>대표자명</td>
							</tr>
						</thead>
						<tbody class="dept_list">
							<%-- <c:choose>
								<c:when test="${not empty dept_list}">
									<c:forEach var="dept_list" items="${dept_list}">
										<tr class="open_detail" data_num="${dept_list.dept_cd}">
											<td>${dept_list.dept_nm}</td>
											<td>${dept_list.dept_num1}-${dept_list.dept_num2}-${dept_list.dept_num3}</td>
											<td>${dept_list.user_nm}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">등록된 부서가 존재하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose> --%>
						</tbody>
					</table>
				</form>
			</div>
			<div class="paging2_div">
				<div class="paging_div" id="paging_div">	
					<%-- <input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
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
					</c:choose> --%>
				</div>
				<input type="button" id="dept_add_fbtn" class="func_btn" value="추가">
				<input type="button" id="dept_del_fbtn" class="func_btn" value="삭제">
			</div>
		</div>
	</div>
</body>
</html>