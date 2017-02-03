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
				var user_pwd = $('#user_pwd').val();
				var user_pwd_chk = $('#user_pwd_chk').val();
				
				$('created_by').val(tmp);
				var tmplength = tmp.length;
				if(entry_flg != 1){
					alert("이미 존재하는 계정입니다.");
				}else{
					if(tmplength > 0){
						//passwordCheck();
						if(passwordCheck() == true){
							$('form').attr("action", "${ctx}/user/userInsert").submit();
						}
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
				var user_pwd = $('#user_pwd');
				var user_pwd_chk = $('#user_pwd_chk');
				var tmplength = tmp.length;
				if(entry_flg != 1){
					//passwordCheck();
					if(passwordCheck() == true){
						$('form').attr("action", "${ctx}/user/userMdfy?user_id = "+tmp).submit();
					}
					
				}else{
					alert("신규 데잍를 입력하세요.");
				}
			});
		
		var tmp = $('#user_id').val();
		
		//한글입력 안되게 처리

		  $("input[name=aaa]").keyup(function(event){ 

		   if (!(event.keyCode >=37 && event.keyCode<=40)) {

		    var inputVal = $(this).val();

		    $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));

		   }

		  });
		//form 내부 전체 input tag 초기화
		  $("#btnReset_btn").click(function() {  
		         $("form").each(function() {  
		            this.reset();  
		         });  
		    });  
	});
		
		
 </script>
 
 
 <!-- 숫자키와 편집버튼만 입력하는 function -->
 <script>

	function onlyNumber(event){
	 	event = event || window.event;
	 	var keyID = (event.which) ? event.which : event.keyCode;
	 	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8|| keyID == 9|| keyID == 18 || keyID == 46 || keyID == 37 || keyID == 39 ) 
	 		return;
	 	else
	 		return false;
	 }
	 function removeChar(event) {
	 	event = event || window.event;
	 	var keyID = (event.which) ? event.which : event.keyCode;
	 	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
	 		return;
	 	else
	 		event.target.value = event.target.value.replace(/[^0-9]/g, "");
	 }
	 /* 숫자만 입력받기 */
	   function fn_press(event, type) {
	       if(type == "numbers") {
	           if(event.keyCode < 48 || event.keyCode > 57) return false;
	           //onKeyDown일 경우 좌, 우, tab, backspace, delete키 허용 정의 필요
	       }
	   }
	 /* 한글입력 방지 */
	    function fn_press_han(obj)
	    {
	        //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
	        if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
	        || event.keyCode == 46 ) return;
	        //obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	        obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	    }
	 
	    //비밀번호 유효성 검사 (영문,숫자,특수문자 혼합하여 8자리~20자리 이내.(비밀번호 표준))
		  function passwordCheck() {
			var userID = document.getElementById("user_id").value;
			var user_pwd = document.getElementById("user_pwd").value; 
			var user_pwd_chk = document.getElementById("user_pwd_chk").value; 
			
			// 재입력 일치 여부 
			if (user_pwd != user_pwd_chk) { 
				alert("입력한 두 개의 비밀번호가 서로 일치하지 않습니다.");
				return ; 
				} 
			// 길이 
			if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{6,15}$/.test(user_pwd_chk)) 
			{ 
				alert("비밀번호는 숫자, 영문, 특수문자 조합으로 6~15자리를 사용해야 합니다.");
				return ;
			} 
			// 영문, 숫자, 특수문자 2종 이상 혼용 
			var chk = 0; 
			if(user_pwd.search(/[0-9]/g) != -1 ) chk ++; 
			if(user_pwd_chk.search(/[a-z]/ig) != -1 ) chk ++; 
			if(user_pwd_chk.search(/[!@#$%^&*()?_~]/g) != -1 ) chk ++; 
			if(chk < 2) {
				alert("비밀번호는 숫자, 영문, 특수문자를 두가지이상 혼용하여야 합니다."); 
				return ; 
				}
			// 동일한 문자/숫자 4이상, 연속된 문자 
			if(/(\w)\1\1\1/.test(user_pwd_chk) || isContinuedValue(user_pwd_chk)) 
			{
				alert("비밀번호에 4자 이상의 연속 또는 반복 문자 및 숫자를 사용하실 수 없습니다."); 
				return ; 
				}
			// 아이디 포함 여부 
			if(user_pwd_chk.search(userID)>-1) 
			{
				alert("ID가 포함된 비밀번호는 사용하실 수 없습니다."); 
				return ;
				}
			/* // 기존 비밀번호와 새 비밀번호 일치 여부 
			if (user_pwd == user_pwd_chk) 
			{
				alert("기존 비밀본호와 새 비밀번호가 일치합니다."); 
				return false; 
				} */ 
				
				return true;
			} 
	
		  function isContinuedValue(value) {
			  console.log("value = " + value);
			  var intCnt1 = 0; 
			  var intCnt2 = 0; 
			  var temp0 = ""; 
			  var temp1 = ""; 
			  var temp2 = ""; 
			  var temp3 = ""; 
			  for (var i = 0; i < value.length-3; i++) {
				  console.log("=========================");
				  temp0 = value.charAt(i); 
				  temp1 = value.charAt(i + 1); 
				  temp2 = value.charAt(i + 2); 
				  temp3 = value.charAt(i + 3); 
				  console.log(temp0); console.log(temp1); console.log(temp2); console.log(temp3);
				  if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == 1 && temp1.charCodeAt(0) - temp2.charCodeAt(0) == 1 && temp2.charCodeAt(0) - temp3.charCodeAt(0) == 1) {
					  intCnt1 = intCnt1 + 1;
				  } 
				  if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == -1 && temp1.charCodeAt(0) - temp2.charCodeAt(0) == -1 && temp2.charCodeAt(0) - temp3.charCodeAt(0) == -1) {
					  intCnt2 = intCnt2 + 1;
				  }
				  console.log("=========================");
				  } 
			  console.log(intCnt1 > 0 || intCnt2 > 0); 
			  return (intCnt1 > 0 || intCnt2 > 0); 
			  }

	 

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
 								<input type="text" name="user_id" id="user_id" class="iuser_txt" style=" width:40%" value="${user_id}"onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"/><input type="text" name="emp_no" id="emp_no" class="iuser_txt" style=" width:40%" value="${emp_no}"/>
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
								<input type="text" name="user_nm" id="user_nm" class="iuser_txt" maxlength="10" style="width:90%" value="${user_nm}"></input>
							</td>
						</tr>
						<tr>
							<th colspan="2" align="left">휴대 전화</th>
							<td colspan="2" align="left">
								<select name="cphone_num1" id="cphone_num1" class="iuser_txt"  style="width:25%">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="019">019</option>
								</select>-<input type="text" name="cphone_num2" id="cphone_num2" class="iuser_txt" maxlength="4" style="width:25%" value="${cphone_num2}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>-<input type="text" name="cphone_num3" id="cphone_num3" class="iuser_txt" maxlength="4" style="width:25%" value="${cphone_num3}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/> 
							</td>
						</tr>
						<tr>
							<th colspan="2" align="left">이메일</th>
							<td colspan="2" align="left">
								<input type="text" name="email_id" id="email_id" class="iuser_txt" style="width:50%" value="${email_id}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;">@<input type="text" name="email_domain" id="email_domain" class="iuser_txt" style="width:50%" value="${email_domain}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"> 
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
							<select name="phone_num1" id="phone_num1" class="iuser_txt" style="width:25%">
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
								</select>-<input type="text" name="phone_num2" id="phone_num2" class="iuser_txt" maxlength="4" style="width:25%" value="${phone_num2}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>-<input type="text" name="phone_num3" id="phone_num3" class="iuser_txt" maxlength="4" style="width:25%" value="${phone_num3}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/> 
							</td>
							
						</tr>
						
					</tbody>
				</table>
				
			</form>
		<!-- Modal Btn Div -->
		<div class="modalL_btn_div">
			<input type="button" id="submit_btn" class="iuser_tab_bt" value="추가"/>
			<input type="button" id="modify_btn" class="iuser_tab_bt" value="편집" />
			<input type="reset" id="btnReset_btn" class="iuser_tab_bt" value="취소"/>
			<!-- <input type="button" id="addsave_btn" class="iuser_tab_bt" value="저장"/> -->
			<input type="button" id="modifysave_btn" class="iuser_tab_bt"  value="저장"/>
		</div>
		</div>
		
	</div>
	
</body>
</html>


