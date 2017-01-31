<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<title>부서관리화면</title>
</head>
<body>
	<div class="main_div">
		<div class="navi_div">
			사용자 > 부서관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<form id="searchForm" name="searchForm">
					<input type="text" id="keyword" name="keyword"> &nbsp;
					<input type="button" id="dept_inqr_fbtn" value="검색">
				</form>
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<form id="delAll_form" name="delAll_form">
					<table summary="dept_list">
						<colgroup>
							<col width="10%">
							<col width="40%">
							<col width="20%">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="allCheck"></th>
								<td>부서명</td>
								<td>연락처</td>
								<td>대표자명</td>
								<td>활성화여부</td>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty dept_list}">
									<c:forEach var="dept_list" items="${dept_list}">
										<tr data_num="${dept_list.dept_cd}">
											<th>
												<input type="checkbox" class="del_point" name="del_code" value="${dept_list.dept_cd}">
											</th>
											<th>
												<span class="open_detail">${dept_list.dept_nm}</span>
											</th>
											<th>${dept_list.dept_num1}-${dept_list.dept_num2}-${dept_list.dept_num3}</th>
											<th>${dept_list.dept_leader}</th>
											<th>
												<c:if test="${dept_list.active_flg eq 'Y'}">활성화</c:if>
												<c:if test="${dept_list.active_flg eq 'N'}">비활성화</c:if>
											</th>
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
			<div id="dept_detail_div">
				<form id="dept_detail_form" name="dept_detail_form">
					<table summary="dept_detail">
						<colgroup>
							<col width="35%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<td class="dc">부서코드</td>
								<td>
									<input type="text" id="dept_cd" name="dept_cd" value="${dept_detail.dept_cd}">
								</td>
							</tr>
							<tr>
								<td class="dc">부서명</td>
								<td>
									<input type="text" id="dept_nm" name="dept_nm" value="${dept_detail.dept_nm}">
								</td>
							</tr>
							<tr>
								<td class="dc">부서전화</td>
								<td>
									<select id="dept_num1" name="dept_num1">
										<option value="02"<%-- <c:if test="${dept_detail.dept_num1 eq '02'}">selected="selected"</c:if> --%>>02</option>
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
									</select>-
									<input type="text" id="dept_num2" name="dept_num2" value="${dept_detail.dept_num2}">-
									<input type="text" id="dept_num3" name="dept_num3" value="${dept_detail.dept_num3}">
								</td>
							</tr>
							<tr>
								<td class="dc">팩스번호</td>
								<td>
									<select id="dept_fnum1" name="dept_fnum1">
										<option value="02"<%-- <c:if test="${dept_detail.dept_num1 eq '02'}">selected="selected"</c:if> --%>>02</option>
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
									</select>-
									<input type="text" id="dept_fnum2" name="dept_fnum2" value="${dept_detail.dept_fnum2}">-
									<input type="text" id="dept_fnum3" name="dept_fnum3" value="${dept_detail.dept_fnum3}">
								</td>
							</tr>
							<tr>
								<td class="dc">활성화여부</td>
								<td>
									<input type="radio" id="active_flg1" name="active_flg" value="Y"/>Y
									<input type="radio" id="active_flg2" name="active_flg" value="N"/>N
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<div class="paging_div">
			<input type="button" id="dept_add_fbtn" value="추가">
			<input type="button" id="dept_del_fbtn" value="삭제">
			<input type="button" id="dept_del_fbtn" value="삭제">
			<input type="button" id="dept_del_fbtn" value="삭제">
		</div>
	</div>
</body>
</html>