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
<script src="${ctx}/resources/common/js/mps/menu/menulist_pop.js"></script>
<title>메뉴 조회</title>
</head>
<body>
	<div id="menuMask" class="mask_div"></div>
	<div class="pop_main_div" id="menuWindow">
		<div class="navi_div">
			마스터 > 메뉴관리
			<div>
				<input type="button" id="menuInpr_close_nfbtn" class="func_btn" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
			</div>
		</div>
		<div class="block_div"></div><div class="block_div"></div>
		<div class="search_div">
			<div class="modal_search_div">
				<!-- <form id="searchForm" name="searchForm"> -->
					<label>메뉴명</label>
					<input type="text" id="menu_nm_key_pop" name="menu_nm_key" class="int_search"> &nbsp;
					<input type="button" id="menuInqr_pop_fbtn" class="btn btn-default btn-sm" value="검색">
				<!-- </form> -->
			</div>
		</div>
		<div class="list_div">
			<div class="modal_list_div">
					<table summary="menu_list_tb" class="table table-hover">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="40%">
						</colgroup>
						<thead>
							<tr>
								<th>메뉴명</th>
								<th>상위메뉴명</th>
								<th>URL</th>
							</tr>
						</thead>
						<tbody class="menu_list_pop">
							
						</tbody>
					</table>
				<div class="modal_paging_div">
					<div class="page" id="paging_menuPop_div">	
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>