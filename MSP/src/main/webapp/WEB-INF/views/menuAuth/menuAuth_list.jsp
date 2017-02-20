<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" />

<!--  -->

<title>MenuAuth List</title>

<style type="text/css">
#menuAuthMask {position:absolute; z-index:9000; background-color:#000; display:none; left:0; top:0;} 
#menu_pop_div { display: none; position:absolute; width:50%; height:75%; left:80%; top:30%; 
				background-color: #c0c4cb	; overflow: auto; }

.menuAuthWindow {display: none; position:absolute; width:50%; height:50%; left:30%; top:30%; z-index:10000;
				background-color: white; overflow: auto;}	
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

.search1_div {
	margin-top: 10px;
	margin-left: 20px;
	float: left;
	width: 48%;
}

</style>

<script type="text/javascript">
function menuAuthByMask() {
	//화면의 높이와 너비를 구한다.
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	
	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	$("#menuAuthMask").css({
		'width' : maskWidth,
		'height' : maskHeight
	});
	
	//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
	$('#menuAuthMask').fadeIn(1000);
	$('#menuAuthMask').fadeTo("slow", 0.5);

	//윈도우 같은 거 띄운다.
	$('.menuAuthWindow').show();
}

$(document).ready(function() {
	// 등록할 때 메뉴검색 팝업 눌렀을 때
	$("#menu_pop_div").hide();
	
	$("#menu_cd_pop").on("click", function(){
		$("#menu_pop_div").show();
		$("#menu_pop_div").center();
		menuListInqrPop(1);
		menuByMask();
	});
	
	//검은 막 띄우기
	$('.menuOpen').click(function(e) {
		e.preventDefault();
		menuAuthByMask();
	});

	//닫기 버튼을 눌렀을 때
	$('.menuAuthWindow #menuClose').click(function(e) {
		//링크 기본동작은 작동하지 않도록 한다.
		e.preventDefault();
		$("#generalTbody").empty();
		$("#menuAuthMask, .menuAuthWindow").hide();
	});

	//검은 막을 눌렀을 때
	$("#menuAuthMask").click(function() {
		$(this).hide();
		$('.menuAuthWindow').hide();
	});
});

function viewLoadingShow(){
     $('#viewLoadingImg').css('position', 'absolute');
     $('#viewLoadingImg').css('left', '45%');
     $('#viewLoadingImg').css('top', '45%');
     $('#viewLoadingImg').css('z-index', '1200');
     $('#viewLoadingImg').show().fadeIn(500);
}

