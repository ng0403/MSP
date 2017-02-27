<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<c:set var="SessionID" value="${sessionScope.user_id}" />
<%-- <script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> --%>
<%-- <script src="${ctx}/resources/common/js/mps/userJS/user_tab_js.js"></script> --%>
<%-- <script src="${ctx}/resources/common/js/common.js"></script> --%>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/userCSS/userCSS.css" type="text/css" />
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" /> --%>
 <title>Insert title here</title>
 <c:if test="${result=='1'}" var = "result"> 
	<script type="text/javascript">
		window.close();
		opener.parent.location.href = "userInqr";
	</script>
 </c:if>
 
<script>
	$(document).ready(function() {
 		$('#Ddept_pop_div').hide();
 		$('#DEPT_POP_BACK').hide();
	      //부서검색버튼 클릭 
   	$("#Ddept_sch_fbtn").on("click", function() {
   		$(".DEPTpop_main_div").show();
   		$(".DEPT_POP_BACK").show();
 		$(".DEPTpop_main_div").center();
   		deptListInqrPop(1);
   		
  		});
   	jQuery.fn.center = function () {
   	    this.css("position","absolute");
   	    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
   	    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
   	    return this;
   	}
		var tmp = $('#Duser_id').val();
		
		if(tmp == null)
		{
			//$('#addsave_btn').CSS('display', "hidden");
			$('#Djoinform').find('input[type="text"]').attr('disabled',false).attr('readonly', false);
			$('#Demp_no').css('display','none');
			$('#Dmodifysave_btn').css('display','none');
			$('#Ddept_nm').attr('readonly',true);
			//$('#modifysave_btn').css("visibility","hidden");

		}else{
			$('#Duser_id').attr("readonly", true);
			$('#Demp_no').css('display','block');
			$('#Dsubmit_btn').css('display','none');
			$('#Ddept_nm').attr('readonly',true);
			$('#Djoinform').find('input[type="text"]').attr('disabled',true);
		    $('#Djoinform').find('input[type="password"]').attr('disabled',true);
		    $('#Djoinform').find('input[type="button"]').attr('disabled',true);
	        $('#Djoinform').find('input[type="email"]').attr('disabled',true);
	        $('#Djoinform').find('select').attr('disabled',true);
			//$('#addsave_btn').css('visibility',"hidden");
		} 
			
		
		//추가 버튼
			$("#Dsubmit_btn").on("click", function() {
				var tmp = $('#Duser_id').val();
				var user_pwd = $('#Duser_pwd').val();
				var user_pwd_chk = $('#Duser_pwd_chk').val();
				var rank_cd = $("#Drank_cd option:selected").val();
				$('created_by').val(tmp);
				var tmplength = tmp.length;
				if(tmp != null){
					if(tmplength > 0){
						//passwordCheck();
						if(passwordCheck(2) == true){
							$('#Djoinform').attr("action", "${ctx}/user/userInsert").submit(); 
							$('#dept_pop_div').hide();
							$('#Ddept_pop_div').hide();
							userListInqr(1);
							$('#userTabMask, #userTabWindow').hide();
							$('#userDetailMask, #userDetailWindow').hide();
						}
					}else{
							alert("사용자 아이디가 없습니다.");
						}
				}else{
					alert("이미 존재하는 계정입니다.");
				}
			});
		//편집 버튼 
			$("#Dmodify_btn").on("click", function() {
				var tmp = $('#Duser_id').val();
				$('created_by').val(tmp);
				
				var tmplength = tmp.length;
				if(tmp != null){
					$('#Djoinform').find('input[type="text"]').attr('disabled',false);
					$('#Djoinform').find('input[type="password"]').attr('disabled',false);
					$('#Djoinform').find('input[type="button"]').attr('disabled',false);
					$('#Djoinform').find('select').attr('disabled',false);
					$('#Duser_id').attr("readonly", true);
					$('#Demp_no').attr("readonly", true);
					$('#Daddsave_btn').css("visibility","hidden");
					$('#Dmodify_btn').attr("disabled", true);
					$('#Dsubmit_btn').attr("disabled", true);
				}else{
					alert("신규 데이터를 입력하세요.");
				}
			});
		//편집 저장 버튼
			$("#Dmodifysave_btn").on("click", function() {
				var tmp = $('#Duser_id').val();
				var user_pwd = $('#Duser_pwd');
				var user_pwd_chk = $('#Duser_pwd_chk');
				var rank_cd = $("#Drank_cd option:selected").val();
				var tmplength = tmp.length;
				if(tmp != null){
					//passwordCheck();
// 					if(passwordCheck(2) == true){
						viewLoadingShow();
						$.ajax({
							url:"/user/userMdfy" 
							, type:"post"
							, contentType:"application/json; charset=UTF-8"
							, dataType:"text"
							, data:JSON.stringify({
								user_id:$("#Duser_id").val()
								, user_nm:$("#Duser_nm").val()
								, user_pwd:$("#Duser_pwd").val()
								, email_id:$("#Demail_id").val()
								, email_domain:$("#Demail_domain").val()
								, cphone_num1:$("#Dcphone_num1").val()
								, cphone_num2:$("#Dcphone_num2").val()
								, cphone_num3:$("#Dcphone_num3").val()
								, phone_num1:$("#Dphone_num1").val()
								, phone_num2:$("#Dphone_num2").val()
								, phone_num3:$("#Dphone_num3").val()
								, dept_cd:$("#Ddept_cd").val()
								, rank_cd:$("#Drank_cd").val()
								, duty_cd:$("#Dduty_cd").val()
							}), 
							error:function(){
								alert("시스템 오류입니다. 관리자에게 문의하세요.");
							}, success:function(resultData){
								if(resultData == "SUCCESS"){
									alert("사용자 수정이 완료되었습니다.");
									userListInqr(1);
									$('.DEPTpop_main_div').hide();
									$('#userTabMask, #userTabWindow').hide();
									$('#userDetailMask, #userDetailWindow').hide();
								}viewLoadingHide();
								location.reload();
							}
						})
						
// 					}
					
				}else{
					alert("신규 데이터를 입력하세요.");
				}
			});
		
		 var tmp = $('#Duser_id').val(); 
		 
		//form 내부 전체 input tag 초기화
		  $("#DbtnReset_btn").click(function() {  
		         $("form").each(function() {  
		            this.reset();  
		         });  
		    });  
		  

	     	/*부서명 클릭 시 상세정보 출력 이벤트*/
	    	$(document).on("click", ".deptTrPop", function(){
	    		var dept_cd_pop = $(this).attr("dept_cd_pop");
	    		var user_nm_pop = $(this).attr("user_nm_pop");
	    		$('#Ddept_cd').val(dept_cd_pop);
	    		$('#Ddept_nm').val(user_nm_pop);
	    		var dept_cd_pop = $(this).attr("Ddept_cd_pop");
				var user_nm_pop = $(this).attr("Duser_nm_pop");
				$('#Ddept_cd').val(dept_cd_pop);
				$('#Ddept_nm').val(user_nm_pop);
	    	});
	}); 
		
		
 </script>
 
