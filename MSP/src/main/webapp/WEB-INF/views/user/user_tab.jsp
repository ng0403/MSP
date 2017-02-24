<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/mps/userJS/user_tab_js.js"></script>
<script src="${ctx}/resources/common/js/common.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Insert title here</title>
 <c:if test="${result=='1'}" var = "result"> 
	<script type="text/javascript">
		window.close();
		opener.parent.location.href = "userlist";
	</script>
 </c:if>
<style type="text/css">
.form-control{
	margin:none;
}
</style>

<script>
	$(document).ready(function() {
 		$('#dept_pop_div').hide();
 		$(".DEPT_POP_BACK").hide();
	      //검색버튼 클릭 
     	$("#dept_sch_fbtn").on("click", function() {
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
		
// 		var tmp = $('#user_id').val();
		
		if(tmp == null)
		{
			//$('#addsave_btn').CSS('display', "hidden");
			$('#joinform').find('input[type="text"]').attr('disabled',false).attr('readonly', false);
			$('#emp_no').css('display','none');
			$('#modifysave_btn').css('display','none');
			$('#dept_nm').attr('readonly',true);
			//$('#modifysave_btn').css("visibility","hidden");

		}else{
			$('#user_id').attr("readonly", true);
			$('#dept_nm').attr('readonly',true);
			$('#emp_no').css('display','block');
			$('#submit_btn').css('display','none');
			$('#joinform').find('input[type="text"]').attr('disabled',true);
		    $('#joinform').find('input[type="password"]').attr('disabled',true);
		    $('#joinform').find('input[type="button"]').attr('disabled',true);
	        $('#joinform').find('input[type="email"]').attr('disabled',true);
	        $('#joinform').find('select').attr('disabled',true);
			//$('#addsave_btn').css('visibility',"hidden");
		} 
			
		
		// 사용자 신규 추가(저장) 버튼
			$("#submit_btn").on("click", function() {
				var tmp = $('#Nuser_id').val();
				var user_pwd = $('#user_pwd').val();
				var user_pwd_chk = $('#user_pwd_chk').val();
				var rank_cd = $("#rank_cd option:selected").val();
				
				$('created_by').val(tmp);
				var tmplength = tmp.length;
				if(tmp != null){
// 					if(passwordCheck(1) == true){
					viewLoadingShow();
					$.ajax({
						url:"/user/userInsert" 
						, type:"post"
						, contentType:"application/json; charset=UTF-8"
						, dataType:"text"
						, data:JSON.stringify({
							user_id:$("#Nuser_id").val()
							, user_nm:$("#user_nm").val()
							, user_pwd:$("#user_pwd").val()
							, email_id:$("#email_id").val()
							, email_domain:$("#email_domain").val()
							, cphone_num1:$("#cphone_num1").val()
							, cphone_num2:$("#cphone_num2").val()
							, cphone_num3:$("#cphone_num3").val()
							, phone_num1:$("#phone_num1").val()
							, phone_num2:$("#phone_num2").val()
							, phone_num3:$("#phone_num3").val()
							, dept_cd:$("#dept_cd").val()
							, rank_cd:$("#rank_cd").val()
							, duty_cd:$("#duty_cd").val()
						}), 
						error:function(){
							alert("시스템 오류입니다. 관리자에게 문의하세요.");
						}, success:function(resultData){
							if(resultData == "SUCCESS"){
								alert("사용자 등록이 완료되었습니다.");
								userListInqr(1);
								$('.DEPTpop_main_div').hide();
								$('#userTabMask, #userTabWindow').hide();
								$('#userDetailMask, #userDetailWindow').hide();
							}viewLoadingHide();
							location.reload();
						}
					})
					
//					}
				
			}else{
				alert("신규 데이터를 입력하세요.");
			}
		});
		
		 var tmp = $('#user_id').val(); 

		//form 내부 전체 input tag 초기화
		  $("#btnReset_btn").click(function() {  
		         $("form").each(function() {  
		            this.reset();  
		         });  
		    });  
	 	/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".deptTrPop", function(){
			var dept_cd_pop = $(this).attr("dept_cd_pop");
			var user_nm_pop = $(this).attr("user_nm_pop");
			$('#dept_cd').val(dept_cd_pop);
			$('#dept_nm').val(user_nm_pop);
			var dept_cd_pop = $(this).attr("Ddept_cd_pop");
			var user_nm_pop = $(this).attr("Duser_nm_pop");
			$('#Ddept_cd').val(dept_cd_pop);
			$('#Ddept_nm').val(user_nm_pop);
		});
	}); 
		
		
 </script>
</head>
<body>
<div id="userTabMask" class="userMask_div"></div>
	<input type="hidden" id="ctx" value="${ctx}">
		<!-- Modal Main Div -->
	<div class="Npop_main_div" id="userTabWindow">
		
		<!-- Modal Navigation Div -->
		<div>
			<input type="button" id="userTabInpr_close_nfbtn" onclick="closeTab();" class="func_btn" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
		</div>
		
		<!-- Modal List Div -->
		<div class="modalL_list_div">
		<div class="table_div">
			<form method="post" id="joinform" >
				<table class="table table-hover">
					<tbody >
						<tr>
							<th style="padding-left: 1%; text-align: right;">사용자ID</th>
							<td style="width: 25%;">
								<input type="hidden" id="user_id_h" value="${user_id}">
								<input type="hidden" id="created_by" value="">
								<input type="hidden" id="active_flg" value="${active_flg}">
 								<input type="text" name="user_id" id="Nuser_id" class="inputTxt" maxlength="10" style=" width:100%" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"/><input type="text" name="emp_no" id="emp_no" class="inputTxt" style=" width:100%" value="${emp_no}"/>
 							</td>
 							<th style="padding-left: 1%; text-align: right;">직급</th>
 							<td style="padding-left: 1%;">
 								 <select name="rank_cd" id="rank_cd" class="inputTxt" style="width: 45%;">
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
							<td style="padding-left: 1%;">
								<input type="password" name="user_pwd" id="user_pwd" class="inputTxt" maxlength="20" style="width:45%" value="${user_pwd}"></input>
							</td>
							<th style="padding-left: 1%; text-align: right;">조직ID</th>
							<td style="padding-left: 1%;">
								 <select name="duty_cd" id="duty_cd" class="inputTxt" style="width: 45%;" >
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
							<td style="padding-left: 1%;">
								<input type="password" name="user_pwd_chk" id="user_pwd_chk" class="inputTxt" style="width:45%"></input>
							</td>
							<th></th>
							<td></td>
						</tr>
						<tr>	
							<th style="padding-left: 1%; text-align: right;" >사용자명</th>
							<td align="left" style="width: 30%; padding-left: 1%;">
								<input type="text" name="user_nm" id="user_nm" class="inputTxt" maxlength="10" style="width:90%" value=""></input>
							</td>
							<th></th>
							<td></td>
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">휴대 전화</th>
							<td style="padding-left: 1%;" align="left" colspan="3">
								<select name="cphone_num1" id="cphone_num1"  class="inputTxt" style="width:15%;  ">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="019">019</option>
								</select>-<input type="text" name="cphone_num2" id="cphone_num2" class="inputTxt" maxlength="4" style="width:25%;  margin-left: 1%;" value="${cphone_num2}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>-<input type="text" name="cphone_num3" id="cphone_num3"  maxlength="4" style="width:25%;   margin-left: 1%;" value="${cphone_num3}" class="inputTxt" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/> 
							</td>
							
							<td></td>
							
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">이메일</th>
							<td style="padding-left: 1%;"  align="left" colspan="3">
								<input type="text" name="email_id" id="email_id" maxlength="20"  class="inputTxt"  style="width:30%;   margin-right: 1%;" value="${email_id}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"> @ <input type="text" name="email_domain" id="email_domain"  class="inputTxt"  style="width:35%;  " value="${email_domain}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"> 
 							</td>
 						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">부서</th>
							<td  align="left" style=" padding-left: 1%;" colspan="3">
								<input type="hidden" id="dept_cd" name="dept_cd" value="${dept_cd}"/> 
								<input type="text" id="dept_nm" name="dept_nm" class="inputTxt" value="${dept_nm}" style="width:30%"/>
								<input type="button" class="btn btn-default btn-sm" id="dept_sch_fbtn" name="dept_sch_fbtn"  value="부서검색" class="" >
							</td>
							
						</tr>
						<tr>
							<th style="padding-left: 1%; text-align: right;">내선전화</th>
							<td style="padding-left: 1%;" colspan="3">
							<select name="phone_num1" id="phone_num1" class="inputTxt" style="width:15%;">
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
								</select> 
							<input type="text" name="phone_num2" id="phone_num2" class="inputTxt" maxlength="4" style="width:25%;  margin-left: 1%;" value="${phone_num2}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>
							-<input type="text" name="phone_num3" id="phone_num3" class="inputTxt" maxlength="4" style="width:25%;  margin-left: 1%;" value="${phone_num3}" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/>
							</td>
							
						</tr>
						
					</tbody>
				</table>
				
			</form>
			</div>
		<!-- Modal Btn Div -->
		<div class="modalL_btn_div" style="margin-top: 2%;">
			<input type="button" id="submit_btn" class="btn btn-primary btn-sm" value="추가"/>
			<input type="reset" id="btnReset_btn" class="btn btn-primary btn-sm" value="취소"/>
<!-- 			<input type="button" id="addsave_btn" class="iuser_tab_bt" value="저장"/> -->
<!-- 			<input type="button" id="modifysave_btn" class="btn btn-primary btn-sm"  value="저장"/> -->
		</div>
		</div>
		
	</div>
<!-- 	<div id="dept_pop_div" style="font-size:11.5px;"> -->
<%-- 		<jsp:include page="../dept/deptlist_pop.jsp"></jsp:include> --%>
<!-- 	</div>  -->
	
	

</body>
</html>


