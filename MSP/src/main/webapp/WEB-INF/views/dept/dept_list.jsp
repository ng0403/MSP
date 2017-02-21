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
<script src="${ctx}/resources/common/js/common.js"></script>
<script src="${ctx}/resources/common/js/mps/dept/dept_list.js"></script>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" /> --%>
<title>부서관리화면</title>

<script type="text/javascript">

	
</script>
</head>
<body>
<%-- <%@include file="../include/header.jsp"%> --%>
	<div class="main_div">
		<div class="navi_div">
			사용자 > 부서관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<form id="searchForm" name="searchForm">
					<label>활성상태</label>
					<select id="active_key" name="active_key" class="selectField">
						<option value="" selected="selected">전체</option>
						<option value="Y">활성화</option>
						<option value="N">비활성화</option>
					</select>
					<label>부서명</label>
					<input type="text" id="dept_nm_key" name="dept_nm_key" > &nbsp;
					<input type="button" id="dept_inqr_fbtn" class="btn btn-default btn-sm" value="검색">
				</form>
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<div class="table_div">
					<form id="delAll_form" name="delAll_form">
						<table summary="dept_list_tb" class="table table-hover">
							<colgroup>
								<col width="5%">
								<col width="35%">
								<col width="25%">
								<col width="15%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="checkall"></th>
									<th>부서명</th>
									<th>연락처</th>
									<th>대표자명</th>
									<tH>활성화여부</th>
								</tr>
							</thead>
							<tbody class="dept_list">
								<c:choose>
									<c:when test="${not empty dept_list}">
										<c:forEach var="dept_list" items="${dept_list}">
											<tr class="open_detail" data_num="${dept_list.dept_cd}">
												<td>
													<input type="checkbox" class="del_point" name="del_code" value="${dept_list.dept_cd}">
												</td>
												<td>${dept_list.dept_nm}</td>
												<td>${dept_list.dept_num1}-${dept_list.dept_num2}-${dept_list.dept_num3}</td>
												<td>${dept_list.user_nm}</td>
												<td>
													<c:if test="${dept_list.active_flg eq 'Y'}">활성화</c:if>
													<c:if test="${dept_list.active_flg eq 'N'}">비활성화</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5">등록된 부서가 존재하지 않습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</form>
				</div>
				<div class="paging_div">
					<div class="left">
						<input type="button" id="dept_add_fbtn" class="btn btn-primary btn-sm" value="추가">
						<input type="button" id="dept_del_fbtn" class="btn btn-primary btn-sm" value="삭제">
					</div>
					<div class="page" id="paging_div">	
						<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
						<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
						<input type="hidden" id="PageNum" value="${pageNum}"/>
						<c:choose>
							<c:when test="${page.endPageNum == 1}">
								<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/>  
								<a style="color: black;"> / ${page.endPageNum}</a>
								<a style="color: black;"> ▶ </a>
							</c:when>
							<c:when test="${pageNum == page.startPageNum}">
								◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/> /&nbsp;
								<a href="#" onclick="deptListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
								<a href="#" onclick="deptListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
							</c:when>
							<c:when test="${pageNum == page.endPageNum}">
								<a href="#" onclick="deptListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
								<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/> /&nbsp;
								<a href="#" onclick="deptListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
							</c:when>
							<c:otherwise>
								<a href="#" onclick="deptListInqr('${pageNum-1}');" id="pNum" > ◀ </a>
								<input type="text" id="pageInput" value="${pageNum}" onkeypress="pageInputRepDept(event);" style='width: 50px; padding: 3px; '/> /&nbsp;
								<a href="#" onclick="deptListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
								<a href="#" onclick="deptListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="right">
						<input type="button" id="dept_exIm_fbtn" class="btn btn-primary btn-sm" value="excel입력">
						<input type="button" id="dept_exEx_fbtn" class="btn btn-primary btn-sm" value="excel출력">
					</div>
				</div>
			</div>
			<div id="dept_detail_div" class="list3_div">
				<form id="dept_detail_form" name="dept_detail_form">
					<table summary="dept_detail" class="table table-hover">
						<colgroup>
							<col width="35%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<th class="dc">부서코드</th>
								<td>
									<input type="text" id="dept_cd" name="dept_cd">
								</td>
							</tr>
							<tr>
								<th class="dc">부서명</th>
								<td>
									<input type="text" id="dept_nm" name="dept_nm">
								</td>
							</tr>
							<tr>
								<th class="dc">부서전화</th>
								<td>
									<select id="dept_num1" name="dept_num1">
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
									</select>
									<label>-</label>
									<input type="text" id="dept_num2" name="dept_num2" class="pNum">
									<label>-</label>
									<input type="text" id="dept_num3" name="dept_num3" class="pNum">
								</td>
							</tr>
							<tr>
								<th class="dc">팩스번호</th>
								<td>
									<select id="dept_fnum1" name="dept_fnum1">
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
									</select>
									<label>-</label>
									<input type="text" id="dept_fnum2" name="dept_fnum2" class="pNum">
									<label>-</label>
									<input type="text" id="dept_fnum3" name="dept_fnum3" class="pNum">
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
						<div class="right">
							<input type="button" id="dept_save_fbtn" class="btn btn-primary btn-sm" value="저장">
							<input type="button" id="dept_edit_nfbtn" class="btn btn-primary btn-sm" value="편집">
							<input type="button" id="dept_reset_nfbtn" class="btn btn-info btn-sm" value="초기화">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>