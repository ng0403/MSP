<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<%-- <script src="${ctx}/resources/common/js/common.js"></script> --%>
<%-- <script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> --%>
<!-- 합쳐지고 최소화된 최신 CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!-- 부가적인 테마 -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">  -->
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/mps/userCSS/userTabCSS.css" type="text/css" /> --%>
<script src="${ctx}/resources/common/js/mps/dept/deptlist_pop.js"></script>
<title>부서 조회</title>

</head>
<body>
<div class="DEPT_POP_BACK"></div>
	<div class="DEPTpop_main_div" style=" background: beige;">
	
		<div>
			<input type="button" id="DeptTabInpr_close_nfbtn" onclick="DEPT_POP_CLOSE();" class="func_btn" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
		</div>
		<div class="navi_div">
			부서검색
		</div>
		<div class="search_div">
			<div class="search2_div" style="width: 100%; height: 34px;">
					<label>부서명</label>
					<input type="text" id="dept_nm_key" name="dept_nm_key"> &nbsp;
					<input type="button" id="dept_inqr_fbtn" class="search_btn" value="검색">
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div" style="width: 100%;">
				<form id="delAll_form" name="delAll_form">
					<table summary="dept_list_tb" style ="width: 98%;"class="table table-bordered"><!--  -->
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
					<div class="page" id="paging_deptPop_div">	
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>