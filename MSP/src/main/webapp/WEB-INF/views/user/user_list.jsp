<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/mps/userJS/user_list_js.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/user/ModalCss.css" type="text/css" />
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>리스트</title>
<!-- <script type="text/javascript"> -->
<!-- // $(document).ready(function() { -->
<%-- // 	var result = ${result} --%>
	
<!-- // } -->
<!-- </script> -->
<script type="text/javascript">
	$("#navisub11").show();
	$("#naviuser").css("font-weight", "bold");
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
						<td><button id="search_fbtn" type="submit" class="user_serach_fbtn"  style="margin-left: 34%;"/>검색</button></td>
					</tr>
			</form>
			<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/user/userlist" id="userlistPagingForm" method="post">
				<input type="hidden" name="user_id_sch" value="${user_id_sch}"/>
				<input type="hidden" name="user_nm_sch" value="${user_nm_sch}"/>
				<input type="hidden" name="dept_cd_sch" value="${dept_cd_sch}"/>
			</form>
			<form action="${ctx}/user/userlist" id="userlistExcelForm" method="post"></form>
		</div>
	</div>

	<!-- List1 Cover Div -->
	<div class="">
		<!-- List1 Div -->
		<div class="list1_div" style=" margin-left: 1%;">
			<form name="delAllForm" id="delAllForm" method="post" action="${ctx}/userDel">
			<table id="mastertable" class="table table-bordered" style ="width: 90%">
				<thead>
					<tr>
						<th><input id="checkall" name="checkAll" type="checkbox" onclick="allChk();" /></th>
						<td style="width: 10%;">사용자ID</td>
						<td style="width: 10%;">사용자명</td>
						<td style="width: 10%;">부서명</td>
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
							<td style="width: 10%;" class="org_name_tag">${list.DEPT_NM}<input type="hidden" id="dept_cd" value="${list.DEPT_CD}"/></td>
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
			<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post"action="${ctx}/user/excelUploadAjax"> 
				<input type="button" value="엑셀출력" class="btn btn-default" onclick="download_list_Excel('userlistExcelForm');" style="float: right;">
	            <input id="excelFile" type="file" name="excelFile" class="btn btn-default" style="float: right;"/>
		        <input type="button" id="addExcelImpoartBtn" class="btn btn-default" onclick="check();" value="업로드" style="float: right;"> 
				<input type="button" id="iuserListAddBtn" onclick="userTabOpen()" class="btn btn-default" value="등록" style="float: left;" />
				<input type="button" id="iuserDelBtn" onclick="deleteAction()" class="btn btn-default" value="삭제" style="float: left;"  />
			</form>
		</div>
	</div>
	</div>
	
</div>

</body>
</html>
<%@include file="../include/footer.jsp"%>