<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />
<%-- <script src="${ctx}/resources/common/js/common.js"></script> --%>
<script src="${ctx}/resources/common/js/mps/menu/menu_list.js"></script> 
<title>메뉴관리화면</title>

</head>
<body>
<%-- <%@include file="../include/header.jsp"%> --%>
	<div class="main_div">
		<div class="navi_div">
			 메뉴관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<!-- <form id="searchForm" name="searchForm"> -->
<!-- 					<label>활성상태</label> -->
<!-- 					<select id="active_key" name="active_key" class="selectField"> -->
<!-- 						<option value="" selected="selected">전체</option> -->
<!-- 						<option value="Y">활성화</option> -->
<!-- 						<option value="N">비활성화</option> -->
<!-- 					</select> -->
					<label>메뉴명</label>
					<input type="text" id="menu_nm_key" name="menu_nm_key" class="inputTxt" style="width:200px;"> &nbsp;
					<input type="button" id="menu_inqr_fbtn" class="btn btn-primary btn-sm" value="검색">
				<!-- </form> -->
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<div class="table_div">
					<form id="delAll_form" name="delAll_form">
						<table summary="menu_list_tb" class="table table-hover">
							<colgroup>
								<col width="5%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="checkall"></th>
									<th>메뉴명</th>
									<th>상위메뉴명</th>
									<th>URL</tH>
									<tH>활성화여부</th>
								</tr>
							</thead>
							<tbody class="menu_list">
								<c:choose>
									<c:when test="${not empty menu_list}">
										<c:forEach var="menu_list" items="${menu_list}">
											<tr class="open_detail" data_num="${menu_list.menu_cd}">
												<td>
													<input type="checkbox" class="del_point" name="del_code" value="${menu_list.menu_cd}">
												</td>
												<td>${menu_list.menu_nm}</td>
												<td>${menu_list.up_menu_nm}</td>
												<td>${menu_list.menu_url}</td>
												<td>
													<c:if test="${menu_list.active_flg eq 'Y'}">활성화</c:if>
													<c:if test="${menu_list.active_flg eq 'N'}">비활성화</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5">등록된 메뉴가 존재하지 않습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</form>
				</div>
			<div class="paging_div">
				<div class="left">
					<input type="button" id="menu_add_nfbtn" class="btn btn-default btn-sm" value="추가">
					<input type="button" id="menu_del_fbtn" class="btn btn-primary btn-sm" value="삭제">
				</div>
				<div class="page" id="paging_div">	
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="PageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1}">
							<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/>  
							<a style="color: black;"> / ${page.endPageNum}</a>
							<a style="color: black;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="menuListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
							<a href="#" onclick="menuListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="menuListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="menuListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
						</c:when>
						<c:otherwise>
							<a href="#" onclick="menuListInqr('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" value="${pageNum}" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="menuListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
							<a href="#" onclick="menuListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="right">
					<!-- <input type="button" id="menu_exIm_fbtn" class="btn btn-primary btn-sm" value="excel입력">
					<input type="button" id="menu_exEx_fbtn" class="btn btn-primary btn-sm" value="excel출력"> -->
				</div>
			</div>
			</div>
			<div id="menu_detail_div" class="list3_div">
				<h5 id="h5">메뉴관리 상세</h5>
				<form id="menu_detail_form" name="menu_detail_form">
					<table summary="menu_detail" class="table table-hover">
						<colgroup>
							<col width="35%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<th class="dc">메뉴ID</th>
								<td>
									<input type="text" id="menu_cd" name="menu_cd" class="inputTxt" >
								</td>
							</tr>
							<tr>
								<th class="dc">메뉴명</th>
								<td>
									<input type="text" id="menu_nm" name="menu_nm" class="inputTxt" >
								</td>
							</tr>
							<tr>
								<th class="dc">메뉴URL</th>
								<td>
									<input type="text" id="menu_url" name="menu_url" class="inputTxt" maxlength="50">
								</td>
							</tr>
							<tr>
								<th class="dc">메뉴레벨</th>
								<td>
									<select id="menu_level" name="menu_level"  style="width:190px;">
										<option value="0">메뉴 계층을 선택해주세요.</option>
										<c:choose>
											<c:when test="${not empty level_list}">
												<c:forEach var="level_list" items="${level_list}">
													<option value="${level_list.code1 }">${level_list.code_txt }</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option>공통코드 목록이 존재하지 않습니다.</option>
											</c:otherwise>
										</c:choose>
									</select>
								</td>
							</tr>
							<tr>
								<th class="dc">상위메뉴ID</th>
								<td>
									<input type="text" id="up_menu_cd" name="up_menu_cd" class="inputTxt">
									<input type="button" id="menuInqr_popup_fbtn" class="btn btn-primary btn-sm" value="메뉴검색">
								</td>
							</tr>
							<tr>
								<th class="dc">상위메뉴명</th>
								<td>
									<input type="text" id="up_menu_nm" name="up_menu_nm" class="inputTxt">
								</td>
							</tr>
							<tr>
								<th class="dc">활성화여부</th>
								<td>
									<input type="radio" class="active_flg" name="active_flg" value="Y"/>Y
									<input type="radio" class="active_flg" name="active_flg" value="N"/>N
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_div">
						<div class="left">
							<input type="button" id="menuTree_inqr_fbtn" class="btn btn-primary btn-sm" value="메뉴트리확인">
						</div>
						<div class="right">
							<input type="button" id="menu_save_fbtn" class="btn btn-primary btn-sm" value="저장">
							<input type="button" id="menu_edit_nfbtn" class="btn btn-default btn-sm" value="편집">
							<input type="button" id="menu_reset_nfbtn" class="btn btn-default btn-sm" value="초기화">
						</div>
					</div>
				</form>
			</div>
		</div>
		<div id="viewLoadingImg" style="display: none;">
			<img src="${ctx}/resources/image/viewLoading.gif">
		</div> 
		<jsp:include page="../menu/menulist_pop.jsp"/>
		<jsp:include page="../menu/menuTree_list.jsp"/>
	</div>
</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>