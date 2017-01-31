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
 <c:if test="${result=='1'}" var = "result"> 
	<script type="text/javascript">
		window.close();
		opener.parent.location.href = "userlist";
	</script>
 </c:if>
 
<script>

	$(document).ready(function() {
		var entry_flg = ${entry_flg}
		var tmp = $('#USER_ID').val();
		if(entry_flg == 1)
		{
			//$('#addsave_btn').CSS('display', "hidden");
			$('#joinform').find('input[type="text"]').attr('disabled',false).attr('readonly', false);
			//$('#modifysave_btn').css("visibility","hidden");

		}else{
			$('#USER_ID').attr("readonly", true);
			$('#joinform').find('input[type="text"]').attr('disabled',true);
		    $('#joinform').find('input[type="password"]').attr('disabled',true);
	        $('#joinform').find('input[type="email"]').attr('disabled',true);
			//$('#addsave_btn').css('visibility',"hidden");
			
		} 
			
		
		//추가 버튼
			$("#submit_btn").on("click", function() {
				var entry_flg = ${entry_flg}
				var tmp = $('#USER_ID').val();
				var tmplength = tmp.length;
				
				if(entry_flg != 1){
					alert("이미 존재하는 계정입니다.");
				}else{
					if(tmplength > 0){
						$('form').attr("action", "${ctx}/usertest/userInsert").submit();
						}else{
							alert("사용자 아이디가 없습니다.");
						}
				}
			});
		//편집 버튼 
			$("#modify_btn").on("click", function() {
				var entry_flg = ${entry_flg}
				var tmp = $('#USER_ID').val();
				
				var tmplength = tmp.length;
				if(entry_flg != 1){
					$('#joinform').find('input[type="text"]').attr('disabled',false);
					$('#joinform').find('input[type="password"]').attr('disabled',false);
			        $('#joinform').find('input[type="email"]').attr('disabled',false);
					$('#USER_ID').attr("readonly", true);
					$('#addsave_btn').css("visibility","hidden");
					$('#modify_btn').attr("disabled", true);
					$('#submit_btn').attr("disabled", true);
				}else{
					alert("신규 데잍를 입력하세요.");
				}
			});
		//편집 저장 버튼
			$("#modifysave_btn").on("click", function() {
				var entry_flg = ${entry_flg}
				var tmp = $('#USER_ID').val();
				
				var tmplength = tmp.length;
				if(entry_flg != 1){
					$('form').attr("action", "${ctx}/usertest/userMdfy?user_id = "+tmp).submit();
				}else{
					alert("신규 데잍를 입력하세요.");
				}
			});
		
		var tmp = $('#USER_ID').val();
		
	/* var user_id = $('#user_id_h').val(); */
});
	

 </script>
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
							<td><input type="hidden" id="user_id_h" value="${USER_ID}">
							<input type="hidden" id="active_flg" value="${ACTIVE_FLG}">
 							<input type="text" name="USER_ID" id="USER_ID" class="iuser_txt" style=" width:90%" value="${USER_ID}"></input></td>
							<th>사용자 이름</th>
							<td><input type="text" name="USER_NAME" id="USER_NAME" class="iuser_txt" style="width:90%" value="${USER_NAME}"></input></td>
							<th>비밀번호</th>
							<td><input type="password" name="PWD" id="PWD" class="iuser_txt" style="width:90%" value="${PWD}"></input></td>
							<th>이메일</th>
							<td><input type="email" name="EMAIL" id="EMAIL" class="iuser_txt" style="width:90%" value="${EMAIL}"> 
 							</td>
							<th>자택 전화번호</th>
							<td><input type="text" name="HOME_PHONE" id="HOME_PHONE" class="iuser_txt" maxlength="12" style="width:90%" value="${HOME_PHONE}" />
							</td>
						</tr>	
						<tr>
							<th>휴대 전화번호</th>
							<td><input type="text" name="CELL_PHONE" id="CELL_PHONE" class="iuser_txt" maxlength="12" style="width:90%" value="${CELL_PHONE}" /> 
							</td>
							<th>회사 전화번호</th>
							<td><input type="text" name="COMPANY_PHONE" id="COMPANY_PHONE" class="iuser_txt" maxlength="12" style="width:90%" value="${COMPANY_PHONE}"/> 
							</td>
							<th>선호 채널</th>
							<td><input type="text" name="P_CHANNEL_CD" id="P_CHANNEL_CD" class="iuser_txt" maxlength="12" style="width:90%" value="${P_CHANNEL_CD}"/> 
							</td>
							<th>사용자 구분</th>
							<td><input type="text" name="USER_TYPE_CD" id="USER_TYPE_CD" class="iuser_txt" maxlength="12" style="width:90%" value="${USER_TYPE_CD}"/> 
							</td>
							<th>조직ID</th>
							<td><input type="text" name="ORG_ID" id="ORG_ID" class="iuser_txt" maxlength="12" style="width:90%" value="${ORG_ID}"/> 
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
			<input type="button" id="submit_btn" class="iuser_tab_bt" value="추가"/>
			<input type="button" id="modify_btn" class="iuser_tab_bt" value="편집" />
			<input type="reset" id="cancel_btn" class="iuser_tab_bt" value="취소"/>
			<!-- <input type="button" id="addsave_btn" class="iuser_tab_bt" value="저장"/> -->
			<input type="button" id="modifysave_btn" class="iuser_tab_bt"  value="저장"/>
		</div>
	</div>
	
</body>
</html>


