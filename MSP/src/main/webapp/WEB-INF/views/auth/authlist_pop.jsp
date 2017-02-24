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
<script src="${ctx}/resources/common/js/mps/authJS/authlist_pop.js"></script>
<style type="text/css">

.pop_main_div {
	width: 550px;
	height: 430px;
	overflow:hidden;

}

label {
	padding-left: 15px;
}

#keyword_pop {
	width: 150px;
}

#authInqr_pop_fbtn {
	margin-left: -5px;
}

#paging_authPop_div {
	margin-left: 190px;
}
</style>
<title>권한 조회</title>
</head>
<body>
<div id="authMask" class="mask_div"></div>
<div class="pop_main_div" id="authWindow">
	<!-- Navigation Div -->
	<div class="navi_div">권한조회
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
			<table summary="auth_list_tb" class="table table-hover" style="width: 95%;">
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