<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="${ctx}/resources/common/js/common.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />
<!--  -->

<title>MenuAuth List</title>

<style type="text/css">
#menuAuthMask {position:absolute; z-index:9000; background-color:#000; display:none; left:0; top:0;}
#menuAuthInsertMask {position:absolute; z-index:9000; background-color:#000; display:none; left:0; top:0;}

.menuAuthWindow {display: none; position:absolute; width:50%; height:50%; left:30%; top:30%; z-index:10000;
				background-color: white; overflow: auto;}	
.menuAuthInsertWindow {display: none; position:absolute; width:50%; height:50%; left:30%; top:30%; z-index:10000;
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

.page2 {
	width: 15%;
	text-align: center;
	float: inherit;
	margin-left: 35%;
	
}

</style>

<script type="text/javascript">
var save_cd;

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

function menuAuthInsertByMask() {
	//화면의 높이와 너비를 구한다.
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	
	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	$("#menuAuthInsertMask").css({
		'width' : maskWidth,
		'height' : maskHeight
	});
	
	//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
	$('#menuAuthInsertMask').fadeIn(1000);
	$('#menuAuthInsertMask').fadeTo("slow", 0.5);

	//윈도우 같은 거 띄운다.
	$('.menuAuthInsertWindow').show();
}

$(document).ready(function() {
	$("#auth_id_pop").on("click", function(){
		authListInqrPop(1);
		popByMask("authMask", "authWindow");
	});
	
	// 등록할 때 메뉴검색 팝업 눌렀을 때
	$("#menu_cd_pop").on("click", function(){
		menuListInqrPop(1);
		popByMask("menuMask", "menuWindow");
	});
	
	// 추가할 때 메뉴선택 팝업클릭 시
	$("#menuAuth_add_btn").on("click", function(){
		save_cd = "insert";
		menuAuthInsertByMask();
	});
	
	//검은 막 띄우기
	$('.menuOpen').click(function(e) {
		e.preventDefault();
		menuAuthByMask();
	});
	
	// 상세보기 수정버튼 클릭 시
	$(".menuAuthWindow #menuAuthMdfy_btn").click(function(e){
		//menuAuthMdfy();
		$("#menuAuthMdfyForm").submit();
	});

	// 상세보기 닫기 버튼을 눌렀을 때
	$('.menuAuthWindow #menuAuthClose').click(function(e) {
		//링크 기본동작은 작동하지 않도록 한다.	
		$("#generalTbody").empty();
		$("#menuAuthMask, .menuAuthWindow").hide();
	});

	// 등록 닫기 버튼을 눌렀을 때
	$('.menuAuthInsertWindow #menuClose').click(function(e) {
		//링크 기본동작은 작동하지 않도록 한다.	
		$("#menuAuthInsertMask, .menuAuthInsertWindow").hide();
	});
	
	// 등록 팝업 취소버튼 클릭 시
	$("#menuAuthClose").click(function(){
		$("#up_menu_nm").val("");
		$("#up_menu_cd").val("");
		$("#auth_id").val("");
		$("#auth_nm").val("");
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
<%-- <%@include file="../include/header.jsp"%> --%>

	<!--Main_Div  -->
	<div class="main_div">
		<!-- Navigation Div -->
		<div class="navi_div">■ 메뉴권한관리</div>

		<!-- Search Cover Div -->
		<div class="search_div">
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
						    	<input type="button" id="search_fbtn" class="btn btn-default btn-sm" onclick="fn_search(1)" value="검색">
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
			
		<!-- List Cover Div -->
		<div class="list_div">
			<div class="list_div1">
				<div class="table_div">
				<form name="delAllForm" id="delAllForm" method="post" action="menuAuthDel">
					<table class="table table-hover">
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
								<tr class="open_detail" data_num="${menuAuthInqrList.MENU_CD}">
									<td align="center" scope="row">
										<input type="checkbox" name="del_menuAuth" id="del_menuAuth" value="${menuAuthInqrList.MENU_CD}:${menuAuthInqrList.AUTH_ID}" />
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
				</div>
				<!-- class="list1_div" -->	
			</div>
			
			<!-- Button Div -->
			<div class="paging_div">
				<div class="left">
					<input type="button" id="menuAuth_add_btn" class="btn btn-primary btn-sm" data-target="#menuAuthAddLayer" data-toggle="modal" value="추가"/> 
					<input type="button" id="menuAuth_del_btn" class="btn btn-primary btn-sm" value="삭제" />
				</div>
				
				<!-- Pagine Div -->
				<div id="menuAuthPagingDiv" class="page2">
					<input type="hidden" id="endPageNum" value="${page.endPageNum}" />
					<input type="hidden" id="startPageNum" value="${page.startPageNum}" />
					<input type="hidden" id="userPageNum" value="${pageNum}" />
					
					<c:choose>
						<c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
							<a style="color: black; text-decoration: none;">◀ </a>
							<input type="text" id="pageInput" class="userPageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, fn_search);" style="width: 15%;" />
							<a style="color: black; text-decoration: none;">/ 1</a>
							<a style="color: black; text-decoration: none;">▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							<a style="color: black; text-decoration: none;">◀ </a>
							<input type="text" id="pageInput" class="userPageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, fn_search);" style="width: 15%;" />
							<a href="#" onclick="fn_search('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
							<a href="#" onclick="fn_search('${pageNum+1}');" id="pNum">▶</a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="fn_search('${pageNum-1}');" id="pNum">◀</a>
							<input type="text" id="pageInput" class="userPageInput" value="${page.endPageNum}" onkeypress="pageInputRep(event, fn_search);" style="width: 15%;" />
							<a href="#" onclick="fn_search('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
							<a style="color: black; text-decoration: none;">▶</a>
						</c:when>
						<c:otherwise>
							<a href="#" onclick="fn_search('${pageNum-1}');" id="pNum">◀</a>
							<input type="text" id="pageInput" class="userPageInput" value="${pageNum}" onkeypress="pageInputRep(event, fn_search);;" style="width: 15%;" />
							<a href="#" onclick="fn_search('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
							<a href="#" onclick="fn_search('${pageNum+1}');" id="pNum">▶</a>
						</c:otherwise>
					</c:choose>
				<!-- class="page1" -->
				</div>
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
		
		 <!-- menuAuth 팝업 -->
		<div style="font-size:11.5px;">
	    	<jsp:include page="../menuAuth/menuAuth_pop.jsp"></jsp:include>
		</div>
		<!-- //menu detail 팝업 -->
		
		<jsp:include page="../menuAuth/menuAuth_insert.jsp"></jsp:include>
		
	<!-- class="main_div" -->
	</div>
	
	<script type="text/javascript">
		
		$("#navisub11").show();
		$("#naviuser").css("font-weight", "bold");
		
		$("#auth_id_sch").keypress(function(){
			enterSearch(event, fn_search);
		});
		
		$("#menu_nm_sch").keypress(function(){
			enterSearch(event, fn_search);
		});
		
		//페이지 엔터시 이벤트
		$(document).on("keypress","#pageInput",function(){
			var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
				pageInputRep(event, fn_search);
    		}
		});
		
		
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
							var auth_id   = menuAuthInqrList[i].AUTH_ID;
							var auth_nm   = menuAuthInqrList[i].AUTH_NM;
							var inqr_auth = menuAuthInqrList[i].INQR_AUTH;
							var add_auth = menuAuthInqrList[i].ADD_AUTH;
							var mdfy_auth = menuAuthInqrList[i].MDFY_AUTH;
							var del_auth = menuAuthInqrList[i].DEL_AUTH;
							var menu_acc_auth = menuAuthInqrList[i].MENU_ACC_AUTH;
							
							contents += "<tr class='open_detail' data_num='"+menu_cd+"' onmouseover='this.style.background='#c0c4cb' onmouseout='this.style.background='white''>"
							+"<td align='center' scope='row'>"
							+"<input type='checkbox' name='del_menuAuth' id='del_menuAuth' value='"+menu_cd+":"+auth_id+"'></td>"
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
					
					paging(data, "#menuAuthPagingDiv", "fn_search");
					
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
						var auth_id = menuAuthDetail[i].auth_id;
						var auth_nm = menuAuthDetail[i].auth_nm;
						var menu_cd = menuAuthDetail[i].menu_cd;
						var menu_nm = menuAuthDetail[i].menu_nm;
						var up_menu_cd = menuAuthDetail[i].up_menu_cd;
	 					var up_menu_nm = menuAuthDetail[i].up_menu_nm;
	 					var menu_url   = menuAuthDetail[i].menu_url;
	 					var active_flg = menuAuthDetail[i].active_flg;
	 					var inqr_auth  = menuAuthDetail[i].inqr_auth;
						var add_auth   = menuAuthDetail[i].add_auth;
						var mdfy_auth  = menuAuthDetail[i].mdfy_auth;
	 					var del_auth   = menuAuthDetail[i].del_auth;
	 					var menu_acc_auth = menuAuthDetail[i].menu_acc_auth;
	 					
	 					if(up_menu_cd == null)
	 					{
	 						up_menu_cd = "없음";
	 					}
	 					if(up_menu_nm == null)
	 					{
	 						up_menu_nm = "없음";
	 					}
	 					if(menu_url == null)
	 					{
	 						menu_url = "없음";
	 					}
	 					
	 					contents1 ="<tr height='15px'>"+
	 					"<th style=' width: 12%; text-align: center;'>권한ID&nbsp;&nbsp;</th>"+
	 					"<td style='width: 38%; text-align: left;'>"+
						"<input type = 'text' id='auth_id1' name='auth_nm' value='"+auth_nm+"' style='font-size:12px;width:80%;background-color:#F2F2F2;' readonly='readonly'>"+
						"<input type = 'hidden' id='auth_id2' name='auth_id2' value='"+auth_id+"'>"+
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
							+"<input type='radio' name='active_flg1' id='active1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='active_flg1' id='active2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td>";
						active_radio2 = "<tr><th style='width: 12%; text-align: center;'>활성화 상태&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='active_flg1' id='active1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='active_flg1' id='active2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td>";
							
						inqr_radio1 = "<th style='width: 12%; text-align: center;'>조회권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='inqr_auth1' id='inqr_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='inqr_auth1' id='inqr_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='true false;'/>N"
							+"</td></tr>";
						inqr_radio2 = "<th style='width: 12%; text-align: center;'>조회권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='inqr_auth1' id='inqr_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='inqr_auth1' id='inqr_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td></tr>";
							
						add_radio1 = "<tr><th style='width: 12%; text-align: center;'>생성권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='add_auth1' id='add_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='add_auth1' id='add_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td>";
						add_radio2 = "<tr><th style='width: 12%; text-align: center;'>생성권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='add_auth1' id='add_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='add_auth1' id='add_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td>";
							
						mdfy_radio1 = "<th style='width: 12%; text-align: center;'>수정권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='mdfy_auth1' id='mdfy_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='mdfy_auth1' id='mdfy_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td></tr>";
						mdfy_radio2 = "<th style='width: 12%; text-align: center;'>수정권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='mdfy_auth1' id='mdfy_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='mdfy_auth1' id='mdfy_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td></tr>";
							
						del_radio1 = "<tr><th style='width: 12%; text-align: center;'>삭제권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='del_auth1' id='del_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='del_auth1' id='del_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td>";
						del_radio2 = "<tr><th style='width: 12%; text-align: center;'>삭제권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='del_auth1' id='del_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='del_auth1' id='del_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td>";
						
						menu_acc_radio1 = "<th style='width: 12%; text-align: center;'>메뉴접근권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td></tr>";
						menu_acc_radio2 = "<th style='width: 12%; text-align: center;'>메뉴접근권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
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
		
		// 상세보기 수정버튼
		function menuAuthMdfy()
		{
			alert("수정버튼");
		}
		
		// 추가버튼 눌렀을 때
		$("#menuAuth_save_btn").on("click", function(){
			$("#menuAuthAdd").submit();
		});
		
		// 삭제 버튼 눌렀을 때
		$("#menuAuth_del_btn").on("click", function(){
			
			if(confirm("선택한 메뉴권한을 삭제 하시겠습니까?")) {
				var check = document.getElementsByName("del_menuAuth");
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
					alert("체크박스를 체크하세요.");
				}
			}
			else {
				return false;
			}

		});
	

	</script>

</body>
</html>

<%-- <%@include file="../include/footer.jsp"%> --%>

