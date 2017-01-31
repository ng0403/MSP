<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/iuser/iuserTab.css" type="text/css" />
 <title>Insert title here</title>
</head>
<body>
	<input type="hidden" id="ctx" value="${ctx}">
	<!-- Modal Main Div -->
	<div class="modalL_main_div">
		
		<!-- Modal Navigation Div -->
		<div class="modalL_navi_div">
		</div>
		
		<!-- Modal List Div -->
		<div class="modalL_list_div">
			<form method="post" id="joinform" >
				<table class="table">
					<tbody id="tbody1">
						<tr>
							<th>사용자ID</th>
							<td>
 							<input type="text" name="USER_ID" id="USER_ID" class="iuser_txt" style=" width:90%" >${list.USER_ID}</input></td>
							<th>사용자 이름</th>
							<td><input type="text" name="USER_NAME" id="USER_NAME" class="iuser_txt" style="width:90%">${list.USER_NAME}</input></td>
							<th>비밀번호</th>
							<td><input type="text" name="PWD" id="PWD" class="iuser_txt" style="width:90%">${list.PWD}</input></td>
							<th>이메일</th>
							<td><input type="text" name="EMAIL" id="EMAIL" class="iuser_txt" style="width:90%"> ${list.EMAIL}
 							</td>
						</tr>	
						<tr>
							<th>자택 전화번호</th>
							<td><input type="text" name="HOME_PHONE" id="HOME_PHONE" class="iuser_txt" maxlength="12" style="width:90%" /> ${list.HOME_PHONE}
							</td>
							<th>휴대 전화번호</th>
							<td><input type="text" name="CELL_PHONE" id="CELL_PHONE" class="iuser_txt" maxlength="12" style="width:90%" /> ${list.CELL_PHONE}
							</td>
							<th>회사 전화번호</th>
							<td><input type="text" name="COMPANY_PHONE" id="COMPANY_PHONE" class="iuser_txt" maxlength="12" style="width:90%" /> ${list.COMPANY_PHONE}
							</td>
							<th>선호 채널</th>
							<td><input type="text" name="P_CHANNEL_CD" id="P_CHANNEL_CD" class="iuser_txt" maxlength="12" style="width:90%" /> ${list.P_CHANNEL_CD}
							</td>
							<th>사용자 구분</th>
							<td><input type="text" name="USER_TYPE_CD" id="USER_TYPE_CD" class="iuser_txt" maxlength="12" style="width:90%" /> ${list.USER_TYPE_CD}
							</td>
							<th>조직ID</th>
							<td><input type="text" name="ORG_ID" id="ORG_ID" class="iuser_txt" maxlength="12" style="width:90%" /> ${list.ORG_ID}
							</td>
							
							
						</tr>
						<tr> 
						 
						</tr>
					</tbody>
				</table>
				
			</form>
		</div>
		
		<!-- Modal Btn Div -->
		<div class="modalL_btn_div">
			<input type="button" id="submitbtn" class="iuser_tab_bt" value="추가"/>
			<input type="button" id="modifybtn" class="iuser_tab_bt" value="편집"/>
			<input type="reset" id="cancelbtn" class="iuser_tab_bt" value="취소"/>
			<input type="button" id="addsavebtn" class="iuser_tab_bt" value="저장"/>
			<input type="button" id="modifysavebtn" class="iuser_tab_bt" style="display:none;" value="저장"/>
		</div>
	</div>

	
<c:if test="${result=='1'}" var = "result"> 
	<script type="text/javascript">
		window.close();
		opener.parent.location.href = "userlist";
	</script>
 </c:if>
 
	<script>
		$(document).ready(function() {

			$("#submitbtn").on("click", function() {
			 
				$('form').attr("action", "${ctx}/usertest/userInsert").submit();
				
				
			});
			
 
		});
	</script>
	
	
			
	
	

</body>
</html>


