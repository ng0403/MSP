<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>  
<script src="${ctx}/resources/common/js/common.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<%-- <%@include file="../include/header.jsp"%> --%>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />


<div class= main_div>

 <div class="navi_div">
게시판 관리 > 리스트
</div>

<!-- <div class= search_div>
<div class= search1_div>

</div>
</div> -->

<div class="list_div">
<div class="list1_div" id="list1_div">
   <form name="delAllForm" id ="delAllForm" method="post" action="/board/board_remove">  
	<table class="table table-hover">
	<thead>
						<tr>
							<th><input id="checkall" type="checkbox"/></th>
							<th>게시판관리번호</th>
							<th>게시판구분</th>
							<th>게시판이름</th>
							<th>생성일</th>
							<th>사용여부</th>
						</tr> 
	</thead>
 						<c:forEach items="${boardmnglist}" var="boardMngVO"> 
							<tr>
								<td scope="row"><input type="checkbox" id="del_code" name="del_code" value="${boardMngVO.BOARD_MNG_NO}"></td>
   								<td>${boardMngVO.BOARD_MNG_NO}</td>
   								<td>${boardMngVO.BOARD_MNG_CD}</td>
								<td><a href="/board_mng/board_mng_detail?BOARD_MNG_NO=${boardMngVO.BOARD_MNG_NO}">${boardMngVO.BOARD_NM}</a> </td>
 								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${boardMngVO.CREATED}" /> </td>
								<td><c:if test="${boardMngVO.ACTIVE_FLG eq 'Y'}">활성화</c:if>
									<c:if test="${boardMngVO.ACTIVE_FLG eq 'N'}">비활성화</c:if>
								
								</td>
							</tr> 
						</c:forEach>
						 
					</table>
					</form>
 
</div>
			
		<div class="paging_div">	
		 <div class="left">
		 <input type="button" id = "board_add_fbtn" class = "btn btn-primary btn-sm" value="추가"/> <input type="button" id ="board_remove_fbtn" class="btn btn-primary btn-sm" value="삭제"  onclick="deleteAction() "/>
 		
		</div>
		<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
		<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
		<input type="hidden" id="boardPageNum" value="${pageNum}"/>
		<c:choose>
			<c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
				<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="boardPageInput" value="${page.startPageNum}" onkeypress="boardpageNumEnter(event);" style="width: 2%;"/>  
				<a style="color: black; text-decoration: none;"> / 1</a>
				<a style="color: black; text-decoration: none;"> ▶ </a>
			</c:when>
			<c:when test="${pageNum == page.startPageNum}">
				<a style="color: black; text-decoration: none;"> ◀ </a><input type="text" id="pageInput" class="boardPageInput" value="${page.startPageNum}" onkeypress="boardpageNumEnter(event);" style="width: 2%;"/>  
				<a href="#" onclick="boardPaging('${page.endPageNum}');" id="pNum" > / ${page.endPageNum}</a>
				<a href="#" onclick="boardPaging('${pageNum+1}');" id="pNum"> ▶ </a>
			</c:when>
			<c:when test="${pageNum == page.endPageNum}">
				<a href="#" onclick="boardPaging('${pageNum-1}');" id="pNum"> ◀ </a>
				<input type="text" id="pageInput" class="boardPageInput" value="${page.endPageNum}" onkeypress="boardpageNumEnter(event);" style="width: 2%;"/> 
				<a href="#" onclick="boardPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
				<a style="color: black; text-decoration: none;"> ▶ </a>
			</c:when>
			<c:otherwise>
				<a href="#" onclick="boardPaging('${pageNum-1}');" id="pNum" > ◀ </a>
				<input type="text" id="pageInput" class="boardPageInput" value="${pageNum}" onkeypress="(event);" style="width: 2%;"/>  
				<a href="#" onclick="boardPaging('${page.endPageNum}');" id="pNum"> / ${page.endPageNum}</a>
				<a href="#" onclick="boardPaging('${pageNum+1}');" id="pNum"> ▶ </a>
			</c:otherwise>
		</c:choose>
		</div>
					
					


<div class = paging_div>

</div> 

</div>

<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/board/board_list" id="boardlistPagingForm" method="post">
				<input type="hidden" name="user_id_sch" value="${user_id_sch}"/>
				<input type="hidden" name="user_nm_sch" value="${user_nm_sch}"/>
				<input type="hidden" name="dept_cd_sch" value="${dept_cd_sch}"/>
			</form>

