<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<c:set var="SessionID" value="${sessionScope.user_id}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Enter" />
<meta content="blendTrans(Duration=0.0)" http-equiv="Page-Exit" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="${ctx}/resources/common/js/common.js"></script>

<script src="${ctx}/resources/common/js/mps/chartJS/dthree_list.js"></script>
<%-- <script src="${ctx}/resources/common/js/mps/chartJS/d3.min.js"></script> --%>
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>

<%-- <script src="${ctx}/resources/common/js/mps/chartJS/foreigner.js"></script>  --%>
<%-- <script src="${ctx}/resources/common/js/mps/chartJS/lineGraph.js"></script>  --%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" /> 
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/AuthCSS/authCSS.css" type="text/css" /> 
<style>
	svg { width: 320px; height: 240px; border: 1px solid black; }
	.bar { fill : orange; }
</style>
<title>D3.js Excel</title>
</head>

<body >
<!--Main_Div  -->
<div class="main_div">

	<!-- Navigation Div -->
	<div class="navi_div">인구관리</div>
		
	<!-- Search Cover Div -->
	<div class="searchChart_div">
		<div class="search2chart_div">
			<label>지역명</label>&nbsp;
			<input type="text" id="keyword" name="keyword" class="inputTxt" > &nbsp;&nbsp;
			<input type="button" id="dthree_inqr_fbtn" class="btn btn-primary btn-sm" value="검색">
			
			<div class="excelBtn">
				<input type="button" id="excelExportPopBtn"  class="btn btn-info btn-sm" onclick="download_list_Excel('dthreeListExcelForm');"  value="엑셀출력" style="float: right; margin-right: 5px;">
		        <input type="button" id="ExcelImpoartPopBtn" class="btn btn-info btn-sm" onclick="excelImportOpen();" value="엑셀등록" style="float: right; " > 
			</div>
			
			<!-- 페이징 전용 폼 -->
			<form action="${ctx}/chart/dthreeInqr" id="dthreeListExcelForm" method="post"></form>
			
