<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<c:set var="SessionID" value="${sessionScope.user_id}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%-- <script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> --%>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<%-- <script src="${ctx}/resources/common/js/common.js"></script>  --%>
<%-- <script src="${ctx}/resources/common/js/mps/authJS/auth_list.js"></script> --%>

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">  -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/mps/AuthCSS/authCSS.css" type="text/css" />  --%>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" /> --%>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" /> --%>

<title>Auth List</title>
</head>
<body>
<!--Main_Div  -->
<div class="main_div">

	<!-- Navigation Div -->
	<div class="navi_div">권한관리</div>
		
	<!-- Search Cover Div -->
	<div class="search_div">
		<div class="search2_div">
<!-- 			<label>활성상태</label> -->
<!-- 			<select id="active_key" name="active_key" class="selectField"> -->
<!-- 				<option value="" selected="selected">전체</option> -->
<!-- 				<option value="Y">활성화</option> -->
<!-- 				<option value="N">비활성화</option> -->
<!-- 			</select> -->
			<label>권한명</label>&nbsp;
			<input type="text" id="keyword" name="keyword" class="inputTxt" > &nbsp;&nbsp;
			<input type="button" id="auth_inqr_fbtn" class="btn btn-primary btn-sm" value="검색">
			
			<div class="excelBtn">
				<input type="button" id="excelExportPopBtn"  class="btn btn-info btn-sm" onclick="download_list_Excel('authListExcelForm');"  value="엑셀출력" style="float: right;">
		        <input type="button" id="ExcelImpoartPopBtn" class="btn btn-info btn-sm" onclick="excelImportOpen();" value="엑셀등록" style="float: right;"> 
			</div>
			
			<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/auth/authInqr" id="authlistPagingForm" method="post">
				<input type="hidden" name="active_key" value="${active_key}"/>
				<input type="hidden" name="keyword" value="${keyword}"/>
			</form>
			<form action="${ctx}/auth/authInqr" id="authListExcelForm" method="post"></form>
		</div>
		
		<div class="search3_div"></div>
		
	</div>
	
	<!-- List Cover Div -->
	<div class="list_div">
		<div class="list2_div">
			
			<div class="table_div">
				<form name="delAllForm" id ="delAllForm" >	
				<table summary="auth_list_tb" class="table table-hover">
					<thead>
						<tr style="width:100%;">
							<th><input type="checkbox" id="checkall" ></th>
							<th align="center" >권한ID</th>
							<th align="center" >권한명</th>
							<th align="center" >활성화여부</th>
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
										<td style="width:30%;" id="authNm">${auth_list.auth_nm}</td>
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
			</div>
			<div class="paging_div">
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
			</div>
		</div>
		
		
		<div id="dept_detail_div" class="list3_div">
			<h5 id="h5">권한 상세</h5>
			<form id="auth_detail_form" name="auth_detail_form">
				<table summary="auth_detail" class="table table-hover">
					<tbody id="tbody1">
						<tr>
							<th style="font-weight: bold;">권한ID</th>
							<td><input type="text" style="padding-left: 6px;" name="auth_id" id="auth_id" class="form-control"  value="${auth_id}" readonly="readonly" ></input></td>
						</tr>
						<tr>
							<th style="font-weight: bold;">권한명</th>
							<td><input type="text" style="padding-left: 6px;" name="auth_nm" id="auth_nm" class="form-control"  value="${auth_nm}"></input></td>
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
			
			<div class="btn_div">
				<input type="button" id="auth_menu" class="btn btn-default btn-sm" value="메뉴권한" style="display:none" onclick="location.href='${ctx}/menuAuth/menuAuthInqr'" >
				<input type="button" id="auth_user" class="btn btn-default btn-sm" value="사용자권한" style="display:none" onclick="location.href='${ctx}/userAuth/view'" >
				
				<div class="right">
					<input type="button" id="auth_reset_nfbtn" class="btn btn-default btn-sm" value="초기화" style="display:none"  />
					<input type="button" id="auth_edit_nfbtn"  class="btn btn-primary btn-sm" value="편집" style="display:none" />
	  				<input type="button" id="auth_save_fbtn"   class="btn btn-primary btn-sm" value="저장" style="display:none" />
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>
</body>
</html>
