<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%-- <link rel="stylesheet" href="${ctx}/resources/common/bootstrap-3.2.0/dist/css/bootstrap.min.css" type="text/css" /> --%>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/bootstrap-3.2.0/dist/css/bootstrap-theme.min.css" type="text/css" /> --%>
<script type="text/javascript" src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<%-- <script type="text/javascript" src="${ctx}/resources/common/bootstrap-3.2.0/dist/js/bootstrap.min.js"></script> --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<%-- <script type="text/javascript" src="${ctx}/resources/common/js/jquery-ui.js"></script> --%>
<script type="text/javascript" src="${ctx}/resources/common/js/standard/common.js"></script>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/jquery-ui.css"	type="text/css" /> --%>
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/header.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/menu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/subMenu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/content.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/common.css" type="text/css" />
<link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet"/>

<%--
    Class Name : user_auth_popup.jsp
    Description : 사용자권한상세정보 팝업을 담당
    Modification Information
      수정일           수정자            수정내용
    ---------- ---------- -------------------------------
    2017.02.02 공재원           최초 생성
    2017.02.02 공재원           주석 추가 , 삭제 버튼 조건 부여
    author : 공재원
    since : 2017.02.02
--%>

<script type="text/javascript">
</script>
</head>
<body>
<div id="userAuthMask"></div> 
	<div class="userAuthWindow" >
		<div id="mainDiv" style="width:100%;" align="center">
			<span style="margin-top:1%;font-size: 15px; float:left; margin-left:1%;"><strong>권한관리>사용자권한>상세정보</strong></span>
			<!-- <input type="button" class="btn btn-default" data-dismiss="modal" style="float:right;font-size:11px;margin-right:1%;margin-top:1%;" value="닫기" onclick="clearTdFunc();"/> -->
			<div>
			<input type="button" href="#" id="userAuthClose" class="func_btn" data-dismiss="modal" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
			</div>
		<div class="block_div"></div><div class="block_div"></div>
		
		<div style="height:340px;width:98%;">
			<!-- General -->
			<div>
				<br />
				<form name="frm_userAuth" id="frm_userAuth" action="/userAuth/updateUserAuth" enctype="multipart/form-data" method="post">
				<div align="center" style="width: 100%">
					<table class="board_view" style="font-size:12px;width: 100%">
					
					<tbody id="generalTbody">
						
					</tbody>
					</table>
				</div>
				</form>
			</div>

		</div>
	</div>
		
	</div> 
	<a href="#" class="userAuthOpen"></a>
	
</body>	