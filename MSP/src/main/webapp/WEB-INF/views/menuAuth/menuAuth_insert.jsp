<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">  -->
<%-- <script type="text/javascript" src="${ctx}/resources/common/js/standard/common.js"></script> --%>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>

<link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/header.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/menu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/subMenu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/content.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/common.css" type="text/css" />
<link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
</head>
<body>
	<div id="menuAuthInsertMask"></div>
	
	<div class="menuAuthInsertWindow" >
		<div id="mainDiv" style="align="center">
			<span style="margin-top:1%; font-size: 15px; float:center; margin-left:1%;"><strong style="text-align: center;">메뉴 권한 상세보기</strong></span>
			<div>
				<input type="button" id="menuClose" class="btn btn-primary btn-sm" data-dismiss="modal" 
					   style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
		        <input type="button" class="btn btn-primary btn-sm" id="menuAuth_save_btn" name="menuAuth_save_btn" value="저장" 
		               style="font-size:11.5px;float:right;margin-right:1%;margin-top:1%;"/>
			</div>
			<div class="block_div"></div>
			
			<div style="height:150px; width:98%;">
				<!-- General -->
				<div>
					<br/>
					<div align="center" style="width: 100%">
						<form name="menuAuthAdd" id="menuAuthAdd" action="menuAuthAdd" method="post">
							<table class="board_view" style="font-size:12px;width: 100%">
							<tr height="15px">
								<th style=" width: 12%; text-align: right;"><span style="color:red;">*</span>권한명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<input type="text" id="auth_nm" name ="auth_nm" value="${auth_nm}" style="width:50%; background-color:#F2F2F2;" readonly="readonly"/>
									<input type="hidden" id="auth_id" name="auth_id" value="${auth_id}">
									<input type="button" id="auth_id_pop" name="auth_id_pop" value="선택" class="btn btn-default btn-sm">
								</td>
								<th style="width: 12%; text-align: left;"><span style="color:red;">&nbsp;&nbsp;*</span>메뉴명&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<input type="text" id="up_menu_nm" name="menu_nm" style="width: 50%;"/>
									<input type="hidden" id="up_menu_cd" name="menu_cd" value="${menu_cd}">
									<input type="button" id="menu_cd_pop" name="menu_cd_pop" value="선택" class="btn btn-default btn-sm">
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width:20%; text-align: right;"><span style="color:red;">*</span>활성화여부&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="active_flg3" name="active_flg3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>조회권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="inqr_auth3" name="inqr_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>생성권한&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="add_auth3" name="add_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>수정권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="mdfy_auth3" name="mdfy_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>삭제권한&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="del_auth3" name="del_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>메뉴접근권한</th>
								<td style="width: 38%; text-align: left;">
									<select id="menu_acc_auth3" name="menu_acc_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="50px"></tr>
						</table>
						</form>
					</div>
					
				</div>
			</div>
		
		</div>
	</div>
	<jsp:include page="../menu/menulist_pop.jsp"></jsp:include>
	<jsp:include page="../auth/authlist_pop.jsp"></jsp:include>
	
	<a href="#" class="menuOpen"></a>
</body>
</html>