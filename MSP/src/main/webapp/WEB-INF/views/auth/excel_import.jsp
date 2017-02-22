<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/mps/authJS/auth_list.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/user/userTab.css" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <title>Insert title here</title>

</head>
<body>
	<input type="hidden" id="ctx" value="${ctx}">
		<!-- Modal Main Div -->
	<div>
		<div>
			<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="${ctx}/auth/excelUploadAjax"> 
				<input id="excelFile" type="file" name="excelFile" class="btn btn-default" style="float: center;"/>
				<input type="button" id="addExcelImpoartBtn" class="btn btn-default" onclick="check();" value="업로드" style="float: center;">
			</form>
		</div>
		
	</div>
	
</body>
</html>


