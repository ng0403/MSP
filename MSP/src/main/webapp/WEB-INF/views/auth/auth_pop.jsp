<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/org/orgDetail.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>권한 등록</title>
</head>
<body>
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
	<input type="hidden" id="ctx" value="${ctx}">
	
	<div>
		<form method="post" id="joinform" >
			<table class="">
				<tbody id="tbody1">
					<tr>
						<th>권한ID</th>
						<td><input type="text" name="auth_id" id="auth_id" class="int"></input></td>
					</tr>
					<tr>
						<th>권한명</th>
						<td><input type="text" name="auth_nm" id="auth_nm" class="int"></input></td>
					</tr>
					<tr>
						<th>활성화여부</th>
						<td><input type="text" name="active_flg" id="active_flg" class="int"></input></td>
					</tr>
				</tbody>
			</table>
			
		</form>
	</div>
	
	<div class="btn02">
		<input type="button" id="rebtn" class="iuser_tab_bt" value="초기화"/>
		<input type="button" id="submitbtn"  class="iuser_tab_bt" value="저장"/>
		<input type="button" id="iuserListEditBtn" class="iuser_bt" value="편집"/>
		<input type="button" id="closebtn" class="iuser_tab_bt" value="닫기"/>
	</div>		
	
	<c:if test="${result=='success'}" var = "result"> 
			<script> window.close();
				opener.parent.location.href = "authlist";
			</script>
	 </c:if>	
	
	<script>
	 
	$(document).ready(function() {
		
		$("#submitbtn").on("click", function() {
			
			$('form').attr("action", "${ctx}/auth/auth_write").submit();	
			alert("추가 완료");
			
		});
		
		$("#closebtn").on("click", function() {
			 
			window.close();
		});
	});
	</script>	

</body>
</html>