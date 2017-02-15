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
		<div class="navi_div">■ 메뉴권한관리</div>
		<br><br>
		
		<!-- Search Cover Div -->
		<div class="search_div">
			<div class="search2_div">
				<form name="searchForm">
						<tr>
							<th>권한ID명</th>
							<td>
								<input type="text" id="menuAuth_sch" name="menuAuth_sch" value="${menuAuth_sch}">
							</td>
						   	 <td>
						    	<input type="button" id="search_fbtn" class="user_serach_fbtn" onclick="fn_search(1)" value="검색">
						    </td>
						</tr>
				</form>
				<!-- Paging Form -->
				<form id="menuAuthlistPagingForm" method="post" action="menuAuthInqr">
			
				</form>
			</div>
		<!-- class="search_div" -->
		</div>
		<br>
			
		<!-- List Cover Div -->
		<div class="list_div">
			<div>
				<form name="delAllForm" id="delAllForm" method="post" action="menuAuthDetailDel">
					<table id="mastertable" class="table table-bordered">
						<thead>
							<tr>
								<td align="center"><input id="checkall" type="checkbox" /></td>
								<td align="center">메뉴코드</td>
								<td align="center">메뉴명</td>
								<td align="center">권한명</td>
								<td align="center">조회권한</td>
								<td align="center">생성권한</td>
								<td align="center">수정권한</td>
								<td align="center">삭제권한</td>
								<td align="center">메뉴접근권한</td>
							</tr>
						</thead>
						
						<tbody id="menuAuthListTbody">
							<c:forEach var="menuAuthInqrList" items="${menuAuthInqrList}">
								<tr class="open_detail" data_num="${menuAuthInqrList.MENU_CD}" 
									onmouseover="this.style.background='#c0c4cb'" onmouseout="this.style.background='white'">
									<td align="center" scope="row">
										<input type="checkbox" name="del_menuAuth" id="del_menuAuth" value="${menuAuthInqrList.MENU_CD}" />
									</td>
									<td>${menuAuthInqrList.MENU_CD}</td>
									<td>${menuAuthInqrList.MENU_NM}</td>
									<td>${menuAuthInqrList.AUTH_NM}</td>
									<td>${menuAuthInqrList.INQR_AUTH}</td>
									<td>${menuAuthInqrList.ADD_AUTH}</td>
									<td>${menuAuthInqrList.MDFY_AUTH}</td>
									<td>${menuAuthInqrList.DEL_AUTH}</td>
									<td>${menuAuthInqrList.MENU_ACC_AUTH}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				
				<!-- Button Div -->
				<div class="btn01">
					<div class="left">
						<input type="button" id="menuAuth_add_btn" class="btn btn-default" value="추가" /> 
						<input type="button" id="menuAuth_del_btn" class="btn btn-default" value="삭제" />
					</div>
				</div>
				
				<!-- Pagine Div -->
				<div id="menuAuthPagingDiv" class="page1">
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
				<!-- class="page1" -->
				</div>
				
			<!-- class="list2_div" -->	
			</div>
		
		<!-- class="list_div" -->
		</div>	
		
	
	<!-- class="main_div" -->
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
			var menuAuth_sch = $("#menuAuth_sch").val();
			var tbody = $("#menuAuthListTbody");
			var contents = "";
			
			// Ajax를 이용해서 페이지 리스트 출력해줘야 하는부분.
			$.ajax({
				url      : 'menuAuth_list',
				type     : 'POST',
				dataType : 'json',
				data     : {
					"menuAuth_sch":menuAuth_sch, "pageNum":pageNum
				},
				success  : function(data) {
					tbody.empty();
					var menuAuthInqrList = data.menuAuthInqrList;
												
					if(menuAuthInqrList.lenght != 0)
					{
						for(var i=0; i<menuAuthInqrList.length; i++)
						{
							var menu_cd = menuAuthInqrList[i].MENU_CD;
							var menu_nm  = menuAuthInqrList[i].MENU_NM;
							var auth_nm   = menuAuthInqrList[i].AUTH_NM;
							var inqr_auth = menuAuthInqrList[i].INQR_AUTH;
							var add_auth = menuAuthInqrList[i].ADD_AUTH;
							var mdfy_auth = menuAuthInqrList[i].MDFY_AUTH;
							var del_auth = menuAuthInqrList[i].DEL_AUTH;
							var menu_acc_auth = menuAuthInqrList[i].MENU_ACC_AUTH;
							
							contents += "<tr class='open_detail' data_num='"+menu_cd+"' onmouseover='this.style.background='#c0c4cb' onmouseout='this.style.background='white''>"
							+"<td align='center' scope='row'>"
							+"<input type='checkbox' name='del_menuAuth' id='del_menuAuth' value='"+menu_cd+"'></td>"
		    				+"<td>"+menu_cd+"</td>"
		    				+"<td>"+menu_nm+"</td>"
		    				+"<td>"+auth_nm+"</td>"
							+"<td>"+inqr_auth+"</td>"
							+"<td>"+add_auth+"</td>"
							+"<td>"+mdfy_auth+"</td>"
							+"<td>"+del_auth+"</td>"
							+"<td>"+menu_acc_auth+"</td>"
							+"</tr>";
						}
					}
					
					tbody.append(contents);
					
					$("#menuAuthPagingDiv").empty();
					
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
					$("#menuAuthPagingDiv").append(pageContent);
				}
			});
			
		}
		
		// 검색 버튼 클릭시
		function fn_search(pageNum)
		{
			var menuAuth_sch = $("#menuAuth_sch").val();
			var tbody = $("#menuAuthListTbody");
			var contents = "";
			var pageContent = "";
				
			$.ajax({
				url      : 'menuAuth_list',
				type     : 'POST',
				dataType : 'json',
				data     : {
					"menuAuth_sch":menuAuth_sch, "pageNum":pageNum
				},
				success  : function(data) {						
					tbody.empty();
					var menuAuthInqrList = data.menuAuthInqrList;
					
					if(menuAuthInqrList.lenght != 0)
					{
						for(var i=0; i<menuAuthInqrList.length; i++)
						{
							var menu_cd = menuAuthInqrList[i].MENU_CD;
							var menu_nm  = menuAuthInqrList[i].MENU_NM;
							var auth_nm   = menuAuthInqrList[i].AUTH_NM;
							var inqr_auth = menuAuthInqrList[i].INQR_AUTH;
							var add_auth = menuAuthInqrList[i].ADD_AUTH;
							var mdfy_auth = menuAuthInqrList[i].MDFY_AUTH;
							var del_auth = menuAuthInqrList[i].DEL_AUTH;
							var menu_acc_auth = menuAuthInqrList[i].MENU_ACC_AUTH;
							
							contents += "<tr class='open_detail' data_num='"+menu_cd+"' onmouseover='this.style.background='#c0c4cb' onmouseout='this.style.background='white''>"
							+"<td align='center' scope='row'>"
							+"<input type='checkbox' name='del_menuAuth' id='del_menuAuth' value='"+menu_cd+"'></td>"
		    				+"<td>"+menu_cd+"</td>"
		    				+"<td>"+menu_nm+"</td>"
		    				+"<td>"+auth_nm+"</td>"
							+"<td>"+inqr_auth+"</td>"
							+"<td>"+add_auth+"</td>"
							+"<td>"+mdfy_auth+"</td>"
							+"<td>"+del_auth+"</td>"
							+"<td>"+menu_acc_auth+"</td>"
							+"</tr>";
						}
					}
					
					tbody.append(contents);
					
					$("#menuAuthPagingDiv").empty();
					
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
					
					$("#menuAuthPagingDiv").append(pageContent);
				}
			});
		}
		
		

	</script>

</body>
</html>

<%@include file="../include/footer.jsp"%>

