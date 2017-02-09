<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" /> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<title>Auth List</title>


	<script type="text/javascript">
	
			
			$("#navisub11").show();
			$("#naviuser").css("font-weight", "bold");
			
		$(function(){
			
			$("#iuserListEditBtn").on("click", function(){  
				openUpdatePop();
			})
		})
		
		function openPop() {
			
			var popUrl = "auth_pop"; 		//팝업창에 출력될 페이지 URL
			var popOption = "width=800, height=450, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	
			window.open(popUrl, "", popOption);
		}
		
		function openUpdatePop(id){
			
			var check = id;  
			var popUrl = "auth_update_pop?auth_id="+check;	//팝업창에 출력될 페이지 URL
			var popOption = "width=800, height=450, resizable=no, scrollbars=no, status=no, location=no;";    //팝업창 옵션(optoin)
					window.open(popUrl,"",popOption); 
		}

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
			
			if (del_code == '') {
				alert("삭제할 대상을 선택하세요.");
				return false;
			}
	 
			if (confirm("정보를 삭제 하시겠습니까?")) {

				//삭제처리 후 다시 불러올 리스트 url
				$("form[name='delAllForm']").attr("action", "${ctx}/auth/auth_delete").submit();
			}
		}
		
		//페이지 엔터키 기능
		function authpageNumEnter(event) {
			$(document).ready(function() {
				var keycode = (event.keyCode ? event.keyCode : event.which);
				if (keycode == '13') {
					var pageNum = parseInt($("#pageInput").val());
					if (pageNum == '') {
						alert("페이지 번호를 입력하세요.")
						$("#pageInput").focus();
					} else if(pageNum > parseInt($("#endPageNum").val())) {
						alert("페이지 번호가 너무 큽니다.");
						$("#pageInput").val($("#authPageNum").val());
						$("#pageInput").focus();
					} else {
						authPaging(pageNum);
					}
				}
				event.stopPropagation();
			});
		}
		
		//사용자관리 페이징
		function authPaging(pageNum) {
			$(document).ready(function() {
				var ctx = $("#ctx").val();
				var $form = $('#authlistPagingForm');
			    
			    var pageNum_input = $('<input type="hidden" value="'+ pageNum +'" name="pageNum">');

			    $form.append(pageNum_input);
			    $form.submit();
			});
		}
	
		//검색 엔터키
		function authEnterSearch(event) {
			$(document).ready(function() {
				var keycode = (event.keyCode ? event.keyCode : event.which);
				if (keycode == '13') {
					auth_goSearch();
				}
			});
		}
		
		//조회 버튼기능
		function auth_goSearch(){
			
			var keyword = $("#keyword").val();
						
			$("#searchForm").submit();
				
		}

