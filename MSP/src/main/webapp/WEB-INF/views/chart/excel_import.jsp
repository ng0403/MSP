<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="result" value="${result}" />
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/mps/authJS/auth_list.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Insert title here</title>   
 
 <script type="text/javascript">
 
 $(document).ready(function() {
	 var result = $("#result").val();
	 if(result == "1"){
		 opener.parent.location.reload();
		 sleep(1*1000);
		 window.open("about:blank","_self").close();
	 }
 });
 
 </script>

</head>
<body>
	<input type="hidden" id="ctx" value="${ctx}">
	<input type="hidden" id="result" value="${result}">
		<!-- Modal Main Div -->
	<div>
		<div style="text-align: center; margin-top: 10%;">
			<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="${ctx}/chart/excelUploadAjax"> 
				<input type="file"   id="excelFile"       class="btn btn-default" name="excelFile"  style="float: center;"/>
				<input type="button" id="excelImpoartBtn" class="btn btn-default" onclick="check();" value="업로드" style="float: center;">
			</form>
		</div>
		
	</div>
	
</body>
</html>


