<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- Modal PopUp -->
<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
	    <div class="modalM_main_div">
	      Modal content
	      <div class="modal-content">
	      	<tr>
	          <td><h4 class="modal-title" style="margin-bottom: 1%;"><b>부서검색</b></h4></td>
	      	</tr>
	      	<tr>
	      		<td>
			      <select id="sch_pop_condition" name="sch_pop_condition">
			      	<option value="dept_nm">부서명</option>
			      	<option value="user_nm">부서장</option>
			      </select>
	      		</td>
	      		<td><input type="text" id="dept_sch" name="dept_sch"/></td>
	      		<td><input type="button" id="dept_pop_sch_fbtn" name="dept_pop_sch_fbtn" value="검색"/></td>
	      	</tr>
	      	
	        <div class="modal-body">
	         <form name="deptPopForm" id="deptPopForm" method="post"
			action="${ctx}/userTab">
			<table id="mastertableDept" class="table table-bordered" style ="width: 90%">
				<thead>
					<tr>
						<td style="width: 10%;">부서명</td>
						<td style="width: 10%;">부서장</td>
						<td style="width: 10%;">전화번호</td>
					</tr>
				</thead>
				<tbody id="usertbody">
				<c:if test="${not empty dept_list}">
					<c:forEach var="listPop" items="${dept_list}">
						<tr class="deptTrPop" id="popTrClick" name="popTrClick" data-dismiss="modal" dept_cd_pop="${listPop.dept_cd}" user_nm_pop="${listPop.user_nm}">
							<td id="dept_nm" name="dept_nm" style=" width: 45%;"><input type="hidden" id="dept_cd_pop" name="dept_cd_pop" value="${listPop.dept_cd}">	${listPop.dept_nm}</td>
							<td style="width: 45%;" ><input type="hidden"  id="user_nm_pop" name="user_nm_pop" value="${listPop.user_nm}">${listPop.user_nm}</td>
							<td style="width: 45%;" >${listPop.dept_num1}-${listPop.dept_num2}-${listPop.dept_num3}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${dept_list.size() == 0}">
					<tr style="cursor: default; background-color: white;">
						<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</form>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        </div>
		  </div>    
	 </div>
  </div> 
</body>
</html>