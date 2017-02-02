<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/user/userTab.css" type="text/css" />
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
		var tmp = $('#user_id').val();
		if(entry_flg == 1)
		{
			//$('#addsave_btn').CSS('display', "hidden");
			$('#joinform').find('input[type="text"]').attr('disabled',false).attr('readonly', false);
			$('#emp_no').css('display','none');
			$('#modifysave_btn').css('display','none');
			//$('#modifysave_btn').css("visibility","hidden");

		}else{
			$('#user_id').attr("readonly", true);
			$('#emp_no').css('display','block');
			$('#submit_btn').css('display','none');
			$('#joinform').find('input[type="text"]').attr('disabled',true);
		    $('#joinform').find('input[type="password"]').attr('disabled',true);
	        $('#joinform').find('input[type="email"]').attr('disabled',true);
			//$('#addsave_btn').css('visibility',"hidden");
			
		} 
			
		
		//추가 버튼
			$("#submit_btn").on("click", function() {
				var entry_flg = ${entry_flg}
				var tmp = $('#user_id').val();
				$('created_by').val(tmp);
				var tmplength = tmp.length;
				
				if(entry_flg != 1){
					alert("이미 존재하는 계정입니다.");
				}else{
					if(tmplength > 0){
						$('form').attr("action", "${ctx}/user/userInsert").submit();
						}else{
							alert("사용자 아이디가 없습니다.");
						}
				}
			});
		//편집 버튼 
			$("#modify_btn").on("click", function() {
				var entry_flg = ${entry_flg}
				var tmp = $('#user_id').val();
				$('created_by').val(tmp);
				
				var tmplength = tmp.length;
				if(entry_flg != 1){
					$('#joinform').find('input[type="text"]').attr('disabled',false);
					$('#joinform').find('input[type="password"]').attr('disabled',false);
					$('#user_id').attr("readonly", true);
					$('#emp_no').attr("readonly", true);
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
				var tmp = $('#user_id').val();
				
				var tmplength = tmp.length;
				if(entry_flg != 1){
					$('form').attr("action", "${ctx}/user/userMdfy?user_id = "+tmp).submit();
				}else{
					alert("신규 데잍를 입력하세요.");
				}
			});
		
		var tmp = $('#user_id').val();
		
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
							<td>
								<input type="hidden" id="user_id_h" value="${user_id}">
								<input type="hidden" id="created_by" value="">
								<input type="hidden" id="active_flg" value="${active_flg}">
 								<input type="text" name="user_id" id="user_id" class="iuser_txt" style=" width:40%" value="${user_id}"/><input type="text" name="emp_no" id="emp_no" class="iuser_txt" style=" width:40%" value="${emp_no}"/>
 							</td>
 							<th>직급</th>
 							<td>
 								<select id="rank_cd" name="rank_cd" style="width: 55%; height: 70%;">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</select>
 								<%-- <select name="rank_cd"  >
									<c:forEach var="rankCD" items="${rank_cd}" varStatus="status2">
										<option value="<c:out value="${rankCD.CODE1}" />" 
											<c:if test="${result.useYn == rankCD.CODE1 }">selected="selected"</c:if>>
											<c:out value="${rankCD.CODE_TXT}" />
										</option>
									</c:forEach>
								</select> --%>
 							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="user_pwd" id="user_pwd" class="iuser_txt" style="width:45%" value="${user_pwd}"></input>
							</td>
							<th>조직ID</th>
							<td>
								<select id="duty_cd" name="duty_cd" style="width: 55%; height: 70%;">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</select>
								<%-- <select name="duty_cd"  >
									<c:forEach var="dutyCD" items="${duty_cd}" varStatus="status2">
										<option value="<c:out value="${dutyCD.CODE1}" />" 
											<c:if test="${result.useYn == dutyCD.CODE1 }">selected="selected"</c:if>>
											<c:out value="${dutyCD.CODE_TXT}" />
										</option>
									</c:forEach>
								</select>  --%>
							</td>
						</tr>
						<tr>
							<th>비밀번호확인</th>
							<td>
								<input type="password" name="user_pwd_chk" id="user_pwd_chk" class="iuser_txt" style="width:45%"></input>
							</td>
						</tr>
						<tr>	
							<th colspan="2" align="left">사용자명</th>
							<td colspan="2" align="left">
								<input type="text" name="user_nm" id="user_nm" class="iuser_txt" style="width:90%" value="${user_nm}"></input>
							</td>
						</tr>
						<tr>
							<th colspan="2" align="left">휴대 전화</th>
							<td colspan="2" align="left">
								<select name="cphone_num1" id="cphone_num1" class="iuser_txt" maxlength="" style="width:25%">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="019">019</option>
								</select>-<input type="text" name="cphone_num2" id="cphone_num2" class="iuser_txt" maxlength="4" style="width:25%" value="${cphone_num2}"/>-<input type="text" name="cphone_num3" id="cphone_num3" class="iuser_txt" maxlength="4" style="width:25%" value="${cphone_num3}"/> 
							</td>
						</tr>
						<tr>
							<th colspan="2" align="left">이메일</th>
							<td colspan="2" align="left">
								<input type="text" name="email_id" id="email_id" class="iuser_txt" style="width:50%" value="${email_id}">@<input type="text" name="email_domain" id="email_domain" class="iuser_txt" style="width:50%" value="${email_domain}"> 
 							</td>
 						</tr>
						<tr>
							<th colspan="2" align="left">부서</th>
							<td colspan="2" align="left">
								<%-- <input type="hidden" id="dept_cd" name="dept_cd" value="${dept_cd}"/> --%> 
								<input type="text" id="dept_cd" name="dept_cd" value="${dept_cd}" style="width:65%"/>
								<input type="button" id="dept_sch_fbtn" name="dept_sch_fbtn"  value="부서검색"/>
							</td>
						</tr>
						<tr>
							<th colspan="2" align="left">내선전화</th>
							<td colspan="2" align="left">
							<select name="phone_num1" id="phone_num1" class="iuser_txt" maxlength="" style="width:25%">
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
								</select>-<input type="text" name="phone_num2" id="phone_num2" class="iuser_txt" maxlength="4" style="width:25%" value="${phone_num2}"/>-<input type="text" name="phone_num3" id="phone_num3" class="iuser_txt" maxlength="4" style="width:25%" value="${phone_num3}"/> 
							</td>
							
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