<script type="text/javascript">
 
 
$("#board_add_fbtn").on("click", function(){
	location.href="/board_mng/board_mng_add";
	
})
  

/* 삭제(체크박스된 것 전부) */
	function deleteAction() {
		var del_code = "";
		$("input[name='del_code']:checked").each(function() {
			del_code = del_code + $(this).val() + ",";
 		}); 
		


		if (del_code == '') {
			alert("삭제할 대상을 선택하세요.");
			return false;
		}
 
		if (confirm("정보를 삭제 하시겠습니까?")) {

 			$.ajax({
 				url : '/board_mng/board_mng_remove',
 				headers : {
 		            "Content-Type" : "application/json",
 		            "X-HTTP-Method-Override" : "POST"
 		         },
 				data : del_code,
 				dataType : 'text',
 				processData: false,
 				contentType: false,
 				type: 'POST',
 				success : function(result) {
 					
 					 					
 					if(result =="success")
						{
 					 
						ajaxList();
						}
					else{
						alert("오류!");
					}
 					 

 				} ,  error:function(request,status,error){
		             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		          } 
 				}) 
			
  		} 
 	}
 	
 	
 	
 	
function ajaxList() {
		
		$.ajax({
			url : '/board_mng/ajax_list',
			headers : {
	            "Content-Type" : "application/json",
	            "X-HTTP-Method-Override" : "POST"
	         },
			data : "",
			dataType : 'json',
			processData: false,
			contentType: false,
			type: 'POST',
			success : function(result) {
  				
				
				var ajaxList = result; 
			    var liststr = "";
				var liststr1 = "";
				var liststr2 = "";
				 
				
			 	var list = ajaxList.length;
				 
			 	liststr    += "<table  class='table table-hover' >" +
								"<tr>" +
							"<th>" +
								"<input id='checkall' type='checkbox'/>" +
							"<th>게시판관리번호</th>" +
							"<th>게시판구분</th>" +
							"<th>게시판이름</th>" +
							"<th>생성일</th>" +
							"<th>사용여부</th>" +
							"</tr>";
			 	
			for(var i=0 ; i<ajaxList.length; i++) {  
				 liststr1  +=    "<tr>" +
									"<td scope='row'><input type='checkbox' name='del_code' value=" + ajaxList[i].board_MNG_NO + "/>" +
									"<td>" + ajaxList[i].board_MNG_NO + "</td>" +
									"<td>" + ajaxList[i].board_MNG_CD + "</td>" +
									"<td><a href=\"/board_mng/board_mng_detail?BOARD_MNG_NO=" + ajaxList[i].board_MNG_NO + "\">" + ajaxList[i].board_NM + "\</a> </td>" +
									"<td>" + ajaxList[i].created + "</td>" + 
							 		"<td>" + ajaxList[i].active_FLG + "</td>" +  
									"</tr>";
							
			 	}
			
			liststr2 +=  "</table>";
				
				var boardtable = document.getElementById("list1_div");
				boardtable.innerHTML = liststr + liststr1 + liststr2; 
				 

			}  
			})
	}
   
 
	$("#checkall").on("click", function() {

		if ($("#checkall").prop("checked")) {

			$("input[name=del_code]").prop("checked", true);
		} else {
			$("input[name=del_code]").prop("checked", false);
		}

	}) 
	 
	
		
	//페이지 엔터키 기능
	function boardpageNumEnter(event) {
		$(document).ready(function() {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				var pageNum = parseInt($("#pageInput").val());
				if (pageNum == '') {
					alert("페이지 번호를 입력하세요.")
					$("#pageInput").focus();
				} else if(pageNum > parseInt($("#endPageNum").val())) {
					alert("페이지 번호가 너무 큽니다.");
					$("#pageInput").val($("#boardPageNum").val());
					$("#pageInput").focus();
				} else {
					boardPaging(pageNum);
				}
			}
			event.stopPropagation();
		});
	}
	
	
	
	//사용자관리 페이징
	function boardPaging(pageNum) {
 		$(document).ready(function() {
			var ctx = $("#ctx").val(); 
			
			var $form = $('#boardlistPagingForm');
		    
		    var pageNum_input = $('<input type="hidden" value="'+pageNum+'" name="pageNum">');

		    $form.append(pageNum_input);
		    $form.submit();
		});
	}
	//검색 엔터키
	function boardEnterSearch(event) {
		$(document).ready(function() {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				board_goSearch();
			}
		});
	}
	
	
 
	
	
</script>


</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>
