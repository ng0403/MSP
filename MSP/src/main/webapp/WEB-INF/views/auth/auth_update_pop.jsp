<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>권한 수정</title>
</head>
<body>
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
	<input type="hidden" id="ctx" value="${ctx}">
	
	<div>
		<form method="post" id="joinform">
			<table border = "1" style="">
				<tbody >
					<c:forEach var="authCheck" items="${authCheck}" >
						
						<tr>
							<th scope="row" style="width:50%;">권한ID</th>
							<td style="width:50%;"><input type="text" value="${authCheck.AUTH_ID}" name="auth_id" id="auth_id" class="int" /></td>
						</tr>
						<tr>
							<th scope="row" style="width:50%;">권한명</th>
							<td style="width:50%;"><input type="text" value="${authCheck.AUTH_NM}" name="auth_nm" id="auth_nm" class="int" /></td>
						</tr>
						<tr>
							<th scope="row" style="width:50%;">활성화여부</th>
							<td style="width:50%;"><input type="text" value="${authCheck.ACTIVE_FLG}" name="active_flg" id="active_flg" class="int" /></td>
						</tr>
						
					</c:forEach>
				</tbody>
		
			</table>
		</form>
	
	</div>
	
	<div class="bt_position_detail">
			<input type="button" id="closebtn" class="iuser_tab_bt" value="닫기"/>
			<input type="button" id="submitbtn" class="addsavebtn" value="저장"  />
		</div>	

     	<c:if test="${result=='success'}" var = "result"> 
			<script>window.close();
			
				opener.parent.location.href = "authlist";
				
			</script>
		 </c:if>
		 
		 <script>
		 
		 $(document).ready(function() {
			 
				$("#submitbtn").on("click", function() {
					 
					$('form').attr("action", "${ctx}/auth/auth_update").submit(); 
					
					alert("저장완료");
				});
				
				$("#closebtn").on("click", function() {
					 
					window.close();
				});
			});
	   	</script>

</body>
</html>