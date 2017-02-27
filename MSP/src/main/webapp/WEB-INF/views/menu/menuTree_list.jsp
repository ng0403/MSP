<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- <c:set var="ctx" value="${pageContext.request.contextPath }" /> --%>
<%-- <script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> --%>
<%-- <script src="${ctx}/resources/common/js/mps/menu/menutree_pop.js"></script> --%>
<title>메뉴 조회</title>
</head>
<body>
	<div id="menuTreeMask" class="mask_div"></div>
	<div class="pop_main_div" id="menuTreeWindow">
		<div class="navi_div">
			마스터 > 메뉴관리
			<div>
				<input type="button" id="menuTreeInpr_close_nfbtn" class="func_btn" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
			</div>
		</div>
		<div class="block_div"></div><div class="block_div"></div>
		
		<div class="list_div">
			<div class="modal_list_div">
				<table summary="menu_tree_list_tb" class="table table-hover">
					<tbody class="menu_tree_list_pop">
							
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>