<!-- 			<!-- 페이징 전용 폼 --> 
<%-- 			<form  action="${ctx}/chart/dthreeInqr" id="dthreelistPagingForm" method="post"> --%>
<%-- 				<input type="hidden" name="active_key" value="${active_key}"/> --%>
<%-- 				<input type="hidden" name="keyword" value="${keyword}"/> --%>
<!-- 			</form> -->
		</div>
		
		<div class="search3_div"></div>
		
	</div>
	
	<!-- List Cover Div -->
	<div class="listChart_div">
		<div class="list2Left_div">
			
			<div class="table_div">
				<form name="delAllForm" id ="delAllForm" >	
				<table summary="dthree_list_tb" class="table table-hover">
					<thead>
						<tr style="width:100%;">
							<th><input type="checkbox" id="checkall" ></th>
							<th align="center" >지역명</th>
							<th align="center" >내국인</th>
							<th align="center" >외국인</th>
							<th align="center" >활성화여부</th>
						</tr>
					</thead>
					<tbody class="dthree_list" >
						<c:choose>
							<c:when test="${not empty dthree_list}">
								<c:forEach var="dthree_list" items="${dthree_list}" >
									<tr class="open_detail" data_num="${dthree_list.area}" >
										<td>
											<input type="checkbox" class="del_point" name="del_code" value="${dthree_list.area}">
										</td>
										<td style="width:25%; cursor: pointer;">
											${dthree_list.area}
										</td> 
										<td style="width:25%; text-align:center; ">${dthree_list.korea}</td>
										<td id="dthreeForeigner">${dthree_list.foreigner}</td>
										<td style="width:25%; text-align:center; " id="active_flg">
											<c:if test="${dthree_list.active_flg eq 'Y'}">활성화</c:if>
											<c:if test="${dthree_list.active_flg eq 'N'}">비활성화</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
						<c:if test="${dhtree_list.size() == 0}">
							<tr style="cursor: default; background-color: white;">
								<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
							</tr>
						</c:if>
					</tbody>
				</table>
				</form>
			</div>
			
			<div class="paging_div">
				<div class="left">
					<input type="button" id="dthree_add_fbtn" class="btn btn-default btn-sm" value="추가"/>
		  			<input type="button" id="dthree_del_fbtn" class="btn btn-primary btn-sm" value="삭제"/>
				</div>
				
				<div class="page" id="paging_div">	
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="PageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1}">
							<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;"/>  
							<a style="color: black;"> / ${page.endPageNum}</a>
							<a style="color: black;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;"/> /&nbsp;
							<a href="#" onclick="dthreeListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
							<a href="#" onclick="dthreeListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="dthreeListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;"/> /&nbsp;
							<a href="#" onclick="dthreeListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
						</c:when>
						<c:otherwise>
							<a href="#" onclick="dthreeListInqr('${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" value="${pageNum}" onkeypress="pageInputRepDept(event);" style="width: 30px; padding: 3px;" /> /&nbsp;
							<a href="#" onclick="dthreeListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
							<a href="#" onclick="dthreeListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			
			
		</div>
			
		<div id="dept_detail_div" class="list3Right_div">
			<h5 id="h5">지역 상세</h5>
			<form id="dthree_detail_form" name="dthree_detail_form">
				<table summary="dthree_detail" class="table table-hover">
					<tbody id="tbody1">
						<tr >
							<th style="font-weight: bold; vertical-align: middle; height: 30px;">지역명</th>
							<td ><input type="text" style="padding-left: 6px; height: 30px;" name="area" id="area" class="inputTxt"  value="${area}"  ></input></td>
						</tr>
						<tr >
							<th style="font-weight: bold; vertical-align: middle; height: 25px;">내국인</th>
							<td ><input type="text" style="padding-left: 6px; height: 30px; " name="korea" id="korea" class="inputTxt"  value="${korea}"></input></td>
						</tr>
						<tr >
							<th style="font-weight: bold; vertical-align: middle; height: 25px;;">외국인</th>
							<td ><input type="text" style="padding-left: 6px; height: 30px;" name="foreigner" id="foreigner" class="inputTxt"  value="${foreigner}"></input></td>
						</tr>
						<tr >
							<th style="font-weight: bold; vertical-align: middle; height: 25px;">활성화여부</th>
							<td style="text-align: left; " >
								<input type="radio" class="active_flg" name="active_flg" value="Y" style="margin-left: 90px; "/>Y &nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" class="active_flg" name="active_flg" value="N"/>N
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			
			<div class="btn_div">
				
				<div class="right">
					<input type="button" id="dthree_reset_nfbtn" class="btn btn-default btn-sm" value="초기화" style="display:none"  />
					<input type="button" id="dthree_edit_nfbtn"  class="btn btn-default btn-sm" value="편집" style="display:none" />
	  				<input type="button" id="dthree_save_fbtn"   class="btn btn-primary btn-sm" value="저장" style="display:none" />
				</div>
			</div> 
			
<!-- 			<div class="dthree"> -->
<%-- 				<script src="${ctx}/resources/common/js/mps/chartJS/foreigner.js"></script>  --%>
<!-- 			</div> -->
				<div class="d3test">
					<%-- <script src="${ctx}/resources/common/js/mps/chartJS/foreigner.js"></script>  --%>
				</div>
				
<!-- 				<svg id="myGraph"></svg> -->
<%-- 				<script src="${ctx}/resources/common/js/mps/chartJS/barChart02.js"></script> --%>
				
				<div>
					<button data-src="/WEB-INF/views/chart/mydata1.csv">mydata1.csv</button>
					<button data-src="/WEB-INF/views/chart/mydata2.csv">mydata2.csv</button>
					<button data-src="/WEB-INF/views/chart/mydata3.csv">mydata3.csv</button>
				</div>
				
				<svg id="myGraph"></svg>
				<script src="${ctx}/resources/common/js/mps/chartJS/barChart03.js"></script>
				
			</div>
		
	</div>		
</div>
</body>
</html>