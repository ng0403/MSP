<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" />
<title>Code List</title>

<style type="text/css">
.menuWindow{display: none; position:absolute; width:15%; height:15%; left:80%; top:30%; 
				background-color: #c0c4cb	; overflow: auto;}	

.menuOpen{display: none;}	
	
.block_div{display:block; height: 10px; clear: both;}

.modal.fade {
  -webkit-transition: opacity .3s linear, top .3s ease-out;
  -moz-transition: opacity .3s linear, top .3s ease-out;
  -ms-transition: opacity .3s linear, top .3s ease-out;
  -o-transition: opacity .3s linear, top .3s ease-out;
  transition: opacity .3s linear, top .3s ease-out;
}
.modal.fade.in {
  top: 5%;
}

.page1 {
	width: 15%;
	text-align: center;
	float: inherit;
	
}

</style>

<script type="text/javascript">
function menuByMask() {
	//화면의 높이와 너비를 구한다.
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	
	alert("Height : " + maskHeight + " Width :" + maskWidth);
	
	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	$("#menuMask").css({
		'width' : maskWidth,
		'height' : maskHeight
	});

	//윈도우 같은 거 띄운다.
	$('.menuWindow').show();
}

$(document).ready(function() {
	//검은 막 띄우기
	$('.menuOpen').click(function(e) {
		e.preventDefault();
		menuByMask();
	});

	//닫기 버튼을 눌렀을 때
	$('.menuWindow #menuClose').click(function(e) {
		//링크 기본동작은 작동하지 않도록 한다.
		e.preventDefault();
		$("#generalTbody").empty();
		$("#menuMask, .menuWindow").hide();
	});

	//검은 막을 눌렀을 때
	$("#menuMask").click(function() {
		$(this).hide();
		$('.menuWindow').hide();
	});
});

</script>


</head>
<body>
<%@include file="../include/header.jsp"%>

<!--Main_Div  -->
<div class="main_div">

	<!-- Navigation Div -->
	<div class="navi_div">■ 코드관리</div>
	
	<br><br>
		
	<!-- Search Cover Div -->
	<div class="search_div">
		<div class="search2_div">
			<form name="searchForm">
					<tr>
						<th>공통코드명</th>
						<td>
							<input type="text" id="grp_nm_sch" name="grp_nm_sch" value="${grp_nm_sch}">
						</td>
					   	 <td>
					    	<input type="button" id="search_fbtn" class="user_serach_fbtn" onclick="fn_search(1)" value="검색">
					    </td>
					</tr>
			</form>
			<!-- Paging Form -->
			<form id="codelistPagingForm" method="post" action="codeInqr">
			
			</form>
		</div>
	</div>
	
	<br>
	
	<!-- List Cover Div -->
		<div class="list_div">
			<div class="list2_div">
				<form name="delAllForm" id="delAllForm" method="post" action="codeDetailDel">
					<table id="mastertable" class="table table-bordered">
						<thead>
							<tr>
								<td align="center"><input id="checkall" type="checkbox" /></td>
								<td align="center">공통코드</td>
								<td align="center">공통코드명</td>
								<td align="center">상세코드</td>
								<td align="center">상세코드명</td>
							</tr>
						</thead>
						<tbody id="codeListTbody">
							<c:forEach var="codeInqrList" items="${codeInqrList}">
								<tr class="open_detail" data_num="${codeInqrList.CODE1}" onmouseover="this.style.background='#c0c4cb'" 
									onmouseout="this.style.background='white'">
									<td align="center" scope="row">
										<input type="checkbox" name="del_code" id="del_code" value="${codeInqrList.CODE1}">
									</td>
									<td align="center">${codeInqrList.GRP_CD}</td>
									<td>${codeInqrList.GRP_NM}</td>
									<td align="center">${codeInqrList.CODE1}</td>
									<td>${codeInqrList.CODE_TXT}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				
				<!-- Button Div -->
				<div class="btn01">
					<div class="left">
						<input type="button" id="code_add_btn" class="btn btn-default" value="추가" /> 
						<input type="button" id="code_del_btn" class="btn btn-default" value="삭제" />
					</div>
				</div>
				
				<!-- Pagine Div -->
				<div id="codePagingDiv" class="page1">
						<input type="hidden" id="endPageNum" value="${page.endPageNum}" />
						<input type="hidden" id="startPageNum" value="${page.startPageNum}" />
						<input type="hidden" id="userPageNum" value="${pageNum}" />
						<c:choose>
							<c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
								<a style="color: black; text-decoration: none;">◀ </a>
								<input type="text" id="pageInput" class="userPageInput" value="${page.startPageNum}" onkeypress="userpageNumEnter(event);" style="width: 15%;" />
								<a style="color: black; text-decoration: none;">/ 1</a>
								<a style="color: black; text-decoration: none;">▶ </a>
							</c:when>
							<c:when test="${pageNum == page.startPageNum}">
								<a style="color: black; text-decoration: none;">◀ </a>
								<input type="text" id="pageInput" class="userPageInput" value="${page.startPageNum}" onkeypress="userpageNumEnter(event);" style="width: 15%;" />
								<a href="#" onclick="userPaging('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
								<a href="#" onclick="userPaging('${pageNum+1}');" id="pNum">▶</a>
							</c:when>
							<c:when test="${pageNum == page.endPageNum}">
								<a href="#" onclick="userPaging('${pageNum-1}');" id="pNum">◀</a>
								<input type="text" id="pageInput" class="userPageInput" value="${page.endPageNum}" onkeypress="userpageNumEnter(event);" style="width: 15%;" />
								<a href="#" onclick="userPaging('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
								<a style="color: black; text-decoration: none;">▶</a>
							</c:when>
							<c:otherwise>
								<a href="#" onclick="userPaging('${pageNum-1}');" id="pNum">◀</a>
								<input type="text" id="pageInput" class="userPageInput" value="${pageNum}" onkeypress="userpageNumEnter(event);" style="width: 15%;" />
								<a href="#" onclick="userPaging('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
								<a href="#" onclick="userPaging('${pageNum+1}');" id="pNum">▶</a>
							</c:otherwise>
						</c:choose>
					</div>
			</div>

			<div class="list3_div">
			<h4>공통코드 상세</h4>
				<form method="post" id="joinform1" action="codeMasterAdd">
					<table class="table">
						<tbody id="tbody1">
							<tr>
								<th>공통코드</th>
								<td>
									<input type="text" name="grp_cd" id="grp_cd" class="iuser_txt" style="width: 90%" size="5" value="${grp_cd}" />
								</td>
								<th>공통코드명</th>
								<td>
									<input type="text" name="grp_nm" id="grp_nm" class="iuser_txt" style="width: 90%" value="${grp_nm}" />
								</td>
							</tr>
							<tr>
								<th>공통코드 설명</th>
								<td><input type="text" name="grp_desc" id="grp_desc"
									class="iuser_txt" style="width: 90%" value="${grp_desc}" /></td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<!-- Button Div -->
				<div class="btn02">
					<div class="left">
						<input type="button" id="codeMaster_add_btn" class="btn btn-default" value="추가" style="display: none" /> 
						<input type="button" id="codeMaster_reset_btn" class="btn btn-default" value="취소" style="display: none" />
					</div>
				</div>
				
				<br><br><br>
				
				<h4>상세코드 상세</h4>
				<form method="post" id="joinform2">
					<table class="table">
						<tbody id="tbody1">
							<tr>
								<th>공통코드</th>
								<td>
									<input type="text" name="grp_cd" id="grp_cd1" class="iuser_txt" style="width: 90%" value="${grp_cd}" size="5" readonly="readonly" />
								</td>
								<td>
									<input type="button" name="selectGrp" id="sel_grp" value="선택" style="width: 90%; display: none" /> <!--  onclick="fn_selectPop()" -->
								</td>
							</tr>
							<tr>
								<th>상세코드</th>
								<td>
									<input type="text" name="code1" id="code1" class="iuser_txt" style="width: 90%" value="${code1}" />
								</td>
								<th>상세코드명</th>
								<td>
									<input type="text" name="code_txt" id="code_txt" class="iuser_txt" style="width: 90%" value="${code_txt}" />
								</td>
							</tr>
							<tr>	
								<th>상세코드 설명</th>
								<td>
									<input type="text" name="code_desc" id="code_desc" class="iuser_txt" maxlength="12" style="width: 90%" value="${code_desc}" />
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<!-- Button Div -->
				<div class="btn02">
					<div class="left">
						<input type="button" id="codeDetail_add_btn" class="btn btn-default" value="추가" style="display: none" /> 
						<input type="button" id="codeDetail_mdfy_btn" class="btn btn-default" value="수정" style="display: none" /> 
						<input type="button" id="codeDetail_reset_btn" class="btn btn-default" value="취소" style="display: none" />
					</div>
				</div>
			</div>
			
			<!-- POPUP Div -->
			<div id="codePagingDiv1" class="paging_div">
				<div id="menuDetail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="menuDetail-tab" aria-hidden="true" data-backdrop="static" data-keyboard="true" >
       				 <div class="modal-dialog modal-lg">
           				 <div class="modal-content">
           				</div>
       				 </div>
    			</div>
				
				<div style="font-size:11.5px;">
					<jsp:include page="../code/code_pop.jsp"></jsp:include>
				</div>

			</div>
		</div>	
		
	<script type="text/javascript">
		
		$("#navisub11").show();
		$("#naviuser").css("font-weight", "bold");
		
		//페이지 엔터키 기능
		function userpageNumEnter(event, url) 
		{
			$(document).ready(function() {
				var keycode = (event.keyCode ? event.keyCode : event.which);
			
				if (keycode == '13') 
				{
					var pageNum = parseInt($("#pageInput").val());
					
					if ($("#pageInput").val() == '') 
					{
						alert("페이지 번호를 입력하세요.");
							
						$("#pageInput").focus();
					}
					else if(parseInt($("#pageInput").val()) > parseInt($("#endPageNum").val())) 
					{
						alert("페이지 번호가 너무 큽니다.");
							
						$("#pageInput").val($("#pageNum").val());
						$("#pageInput").focus();
					}
					else 
					{
						userPaging(pageNum);
					}
				}
				event.stopPropagation();
			});
		}				
	
		//사용자관리 페이징
		function userPaging(pageNum) 
		{
			var grp_cd = $("#grp_nm_sch").val();
			var tbody = $("#codeListTbody");
			var contents = "";
			
			// Ajax를 이용해서 페이지 리스트 출력해줘야 하는부분.
			$.ajax({
				url      : 'codeSearch_list2',
				type     : 'POST',
				dataType : 'json',
				data     : {
					"grp_cd":grp_cd, "pageNum":pageNum
				},
				success  : function(data) {
					tbody.empty();
					var codeInqrList = data.codeInqrList;
												
					if(codeInqrList.lenght != 0)
					{
						for(var i=0; i<codeInqrList.length; i++)
						{
							var grp_cd1 = codeInqrList[i].grp_cd;
							var grp_nm  = codeInqrList[i].grp_nm;
							var code1   = codeInqrList[i].code1;
							var code_txt = codeInqrList[i].code_txt;
							
							contents += "<tr class='open_detail' data_num='"+code1+"' onmouseover='this.style.background='#c0c4cb' onmouseout='this.style.background='white''>"
							+"<td align='center' scope='row'>"
							+"<input type='checkbox' name='del_code' id='del_code' value='"+code1+"'></td>"
		    				+"<td align='center'>"+grp_cd1+"</td>"
		    				+"<td>"+grp_nm+"</td>"
		    				+"<td align='center'>"+code1+"</td>"
							+"<td>"+code_txt+"</td>"
							+"</tr>";
						}
					}
					
					tbody.append(contents);
					
					$("#codePagingDiv").empty();
					
					if(data.page.endPageNum == 1)
					{
						pageContent = "<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repUserPageInput' value='"+data.page.startPageNum+"' onkeypress='pageInputRepUser(event);'/>"  
						+"<a style='color: black; text-decoration: none;'> / "+data.page.endPageNum+"</a>"
					}
					else if(data.page.startPageNum == data.page.endPageNum)
					{
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 15%;' id='pageInput' class='repUserPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					}
					else if(data.pageNum == 1)
					{
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 15%; ' id='pageInput' class='repUserPageInput' value='"+data.page.startPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum+1)+") id='pNum'> ▶ </a>";
					}
					else if(data.pageNum == data.page.endPageNum)
					{
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 15%;' id='pageInput' class='repUserPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					}
					else
					{
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 15%; ' id='pageInput' class='repUserPageInput' value='"+data.pageNum+"' onkeypress=\"pageInputRepUser(event);\"/>"
						+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum+1)+") id='pNum'> ▶ </a>";
					}
					$("#codePagingDiv").append(pageContent);
				}
			});
			
		}
		
		// 검색 버튼 클릭시
		function fn_search(pageNum)
		{
				var grp_cd = $("#grp_nm_sch").val();
				var tbody = $("#codeListTbody");
				var contents = "";
				var pageContent = "";
				
				$.ajax({
					url      : 'codeSearch_list2',
					type     : 'POST',
					dataType : 'json',
					data     : {
						"grp_cd":grp_cd, "pageNum":pageNum
					},
					success  : function(data) {						
						tbody.empty();
						var codeInqrList = data.codeInqrList;
													
						if(codeInqrList.lenght != 0)
						{
							for(var i=0; i<codeInqrList.length; i++)
							{
								var grp_cd1 = codeInqrList[i].grp_cd;
								var grp_nm  = codeInqrList[i].grp_nm;
								var code1   = codeInqrList[i].code1;
								var code_txt = codeInqrList[i].code_txt;
								
								contents += "<tr class='open_detail' data_num='"+code1+"' onmouseover='this.style.background=#c0c4cb' onmouseout='this.style.background='white''>"
								+"<td align='center' scope='row'>"
								+"<input type='checkbox' name='del_code' id='del_code' value='"+code1+"'></td>"
			    				+"<td align='center'>"+grp_cd1+"</td>"
			    				+"<td>"+grp_nm+"</td>"
			    				+"<td align='center'>"+code1+"</td>"
								+"<td>"+code_txt+"</td>"
								+"</tr>";
							}
						}
						
						tbody.append(contents);
						
						$("#codePagingDiv").empty();
						
						if(data.page.endPageNum == 1)
						{
							pageContent = "<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
							+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repUserPageInput' value='"+data.page.startPageNum+"' onkeypress='pageInputRepUser(event);'/>"  
							+"<a style='color: black; text-decoration: none;'> / "+data.page.endPageNum+"</a>"
						}
						else if(data.page.startPageNum == data.page.endPageNum)
						{
							pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
							+"<input type='text' style='width: 15%;' id='pageInput' class='repUserPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
							+"<a style='color:black; text-decoration: none;'>▶</a>";
						}
						else if(data.pageNum == 1)
						{
							pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
							+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 15%; ' id='pageInput' class='repUserPageInput' value='"+data.page.startPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum+1)+") id='pNum'> ▶ </a>";
						}
						else if(data.pageNum == data.page.endPageNum)
						{
							pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
							+"<input type='text' style='width: 15%; ' id='pageInput' class='repUserPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
							+"<a style='color:black; text-decoration: none;'>▶</a>";
						}
						else
						{
							pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
							+"<input type='text' style='width: 15%; ' id='pageInput' class='repUserPageInput' value='"+data.pageNum+"' onkeypress=\"pageInputRepUser(event);\"/>"
							+"<a style='cursor: pointer;' onclick=fn_search("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
							+"<a style='cursor: pointer;' onclick=fn_search("+(data.pageNum+1)+") id='pNum'> ▶ </a>";
						}
						$("#codePagingDiv").append(pageContent);
					}
				});
		}
			
		// 검색 버튼 클릭시 - 기존
		$(function(){
			$("#search_fbtn1").click(function(){
				var grp_cd = $("#grp_nm_sch").val();
				//var url = "codeSearch_list/"+grp_cd;
				var url = "codeSearch_list2";
				var tbody = $("#codeListTbody");
				var contents = "";
				
				// getJSON은 get 방식으로 post는 post 방식으로 ajax를 사용한다. (getJSON = get)
				$.post(url, function(data){
					$(data).each(function() {	// each -> foreach
						tbody.empty();			// tbody 부분을 비워주는 역할.
						
						contents += "<tr class='open_detail' data_num='"+this.code1+"' onmouseover='this.style.background=#c0c4cb' onmouseout='this.style.background=white'>"
						+"<td align='center' scope='row'>"
						+"<input type='checkbox' name='del_code' id='del_code' value='"+this.code1+"'></td>"
	    				+"<td align='center'>"+this.grp_cd+"</td>"
	    				+"<td>"+this.grp_nm+"</td>"
	    				+"<td align='center'>"+this.code1+"</td>"
						+"<td>"+this.code_txt+"</td>"
						+"</tr>";
						
						tbody.append(contents);
					});
					
				});
			});
		});
		
		// 공통코드 선택 POPUP
		$("#sel_grp").on("click", function(){
			var tbody_general = $('#generalTbody');
			var contents = "";
			
			$.ajax({
				url 	 : 'searchGrpPop',
				type 	 : 'POST',
				dataType : 'json',
				success  : function(data){
					tbody_general.empty();
					var grpPop = data.grpPop;
					
					if(grpPop.lenght != 0)
					{
						for(var i=0; i<grpPop.length; i++)
						{
							var grp_cd_pop = grpPop[i].grp_cd;
							var grp_nm_pop = grpPop[i].grp_nm;
							
							contents +=
								"<tr height='15px'>"+
									"<td style='text-align: center;' onclick='pop_grpCode("+grp_cd_pop+")'>"+
										grp_cd_pop+
									"</td>"+
									"<td style='width: 80%; text-align: left;'>"+
										grp_nm_pop+
									"</td>"+
								"</tr>";
								
						}
					}
					tbody_general.append(contents);
				}
			});
			$('.menuOpen').click();
		});
		
		// Mainc창에 상세코드 상세보기란에 있는 공통코드 부분에 값을 넣는다.
		function pop_grpCode(grpCode)
		{
			var tmp = grpCode;
			$("#grp_cd1").val("0"+grpCode);
		}
		
		// 코드 추가버튼을 눌렀을 시
		$("#code_add_btn").on("click", function(){
			// 숨겨놓은 각각의 버튼을 보여준다.
			$("#codeMaster_add_btn").show();
			$("#codeMaster_reset_btn").show();
			$("#codeDetail_add_btn").show();
			$("#codeDetail_mdfy_btn").hide();
			$("#codeDetail_reset_btn").show();
			$("#sel_grp").show();
			
			// 상세보기로 내용이 있을 경우 reset해준다.
			$("#joinform1").each(function(){
				this.reset();
			})
			
			$("#joinform2").each(function(){
				this.reset();
			})
		});
	
		// 코드 삭제버튼 클릭 시
		$("#code_del_btn").on("click", function(){
			var check = document.getElementsByName("del_code");
			var check_len = check.length;
			var checked = 0;
			
			for(i=0; i<check_len; i++)
			{
				if(check[i].checked == true)
				{
					$("#delAllForm").submit();
					checked++;
				}
			}
	
			if(checked == 0)
			{
				alert("체크박스를 선택해주세요.");
			}
		});

		// 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.)
		$(function(){
			$(document).on("click", ".open_detail", function() {	// ajax일 경우 이런 식으로 사용해야한다.
				code1 = $(this).attr("data_num");
				
				codeDetailInqr(code1);
			});
			
		});
		
		// 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.)
		function codeDetailInqr(code1) 
		{				
			//$.getJSON("codeDetail_list/"+code1, function(data){	// 와 같이 써도 똑같다. (get이냐 post냐의 차이)
			$.post("codeDetail_list/"+code1, function(data){
				$(data).each(function() {
					var grp_cd = this.grp_cd;
					var grp_nm = this.grp_nm;
					var grp_desc = this.grp_desc;
					var code1  = this.code1;
					var code_txt  = this.code_txt;
					var code_desc = this.code_desc;
					
					$("#grp_cd").val(grp_cd);
					$("#grp_cd1").val(grp_cd);
					$("#grp_nm").val(grp_nm);
					$("#grp_desc").val(grp_desc);
					$("#code1").val(code1);
					$("#code_txt").val(code_txt);
					$("#code_desc").val(code_desc);
				});
				
			});
	
			// 수정을 하지 말아야 할 것들은 readOnly로 바꿔준다.
			$("#grp_cd").attr("readOnly", true);
			$("#grp_nm").attr("readOnly", true);
			$("#grp_desc").attr("readOnly", true);
			$("#code1").attr("readOnly", true);
			
			// 추가 버튼이 아닌 수정버튼이 보이도록 해준다.
			$("#codeDetail_add_btn").hide();
			$("#codeDetail_mdfy_btn").show();
			$("#codeDetail_reset_btn").show();
		}	
	
		// 공통코드 상세보기 추가 버튼
		$("#codeMaster_add_btn").on("click", function(){
			if($("#grp_cd").val() == "" || $("#grp_cd").val() == null){
				alert("공통코드를 입력해주세요");
				return false;
			}
			else if($("#grp_nm").val() == "" || $("#grp_nm").val() == null){
				alert("공통코드명을 입력해주세요");
				return false;
			}
			else if($("#grp_desc").val() == "" || $("#grp_desc").val() == null)
			{
				alert("공통코드설명를 입력해주세요");
				return false;
			}
			else
			{
				alert("공통코드가 등록 되었습니다.");
				$("#joinform1").submit();
			}
		});
		
		// 공통코드 상세보기 삭제버튼
		$("#codeMaster_reset_btn").on("click", function(){
			$("#grp_cd").val("");
		});
			
		// 상세코드 상세보기 추가버튼 
		$("#codeDetail_add_btn").on("click", function(){
			if($("#grp_cd1").val() == "" || $("#grp_cd1").val() == null){
				alert("공통코드를 선택해주세요");
				return false;
			}
			if($("#code1").val() == "" || $("#code1").val() == null){
				alert("상세코드를 입력해주세요");
				return false;
			}
			else if($("#code_txt").val() == "" || $("#code_txt").val() == null)
			{
				alert("상세코드명를 입력해주세요");
				return false;
			}
			else if($("#code_desc").val() == "" || $("#code_desc").val() == null)
			{
				alert("상세코드설명를 입력해주세요");
				return false;
			}
			else
			{
				alert("상세코드가 등록 되었습니다.");
				$('form').attr("action", "codeDetailAdd");
				$("#joinform2").submit();
			}
		});
		
		// 상세코드 상세보기 수정버튼
		$("#codeDetail_mdfy_btn").on("click", function(){
			$("#code1").readOnly = true;
			
			if($("#code_txt").val() == "" || $("#code_txt").val() == null)
			{
				alert("상세코드명를 입력해주세요");
				return false;
			}
			else if($("#code_desc").val() == "" || $("#code_desc").val() == null)
			{
				alert("상세코드설명를 입력해주세요");
				return false;
			}
			else
			{	 
				$('form').attr("action", "codeDetailMdfy"); 
				alert("상세코드가 수정 되었습니다.");
				$("#joinform2").submit();
			}
		});
	
		
	</script>
</div>
</body>
</html>

<%@include file="../include/footer.jsp"%>