<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/standard/iuser/iuserList.css" type="text/css" /> --%>
<style type="text/css">
@CHARSET "UTF-8";
/*                                    */
div.mastertable label {
	font-weight: normal;
	text-align: left;
	white-space: nowrap;
}

div.mastertable select {
	width: 75px;
	display: inline-block;
}

div.dataTables_filter {
	text-align: right;
}

div.dataTables_filter label {
	font-weight: normal;
	white-space: nowrap;
	text-align: left;
}

div.dataTables_filter input {
	margin-left: 0.5em;
	display: inline-block;
}

div.dataTables_info {
	padding-top: 8px;
	white-space: nowrap;
}

div.dataTables_paginate {
	margin: 0;
	white-space: nowrap;
	text-align: right;
}

div.dataTables_paginate ul.pagination {
	margin: 2px 0;
	white-space: nowrap;
}

@media screen and (max-width: 767px) {
	div.mastertable, div.dataTables_filter, div.dataTables_info, div.dataTables_paginate
		{
		text-align: center;
	}
}

table.mastertable td, table.mastertable th {
	-webkit-box-sizing: content-box;
	-moz-box-sizing: content-box;
	box-sizing: content-box;
}

table.mastertable {
	clear: both;
	margin-top: 6px !important;
	margin-bottom: 6px !important;
	max-width: none !important;
}

table.mastertable thead .sorting, table.mastertable thead .sorting_asc,
	table.mastertable thead .sorting_desc, table.mastertable thead .sorting_asc_disabled,
	table.mastertable thead .sorting_desc_disabled {
	cursor: pointer;
}

table.mastertable thead .sorting {
	background: url('../images/sort_both.png') no-repeat center right;
}

table.mastertable thead .sorting_asc {
	background: url('../images/sort_asc.png') no-repeat center right;
}

table.mastertable thead .sorting_desc {
	background: url('../images/sort_desc.png') no-repeat center right;
}

table.mastertable thead .sorting_asc_disabled {
	background: url('../images/sort_asc_disabled.png') no-repeat center
		right;
}

table.mastertable thead .sorting_desc_disabled {
	background: url('../images/sort_desc_disabled.png') no-repeat center
		right;
}

table.mastertable thead>tr>th {
	padding-left: 18px;
	padding-right: 18px;
}

table.mastertable th:active {
	outline: none;
}

/* Scrolling */
div.mastertables_scrollHead table {
	margin-bottom: 0 !important;
	border-bottom-left-radius: 0;
	border-bottom-right-radius: 0;
}

div.mastertables_scrollHead table thead tr:last-child th:first-child, div.mastertables_scrollHead table thead tr:last-child td:first-child
	{
	border-bottom-left-radius: 0 !important;
	border-bottom-right-radius: 0 !important;
}

div.mastertables_scrollBody table {
	border-top: none;
	margin-top: 0 !important;
	margin-bottom: 0 !important;
}

div.mastertables_scrollBody tbody tr:first-child th, div.mastertables_scrollBody tbody tr:first-child td
	{
	border-top: none;
}

div.mastertables_scrollFoot table {
	margin-top: 0 !important;
	border-top: none;
}

/* Frustratingly the border-collapse:collapse used by Bootstrap makes the column
   width calculations when using scrolling impossible to align columns. We have
   to use separate
 */
table.table-bordered.mastertable {
	border-collapse: separate !important;
}

table.table-bordered thead th, table.table-bordered thead td {
	border-left-width: 0;
	border-top-width: 0;
}

table.table-bordered tbody th, table.table-bordered tbody td {
	border-left-width: 0;
	border-bottom-width: 0;
}

table.table-bordered th:last-child, table.table-bordered td:last-child {
	border-right-width: 0;
}

div.mastertables_scrollHead table.table-bordered {
	border-bottom-width: 0;
}

/*
 * TableTools styles
 */
.table.mastertable tbody tr.active td, .table.mastertable tbody tr.active th
	{
	background-color: #08C;
	color: white;
}

.table.mastertable tbody tr.active:hover td, .table.mastertable tbody tr.active:hover th
	{
	background-color: #0075b0 !important;
}

.table.mastertable tbody tr.active th>a, .table.mastertable tbody tr.active td>a
	{
	color: white;
}

.table-striped.mastertable tbody tr.active:nth-child(odd) td,
	.table-striped.mastertable tbody tr.active:nth-child(odd) th {
	background-color: #017ebc;
}

table.DTTT_selectable tbody tr {
	cursor: pointer;
}

div.DTTT .btn:hover {
	text-decoration: none !important;
}

ul.DTTT_dropdown.dropdown-menu {
	z-index: 2003;
}

