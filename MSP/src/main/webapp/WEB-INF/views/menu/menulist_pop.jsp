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

<title>메뉴관리화면</title>
<!-- <style type="text/css">
	.mask_div {
		display: none;
		position:absolute; 
		z-index:9000; 
		background-color:#000;  
		left:0; 
		top:0;
		width: 100%;
		height: 100%;
		overflow: auto;
	} 
	.pop_main_div{
		display: none;
		position:absolute; 
		width:40%; 
		height:55%; 
		left:40%; 
		top:15%; 
		z-index:10000; 
		background-color: #FFFFFF; 
		overflow: auto;
	}
	.block_div{display:block; 
		height: 10px; 
		clear: both;
	}
	#menuInpr_close_nfbtn{
		font-size:11px;
		margin-top:1%; 
		margin-right:1%; 
		float: right;
	}
</style> -->
<script type="text/javascript">	
	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#menuInqr_pop_fbtn").click(function(){
			menuListInqrPop(1);
		})
		/*검색창 엔터 시 처리 이벤트*/
		$("#menu_nm_key_pop").keypress(function(){
			enterSearchPop(event);
		})		
		//검은 막을 눌렀을 때
		$('#menuMask').click(function() {
			$(this).hide();
			$('#menuWindow').hide();
		});
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_menuList", function(){
			if(save_cd == "insert" || save_cd == "update"){
				var menu_cd = $(this).attr("data_num");
				var menu_nm = $(this).children("td").eq(0).html();
				$('#up_menu_cd').val(menu_cd);
				$('#up_menu_nm').val(menu_nm);
				$('.menu_list_pop, #paging_menuPop_div').html("");
				$('#menuMask, #menuWindow').hide();
			}
		})
		//닫기 버튼을 눌렀을 때
		$('#menuInpr_close_nfbtn').click(function(e) {
			$('.menu_list_pop, #paging_menuPop_div').html("");
			$('#menuMask, #menuWindow').hide();
		});
	})
	
	/*메뉴 리스트 출력및 페이징 처리 함수*/
	function menuListInqrPop(pageNum){
		var menu_nm_key = $("#menu_nm_key_pop").val();
		
		viewLoadingShow();
		$.post("/menu/search_list_pop",{"menu_nm_key":menu_nm_key, "pageNum":pageNum}, function(data){
			$(".menu_list_pop").html("");
			$(data.menu_list).each(function(){
 				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var up_menu_nm = this.up_menu_nm;
				menuListPopOutput(menu_cd, menu_nm, menu_url, up_menu_nm);
			})
			$("#paging_menuPop_div").html("");
			$(data).each(function(){
				var pageNum = this.pageNum;
				var totalCount = this.page.totalCount;
				var pageSize = this.page.pageSize;
				var pageBlockSize = this.page.pageBlockSize;
				var startRow = this.page.startRow;
				var endRow = this.page.endRow;
				var startPageNum = this.page.startPageNum;
				var endPageNum = this.page.endPageNum;
				var currentPageNum = this.page.currentPageNum;
				var totalPageCount = this.page.totalPageCount;
				menuPagePopOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount);
			})
		}).fail(function(){
			alert("메뉴 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
		viewLoadingHide();
	}
	/*메뉴 리스트 출력 함수*/
	function menuListPopOutput(menu_cd, menu_nm, menu_url, up_menu_nm){
		
		var menu_tr = $("<tr>");
		menu_tr.addClass("open_menuList");
		menu_tr.attr("data_num",menu_cd);
		
		var menu_nm_td = $("<td>");
		menu_nm_td.html(menu_nm);
		
		var up_menu_nm_td = $("<td>");
		up_menu_nm_td.html(up_menu_nm);
		
		var menu_url_td = $("<td>");
		menu_url_td.html(menu_url);
		
		menu_tr.append(menu_nm_td).append(up_menu_nm_td).append(menu_url_td);
		
		$(".menu_list_pop").append(menu_tr);
			
	}
	/*페이징 출력 함수*/
	function menuPagePopOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount){
		if(endPageNum == 1)
		{
			pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress='menuPageInputRepPop(event);'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
			+"<a style='color:black; text-decoration: none;'>▶</a>"
		}
		else if(startPageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"menuPageInputRepPop(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrtPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"menuPageInputRepPop(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"menuPageInputRepPop(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"menuPageInputRepPop(event);\"/>"
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=menuListInqrPop("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		$("#paging_menuPop_div").append(pageContent);

	}
	// 검색 페이징 엔터키
    function menuPageInputRepPop(event) {	
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
    				menuListInqrPop(pageNum);
    			}
    		}
    		event.stopPropagation();
    	});
    }
	
  	//검색 엔터키
    function menuEnterSearchPop(event) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		menuListInqrPop(1);
    	}
    	event.stopPropagation();
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
	
	//menuDetail image popup
	function popByMask(message1,message2) {
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$('#'+message1+'').css({
			'width' : maskWidth,
			'height' : maskHeight
		});

		//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
		$('#'+message1+'').fadeIn(1000);
		$('#'+message1+'').fadeTo("slow", 0.5);

		//윈도우 같은 거 띄운다.
		$('#'+message2+'').show();
	}
</script>
</head>
<body>
	<div id="menuMask" class="mask_div"></div>
	<div class="pop_main_div" id="menuWindow">
		<div class="navi_div">
			마스터 > 메뉴관리
			<div>
				<input type="button" id="menuInpr_close_nfbtn" class="func_btn" style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
			</div>
		</div>
		<div class="block_div"></div><div class="block_div"></div>
		<div class="search_div">
			<div class="modal_search_div">
				<!-- <form id="searchForm" name="searchForm"> -->
					<label>메뉴명</label>
					<input type="text" id="menu_nm_key_pop" name="menu_nm_key" class="int_search"> &nbsp;
					<input type="button" id="menuInqr_pop_fbtn" class="btn btn-default btn-sm" value="검색">
				<!-- </form> -->
			</div>
		</div>
		<div class="list_div">
			<div class="modal_list_div">
					<table summary="menu_list_tb" class="table table-hover">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="40%">
						</colgroup>
						<thead>
							<tr>
								<th>메뉴명</th>
								<th>상위메뉴명</th>
								<th>URL</th>
							</tr>
						</thead>
						<tbody class="menu_list_pop">
							
						</tbody>
					</table>
				<div class="modal_paging_div">
					<div class="page" id="paging_menuPop_div">	
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>