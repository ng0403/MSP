<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>     
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/mps/userJS/user_list_js.js"></script>
<script src="${ctx}/resources/common/js/mps/userJS/user_tab_js.js"></script>
<script src="${ctx}/resources/common/js/common.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/userCSS/userTabCSS.css" type="text/css" /> 
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/userCSS/userCSS.css" type="text/css" />   
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" /> 
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" /> 
<script src="${ctx}/resources/common/js/common.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>리스트</title>
<script type="text/javascript">
$(document).ready(function() { 
	 <c:if test="${result=='1'}" var = "result"> 
			window.close();
			opener.parent.location.href = "userlist";
	 </c:if>
	
// 	$('#dept_pop_div').hide();
// 	$('#Ddept_pop_div').hide();
	$("#navisub11").show();
	$("#naviuser").css("font-weight", "bold");
	
// 	var menu_cd = "";
// 	var save_cd = "";
	

	/*부서명 클릭 시 상세정보 출력 이벤트*/
	$(document).on("click", ".open_detail", function(){
		var user_id_pop = $(this).attr("user_id_pop");
		$('#user_id').val(user_id_pop);
// 		onPopup(user_id_pop);
	})
	
	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#search_fbtn").click(function(){
			userListInqr(1);
		})

		
		/*삭제버튼 클릭 시 처리 이벤트*/
		$("#iuserDelBtn").click(function(){
			if (confirm("정보를 삭제 하시겠습니까?")) {
				userDel();
			}
		})
		
		
// 		/* 체크박스 전체선택, 전체해제 */
// 		$("#checkall").on("click", function(){
// 		      if( $("#checkall").is(':checked') ){
// 		        $("input[name=del_code]").prop("checked", true);
// 		      }else{
// 		        $("input[name=del_code]").prop("checked", false);
// 		      }
// 		})
		
		//사용자상세정보 버튼 클릭시 이벤트
		$("#userAdd_fbtn").click(function(){
			popByMask("userMask", "userWindow");
		})
	})
});
</script>

<style type="text/css">

.list_div {
	margin: auto;

}

.thth {
	text-align: center;
}

.idUser{
	text-align: left;
	padding-left: 50px;
}

#userAdd_fbtn, #ExcelImpoartPopBtn {
	margin-right: 5px;
}

</style>

</head>
<body>

<!--Main_Div  -->
<div class="main_div">
	<!-- Navigation Div -->
	<div class="navi_div" style="margin-bottom: 1%; margin-top: 1%;">■ 사용자관리</div>
	
	<!-- Search1 Cover Div -->
	<div class="">
		
		<!-- Search1 Div  -->
		<div class="search1_div" style=" margin-left: 1%; margin-bottom: 1%;">
				<select id="active_key" name="active_key" class="selectField" >
					<option value="" selected="selected">-검색조건-</option>
					<option value="user_id_sch">사용자ID</option>
					<option value="user_nm_sch">사용자명</option>
					<option value="dept_nm_sch">부서명</option>
				</select>	
				<input type="text" id="user_sch_key" name="uesr_sch_key" > &nbsp;
				<input type="button" id="search_fbtn" class="btn btn-default btn-sm" value="검색"/>
			<!-- 페이징 전용 폼 -->
			<form action="${ctx}/user/userInqr" id="userlistExcelForm" method="post"></form>
		</div>
	</div>

	<!-- List1 Cover Div -->
	<div class="list_div" >
		<!-- List1 Div -->
		<div class="list1_div" style=" margin-left: 1%;">
		<div class="table_div">
			<form id="delAll_form" name="delAll_form">
			<table summary="menu_list_tb" class="table table-hover" style="width:100%; margin:auto">
					<colgroup>
						<col width="5%">
						<col width="13%">
						<col width="12%">
						<col width="12%">
						<col width="18%">
						<col width="20%">
						<col width="10%">
						<col width="10%">
					</colgroup>  
					<thead>
						<tr >
							<th id="checkTh" class="thth"><input type="checkbox" id="checkall"></th>
							<th class="thth">사용자ID</th>
							<th class="thth">사용자명</th>
							<th class="thth">부서명</tH>
							<th class="thth">이메일</th>
							<th class="thth">연락처</th>
							<th class="thth">권한</th>
							<th class="thth">상태</th>
						</tr>
					</thead>
					<tbody class="user_list">
								<c:choose>
									<c:when test="${not empty user_list}">
										<c:forEach var="user_list" items="${user_list}">
											<tr class="open_detail" data_num="${user_list.USER_ID}">
												<td id="checkTd" class="thth">
													<input type="checkbox" class="del_point" name="del_code" value="${user_list.USER_ID}">
<%-- 													<input type="hidden" id="user_id" value="${user_list.USER_ID}"> --%>
												</td>
												<td onclick="onPopup(this.id);" name="user_id" id="${user_list.USER_ID}" > ${user_list.USER_ID}</td>
												<td>${user_list.USER_NM}</td>
												<td>${user_list.DEPT_NM}</td>
												<td>${user_list.EMAIL_ID}@${user_list.EMAIL_DOMAIN}</td>
												<td class="thth">${user_list.CPHONE_NUM1}-${user_list.CPHONE_NUM2}-${user_list.CPHONE_NUM3}</td>
												<td>${user_list.AUTH_NM}</td>
<!-- 												<td> -->
<%-- 													<c:if test="${user_list.AUTH_NM eq NULL}">권한없음.</c:if> --%>
<%-- 													<c:if test="${user_list.AUTH_NM != NULL}">${user_list.AUTH_NM}</c:if></td> --%>
<!-- 												<td> -->
												<td class="thth">
													<c:if test="${user_list.ACTIVE_FLG eq 'Y'}">활성화</c:if>
													<c:if test="${user_list.ACTIVE_FLG eq 'N'}">비활성화</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5">사용자가 존재하지 않습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>			
		</form>
		</div>
		</div>
	<!-- Paging Div -->
	<div id="viewLoadingImg" style="display: none;">
			<img src="${ctx}/resources/image/viewLoading.gif">
	</div> 
	<div class="paging_div">
				<div class="left">
					<input type="button" id="userAdd_fbtn" onclick="userTabOpen()"  class="btn btn-primary btn-sm"  value="추가"style="float: left;" />
					<input type="button" id="iuserDelBtn"  class="btn btn-primary btn-sm"  value="삭제" style="float: left;"  />
				</div>
				<div class="page" id="paging_div">	
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="PageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1}">
							<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, userListInqr);" style='width: 50px; padding: 3px; '/>  
							<a style="color: black;"> / ${page.endPageNum}</a>
							<a style="color: black;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, userListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="userListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
							<a href="#" onclick="userListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="userListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRep(event, userListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="userListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
						</c:when>
						<c:otherwise>
							<a href="#" onclick="userListInqr('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" value="${pageNum}" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="userListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
							<a href="#" onclick="userListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="right">
					<input type="button" value="엑셀출력"  class="btn btn-primary btn-sm"  onclick="download_list_Excel('userlistExcelForm');" style="float: right;">
			        <input type="button" id="ExcelImpoartPopBtn"  class="btn btn-primary btn-sm"  onclick="excelImportOpen();" value="엑셀등록" style="float: right;"> 
					
				</div>
			</div>
	</div>
		<jsp:include page="../user/user_tab.jsp"></jsp:include>
		<jsp:include page="../user/user_detail.jsp"></jsp:include>
<!-- 	<div id="dept_pop_div" style="font-size:11.5px;"> -->
		<jsp:include page="../dept/deptlist_pop.jsp"></jsp:include>
<!-- 	</div> -->

</div>

</body>
</html>