ul.DTTT_dropdown.dropdown-menu a {
	color: #333 !important;
	/* needed only when demo_page.css is included */
}

ul.DTTT_dropdown.dropdown-menu li {
	position: relative;
}

ul.DTTT_dropdown.dropdown-menu li:hover a {
	background-color: #0088cc;
	color: white !important;
}

div.DTTT_collection_background {
	z-index: 2002;
}

/* TableTools information display */
div.DTTT_print_info {
	position: fixed;
	top: 50%;
	left: 50%;
	width: 400px;
	height: 150px;
	margin-left: -200px;
	margin-top: -75px;
	text-align: center;
	color: #333;
	padding: 10px 30px;
	opacity: 0.95;
	background-color: white;
	border: 1px solid rgba(0, 0, 0, 0.2);
	border-radius: 6px;
	-webkit-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.5);
	box-shadow: 0 3px 7px rgba(0, 0, 0, 0.5);
}

div.DTTT_print_info h6 {
	font-weight: normal;
	font-size: 28px;
	line-height: 28px;
	margin: 1em;
}

div.DTTT_print_info p {
	font-size: 14px;
	line-height: 20px;
}

div.mastertables_processing {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 100%;
	height: 60px;
	margin-left: -50%;
	margin-top: -25px;
	padding-top: 20px;
	padding-bottom: 20px;
	text-align: center;
	font-size: 1.2em;
	background-color: white;
	background: -webkit-gradient(linear, left top, right top, color-stop(0%, rgba(255,
		255, 255, 0)), color-stop(25%, rgba(255, 255, 255, 0.9)),
		color-stop(75%, rgba(255, 255, 255, 0.9)),
		color-stop(100%, rgba(255, 255, 255, 0)));
	background: -webkit-linear-gradient(left, rgba(255, 255, 255, 0) 0%,
		rgba(255, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%,
		rgba(255, 255, 255, 0) 100%);
	background: -moz-linear-gradient(left, rgba(255, 255, 255, 0) 0%,
		rgba(255, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%,
		rgba(255, 255, 255, 0) 100%);
	background: -ms-linear-gradient(left, rgba(255, 255, 255, 0) 0%,
		rgba(255, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%,
		rgba(255, 255, 255, 0) 100%);
	background: -o-linear-gradient(left, rgba(255, 255, 255, 0) 0%,
		rgba(255, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%,
		rgba(255, 255, 255, 0) 100%);
	background: linear-gradient(to right, rgba(255, 255, 255, 0) 0%,
		rgba(255, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%,
		rgba(255, 255, 255, 0) 100%);
}

/*
 * FixedColumns styles
 */
div.DTFC_LeftHeadWrapper table, div.DTFC_LeftFootWrapper table, div.DTFC_RightHeadWrapper table,
	div.DTFC_RightFootWrapper table, table.DTFC_Cloned tr.even {
	background-color: white;
	margin-bottom: 0;
}

div.DTFC_RightHeadWrapper table, div.DTFC_LeftHeadWrapper table {
	border-bottom: none !important;
	margin-bottom: 0 !important;
	border-top-right-radius: 0 !important;
	border-bottom-left-radius: 0 !important;
	border-bottom-right-radius: 0 !important;
}

div.DTFC_RightHeadWrapper table thead tr:last-child th:first-child, div.DTFC_RightHeadWrapper table thead tr:last-child td:first-child,
	div.DTFC_LeftHeadWrapper table thead tr:last-child th:first-child, div.DTFC_LeftHeadWrapper table thead tr:last-child td:first-child
	{
	border-bottom-left-radius: 0 !important;
	border-bottom-right-radius: 0 !important;
}

div.DTFC_RightBodyWrapper table, div.DTFC_LeftBodyWrapper table {
	border-top: none;
	margin: 0 !important;
}

div.DTFC_RightBodyWrapper tbody tr:first-child th, div.DTFC_RightBodyWrapper tbody tr:first-child td,
	div.DTFC_LeftBodyWrapper tbody tr:first-child th, div.DTFC_LeftBodyWrapper tbody tr:first-child td
	{
	border-top: none;
}

div.DTFC_RightFootWrapper table, div.DTFC_LeftFootWrapper table {
	border-top: none;
	margin-top: 0 !important;
}

/*
 * FixedHeader styles
 */
div.FixedHeader_Cloned table {
	margin: 0 !important
}


}
</style>
<title>리스트</title>
<script type="text/javascript">
	$("#navisub11").show();
	$("#naviuser").css("font-weight", "bold");

	function userTabOpen() {
		var popUrl = "userTab";
		var popOption = "width=950, height=320, resize=no, scrollbars=no, status=no, location=no, directories=no;";
		window.open(popUrl, "", popOption);
	}

	//수정
	function onPopup(id) {
		var tmp = id;//$("#user_id_h").val();
		alert(tmp);

		var popUrl = "userMdfyPop?user_id=" + tmp; //팝업창에 출력될 페이지 URL
		var popOption = "width=950, height=320, resize=no, scrollbars=no, status=no, location=no, directories=no;"; //팝업창 옵션(optoin)

		window.open(popUrl, "", popOption);
	};
</script>

<script type="text/javascript">
	// 1.모두 체크
	/* 체크박스 전체선택, 전체해제 */
	function allChk() {
		if ($("#checkall").is(':checked')) {
			$("input[name=del_code]").prop("checked", true);
		} else {
			$("input[name=del_code]").prop("checked", false);
		}
	}

	/* 삭제(체크박스된 것 전부) */
	function deleteAction() {
		var del_code = "";
		$("input[name='del_code']:checked").each(function() {
			del_code = del_code + $(this).val() + ",";
		});
		del_code = del_code.substring(0, del_code.lastIndexOf(",")); //맨끝 콤마 지우기

		if (del_code == '') {
			alert("삭제할 대상을 선택하세요.");
			return false;
		}
		console.log("### del_code => {}" + del_code);

		if (confirm("정보를 삭제 하시겠습니까?")) {

			//삭제처리 후 다시 불러올 리스트 url      

			location.href = "${ctx}/usertest/userDel?user_id=" + del_code;
		}
	}
</script>

</head>
<body>

<!--Main_Div  -->
<div class="main_div">
	<!-- Navigation Div -->
	<div class="navi_div">■ 사용자관리</div>
	
	<!-- Search1 Cover Div -->
	<div class="">
		
		<!-- Search1 Div  -->
		<div class="search1_div">
			<form name="searchForm" method="post" action="${ctx}/user">
					<select name="keyfield">
						<option value="u_id">사용자ID명</option>
						<option value="u_name">사용자명</option>
						<option value="o_name">조직명</option>
					</select> <input id="title_text" type="text" name="keyword"
						class="int_search"> &nbsp;
					<button id="search_btn" type="submit" class="iuser_serach_bt">검색</button>
			</form>
		</div>
	</div>
	
	<!-- List1 Cover Div -->
	<div class="">
		
		<!-- List1 Div -->
		<div class="list1_div">
			<form name="delAllForm" id="delAllForm" method="post"
			action="${ctx}/userDel">
			<table id="mastertable" class="mastertable">
				<thead>
					<tr>
						<th><input id="checkall" name="checkAll" type="checkbox"
							onclick="allChk();" /></th>
						<td style="width: 10%;">사용자ID</td>
						<td style="width: 10%;">사용자명</td>
						<td style="width: 10%;">조직명</td>
						<td style="width: 20%;">이메일</td>
						<td style="width: 20%;">연락처</td>
						<td style="width: 10%;">권한</td>
						<td style="width: 10%;">사용자구분</td>
						<td style="width: 10%;">상태</td>
					</tr>
				</thead>
				<tbody id="usertbody">
					<c:forEach var="list" items="${list}">
						<tr>

							<th scope="row"><input type="checkbox" class="ab"
								name="del_code" value="${list.USER_ID}"> <input
								type="hidden" id="user_id_h" value="${list.USER_ID}" /></th>
							<a href="#"><td style="width: 10%;" name="user_id"
								id="${list.USER_ID}" onclick="onPopup(this.id);">${list.USER_ID}</td></a>
							<td style="width: 10%;" class="user_name_tag">${list.USER_NAME}</td>
							<td style="width: 10%;" class="org_name_tag">${list.ORG_ID}</td>
							<td style="width: 20%;" class="email_tag">${list.EMAIL}</td>
							<td style="width: 20%;" class="cell_phone_tag">${list.CELL_PHONE}</td>
							<td style="width: 10%;" class="auth_name_tag"><c:if
									test="${empty list.AUTH_NAME}">
						권한없음
					</c:if> <c:if test="${not empty list.AUTH_NAME}">
						${list.auth_name}
					</c:if></td>
							<td style="width: 20%;" class="user_type_cd">${list.USER_TYPE_CD}</td>
							<td style="width: 20%;" class="active_flg">${list.ACTIVE_FLG}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		</div>
	</div>
	
	<!-- Paging Div -->
	<div class="paging_div">
		<input type="button" id="iuserListAddBtn" onclick="userTabOpen()"
			class="iuser_bt" value="등록" />
		<!-- <input type="button" id="iuserListEditBtn" class="iuser_bt" value="수정"/> -->
		<input type="button" id="iuserDelBtn" onclick="deleteAction()"
			class="iuser_bt" value="삭제" />
	</div>
</div>
</body>
</html>