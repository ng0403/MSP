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
								<input type="hidden" id="user_id_h" value="${list.user_id}">
								<input type="hidden" id="active_flg" value="${list.active_flg}">
 								<input type="text" name="user_id" id="user_id" class="iuser_txt" style=" width:90%" value="${list.user_id}"></input>
 							</td>
 							<th>직급</th>
 							<td>
 								<select>
									<option></option>
									<option></option>
									<option></option>
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
								<input type="password" name="user_pwd" id="user_pwd" class="iuser_txt" style="width:90%" value="${list.user_pwd}"></input>
							</td>
							<th>조직ID</th>
							<td>
								<select>
									<option></option>
									<option></option>
									<option></option>
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
								<input type="password" name="user_pwd_chk" id="user_pwd_chk" class="iuser_txt" style="width:90%"></input>
							</td>
						</tr>
						<tr>	
							<th>사용자명</th>
							<td>
								<input type="text" name="user_nm" id="user_nm" class="iuser_txt" style="width:90%" value="${list.user_nm}"></input>
							</td>
						</tr>
						<tr>
							<th>휴대 전화</th>
							<td>
								<select name="cphone_num1" id="cphone_num1" class="iuser_txt" maxlength="" style="width:90%" value="${list.cphone_num1}">
									<option name="cphone_num1" id="cphone_num1" class="iuser_txt" maxlength="" style="width:90%"value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="019">019</option>
								</select>-<input type="text" name="cphone_num2" id="cphone_num2" class="iuser_txt" maxlength="4" style="width:90%" value="${list.cphone_num2}"/>-<input type="text" name="cphone_num3" id="cphone_num3" class="iuser_txt" maxlength="4" style="width:90%" value="${list.cphone_num3}"/> 
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" name="email_id" id="email_id" class="iuser_txt" style="width:90%" value="${list.email_id}">@<input type="text" name="email_domain" id="email_domain" class="iuser_txt" style="width:90%" value="${list.email_domain}"> 
 							</td>
 						</tr>
						<tr>
							<th>부서</th>
							<td>
								<input type="hidden" id="dept_cd" name="dept_cd" value="${list.dept_cd}"/> 
								<input type="text" id="dept_nm" name="dept_nm" value="${list.dept_nm}"/>
								<input type="button" id="dept_sch_fbtn" name="dept_sch_fbtn"  value="부서검색"/>
							</td>
						</tr>
						<tr>
							<th>내선전화</th>
							<td>
							<select name="phone_num1" id="phone_num1" class="iuser_txt" maxlength="" style="width:90%" value="${list.phone_num1}">
									<option name="phone_num1" id="phone_num1" class="iuser_txt" maxlength="3" style="width:90%"value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
								</select>-<input type="text" name="phone_num2" id="phone_num2" class="iuser_txt" maxlength="4" style="width:90%" value="${list.phone_num2}"/>-<input type="text" name="phone_num3" id="phone_num3" class="iuser_txt" maxlength="4" style="width:90%" value="${list.phone_num3}"/> 
							</td>
							
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


