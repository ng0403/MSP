<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/user/ModalCss.css" type="text/css" />
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>리스트</title>
<!-- <script type="text/javascript">
$(document).ready(function() {

</script> -->

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
	
	//페이지 엔터키 기능
	function userpageNumEnter(event) {
		$(document).ready(function() {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				var pageNum = parseInt($("#pageInput").val());
				if (pageNum == '') {
					alert("페이지 번호를 입력하세요.")
					$("#pageInput").focus();
				} else if(pageNum > parseInt($("#endPageNum").val())) {
					alert("페이지 번호가 너무 큽니다.");
					$("#pageInput").val($("#userPageNum").val());
					$("#pageInput").focus();
				} else {
					userPaging(pageNum);
				}
			}
			event.stopPropagation();
		});
	}
	
	
	
	//사용자관리 페이징
	function userPaging(pageNum) {
		$(document).ready(function() {
			var ctx = $("#ctx").val();
			var $form = $('#userlistPagingForm');
		    
		    var pageNum_input = $('<input type="hidden" value="'+pageNum+'" name="pageNum">');

		    $form.append(pageNum_input);
		    $form.submit();
		});
	}
	//검색 엔터키
	function userEnterSearch(event) {
		$(document).ready(function() {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				user_goSearch();
			}
		});
	}
	
	//사용자관리 조회 버튼기능
	function user_goSearch(){
		
		var user_id_sch = $("#user_id_sch").val();
		var user_nm_sch = $("#user_nm_sch").val();
		var dept_cd_sch = $("#dept_cd_sch").val();
		
		$("#userSearchForm").submit();
			
	}

</script>

</head>
<body>
 <%@include file="../include/header.jsp"%>

<!--Main_Div  -->
<div class="main_div">
	<!-- Navigation Div -->
	<div class="navi_div" style="margin-bottom: 1%; margin-top: 1%;">■ 사용자관리</div>
	
	<!-- Search1 Cover Div -->
	<div class="">
		
		<!-- Search1 Div  -->
		<div class="search1_div" style=" margin-left: 1%; margin-bottom: 1%;">
			<form name="userSearchForm" method="post" action="${ctx}/user/userlist">
					<tr>
						<th>사용자ID</th>
						<td><input type="text" id="user_id_sch" name="user_id_sch" value="${user_id_sch}" onkeypress="userEnterSearch(event);"></td>
						<th>사용자명</th>
						<td><input type="text" id="user_nm_sch" name="user_nm_sch" value="${user_nm_sch}" onkeypress="userEnterSearch(event);"></td>
						<th>부서명</th>
						<td><input type="text" id="dept_cd_sch" name="dept_cd_sch" value="${dept_cd_sch}" onkeypress="userEnterSearch(event);"></td>&nbsp;
					    <td><button id="search_fbtn" type="submit" class="user_serach_fbtn" />검색</button></td>
					</tr>
			</form>
			<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/user/userlist" id="userlistPagingForm" method="post">
				<input type="hidden" name="user_id_sch" value="${user_id_sch}"/>
				<input type="hidden" name="user_nm_sch" value="${user_nm_sch}"/>
				<input type="hidden" name="dept_cd_sch" value="${dept_cd_sch}"/>
			</form>
		</div>
	</div>
	
	<!-- List1 Cover Div -->
	<div class="">
		
		<!-- List1 Div -->
		<div class="list1_div" style=" margin-left: 1%;">
			<form name="delAllForm" id="delAllForm" method="post"
			action="${ctx}/userDel">
			<table id="mastertable" class="table table-bordered" style ="width: 90%">
				<thead>
					<tr>
						<th><input id="checkall" name="checkAll" type="checkbox" onclick="allChk();" /></th>
						<td style="width: 10%;">사용자ID</td>
						<td style="width: 10%;">사용자명</td>
						<td style="width: 10%;">조직명</td>
						<td style="width: 20%;">이메일</td>
						<td style="width: 25%;">연락처</td>
						<td style="width: 10%;">권한</td>
						<td style="width: 10%;">상태</td>
					</tr>
				</thead>
				<tbody id="usertbody">
				<c:if test="${not empty user_list}">
					<c:forEach var="list" items="${user_list}">
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
				</c:if>
				<c:if test="${user_list.size() == 0}">
					<tr style="cursor: default; background-color: white;">
						<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</form>
		</div>
	<!-- Paging Div -->
	<div class="paging_div" style="width: 100%; text-align: center;">
	
		<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
		<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
		<input type="hidden" id="userPageNum" value="${pageNum}"/>
		<c:choose>
			<c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
				<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="userPageInput" value="${page.startPageNum}" onkeypress="userpageNumEnter(event);" style="width: 2%;"/>  
				<a style="color: black; text-decoration: none;"> / 1</a>
				<a style="color: black; text-decoration: none;"> ▶ </a>
			</c:when>
			<c:when test="${pageNum == page.startPageNum}">
				<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="userPageInput" value="${page.startPageNum}" onkeypress="userpageNumEnter(event);" style="width: 2%;"/>  
				<a href="#" onclick="userPaging('${page.endPageNum}');" id="pNum" > / ${page.endPageNum}</a>
				<a href="#" onclick="userPaging('${pageNum+1}');" id="pNum"> ▶ </a>
			</c:when>
			<c:when test="${pageNum == page.endPageNum}">
				<a href="#" onclick="userPaging('${pageNum-1}');" id="pNum"> ◀ </a>
				<input type="text" id="pageInput" class="userPageInput" value="${page.endPageNum}" onkeypress="userpageNumEnter(event);" style="width: 2%;"/> 
				<a href="#" onclick="userPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
				<a style="color: black; text-decoration: none;"> ▶ </a>
			</c:when>
			<c:otherwise>
				<a href="#" onclick="userPaging('${pageNum-1}');" id="pNum" > ◀ </a>
				<input type="text" id="pageInput" class="userPageInput" value="${pageNum}" onkeypress="(event);" style="width: 2%;"/>  
				<a href="#" onclick="userPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
				<a href="#" onclick="userPaging('${pageNum+1}');" id="pNum"> ▶ </a>
			</c:otherwise>
		</c:choose>
		<div class="" style="text-align: right; margin-right: 10%;">
			<input type="button" id="iuserListAddBtn" onclick="userTabOpen()" class="btn btn-default" value="등록" />
			<input type="button" id="iuserDelBtn" onclick="deleteAction()" class="btn btn-default" value="삭제" />
		</div>
	</div>
	</div>
	
</div>

</body>
</html>
<%@include file="../include/footer.jsp"%>