function viewLoadingHide(){
   $('#viewLoadingImg').fadeOut();   
}

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
		<div class="">
			<div class="search1_div">
				<form name="searchForm">
					<table>
						<tr>
							<th>권한명</th>
							<td>
								<input type="text" id="auth_id_sch" name="auth_id_sch" value="${auth_id_sch}">
							</td>
						    <th>메뉴명</th>
							<td>
								<input type="text" id="menu_nm_sch" name="menu_nm_sch" value="${menu_nm_sch}">
							</td>
						   	<td>
						    	<input type="button" id="search_fbtn" class="user_serach_fbtn" onclick="fn_search(1)" value="검색">
						    </td>
						</tr>
					</table>
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
									<td>
										<a href="javascript:void(0)" onclick="fn_menuAuthPop('${menuAuthInqrList.MENU_CD}', '${menuAuthInqrList.AUTH_NM }')">${menuAuthInqrList.MENU_CD}</a>
									</td>
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
						<input type="button" id="menuAuth_add_btn" class="btn btn-default" data-target="#menuAuthAddLayer" data-toggle="modal" value="추가" /> 
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
		
		<!-- 메뉴권한 상세정보 창 띄우기(취소 - 부트스트랩을 mask모달로 변경) -->
		<div id="menuAuthDetail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="menuAuthDetail-tab" aria-hidden="true" data-backdrop="static" data-keyboard="true" >
     	   <div class="modal-dialog modal-lg">
     	       <div class="modal-content">
     	       </div>
    	    </div>
		</div>
		
		<div id="viewLoadingImg" style="display: none;">
			<img src="${ctx}/resources/image/viewLoading.gif">
   		</div>
		
		 <!-- menu detail 팝업 -->
		<div style="font-size:11.5px;">
	    	<jsp:include page="../menuAuth/menuAuth_pop.jsp"></jsp:include>
		</div>
		<!-- //menu detail 팝업 -->
		
		<!--  메뉴권한 등록 창띄우기 -->
    	<div class="modal fade" id="menuAuthAddLayer" style="display: none;">
			<div class="modal-dialog modal-lg">   <!-- modal-lg -->
				<div class="modal-content">
					<span style="float:left;margin-left:1%;margin-top:1%; font-size:15px;">
						<strong>메뉴권한 등록</strong></span>
		        
		        <form name="menuAuthAdd" id="menuAuthAdd" action="menuAuthAdd"	enctype="multipart/form-data" method="post">
		        	<input type="button" class="btn btn-default" data-dismiss="modal" value="닫기" style="font-size:11.5px;float:right;margin-right:1%;margin-top:1%;"/>
		        	<input type="button" class="btn btn-default" id="menuAuth_save_btn" value="저장" style="font-size:11.5px;float:right;margin-right:1%;margin-top:1%;"/><!-- submit으로 보내는 것이 post,  value값 직접 전달이get -->
		        
	            	<div class="block_div"></div><div class="block_div"></div><div class="block_div"></div>
	           
					<div align="center" style="width: 100%">
						<table class="board_view" style="font-size:12px;width: 100%">
							<tr height="15px">
								<th style=" width: 12%; text-align: right;"><span style="color:red;">*</span>권한ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<input type="text" id="auth_id3" name ="auth_id3" style="width:80%; background-color:#F2F2F2;" value="${auth_id3}" readonly="readonly"/>
									<input type="button" id="auth_pop" name="auth_pop" value="선택">
								</td>
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>메뉴코드&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<input type="text" id="menu_cd3" name="menu_cd3" style="width: 80%;"/>
									<input type="button" id="menu_cd_pop" name="menu_cd_pop" value="선택">
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width:20%; text-align: right;"><span style="color:red;">*</span>활성화여부&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="avtive_flg3" name="avtive_flg3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>조회권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="inqr_auth3" name="inqr_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>생성권한&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="add_auth3" name="add_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>수정권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="mdfy_auth3" name="mdfy_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>삭제권한&nbsp;&nbsp;</th>
								<td style="width: 38%; text-align: left;">
									<select id="del_auth3" name="del_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="15px"></tr>
							<tr height="15px">
								<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>메뉴접근권한</th>
								<td style="width: 38%; text-align: left;">
									<select id="menu_acc_auth3" name="menu_acc_auth3" style="width: 30%;font-size:10.5px;">
									    <option value="">선택</option>
									    <option value="Y">Y</option>
									    <option value="N">N</option>
									</select>
								</td>
							</tr>
							<tr height="50px"></tr>
						</table>
					</div>
		        </form>
				</div>
			</div>
		<!-- 등록 DIV -->
    	</div>	
	<!-- class="main_div" -->
	</div>
	
	<div id="menu_pop_div" style="font-size:11.5px;">
		<jsp:include page="../menu/menulist_pop.jsp"></jsp:include>
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
			var auth_id_sch = $("#auth_id_sch").val();
			var menu_nm_sch = $("#menu_nm_sch").val();
			var tbody = $("#menuAuthListTbody");
			var contents = "";
			
			// Ajax를 이용해서 페이지 리스트 출력해줘야 하는부분.
			$.ajax({
				url      : 'menuAuth_list',
				type     : 'POST',
				dataType : 'json',
				data     : {
					"auth_id_sch":auth_id_sch, "menu_nm_sch":menu_nm_sch, "pageNum":pageNum
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
							+"<td><a href='javascript:void(0)' onclick='fn_menuAuthPop(\""+menu_cd+"\", \""+auth_nm+"\")'>"+menu_cd+"</a></td>"
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
			var auth_id_sch = $("#auth_id_sch").val();
			var menu_nm_sch = $("#menu_nm_sch").val();
			var tbody = $("#menuAuthListTbody");
			var contents = "";
			var pageContent = "";
				
			$.ajax({
				url      : 'menuAuth_list',
				type     : 'POST',
				dataType : 'json',
				data     : {
					"auth_id_sch":auth_id_sch, "menu_nm_sch":menu_nm_sch, "pageNum":pageNum
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
							+"<td><a href='javascript:void(0)' onclick='fn_menuAuthPop(\""+menu_cd+"\", \""+auth_nm+"\")'>"+menu_cd+"</a></td>"
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
	
		// 상세보기 팝업
		function fn_menuAuthPop(menu_cd, auth_nm)
		{
			var menu_cd = menu_cd;
			var auth_nm = auth_nm;
			
			var tbody = $("#generalTbody");
			var contents  = "";
			var contents1 = "";
			
			var active_radio1 = "";
			var active_radio2 = "";
			var inqr_radio1 = "";
			var inqr_radio2 = "";
			var add_radio1 = "";
			var add_radio2 = "";
			var mdfy_radio1 = "";
			var mdfy_radio2 = "";
			var del_radio1 = "";
			var del_radio2 = "";
			var menu_acc_radio1 = "";
			var menu_acc_radio2 = "";
			
			$.ajax({
				url		 : 'menuAuthDetail',
				type	 : 'POST',
				dataType : 'json',
				data	 : {
					"menu_cd":menu_cd, "auth_nm":auth_nm
				},
				success  : function(data){
					tbody.empty();
					var menuAuthDetail = data.menuAuthDetail;
					
					for(var i=0; i<menuAuthDetail.length; i++)
					{
						var auth_id = menuAuthDetail[i].AUTH_NM;
						var menu_cd = menuAuthDetail[i].MENU_CD;
						var menu_nm = menuAuthDetail[i].MENU_NM;
						var up_menu_cd = menuAuthDetail[i].UP_MENU_CD;
	 					var up_menu_nm = menuAuthDetail[i].UP_MENU_NM;
	 					var menu_url   = menuAuthDetail[i].MENU_URL;
	 					var active_flg = menuAuthDetail[i].ACTIVE_FLG;
	 					var inqr_auth  = menuAuthDetail[i].INQR_AUTH;
						var add_auth   = menuAuthDetail[i].ADD_AUTH;
						var mdfy_auth  = menuAuthDetail[i].MDFY_AUTH;
	 					var del_auth   = menuAuthDetail[i].DEL_AUTH;
	 					var menu_acc_auth = menuAuthDetail[i].menu_acc_auth;
	 					
	 					contents1 ="<tr height='15px'>"+
	 					"<th style=' width: 12%; text-align: center;'>권한ID&nbsp;&nbsp;</th>"+
	 					"<td style='width: 38%; text-align: left;'>"+
						"<input type = 'text' id='auth_id1' name='auth_id1' value='"+auth_id+"' style='font-size:12px;width:80%;background-color:#F2F2F2;' readonly='readonly'>"+
						"</td>"+
						"<th style=' width: 12%; text-align: center;'>메뉴코드&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type = 'text' id='menu_cd1' name='menu_cd1' value='"+menu_cd+"' style='font-size:12px;width:80%;background-color:#F2F2F2;' readonly='readonly'>"+
						"</td>"+
						"</tr>"+
						"<tr height='15px'>"+
						"<th style='width: 12%; text-align: center;'>메뉴명&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='menu_nm1' name='menu_nm1' value='"+menu_nm+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"<th style='width: 12%; text-align: center;'>상위메뉴코드&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='up_menu_cd1' name='up_menu_cd1' value='"+up_menu_cd+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"</tr>"+
						"<tr height='15px'>"+
						"<th style='width: 12%; text-align: center;'>상위메뉴명&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='up_menu_nm1' name='up_menu_nm1' value='"+up_menu_nm+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"</td>"+
						"<th style='width: 12%; text-align: center;'>메뉴URL&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='menu_url1' name='menu_url1' value='"+menu_url+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"</tr>";
						
						active_radio1 = "<tr><th style='width: 12%; text-align: center;'>활성화 상태&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='active_flg1' id='active1' value='Y' style='text-align:right;width:10%;' onclick='return false;' checked/>Y"+
							"<input type='radio' name='active_flg1' id='active2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;'/>N"
							+"</td>";
						active_radio2 = "<tr><th style='width: 12%; text-align: center;'>활성화 상태&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='active_flg1' id='active1' value='Y' style='text-align:right;width:10%;' onclick='return false;'/>Y"+
							"<input type='radio' name='active_flg1' id='active2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;' checked/>N"
							+"</td>";
							
						inqr_radio1 = "<th style='width: 12%; text-align: center;'>조회권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='inqr_auth1' id='inqr_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;' checked/>Y"+
							"<input type='radio' name='inqr_auth1' id='inqr_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;'/>N"
							+"</td></tr>";
						inqr_radio2 = "<th style='width: 12%; text-align: center;'>조회권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='inqr_auth1' id='inqr_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;'/>Y"+
							"<input type='radio' name='inqr_auth1' id='inqr_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;' checked/>N"
							+"</td></tr>";
							
						add_radio1 = "<tr><th style='width: 12%; text-align: center;'>생성권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='add_auth1' id='add_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;' checked/>Y"+
							"<input type='radio' name='add_auth1' id='add_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;'/>N"
							+"</td>";
						add_radio2 = "<tr><th style='width: 12%; text-align: center;'>생성권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='add_auth1' id='add_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;'/>Y"+
							"<input type='radio' name='add_auth1' id='add_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;' checked/>N"
							+"</td>";
							
						mdfy_radio1 = "<th style='width: 12%; text-align: center;'>수정권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='mdfy_auth1' id='mdfy_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;' checked/>Y"+
							"<input type='radio' name='mdfy_auth1' id='mdfy_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;'/>N"
							+"</td></tr>";
						mdfy_radio2 = "<th style='width: 12%; text-align: center;'>수정권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='mdfy_auth1' id='mdfy_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;'/>Y"+
							"<input type='radio' name='mdfy_auth1' id='mdfy_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;' checked/>N"
							+"</td></tr>";
							
						del_radio1 = "<tr><th style='width: 12%; text-align: center;'>삭제권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='del_auth1' id='del_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;' checked/>Y"+
							"<input type='radio' name='del_auth1' id='del_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;'/>N"
							+"</td>";
						del_radio2 = "<tr><th style='width: 12%; text-align: center;'>삭제권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='del_auth1' id='del_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;'/>Y"+
							"<input type='radio' name='del_auth1' id='del_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;' checked/>N"
							+"</td>";
						
						menu_acc_radio1 = "<th style='width: 12%; text-align: center;'>메뉴접근권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;' checked/>Y"+
							"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;'/>N"
							+"</td></tr>";
						menu_acc_radio2 = "<th style='width: 12%; text-align: center;'>메뉴접근권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth1' value='Y' style='text-align:right;width:10%;' onclick='return false;'/>Y"+
							"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return false;' checked/>N"
							+"</td></tr>";	
							
						if(active_flg == 'Y') {
							contents = contents1 + active_radio1;
						}
						else {
							contents = contents1 + active_ardio2;
						}
						
						if(inqr_auth == 'Y') {
							contents = contents + inqr_radio1;
						}
						else {
							contents = contents + inqr_radio2;
						}
						
						if(add_auth == 'Y') {
							contents = contents + add_radio1;
						}
						else {
							contents = contents + add_radio2;
						}
						
						if(mdfy_auth == 'Y') {
							contents = contents + mdfy_radio1;
						}
						else {
							contents = contents + mdfy_radio2;
						}
						
						if(del_auth == 'Y') {
							contents = contents + del_radio1;
						}
						else {
							contents = contents + del_radio2;
						}
						
						if(menu_acc_auth == 'Y') {
							contents = contents + menu_acc_radio1;
						}
						else {
							contents = contents + menu_acc_radio2;
						}
						
						tbody.append(contents);
					}
				}
			});
			
			$('.menuOpen').click();
		}
		
		// 추가버튼 눌렀을 때
		$("#menuAuth_save_btn").on("click", function(){
			$("#menuAuthAdd").submit();
		});
		
		// 삭제 버튼 눌렀을 때
		$("#menuAuth_del_btn").on("click", function(){
			var check = document.getElementsByName("del_menuAuth");
			var check_len = check.length;
			var checked = 0;
			
			for(i=0; i<check_len; i++)
			{
				if(check[i].checked == true)
				{
					alert("OH~!");
					checked++;
				}
			}
			
			if(checked == 0)
			{
				alert("체크박스를 체크하세요.");
			}
		});

	</script>

</body>
</html>

<%@include file="../include/footer.jsp"%>

