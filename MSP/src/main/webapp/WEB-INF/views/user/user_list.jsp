<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/user/userList.css" type="text/css" />

<title>리스트</title>
<script type="text/javascript">
	$("#navisub11").show();
	$("#naviuser").css("font-weight", "bold");

	function userTabOpen() {
		var popUrl = "userTab";
		var popOption = "width=650, height=450, resize=no, scrollbars=no, status=no, location=no, directories=no;";
		window.open(popUrl, "", popOption);
	}

	//수정
	function onPopup(id) {
		var tmp = id;//$("#user_id_h").val();
		alert(tmp);

		var popUrl = "userMdfyPop?user_id=" + tmp; //팝업창에 출력될 페이지 URL
		var popOption = "width=650, height=450, resize=no, scrollbars=no, status=no, location=no, directories=no;"; //팝업창 옵션(optoin)

		window.open(popUrl, "", popOption);
	};
</script>

<script type="text/javascript">
	// 1.모두 체크
	/* 체크박스 전체선택, 전체해제 */
	function allChk() {
		if ($("#checkall").is(':checked')) {
			$("input[name=del_code]").prop("checked", true);
		} else {
			$("input[name=del_code]").prop("checked", false);
		}
	}

	/* 삭제(체크박스된 것 전부) */
	function deleteAction() {
		var del_code = "";
		$("input[name='del_code']:checked").each(function() {
			del_code = del_code + $(this).val() + ",";
		});
		del_code = del_code.substring(0, del_code.lastIndexOf(",")); //맨끝 콤마 지우기

		if (del_code == '') {
			alert("삭제할 대상을 선택하세요.");
			return false;
		}
		console.log("### del_code => {}" + del_code);

		if (confirm("정보를 삭제 하시겠습니까?")) {

			//삭제처리 후 다시 불러올 리스트 url      

			location.href = "${ctx}/user/userDel?user_id=" + del_code;
		}
	}
</script>

</head>
<body>

<!--Main_Div  -->
<div class="main_div">
	<!-- Navigation Div -->
	<div class="navi_div">■ 사용자관리</div>
	
	<!-- Search1 Cover Div -->
	<div class="">
		
		<!-- Search1 Div  -->
		<div class="search1_div">
			<form name="searchForm" method="post" action="${ctx}/user">
					<select name="keyfield">
						<option value="u_id">사용자ID명</option>
						<option value="u_name">사용자명</option>
						<option value="o_name">조직명</option>
					</select> <input id="title_text" type="text" name="keyword"
						class="int_search"> &nbsp;
					<button id="search_btn" type="submit" class="iuser_serach_bt">검색</button>
			</form>
		</div>
	</div>
	
	<!-- List1 Cover Div -->
	<div class="">
		
		<!-- List1 Div -->
		<div class="list1_div">
			<form name="delAllForm" id="delAllForm" method="post"
			action="${ctx}/userDel">
			<table id="mastertable" class="mastertable">
				<thead>
					<tr>
						<th><input id="checkall" name="checkAll" type="checkbox" onclick="allChk();" /></th>
						<td style="width: 10%;">사용자ID</td>
						<td style="width: 10%;">사용자명</td>
						<td style="width: 10%;">조직명</td>
						<td style="width: 20%;">이메일</td>
						<td style="width: 20%;">연락처</td>
						<td style="width: 10%;">권한</td>
						<td style="width: 10%;">상태</td>
					</tr>
				</thead>
				<tbody id="usertbody">
					<c:forEach var="list" items="${list}">
						<tr>
							<th scope="row"><input type="checkbox" class="ab" name="del_code" value="${list.USER_ID}">
							 <input	type="hidden" id="user_id_h" value="${list.USER_ID}" /></th>
							<a href="#"><td style="width: 10%;" name="user_id" id="${list.USER_ID}" onclick="onPopup(this.id);">${list.USER_ID}</td></a>
							<td style="width: 10%;" class="user_name_tag">${list.USER_NM}</td>
							<td style="width: 10%;" class="org_name_tag">${list.DEPT_CD}</td>
							<td style="width: 20%;" class="email_tag">${list.EMAIL_ID}@${list.EMAIL_DOMAIN}</td>
							<td style="width: 20%;" class="cell_phone_tag">${list.CPHONE_NUM1}-${list.CPHONE_NUM2}-${list.CPHONE_NUM3}</td>
							<td style="width: 10%;" class="auth_name_tag">
								<c:if test="${empty list.AUTH_NM}"> 권한없음	</c:if>
								<c:if test="${not empty list.AUTH_NM}"> ${list.AUTH_NM} </c:if>
							</td>
							<%-- <td style="width: 20%;" class="user_type_cd">${list.USER_TYPE_CD}</td> --%>
							<td style="width: 20%;" class="active_flg">${list.ACTIVE_FLG}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		</div>
	</div>
	
	<!-- Paging Div -->
	<div class="paging_div">
		<input type="button" id="iuserListAddBtn" onclick="userTabOpen()"
			class="iuser_bt" value="등록" />
		<!-- <input type="button" id="iuserListEditBtn" class="iuser_bt" value="수정"/> -->
		<input type="button" id="iuserDelBtn" onclick="deleteAction()"
			class="iuser_bt" value="삭제" />
	</div>
</div>
</body>
</html>