<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath }" />

<%--
    Class Name : user_auth_list.jsp
    Description : 사용자권한리스트,등록화면을 담당
    Modification Information
      수정일           수정자            수정내용
    ---------- ---------- -------------------------------
    2017.02.01 공재원           최초 생성
    author : 공재원
    since : 2017.02.01
--%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" type="text/css" />
<script type="text/javascript" src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<%-- <script type="text/javascript" src="${ctx}/resources/common/js/jquery-ui.js"></script> --%>
<script type="text/javascript" src="${ctx}/resources/common/js/standard/common.js"></script>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/jquery-ui.css"	type="text/css" /> --%>
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/header.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/menu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/subMenu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/content.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/common.css" type="text/css" />
<link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet">

<title>Insert title here</title>
<style type="text/css">
#inputDiv{margin-top: 10px;}
#titleSpan{ margin-left: 4%; font-size: 15px; font-weight: bold;}
#cusSpan{display:inline-block; width: 100px; text-align: right; }
#customerNo{width: 120px;}
#material_txt{width: 120px; }
#dbUpdateDate{float:left; width:100px; border: 0px; color: gray;}
#tableDiv{width:100%; margin:auto; overflow-x: scroll;}

#selectSpan{display:inline-block; width:110px; text-align: right;}
#btn_search{float:right; margin-right: 5px; margin-top: 5px;}
#excelDown{float: right; margin-right: 3%; margin-top: 5px;}

#inputDiv select{width: 100px;}
#inputDiv > label{display:inline-block; width: 95px; text-align: right;}
#noticeListTbody > td{height: 23px;}

#userAuthMask {position:absolute; z-index:9000; background-color:#000; display:none; left:0; top:0;} 
.userAuthWindow{display: none; position:absolute; width:60%; height:55%; left:20%; top:15%; z-index:10000; 
				background-color: white; overflow: auto;}	
.userAuthOpen{display: none;}	
	
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

.button-default {
    background-color: #81BEF7;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
}
</style>