</script>
</head>
<body>
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<%@include file="../include/header.jsp" %>
<!--Main_Div  -->
<div class="main_div">

	<!-- Navigation Div -->
	<div class="navi_div">권한관리</div>
		
	<!-- Search Cover Div -->
	<div class="search_div">
		<div class="search2_div">
			<form name="searchForm"  method="post" action="${ctx}/auth/authlist">
					<select name="keyfield" class="selectField">
						<option value="active_flg_y">활성화</option>
						<option value="active_flg_n">비활성화</option>
					</select> 
					<span>권한명</span>
						<input id="keyword" type="text" name="keyword" class="int_search" value="${keyword}" onkeypress="authEnterSearch(event);" > 
						&nbsp;
					<button id="search_fbtn" class="btn btn-default btn-sm">검색</button>
			</form>
			<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/auth/authlist" id="authlistPagingForm" method="post">
				<input type="hidden" name="active_flg_y" value="${active_flg_y}"/>
				<input type="hidden" name="active_flg_n" value="${active_flg_n}"/>
				<input type="hidden" name="keyword" value="${keyword}"/>
			</form>
			
		</div>
		<div class="search3_div">
			
			
		</div>
	</div>
	
	<!-- List Cover Div -->
	<div class="list_div">
		<div class="list2_div">
			<form name="delAllForm" id ="delAllForm" method="post" action="${ctx}/auth_delete" >	
			<table id="mastertable" class="table table-hover">
				<thead>
					<tr style="width:100%;">
						<th><input id="checkall" name="checkAll" type="checkbox" onclick="allChk();"/></th>
						<td style="width:35%;">권한ID</td>
						<td style="width:30%;">권한명</td>
						<td style="width:20%;">활성화여부</td>
					</tr>
				</thead>
				<tbody id="usertbody" >
					<c:if test="${not empty list}">
					<c:forEach var="list" items="${list}" >
					<tr>
						<th scope="row"><input type="checkbox" class="ab" id="del_code" name="del_code" value="${list.AUTH_ID}" ></th>
						<td style="width:30%; cursor: pointer;" class="user_name_tag" id = "${list.AUTH_ID}" onclick="openUpdatePop(this.id);" >
							${list.AUTH_ID}
						</td> 
						<td style="width:30%;" class="user_name_tag">${list.AUTH_NM}</td>
						<td style="width:30%;" class="user_name_tag">${list.ACTIVE_FLG}</td>
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${list.size() == 0}">
						<tr style="cursor: default; background-color: white;">
							<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
						</tr>
					</c:if>
				</tbody>
			</table>
			</form>
		</div>
		
		<div class="list3_div">
			<input type="hidden" id="ctx" value="${ctx}">
			<form method="post" id="joinform" >
				<table class="table table-hover">
					<tbody id="tbody1">
						<tr>
							<th>권한ID</th>
							<td><input type="text" name="auth_id" id="auth_id" class="int" readonly="readonly" ></input></td>
						</tr>
						<tr>
							<th>권한명</th>
							<td><input type="text" name="auth_nm" id="auth_nm" class="int" ></input></td>
						</tr>
						<tr>
							<th>활성화여부</th>
							<td><input type="text" name="active_flg" id="active_flg" class="int" ></input></td>
						</tr>
					</tbody>
				</table>
				
			</form>
			
		</div>
		
		<!-- Paging Div -->
		<div class="paging_div">
			<div class="btn01">
				<div class="left">
					<input type="button" class="btn btn-primary btn-sm" onclick="openPop()" value="추가"/>
		  			<input type="button" class="btn btn-primary btn-sm" onclick="deleteAction()" value="삭제"/>
				</div>
			
				<div class="page">
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="authPageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
							<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="authPageInput" value="${page.startPageNum}" onkeypress="authpageNumEnter(event);" style="width: 8%;"/>  
							<a style="color: black; text-decoration: none;"> / 1</a>
							<a style="color: black; text-decoration: none;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="authPageInput" value="${page.startPageNum}" onkeypress="authpageNumEnter(event);" style="width: 8%;"/>  
							<a href="#" onclick="authPaging('${page.endPageNum}');" id="pNum" > / ${page.endPageNum}</a>
							<a href="#" onclick="authPaging('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="authPaging('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" class="authPageInput" value="${page.endPageNum}" onkeypress="authpageNumEnter(event);" style="width: 8%;"/> 
							<a href="#" onclick="authPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
							<a style="color: black; text-decoration: none;"> ▶ </a>
						</c:when>
						<c:otherwise>
							<a href="#" onclick="authPaging('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" class="authPageInput" value="${pageNum}" onkeypress="(event);" style="width: 8%;"/>  
							<a href="#" onclick="authPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
							<a href="#" onclick="authPaging('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div class="right">
					<input type="button" id="excelImport" class="btn btn-info btn-sm" value="excel입력"/>
		  			<input type="button" id="excelExport" class="btn btn-info btn-sm" value="excel출력"/>
				</div>
			</div>
			
			<div class="btn02">
				<input type="button" id="menu" class="btn btn-primary btn-sm" value="메뉴권한">
				<input type="button" id="user" class="btn btn-primary btn-sm" value="사용자권한">
				
				<div class="right">
					<input type="button" id="resetBtn"class="btn btn-primary btn-sm" value="초기화"/>
	  				<input type="button" id="saveBtn"  class="btn btn-primary btn-sm" value="저장"/>
				</div>
			</div>
			
		</div>
		
	</div>
</div>
<%@include file="../include/footer.jsp"%>
</body>
</html>
