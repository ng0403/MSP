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
		opener.parent.location.href = "codeInqr";
	</script>
</c:if>
 
<script>

	$(document).ready(function() {
		var entry_flg = ${entry_flg}
		var tmp = $('#grp_cd').val();
		
		if(entry_flg == 1)
		{
			//$('#joinform').find('input[type="text"]').attr('disabled',false).attr('readonly', false);
		}
		else
		{
			//$('#USER_ID').attr("readonly", true);
			//$('#joinform').find('input[type="text"]').attr('disabled',true);
		    //$('#joinform').find('input[type="password"]').attr('disabled',true);
	        //$('#joinform').find('input[type="email"]').attr('disabled',true);
			//$('#addsave_btn').css('visibility',"hidden");	
		} 
		
		//추가 버튼
		$("#submit_btn").on("click", function() {
			var entry_flg = ${entry_flg}
			var tmp = $('#USER_ID').val();
			var tmplength = tmp.length;
				
			if(entry_flg != 1){
				alert("이미 존재하는 계정입니다.");
			}
			else
			{
				if(tmplength > 0){
					$('form').attr("action", "${ctx}/usertest/userInsert").submit();
				}
				else
				{
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
							<th>공통코드</th>
							<td>
								<input type="text" name="grp_cd" id="grp_cd" class="iuser_txt" style=" width:90%" value="${grp_cd}"></input></td>
							<th>공통코드명</th>
							<td>
								<input type="text" name="grp_nm" id="grp_nm" class="iuser_txt" style="width:90%" value="${grp_nm}"/>
							</td>
							<th>공통코드 설명</th>
							<td>
								<input type="text" name="grp_desc" id="grp_desc" class="iuser_txt" style="width:90%" value="${grp_desc}"/>
							</td>
							<th>상세코드</th>
							<td>
								<input type="text" name="code1" id="code1" class="iuser_txt" style="width:90%" value="${code1}" />
							</td>
							<th>상세코드명</th>
							<td>
								<input type="text" name="code_txt" id="code_txt" class="iuser_txt" style="width:90%" value="${code_txt}" /> 
 							</td>
							<th>상세코드 설명</th>
							<td>
								<input type="text" name="code_desc" id="code_desc" class="iuser_txt" maxlength="12" style="width:90%" value="${code_desc}" />
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


