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
			<span style="margin-top:1%; font-size: 15px; float:center; margin-left:1%;"><strong style="text-align: center;">메뉴 권한 등록</strong></span>
			<div class="block_div"></div>
			
			<div style="height:150px; width:98%;">
				<!-- General -->
				<div>
					<br/>
					<div align="center" style="width: 100%">
						<form name="menuAuthAdd" id="menuAuthAdd" action="menuAuthAdd" method="post">
							<table class="table table-hover" style="font-size:12px;width: 100%">
							<tr height="15px">
								<th style=" width: 20%; text-align: right;">권한명</th>
								<td style="width: 30%; text-align: left;">
									<input type="text" class="inputTxt" id="auth_nm" name ="auth_nm" value="${auth_nm}" style="width:50%; background-color:#F2F2F2;" readonly="readonly"/>
									<input type="hidden" id="auth_id" name="auth_id" value="${auth_id}">
									<input type="button" id="auth_id_pop" name="auth_id_pop" value="선택" class="btn btn-default btn-sm">
								</td>
								<th style="width: 20%; text-align: right;">메뉴명</th>
								<td style="width: 30%; text-align: left;">
									<input type="text" class="inputTxt" id="up_menu_nm" name="menu_nm" style="width: 50%;"/>
									<input type="hidden" id="up_menu_cd" name="menu_cd" value="${menu_cd}">
									<input type="button" id="menu_cd_pop" name="menu_cd_pop" value="선택" class="btn btn-default btn-sm">
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width:20%; text-align: right;">활성화여부</th>
								<td style="width: 30%; text-align: left;">
									<input type="radio" id="active_flg3" name="active_flg3" value="Y">&nbsp;&nbsp;Y&nbsp;&nbsp;
									<input type="radio" id="active_flg3" name="active_flg3" value="N">&nbsp;&nbsp;N
								</td>
								<td>
								</td>
								<td>
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 20%; text-align: right;">조회권한</th>
								<td style="width: 30%; text-align: left;">
									<input type="radio" id="inqr_auth3" name="inqr_auth3" value="Y">&nbsp;&nbsp;Y&nbsp;&nbsp;
									<input type="radio" id="inqr_auth3" name="inqr_auth3" value="N">&nbsp;&nbsp;N
								</td>
								<th style="width: 20%; text-align: right;">생성권한</th>
								<td style="width: 30%; text-align: left;">
									<input type="radio" id="add_auth3" name="add_auth3" value="Y">&nbsp;&nbsp;Y&nbsp;&nbsp;
									<input type="radio" id="add_auth3" name="add_auth3" value="N">&nbsp;&nbsp;N
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 20%; text-align: right;">수정권한</th>
								<td style="width: 30%; text-align: left;">
									<input type="radio" id="mdfy_auth3" name="mdfy_auth3" value="Y">&nbsp;&nbsp;Y&nbsp;&nbsp;
									<input type="radio" id="mdfy_auth3" name="mdfy_auth3" value="N">&nbsp;&nbsp;N
								</td>
								<th style="width: 20%; text-align: right;">삭제권한</th>
								<td style="width: 30%; text-align: left;">
									<input type="radio" id="del_auth3" name="del_auth3" value="Y">&nbsp;&nbsp;Y&nbsp;&nbsp;
									<input type="radio" id="del_auth3" name="del_auth3" value="N">&nbsp;&nbsp;N
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 20%; text-align: right;">메뉴접근권한</th>
								<td style="width: 30%; text-align: left;">
									<input type="radio" id="menu_acc_auth3" name="menu_acc_auth3" value="Y">&nbsp;&nbsp;Y&nbsp;&nbsp;
									<input type="radio" id="menu_acc_auth3" name="menu_acc_auth3" value="N">&nbsp;&nbsp;N
								</td>
								<td>
								</td>
								<td>
								</td>
							</tr>
							<tr height="50px"></tr>
						</table>
						</form>
					</div>
					<div>
		        		<input type="button" class="btn btn-primary btn-sm" id="menuAuth_save_btn" name="menuAuth_save_btn" value="저장" 
		            		   style="font-size:11.5px; float:left; margin-left:1%;margin-top:1%;" onclick="menuAuthInsert()"/>
		            	<input type="button" id="menuClose" class="btn btn-primary btn-sm" data-dismiss="modal" 
							   style="font-size:11px;margin-top:1%; margin-left:1%; float: left;" value="닫기"/>
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