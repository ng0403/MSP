<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<title>Auth List</title>

</head>
<body>

<!--Main_Div  -->
<div class="main_div">

	<!-- Navigation Div -->
	<div class="navi_div">■ 권한관리</div>
		
	<!-- Search Cover Div -->
	<div class="search_div">
		<div class="search2_div">
			<form name="searchForm" method="post" action="${ctx}/user">
					<select name="keyfield">
						<option value="active_flg">활성화</option>
						<option value="auth_nm">비활성화</option>
					</select> 
					<input id="title_text" type="text" name="keyword" class="int_search"> &nbsp;
					<button id="search_btn" type="submit" class="iuser_serach_bt">검색</button>
			</form>
		</div>
		<div class="search2_div">
		
		</div>
	</div>
	
	<!-- List Cover Div -->
	<div class="list_div">
		<div class="list2_div">
			<form name="delAllForm" id="delAllForm" method="post" action="${ctx}/auth/auth_delete" >	
			<table id="mastertable" border = "1">
				<thead>
					<tr>
						<th><input id="checkall" type="checkbox"/></th>
						<td style="width:25%;">권한ID</td>
						<td style="width:25%;">권한명</td>
						<td style="width:25%;">활성화여부</td>
					</tr>
				</thead>
				<tbody id="usertbody" >
					<c:forEach var="authList" items="${authList}" >
					<tr onmouseover="this.style.background='#c0c4cb'" onmouseout="this.style.background='white'">
						<th scope="row"><input type="checkbox" name="del_code" value="${authList.AUTH_ID}"></th>
						<%-- <td style="width:10%;" id="user_id_a">
							<a href='#'>${employeeList.id_nm}</a>
						</td> --%>  
						<td  style="width:25%; cursor: pointer;" class="user_name_tag" id = "${authList.AUTH_NM}" onclick="openupdatePop(this.id);">${authList.AUTH_NM}
	 					</td>
						<td style="width:25%;" class="user_name_tag">${authList.ACTIVE_FLG}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</form>
		</div>
		<div class="list2_div">
		
		</div>
		
		<!-- Paging Div -->
		<div class="paging_div">
			<input type="button" id="iuserListAddBtn" class="func_btn" value="추가"/>
  			<input type="button" id="iuserDelBtn" class="func_btn" value="삭제"/>
  			
  			<input type="button" id="excelImport" class="func_btn" value="excel입력"/>
  			<input type="button" id="excelExport" class="func_btn" value="excel출력"/>
			
		</div>
	</div>
</div>

</body>
</html>