</head>
<body>
<div id="userDetailMask" class="userMask_div"></div>
	<input type="hidden" id="ctx" value="${ctx}">
		<!-- Modal Main Div -->
	<div class="Dpop_main_div"id="userDetailWindow">
		
		<!-- Modal Navigation Div -->
		<div>
			<input type="button" id="userTabInpr_close_nfbtn" onclick="closeTab();" class="func_btn" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
		</div>
		
		<!-- Modal List Div -->
		<div class="modalL_list_div">
		<div class="table_div">
			<form method="post" id="Djoinform" >
				<table id="Dtable" class="table table-hover">
					<tbody id="Dtbody1">
					
						<tr>
							<th style="padding-left: 1%; text-align: right;">사용자ID</th>
							<td style="width: 25%;">
								<input type="hidden" id="Duser_id_h" value="${user_id}">
								<input type="hidden" id="Dcreated_by" value="">
								<input type="hidden" id="Dactive_flg" value="${active_flg}">
 								<input type="text" name="Duser_id" id="Duser_id" class="inputTxt" style=" width:100%" value="${user_id}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"/><input type="text" name="emp_no" id="Demp_no" class="inputTxt" style=" width:100%" value="${emp_no}"/>
 							</td>
 							<th style="padding-left: 1%; text-align: right;">직급</th>
 							<td>
 								 <select id="Drank_cd" name="rank_cd" class="inputTxt" style="width: 45%;"  >
									<c:forEach var="rankCd" items="${rank_cd_list}" varStatus="status2">
										<option value="<c:out value="${rankCd.rank_cd}" />" 
											<c:if test="${rank_cd == rankCd.rank_cd }">selected="selected"</c:if>>
											${rankCd.rank_nm}
										</option>
									</c:forEach>
								</select> 
 							</td>
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">비밀번호</th>
							<td>
								<input type="password" name="user_pwd" id="Duser_pwd" class="inputTxt" maxlength="20" style="width:45%" value="${user_pwd}"></input>
							</td>
							<th style="padding-left: 1%; text-align: right;">조직ID</th>
							<td>
								 <select name="duty_cd" id="Dduty_cd" class="inputTxt" style="width: 45%;">
									<c:forEach var="dutyCd" items="${duty_cd_list}" varStatus="status2">
										<option value="<c:out value="${dutyCd.duty_cd}" />" 
											<c:if test="${duty_cd == dutyCd.duty_cd }">selected="selected"</c:if>>
											${dutyCd.duty_nm}
										</option>
									</c:forEach>
								</select> 
							</td>
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">비밀번호확인</th>
							<td>
								<input type="password" name="user_pwd_chk" id="Duser_pwd_chk" class="inputTxt" style="width:45%"></input>
							</td>
							<th>
							</th>
							<td>
							</td>
						</tr>
						<tr>	
							<th style="padding-left: 1%; text-align: right;"  >사용자명</th>
							<td>
								<input type="text" name="user_nm" id="Duser_nm" class="inputTxt" maxlength="10" style="width:90%" value="${user_nm}"></input>
							</td>
							<th>
							</th>
							<td>
							</td>
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;"  >휴대 전화</th>
							<td colspan="3">
								<select name="cphone_num1" id="Dcphone_num1" class="inputTxt"  style="width:15%;">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="019">019</option>
								</select>- 
								<input type="text" name="cphone_num2" id="Dcphone_num2" class="inputTxt" maxlength="4" style="width:25%;  margin-left: 1%;"  value="${cphone_num2}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>-
								<input type="text" name="cphone_num3" id="Dcphone_num3" class="inputTxt" maxlength="4" style="width:25%;  margin-left: 1%;"  value="${cphone_num3}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;"  >이메일</th>
							<td colspan="3">
								<input type="text" name="email_id" id="Demail_id" class="inputTxt"  style="width:30%;  margin-right: 1%;" maxlength="20" value="${email_id}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;">  @ 
 								<input type="text" name="email_domain" id="Demail_domain" class="inputTxt"  style="width:35%;"  maxlength="20"  value="${email_domain}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;">
 							
 						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">부서</th>
							<td style="padding-left: 1%;" colspan="3">
								<input type="text" id="Ddept_nm" name="dept_nm" class="inputTxt" value="${dept_nm}" style="width:30%"/>
								<input type="button" class="btn btn-default btn-sm" id="Ddept_sch_fbtn" name="dept_sch_fbtn"  value="부서검색" class="" >
								<input type="hidden" id="Ddept_cd" name="dept_cd" value="${dept_cd}"/>
							</td>
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">내선전화</th>
							<td colspan="3">
							<select name="phone_num1" id="Dphone_num1" class="inputTxt" style="width:15%;" >
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
								</select>- 
							<input type="text" name="phone_num2" id="Dphone_num2" class="inputTxt" maxlength="4" style="width:30%; margin-left: 1%;" value="${phone_num2}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>
							-<input type="text" name="phone_num3" id="Dphone_num3" class="inputTxt" maxlength="4" style="width:30%;   margin-left: 1%;" value="${phone_num3}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>
							</td>
							
							
						</tr>
						
					</tbody>
				</table>
				
			</form>
			</div>
		<!-- Modal Btn Div -->
		<div class="modalL_btn_div" style="margin-top: 2%;">
		<c:choose>
			<c:when test="${SessionID == 'admin'}">
				<input type="button" id="Dmodify_btn" class="btn btn-primary btn-sm" value="편집" />
				<input type="reset" id="DbtnReset_btn" class="btn btn-default btn-sm" value="취소"/>
				<input type="button" id="Dmodifysave_btn" class="btn btn-primary btn-sm"  value="저장"/>
			</c:when>
		</c:choose>
		</div>
		</div>
</div>	
<!-- 	<div id="Ddept_pop_div" style="font-size:11.5px;"> -->
<%-- 		<jsp:include page="../dept/deptlist_pop.jsp"></jsp:include> --%>
<!-- 	</div>  -->
	

</body>
</html>


