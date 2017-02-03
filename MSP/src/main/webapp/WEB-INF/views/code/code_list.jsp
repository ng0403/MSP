<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@include file="../include/header.jsp"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<title>Code List</title>

</head>
<body>

<!--Main_Div  -->
<div class="main_div">

	<!-- Navigation Div -->
	<div class="navi_div">■ 코드관리</div>
		
	<!-- Search Cover Div -->
	<div class="search_div">
		<div class="search2_div">
		</div>
		<div class="search2_div">
		</div>
	</div>
	
	<!-- List Cover Div -->
	<div class="list_div">
		<div class="list2_div">
			<form name="delAllForm" id="delAllForm" method="post" action="codeDetailDel" >	
			<table id="mastertable" class="table table-bordered" width="90%">
				<thead>
					<tr>
						<th><input id="checkall" type="checkbox"/></th>
						<th>공통코드</th>
						<th>공통코드명</th>
						<th>상세코드</th>
						<th>상세코드명</th>
					</tr>
				</thead>
				<tbody id="codeListTbody" >
					<c:forEach var="codeInqrList" items="${codeInqrList}" >
					<tr data_num="${codeInqrList.CODE1}" onmouseover="this.style.background='#c0c4cb'" onmouseout="this.style.background='white'">
						<th scope="row">
							<input type="checkbox" name="del_code" id="del_code" value="${codeInqrList.CODE1}">
						</th>
						<td>
							<span class="open_detail">${codeInqrList.GRP_CD}</span>
	 					</td>
	 					<td>
							${codeInqrList.GRP_NM}
						</td>
						<td>
							${codeInqrList.CODE1}
						</td>
						<td>
							${codeInqrList.CODE_TXT}
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</form>
		</div>
		
		<div class="paging_div">
			<input type="button" id="codeMaster_add_btn" class="btn btn-default" value="추가"/>
  			<input type="button" id="codeMaster_del_btn" class="btn btn-default" value="삭제"/>
		</div>
		<br>
		
		<h4>공통코드 상세</h4>
		<div class="insert1_div">
			<form method="post" id="joinform1" action="codeMasterAdd" >
				<table class="table">
					<tbody id="tbody1">
						<tr>
							<th>공통코드</th>
							<td>
								<input type="text" name="grp_cd" id="grp_cd" class="iuser_txt" style=" width:90%" value="${grp_cd}"></input>
							</td>
							<th>공통코드명</th>
							<td>
								<input type="text" name="grp_nm" id="grp_nm" class="iuser_txt" style="width:90%" value="${grp_nm}"/>
							</td>
							<th>공통코드 설명</th>
							<td>
								<input type="text" name="grp_desc" id="grp_desc" class="iuser_txt" style="width:90%" value="${grp_desc}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		
		<br>
		<div class="button1_div">
			<input type="button" id="codeMaster_add_btn" class="btn btn-default" value="추가"/>
  			<input type="button" id="codeMaster_del_btn" class="btn btn-default" value="삭제"/>
		</div>
		<br>
		
		<script type="text/javascript">
			$(function(){
				$(".open_detail").click(function(){
					code1 = $(this).parents("tr").attr("data_num");
					
					codeDetailInqr(code1);
				})
				
			});
			
			function codeDetailInqr(code1) {				
				$.getJSON("codeDetail_list/"+code1, function(data){
					$(data).each(function() {
						var grp_cd = this.grp_cd;
						var grp_nm = this.grp_nm;
						var grp_desc = this.grp_desc;
						var code1  = this.code1;
						var code_txt  = this.code_txt;
						var code_desc = this.code_desc;
						
						$("#grp_cd").val(grp_cd);
						$("#grp_cd1").val(grp_cd);
						$("#grp_nm").val(grp_nm);
						$("#grp_desc").val(grp_desc);
						$("#code1").val(code1);
						$("#code_txt").val(code_txt);
						$("#code_desc").val(code_desc);
					})
					
				});
				
			}
			
			$("#codeMaster_add_btn").on("click", function(){
				if($("#grp_cd").val() == "" || $("#grp_cd").val() == null){
					alert("공통코드를 입력해주세요");
					return false;
				}
				else if($("#grp_nm").val() == "" || $("#grp_nm").val() == null){
					alert("공통코드명을 입력해주세요");
					return false;
				}
				else if($("#grp_desc").val() == "" || $("#grp_desc").val() == null)
				{
					alert("공통코드설명를 입력해주세요");
					return false;
				}
				else
				{
					alert("공통코드가 등록 되었습니다.");
					$("#joinform1").submit();
				}
			});
		
			
		</script>

		<h4>상세코드 상세</h4>
		<div class="insert2_div">
			<form method="post" id="joinform2" action="codeDetailAdd" >
				<table class="table">
					<tbody id="tbody1">
						<tr>
							<th>공통코드</th>
							<td>
								<input type="text" name="grp_cd" id="grp_cd1" class="iuser_txt" style=" width:90%" value="${grp_cd}" readonly="readonly"/>
							</td>
							<td>
								<input type="button" name="selectGrp" id="sel_grp" value="선택" />
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
		
		<br><br>
		<!-- Paging Div -->
		<div class="button2_div">
 			<input type="button" id="codeDetail_add_btn" class="btn btn-default" value="추가"/>
 			<input type="button" id="codeDetail_mdfy_btn" class="btn btn-default" value="수정"/>
  			<input type="button" id="codeDetail_del_btn" class="btn btn-default" value="삭제"/>
		</div>
		
		<script type="text/javascript">
			
			$("#codeDetail_add_btn").on("click", function(){
				//if($("#grp_cd").val() == "" || $("#grp_cd").val() == null){
				//	alert("공통코드를 선택해주세요");
				//	return false;
				//}
				if($("#code1").val() == "" || $("#code1").val() == null){
					alert("상세코드를 입력해주세요");
					return false;
				}
				else if($("#code_txt").val() == "" || $("#code_txt").val() == null)
				{
					alert("상세코드명를 입력해주세요");
					return false;
				}
				else if($("#code_desc").val() == "" || $("#code_desc").val() == null)
				{
					alert("상세코드설명를 입력해주세요");
					return false;
				}
				else
				{
					alert("상세코드가 등록 되었습니다.");
					$("#joinform2").submit();
				}
			});
			
			$("#codeDetail_mdfy_btn").on("click", function(){
				if($("#code_txt").val() == "" || $("#code_txt").val() == null)
				{
					alert("상세코드명를 입력해주세요");
					return false;
				}
				else if($("#code_desc").val() == "" || $("#code_desc").val() == null)
				{
					alert("상세코드설명를 입력해주세요");
					return false;
				}
				else
				{
						 
					$('form').attr("action", "${ctx}/employee/employee_update").submit(); 
					alert("상세코드가 수정 되었습니다.");
					$("#joinform2").submit();
				}
			});
			
			$("#codeDetail_del_btn").on("click", function(){
				var check = document.getElementsByName("del_code");
				//var check1 = $(this).parents("tr").children(3).val();
				
				var check_len = check.length;
				var checked = 0;
				
				for(i=0; i<check_len; i++)
				{
					if(check[i].checked == true)
					{
						$("#delAllForm").submit();
						checked++;
					}
				}
				
				if(checked == 0)
				{
					alert("체크박스를 선택해주세요.");
				}
			});
		
			
		</script>
		
	</div>
</div>

</body>
</html>

<%@include file="../include/footer.jsp"%>