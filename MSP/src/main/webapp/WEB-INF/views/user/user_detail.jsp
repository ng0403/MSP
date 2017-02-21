<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/mps/userJS/user_tab_js.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/user/userTab.css" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <title>Insert title here</title>
 <c:if test="${result=='1'}" var = "result"> 
	<script type="text/javascript">
		window.close();
		opener.parent.location.href = "userlist";
	</script>
 </c:if>
<style type="text/css">
/* body { margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; } */

#dept_pop_div { display: none; position:absolute; width:50%; height:75%; left:80%; top:30%; 
				background-color: #c0c4cb	; overflow: auto;}

</style>
 
<script>
	$(document).ready(function() {
 		$('#dept_pop_div').hide();
	      //부서검색버튼 클릭 
   	$("#dept_sch_fbtn").on("click", function() {
   		$("#dept_pop_div").show();
   		$("#dept_pop_div").center();
   		deptListInqrPop(1);
   		
  		});
   	jQuery.fn.center = function () {
   	    this.css("position","absolute");
   	    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
   	    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
   	    return this;
   	}
		var entry_flg = ${entry_flg}
		var tmp = $('#user_id').val();
		
		if(entry_flg == 1)
		{
			//$('#addsave_btn').CSS('display', "hidden");
			$('#joinform').find('input[type="text"]').attr('disabled',false).attr('readonly', false);
			$('#emp_no').css('display','none');
			$('#modifysave_btn').css('display','none');
			$('#dept_nm').attr('readonly',true);
			//$('#modifysave_btn').css("visibility","hidden");

		}else{
			$('#user_id').attr("readonly", true);
			$('#emp_no').css('display','block');
			$('#submit_btn').css('display','none');
			$('#dept_nm').attr('readonly',true);
			$('#joinform').find('input[type="text"]').attr('disabled',true);
		    $('#joinform').find('input[type="password"]').attr('disabled',true);
		    $('#joinform').find('input[type="button"]').attr('disabled',true);
	        $('#joinform').find('input[type="email"]').attr('disabled',true);
	        $('#joinform').find('select').attr('disabled',true);
			//$('#addsave_btn').css('visibility',"hidden");
			
		} 
			
		
		//추가 버튼
			$("#submit_btn").on("click", function() {
				var entry_flg = ${entry_flg}
				var tmp = $('#user_id').val();
				var user_pwd = $('#user_pwd').val();
				var user_pwd_chk = $('#user_pwd_chk').val();
				var rank_cd = $("#rank_cd option:selected").val();
				
				$('created_by').val(tmp);
				var tmplength = tmp.length;
				if(entry_flg != 1){
					alert("이미 존재하는 계정입니다.");
				}else{
					if(tmplength > 0){
						//passwordCheck();
						if(passwordCheck() == true){
							$('#joinform').attr("action", "${ctx}/user/userInsert").submit(); 
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
					$('#joinform').find('input[type="button"]').attr('disabled',false);
					$('#joinform').find('select').attr('disabled',false);
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
				alert(tmp);
				var user_pwd = $('#user_pwd');
				var user_pwd_chk = $('#user_pwd_chk');
				var rank_cd = $("#rank_cd option:selected").val();
				var tmplength = tmp.length;
				if(entry_flg != 1){
					//passwordCheck();
					if(passwordCheck() == true){
						$('#joinform').attr("action", "${ctx}/user/userMdfy?user_id = "+tmp).submit();
					}
					
				}else{
					alert("신규 데이터를 입력하세요.");
				}
			});
		
		 var tmp = $('#user_id').val(); 
		 
		 
		 $("#modal_trigger").leanModal({ top: 200, overlay: 0.6, closeButton: ".modal_close" });

	        $(function () {
	            // Calling Login Form
	            //$("#login_form").click(function () {
	            //$(".user_login").show();
	            //return false;
	            //});

	        })
		
		/* // 한글입력 안되게 처리

		  $("input[name=aaa]").keyup(function(event){ 

		   if (!(event.keyCode >=37 && event.keyCode<=40)) {

		    var inputVal = $(this).val();

		    $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));

		   }

		  });*/
		//form 내부 전체 input tag 초기화
		  $("#btnReset_btn").click(function() {  
		         $("form").each(function() {  
		            this.reset();  
		         });  
		    });  
		  
	      //부서검색버튼 클릭 
	     	$("#dept_sch_fbtn").on("click", function() {
	     		
	    			var popUrl = "dept_Pop_sch_list";
	    			var popOption = "width=650, height=450, resize=no, scrollbars=no, status=no, location=no, directories=no;";
	    			window.open(popUrl, "", popOption);
	    		});
	     	/*부서명 클릭 시 상세정보 출력 이벤트*/
	    	$(document).on("click", ".deptTrPop", function(){
	    		var dept_cd_pop = $(this).attr("dept_cd_pop");
	    		var user_nm_pop = $(this).attr("user_nm_pop");
	    		$('#dept_cd').val(dept_cd_pop);
	    		$('#dept_nm').val(user_nm_pop);
	    	});
	}); 
		
		
 </script>
 
 <script type="text/javascript">
/*  function changeDiscType(){
		if( $("#rank_cd option:selected").val() == "1"){
			$('.discount_cost').text("*할인율");
			$('#td_disc_type').html("<input name='disc_rate' id='disc_rate' type='text' maxlength='2' max='99'>%")
		}else if($("#cb_disc_type option:selected").val() == "2"){
			$('.discount_cost').text("*할인금액");
			$('#td_disc_type').html("<input name='disc_amt' id='disc_amt' type='text' maxlength='6' max='999999'>원")
		}else{
			return;
		}
	} */
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
							<td style="width: 25%;">
								<input type="hidden" id="user_id_h" value="${user_id}">
								<input type="hidden" id="created_by" value="">
								<input type="hidden" id="active_flg" value="${active_flg}">
 								<input type="text" name="user_id" id="user_id" class="iuser_txt" style=" width:100%" value="${user_id}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"/><input type="text" name="emp_no" id="emp_no" class="iuser_txt" style=" width:100%" value="${emp_no}"/>
 							</td>
 							<th>직급</th>
 							<td>
 								 <select name="rank_cd"  >
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
							<th>비밀번호</th>
							<td>
								<input type="password" name="user_pwd" id="user_pwd" class="iuser_txt" maxlength="20" style="width:45%" value="${user_pwd}"></input>
							</td>
							<th>조직ID</th>
							<td>
								 <select name="duty_cd"  >
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
							<th>비밀번호확인</th>
							<td>
								<input type="password" name="user_pwd_chk" id="user_pwd_chk" class="iuser_txt" style="width:45%"></input>
							</td>
						</tr>
						<tr>	
							<th  align="left">사용자명</th>
							<td colspan="2" align="left">
								<input type="text" name="user_nm" id="user_nm" class="iuser_txt" maxlength="10" style="width:90%" value="${user_nm}"></input>
							</td>
						</tr>
						<tr>
							<th  align="left">휴대 전화</th>
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
							<th  align="left">이메일</th>
							<td colspan="2" align="left">
								<input type="text" name="email_id" id="email_id" class="onlyEng" maxlength="20" style="width:35%" value="${email_id}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;">@<input type="text" name="email_domain" id="email_domain" class="iuser_txt" maxlength="20" style="width:50%" value="${email_domain}" onkeypress="fn_press_han(this);" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"> 
 							</td>
 						</tr>
						<tr>
							<th  align="left">부서</th>
							<td colspan="2" align="left">
								<input type="hidden" id="dept_cd" name="dept_cd" value="${dept_cd}"/> 
								<input type="text" id="dept_nm" name="dept_nm" value="${dept_nm}" style="width:65%"/>
								<input type="button" id="dept_sch_fbtn" name="dept_sch_fbtn"  value="부서검색" class="" data-toggle="modal" data-target="#myModal" data-backdrop="static" >
							</td>
						</tr>
						<tr>
							<th  align="left">내선전화</th>
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
	<div id="dept_pop_div" style="font-size:11.5px;">
		<jsp:include page="../dept/deptlist_pop.jsp"></jsp:include>
	</div> 
	

</body>
</html>