<script type="text/javascript">

    //검색된 메뉴 리스트
    function fn_userAuthSearchList(pageNum){
	    	var user_id=$("#user_id").val();
	    	var user_nm=$("#user_nm").val();
	    	var auth_id=$("#auth_id").val();
	    	
	    	var tbody = $('#userAuthListTbody');
	    	var contents="";
	    	$.ajax({
	    		url : '/cp/userAuth/userAuthSearchList',
	    		type : 'POST',
	    		dataType :'json',
	    		data : {
	    			"user_id":user_id,"user_nm":user_nm,"auth_id":auth_id,"pageNum":pageNum},
	    		success : function(data){
	    			tbody.empty();
	    			var list_userAuth=data.list;
	    			if(list_userAuth.length!=0){
	    			for(var i=0;i<list_userAuth.length;i++){
	    				var user_id2=list_userAuth[i].user_id;
	    				var user_nm=list_userAuth[i].user_nm;
	    				var agg_auth_nm=list_userAuth[i].agg_auth_nm;
	    				var dept_nm=list_userAuth[i].dept_nm;
	    				if(dept_nm == null){
	    				    dept_nm = "";
	    				}
	    				var email=list_userAuth[i].email;
	    				if(email == null){
	    				    email = "";
	    				}
	    				var cphone=list_userAuth[i].cphone;
	    				if(cphone == null){
	    				    cphone = "";
	    				}
	    				var created_by_nm=list_userAuth[i].created_by_nm;
	    				var created=list_userAuth[i].created;
	    				var active_flg=list_userAuth[i].active_flg;
	    				
	    				contents += "<tr><td><input type='checkbox' id='chk' name='chk' value='"+user_id2+"'/></td>"
	    				+"<td class='promo_type_nm' style='text-align:left;'>"
	    				+"<input type='hidden' id='user_id2' value='"+user_id2+"'>"
	    				+"<a href='javascript:void(0)' onclick='userAuthPop1(\""+user_id2+"\")'>&nbsp;&nbsp;"+user_id2+"</a></td>"
	    				+"<td class='promo_type_nm' style='text-align:left;'>"
	    				+"<a href='javascript:void(0)' onclick='userAuthPop1(\""+user_id2+"\")'>&nbsp;&nbsp;"+user_nm+"</a></td>"
	    				
	    				+"<td style='text-align:left;'>&nbsp;&nbsp;"+agg_auth_nm+"</td>"
						+"<td style='text-align:left;'>&nbsp;&nbsp;"+dept_nm+"</td>"
						+"<td style='text-align:left;'>&nbsp;&nbsp;"+email+"</td>"
						+"<td style='text-align:left;'>&nbsp;&nbsp;"+cphone+"</td>"
						+"<td style='text-align:center;'>"+active_flg+"</td>"
						+"<td style='text-align:left;'>&nbsp;&nbsp;"+created_by_nm+"</td>"
						+"<td style='text-align:left;'>&nbsp;&nbsp;"+created+"</td>"
						+"</tr>";
						
	    			}
	    			}else{
	    				contents = "<tr><td style='height: 250px; background: white;' colspan='10'><b>"+"No Result Data.</b></td></tr>";
	    			}
	    			tbody.append(contents);
	    			
	    			var pageContent = "";
	    			// 페이징 다시그리기
	    			$("#userAuthPagingDiv").empty();
	    			
	    			if(data.page.endPageNum==1){
						pageContent = "<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repUserPageInput' value='"+data.page.startPageNum+"' onkeypress='pageInputRepUser(event);'/>"  
						+"<a style='color: black; text-decoration: none;'> / "+data.page.endPageNum+"</a>"
						+"<a style='color: black; text-decoration: none;''> ▶ </a>"
					}else if(data.page.startPageNum == data.page.endPageNum){
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repUserPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					}else if(data.pageNum == 1){
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repUserPageInput' value='"+data.page.startPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+(data.pageNum+1)+") id='pNum'> ▶ </a>";
					} else if(data.pageNum == data.page.endPageNum){
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repUserPageInput' value='"+data.page.endPageNum+"' onkeypress=\"pageInputRepUser(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					} else {
						pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+data.page.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+(data.pageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repUserPageInput' value='"+data.pageNum+"' onkeypress=\"pageInputRepUser(event);\"/>"
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+data.page.endPageNum+") id='pNum'> / "+data.page.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=fn_userAuthSearchList("+(data.pageNum+1)+") id='pNum'> ▶ </a>";
					}
	    			$("#userAuthPagingDiv").append(pageContent);
	    		},
	    		
	    		beforeSend: function(){
	        	viewLoadingShow();			
	        },
	        complete:function(){
	        	viewLoadingHide();
	    	},	
	    		error : function(request,status,error) {
	    	          alert("사용자페이징code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    	      }
	    	}); 
	    }
	    
    //메뉴 상세 팝업
    function fn_menuPop(){
	    	var user_id = $("#popMenuId1").val();
	    	
	    	var tbody_general = $('#generalTbody');
	    	
	    	var contents="";
	    	
	    	$.ajax({
	    		url : '/cp/userAuth/openUserAuthDetail',
	    		type : 'POST',
	    		dataType :'json',
	    		data : { "user_id":user_id },
	    		success : function(data){
	    			tbody_general.empty();
	    			
	    			var user_id = data.user_id;
	    			var user_nm = data.user_nm;
	    			var menu_url = data.menu_url;
	    			var p_user_id = data.p_user_id;
	    			var menu_level = data.menu_level;
	    			var default_flg = data.default_flg;
	    			var active_flg = data.active_flg;
	    			var c_user_id = data.c_user_id;
	    			var cdate = data.cdate;
	    			var u_user_id = data.u_user_id;
	    			var udate = data.udate;
	    			
	    			contents="<tr height='15px'>"+
							"<th style=' width: 12%; text-align: right;'><span style='color:red;'>*</span>메뉴ID&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type = 'text' id='user_id1' name='user_id1' value = '"+user_id+"' style='font-size:12px;width:80%;background-color:#F2F2F2;' readonly='readonly'>"+
							"</td>"+
							"<th style='width: 12%; text-align: right;'><span style='color:red;'>*</span>메뉴명&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type='text' id='user_nm1' name='user_nm1' value='"+user_nm+"' style='width: 80%;'/>"+
							"</td>"+
						"</tr>"+
						"<tr height='15px'></tr>"+

						"<tr height='15px'>"+
							"<th style='width: 12%; text-align: right;'>상위메뉴명&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type='text' id='p_user_id1' name='p_user_id1' value='"+p_user_id+"' style='width: 80%;'/>"+
							"</td>"+
							"<th style='width: 12%; text-align: right;'><span style='color:red;'>*</span>메뉴레벨&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type='text' id='menu_level1' name='menu_level1' value='"+menu_level+"' style='width: 80%;'/>"+
							"</td>"+
						"</tr>"+
						"<tr height='15px'></tr>"+
						"<tr height='15px'>"+
							"<th style='width: 12%; text-align: right;'><span style='color:red;'>*</span>메뉴 URL&nbsp;&nbsp;</th>"+
							"<td colspan='3' style='width: 88%; text-align: left;'>"+
								"<input type='text' id='menu_url1' name='menu_url1' value='"+menu_url+"' style='width: 90%;'/>"+
							"</td>"+
						"</tr>"+
						"<tr height='15px'></tr>"+
						"<tr height='15px'>"+
							"<th style='width:12%; text-align: right;'><span style='color:red;'>*</span>디폴트여부&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
							    "<select id='default_flg1' name='default_flg1' style='width: 30%;'>"+
							        "<option value='"+default_flg+"'>"+default_flg+"</option>"+
							        "<option value=''>"+"-----"+"</option>"+
							        "<option value='Y'>"+"Y"+"</option>"+
							        "<option value='N'>"+"N"+"</option>"+
							    "</select>"+
							"</td>"+
							"<th style='width: 12%; text-align: right;'><span style='color:red;'>*</span>상태&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<select id='active_flg1' name='active_flg1' style='width: 30%;'>"+
							        "<option value='"+active_flg+"'>"+active_flg+"</option>"+
							        "<option value=''>"+"-----"+"</option>"+
							        "<option value='Y'>"+"Y"+"</option>"+
							        "<option value='N'>"+"N"+"</option>"+
							    "</select>"+
							"</td>"+
						"</tr>"+
						"<tr height='15px'></tr>"+
						"<tr height='15px'>"+
							"<th style='width: 12%; text-align: right;'><span style='color:red;'>*</span>최초등록자&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type='text' value='"+c_user_id+"' id='c_user_id1' name='c_user_id1' style='width: 80%;background-color:#F2F2F2;' readonly='readonly' />"+
							"</td>"+
							"<th style='width: 12%; text-align: right;'><span style='color:red;'>*</span>최초등록일시&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type='text' value='"+cdate+"' id='cdate1' name='cdate1' style='width: 80%;background-color:#F2F2F2;' readonly='readonly' />"+
							"</td>"+
						"</tr>"+
						"<tr height='15px'></tr>"+
						"<tr height='15px'>"+
							"<th style='width: 12%; text-align: right;'>최종등록자&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type='text' value='"+u_user_id+"' id='u_user_id1' name='u_user_id1' style='width: 80%;background-color:#F2F2F2;' readonly='readonly' />"+
							"</td>"+
							"<th style='width: 12%; text-align: right;'>최종변경일시&nbsp;&nbsp;</th>"+
							"<td style='width: 38%; text-align: left;'>"+
								"<input type='text' value='"+udate+"' id='udate1' name='udate1' style='width: 80%;background-color:#F2F2F2;' readonly='readonly' />"+
							"</td>"+
						"</tr>"+
						"<tr height='15px'></tr>"+
						"<tr>"+
							"<td align='right' colspan='4'>"+ 
								"<input type='button' class='btn btn-default' id='update' value='저장' style='font-size:11.5px;float:right;margin-right:1%;margin-top:1%;' onclick='fn_checkRequired1();'/>"+
							"</tr>"+
						"<tr height='5px'></tr>";
						
						tbody_general.append(contents);
	    		},
	    		beforeSend: function(){
	        	viewLoadingShow();			
	        },
	        complete:function(){
	        	viewLoadingHide();
	    	},	
	    	error : function(request,status,error) {
	    	    alert("사용자페이징code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    	}
	    }); 
	}
    
    //검색 엔터키
    function enterSearch(event) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		fn_userAuthSearchList(1);
    	}
    	event.stopPropagation();
    }

    // 검색 페이징 엔터키
    function pageInputRepUser(event) {	
    	$(document).ready(function() {
    		var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
    			var pageNum = parseInt($("#pageInput").val());
    			if ($("#pageInput").val() == '') {
    				alert("Input page number.")
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else if(pageNum > parseInt($("#endPageNum").val())) {
    				alert("The page number is too large.");
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else if (1 > pageNum) {
    				alert("The page number is too small.");
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else {
    				fn_userAuthSearchList(pageNum);
    			}
    		}
    		event.stopPropagation();
    	});
    }
    
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
	
	//메뉴 팝업 호출
	function userAuthPop1(user_id2){		
		
		$("#popMenuId1").val(user_id2);
					
		fn_menuPop();
		
		$('.userAuthOpen').click();
		
	}
	
    //userAuthDetail image popup
	function userAuthByMask() {
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$('#userAuthMask').css({
			'width' : maskWidth,
			'height' : maskHeight
		});

		//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
		$('#userAuthMask').fadeIn(1000);
		$('#userAuthMask').fadeTo("slow", 0.5);

		//윈도우 같은 거 띄운다.
		$('.userAuthWindow').show();
	}

	$(document).ready(function() {
		//검은 막 띄우기
		$('.userAuthOpen').click(function(e) {
			e.preventDefault();
			userAuthByMask();
		});

		//닫기 버튼을 눌렀을 때
		$('.userAuthWindow #menuClose').click(function(e) {
			//링크 기본동작은 작동하지 않도록 한다.
			e.preventDefault();
			$('#generalTbody').empty();
			$('#userAuthMask, .userAuthWindow').hide();
		});

		//검은 막을 눌렀을 때
		$('#userAuthMask').click(function() {
			$(this).hide();
			$('.userAuthWindow').hide();
		});
	});	

$(document).ready(function(){	
	var user_id5 = '${user_id5}';
	//alert(user_id5);
	$('#user_id3').val(user_id5);
});

</script>
</head>
<body>
	<input type="hidden" id="ctx" value="${ctx}">
	<input type="hidden" id="userNo" value="${userNo}">
	<input type="hidden" id="popMenuId1">
    <div style="margin-left:1%;"><h3>권한관리>사용자권한 리스트</h3></div>
    
	<div id="container" style="margin-top:1%;">
	    <!-- 사용자권한 리스트,조회화면 -->
	    <form name="frm_userAuth" id="frm_userAuth" action="/cp/userAuth/deleteUserAuth"	enctype="multipart/form-data"  method="post">
		<div id="inputDiv" style="font-size:11.8px;width:100%;font-family:Helvetica, sans-serif;">
				<label for="user_id">사용자 ID :</label>
					<input type="text" id="user_id" name="user_id" style="width: 80px" />&nbsp;
				<label for="user_nm">사용자명 :</label>
					<input type="text" id="user_nm" name="user_nm" style="width: 100px" />&nbsp;
				<label for="auth_id">권한명 :</label>
					<select id="auth_id" name="auth_id" style="width:80px;font-size:10px;">
					    <option value=""> -- 권한 -- </option>
						<c:forEach var="authList" items="${authList}" varStatus="i">
							<option value="${authList.auth_id}">${authList.auth_nm}</option>
						</c:forEach>
					</select>
				
					<c:if test="${fn:length(list) != 0 }">
					    <input type="button" id="deleteUserAuth" class="button-default" value="삭제" onclick="fn_delete();" style="font-size:11px; background-color:#81BEF7;float:right;" />
					</c:if>
					<input type="button" class="button-default" value="사용자권한 등록" data-target="#userAuthWriteLayer" data-toggle="modal" 
						id="userAuthWritePop" style="font-size:11px; background-color:#81BEF7;font-color:white;float:right;margin-right:1%"/> 
					<input type="button" class="button-default" onclick="fn_userAuthSearchList(1);" value="조회" style="font-size:11px;float:right;margin-right:1%;
					    background-color:#81BEF7;font-color:white;"/>&nbsp;
		</div><div class="block_div"></div>

		<div id="tableDiv" style="font-size:11.8px;font-family:Helvetica, sans-serif;">
			<table class="commonTable" id="userAuthListTable"	style="width: 100%;word-break:break-all; white-space:nowrap;">
				<thead>
					<tr>
					    <th style="width: 3%; text-align:center;"><input type="checkbox" id="checkAll"/></th>
						<th style="width: 10%; text-align: center;">사용자ID</th>
						<th style="width: 12%; text-align: center;">사용자명</th>
						<th style="width: *; text-align: center;">권한명</th>
						<th style="width: 10%; text-align: center;">부서명</th>
						<th style="width: 15%; text-align: center;">이메일</th>
						<th style="width: 10%; text-align: center;">연락처</th>
						<th style="width: 5%; text-align: center;">활성화여부</th>
						<th style="width: 10%; text-align: center;">작성자</th>
						<th style="width: 10%; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody id="userAuthListTbody">
					<c:if test="${fn:length(list) != 0 }">
						<c:forEach items="${list}" var="list">
							<tr>
							    <td><input type="checkbox" id="chk" name="chk" value="${list.user_id}"/></td>
								<td class="promo_type_nm" style="text-align:left;">
									<input type="hidden" id="user_id2" name="user_id2"	value="${list.user_id}">
								    <a href='javascript:void(0)' onclick="userAuthPop1('${list.user_id}')">&nbsp;&nbsp;${list.user_id}</a>
								</td>
								<td class="promo_type_nm" style="text-align:left;">
								    <a href='javascript:void(0)' onclick="userAuthPop1('${list.user_id}')">&nbsp;&nbsp;${list.user_nm}</a>
								</td>
								<td style="text-align:left;">&nbsp;&nbsp;${list.agg_auth_nm}</td>
								
								<td style="text-align:left;">
								    &nbsp;&nbsp;${list.dept_nm}
								</td>
								<td style="text-align:left;">&nbsp;&nbsp;${list.email}</td>
								
								<td style="text-align:left;">&nbsp;&nbsp;${list.cphone }</td>
								<td style="text-align:center;">&nbsp;&nbsp;${list.active_flg }</td>
								<td style="text-align:left;">&nbsp;&nbsp;${list.created_by_nm }</td>
								<td style="text-align:left;">&nbsp;&nbsp;${list.created }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(list) == 0 }">
						<tr>
							<td style="height: 250px; background: white;" colspan="10"><b>No Result Data.</b></td>
						</tr>
					</c:if>
				</tbody>
				<tfoot style="text-align: right">
					<tr style="height: 10px"></tr>
				</tfoot>
			</table>
		</div>
		
		<div  id="userAuthPagingDiv" align="center" style="margin-top: 10px;">
		<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
		<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
		<input type="hidden" id="PageNum" value="${pageNum}"/>
		<c:choose>
			<c:when test="${page.endPageNum == 1}">
				<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageNumInputEnter(event, '/userAuth/view');" style='width: 50px; padding: 3px; '/>  
				<a style="color: black;"> / ${page.endPageNum}</a>
				<a style="color: black;"> ▶ </a>
			</c:when>
			<c:when test="${pageNum == page.startPageNum}">
				◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageNumInputEnter(event, '/userAuth/view');" style='width: 50px; padding: 3px; '/> /&nbsp;
				<a href="#" onclick="fn_userAuthSearchList('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
				<a href="#" onclick="fn_userAuthSearchList('${pageNum+1}');" id="pNum"> ▶ </a>
			</c:when>
			<c:when test="${pageNum == page.endPageNum}">
				<a href="#" onclick="fn_userAuthSearchList('${pageNum-1}');" id="pNum"> ◀ </a>
				<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageNumInputEnter(event, '/userAuth/view');" style='width: 50px; padding: 3px; '/> /&nbsp;
				<a href="#" onclick="fn_userAuthSearchList('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
			</c:when>
			<c:otherwise>
				<a href="#" onclick="fn_userAuthSearchList('${pageNum-1}');" id="pNum" > ◀ </a>
				<input type="text" id="pageInput" value="${pageNum}" onkeypress="pageNumInputEnter(event, '/userAuth/view');" style='width: 50px; padding: 3px; '/> /&nbsp;
				<a href="#" onclick="fn_userAuthSearchList('${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
				<a href="#" onclick="fn_userAuthSearchList('${pageNum+1}');" id="pNum"> ▶ </a>
			</c:otherwise>
		</c:choose>
	    </div> 
	    </form>
	    <!--  //사용자권한 리스트,조회화면 -->
	    
	<!-- 사용자권한 상세정보 창 띄우기(취소 - 부트스트랩을 mask모달로 변경) -->
	<div id="userAuthDetail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="userAuthDetail-tab" aria-hidden="true" data-backdrop="static" data-keyboard="true" >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
            </div>
        </div>
    </div>
    <!-- //사용자권한 상세정보 창 띄우기 -->
	<br />
	<div id="viewLoadingImg" style="display: none;">
         <img src="${ctx}/resources/image/viewLoading.gif">
    </div> 
    
    <!--  메뉴 등록 창띄우기 -->
    <div class="modal fade" id="userAuthWriteLayer" style="display: none;">
		<div class="modal-dialog modal-lg">   <!-- modal-lg -->
			<div class="modal-content">
			    <span style="float:left;margin-left:1%;margin-top:1%; font-size:15px;">
		            <strong>사용자권한 등록</strong></span>
		        
		        <form name="frm_promo1" id="frm_promo1" action="/cp/userAuth/createUserAuth"	enctype="multipart/form-data" method="post">
		        <input type="button" class="btn btn-default" data-dismiss="modal" value="닫기" style="font-size:11.5px;float:right;margin-right:1%;margin-top:1%;"/>
		        <input type="button" class="btn btn-default" id="write" value="저장" style="font-size:11.5px;float:right;margin-right:1%;margin-top:1%;" onclick="fn_checkRequired();"/><!-- submit으로 보내는 것이 post,  value값 직접 전달이get -->
		        
	            <div class="block_div"></div><div class="block_div"></div><div class="block_div"></div>
				
					<div align="center" style="width: 100%">
					<table class="board_view" style="font-size:12px;width: 100%">
						<tr height="15px">
							<th style=" width: 12%; text-align: right;"><span style="color:red;">*</span>메뉴ID&nbsp;&nbsp;</th>
							<td style="width: 38%; text-align: left;">
								<input type = "text" id="user_id3" name ="user_id3" style="width:80%; background-color:#F2F2F2;" value = "${user_id5}" readonly="readonly"/>
							</td>
							<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>메뉴명&nbsp;&nbsp;</th>
							<td style="width: 38%; text-align: left;">
								<input type="text" id="user_nm3" name="user_nm3" style="width: 80%;"	/>
							</td>
						</tr>
						<tr height="15px"></tr>

						<tr height="15px">
							<th style="width: 12%; text-align: right;">상위메뉴명&nbsp;&nbsp;</th>
							<td style="width: 38%; text-align: left;">
								<input class="text" type="text" id="p_user_id3" name="p_user_id3" style="width: 80%;"	/>
							</td>
							<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>메뉴레벨&nbsp;&nbsp;</th>
							<td style="width: 38%; text-align: left;">
								<input class="text" type="text" id="menu_level3" name="menu_level3" style="width: 80%;"	/>
							</td>
						</tr>
						<tr height="15px"></tr>
						<tr height="15px">
							<th style="width: 12%; text-align: right;">메뉴 URL&nbsp;&nbsp;</th>
							<td colspan="3" style="width: 88%; text-align: left;">
								<input type="text" id="menu_url3" name="menu_url3" style="width: 90%;"/>
							</td>
						</tr>
						<tr height="15px"></tr>
						<tr height="15px">
							<th style="width:12%; text-align: right;"><span style="color:red;">*</span>디폴트여부&nbsp;&nbsp;</th>
							<td style="width: 38%; text-align: left;">
								<select id="default_flg3" name="default_flg3" style="width: 30%;font-size:10.5px;">
								    <option value="">선택</option>
								    <option value="Y">Y</option>
								    <option value="N">N</option>
								</select>
							</td>
							<th style="width: 12%; text-align: right;"><span style="color:red;">*</span>상태&nbsp;&nbsp;</th>
							<td style="width: 38%; text-align: left;">
								<select id="active_flg3" name="active_flg3" style="width: 30%;font-size:10.5px;">
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
	</div>
    <!-- //메뉴 등록 창띄우기 -->
</div>
    
    <!-- menu detail 팝업 -->
	<div style="font-size:11.5px;">
	    <jsp:include page="../userAuth/user_auth_popup.jsp"></jsp:include>
	</div>
	<!-- //menu detail 팝업 -->

	<script type="text/javascript">
	/* 사용자권한 등록 시 필수 값 입력 확인 */
	function fn_checkRequired(){
		var user_id1=$('#user_id3').val();
		var user_nm1=$('#user_nm3').val();
		var p_user_id1=$('#p_user_id3').val();
		var menu_level1=$('#menu_level3').val();
		var menu_url1=$('#menu_url3').val();
		var default_flg1=$('#default_flg3').val();
		var active_flg1=$('#active_flg3').val();
		if(user_id1==null || user_id1=="" ||user_nm1==null ||user_nm1==""
		||menu_level1==null ||menu_level1==""
		||menu_url1==null ||menu_url1==""||default_flg1==null ||default_flg1==""
		||active_flg1==null ||active_flg1==""){
			alert("필수 값을 모두 입력해주세요.");
			return;
		}else{
		    $('form#frm_promo1')[0].submit();
		}
	}
	/* //메뉴 등록 시 필수 값 입력 확인 */
	
	/* 메뉴 수정 시 필수 값 입력 확인 */
	function fn_checkRequired1(){
	    var user_id1=$('#user_id1').val();
		var user_nm1=$('#user_nm1').val();
		var p_user_id1=$('#p_user_id1').val();
		var menu_level1=$('#menu_level1').val();
		var menu_url1=$('#menu_url1').val();
		var default_flg1=$('#default_flg1').val();
		var active_flg1=$('#active_flg1').val();
		if(user_id1==null || user_id1=="" ||user_nm1==null ||user_nm1==""
		||menu_level1==null ||menu_level1==""
		||menu_url1==null ||menu_url1==""||default_flg1==null ||default_flg1==""
		||active_flg1==null ||active_flg1==""){
			alert("필수 값을 모두 입력해주세요.");
			return;
		}else{
		    $('form#frm_promo')[0].submit();
		}
	}
	/* //메뉴 수정 시 필수 값 입력 확인 */
	
	/* 체크박스 전체선택 */
	$(document).ready(function(){
	    //최상단 체크박스 클릭
	    $("#checkAll").click(function(){
	        //클릭되었으면
	        if($("#checkAll").prop("checked")){
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
	            $("input[name=chk]").prop("checked",true);
	            //클릭이 안되있으면
	        }else{
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
	            $("input[name=chk]").prop("checked",false);
	        }
	    });
	});
	/* //체크박스 전체선택 */
	
	var selected = new Array();
	/* 메뉴 삭제 */
	function fn_delete(){
	    $("input:checkbox[name=chk]:checked").each(function() {
            selected.push($(this).val());
        });
	    
	    if(selected.length ==0){
	        alert("삭제할 데이터를 선택하세요.");
	        return;
	    }else{
	        $('form#frm_userAuth')[0].submit();
	    }
	}
	/* //메뉴 삭제 */
	
	</script>
</body>
</html>