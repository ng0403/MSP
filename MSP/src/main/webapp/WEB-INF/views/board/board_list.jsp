<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
 <c:set var="SessionID" value="${sessionScope.user_id}" />
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/common.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/BoardCSS/boardCSS.css" type="text/css" />
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>

</head>
<body> 
 
<div class="main_div">
	<div class="navi_div">
 		게시판 > 리스트
	</div>

	<!-- Q&A 리스트, 조회화면 -->
	<div class="search_div">
		<div class="search2_div">
	    	<form name="frm_QnA" id="frm_QnA" action="/board/search_QnA"	enctype="multipart/form-data"  method="post">
	
				<label >제  목</label>
				<input type="text" id="keyword" name="keyword" class="inputTxt" > &nbsp; 
	
			 	<input type="button" id="dept_inqr_fbtn" onclick="boardListInqr(1);" value="검색" id="board_inqr_fbtn" class="btn btn-default btn-sm" value="검색">
		 </form>  
		</div>
	</div>

	<div class="list_div">
		<div class="list1_div" id ="list1_div">  
 			<form name="delAllForm" id ="delAllForm" method="post" action="/board/board_remove">  
				<div class="table_div">
					<table  class="table table-hover" >
						<thead>
							<tr>
								<th><input id="checkall" type="checkbox"/></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
								
							</tr>
							
						 </thead>  
				 					 
						<tbody class="board_list">
							<c:forEach items="${boardlist}" var="boardVO"> 
					
								<tr class="open_list">
									<td scope="row"><input type="checkbox" id="del_code" name="del_code" value="${boardVO.BOARD_NO}"></td>
			 						<td>${boardVO.BOARD_NO}</td>
									<%-- <td><a href="/board/boardDetail?BOARD_NO=${boardVO.BOARD_NO}">${boardVO.TITLE}</a> </td> --%>
									<td><a href="#" onclick="boardDetail('${boardVO.BOARD_NO}');" id="${boardVO.BOARD_NO}">${boardVO.TITLE}</td>
									<td>${boardVO.CREATED_BY} </td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.CREATED}" /></td>
									<td>${boardVO.VIEW_CNT}</td>
								</tr> 
							</c:forEach>
						</tbody>
					</table>
				</div>
		 </form>
 	</div>	
 
	<div class="paging_div">
	
	 	<div class="left">
		   <input type="button" id = "board_add_fbtn"  class = "btn btn-primary btn-sm" value="추가"/> 
 		    <input type="button" id ="board_remove_fbtn" class="btn btn-primary btn-sm" value="삭제"  onclick="deleteAction() "/>
		</div> 
		
		<div class="page" id="paging_div">	
					<input type="hidden" id="endPageNum" value="${page.endPageNum}"/>
					<input type="hidden" id="startPageNum" value="${page.startPageNum}"/>
					<input type="hidden" id="PageNum" value="${pageNum}"/>
					<c:choose>
						<c:when test="${page.endPageNum == 1}">
							<a style="color: black;"> ◀ </a><input type="text" id="pageInput" class="monPageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/>  
							<a style="color: black;"> / ${page.endPageNum}</a>
							<a style="color: black;"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.startPageNum}">
							◀ <input type="text" id="pageInput" value="${page.startPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="boardListInqr('${page.endPageNum}');" id="pNum" >${page.endPageNum}</a>
							<a href="#" onclick="boardListInqr('${pageNum+1}');" id="pNum"> ▶ </a>
						</c:when>
						<c:when test="${pageNum == page.endPageNum}">
							<a href="#" onclick="boardListInqr('${pageNum-1}');" id="pNum"> ◀ </a>
							<input type="text" id="pageInput" value="${page.endPageNum}" onkeypress="pageInputRep(event, menuListInqr);" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="boardListInqr('${page.endPageNum}');" id="pNum">${page.endPageNum}</a> ▶
						</c:when>
						<c:otherwise>
							<a href="#" onclick="boardListInqr'${pageNum-1}');" id="pNum" > ◀ </a>
							<input type="text" id="pageInput" value="${pageNum}" style='width: 50px; padding: 3px; '/> /&nbsp;
							<a href="#" onclick="boardListInqr'${page.endPageNum}');" id="pNum">${page.endPageNum}</a>
							<a href="#" onclick="boardListInqr'${pageNum+1}');" id="pNum"> ▶ </a>
						</c:otherwise>
					</c:choose>
				</div>
		
		<div class="right">
 		</div> 
	</div>

	<div class = paging_div>
	
	</div> 
</div>
 </div>
<script type="text/javascript">

$(document).ready(function() { 
	 
	 /* 접속된 세션 아이디 입니다. */
	 var sessionID = "${SessionID}" 

	if(sessionID == 'admin'){
 	 }else{
		 alert("${SessionID}");
			alert(" ** 접근권한이 없습니다. ** \n ** 관리자 권한으로 로그인하세요. **\n ** 로그인화면으로 이동합니다. **");
//			location.href = "/logout";
			location.href = "/";
	 }
	
}) 

	
 	function boardDetail(a){
 		alert(a);
 		
 	} 
 	
    $("#board_add_fbtn").on("click", function(){
	location.href="/board/boardInsert";
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
			 /* 접속된 세션 아이디 입니다. */
			 var sessionID = "${SessionID}" 

			if(sessionID == 'admin'){ 
				$.ajax({
	 				url : '/board/board_remove',
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
	 				
	 				}
	 				})  
		 	 }else{
				 alert("${SessionID}");
					alert(" ** 접근권한이 없습니다. ** \n ** 관리자 권한으로 로그인하세요. **\n ** 로그인화면으로 이동합니다. **");
//					location.href = "/logout";
					location.href = "/";
			 }  
 	}
 	
 	
 	
 	
 	function ajaxList() {
 		boardListInqr(1); 
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
	 
	 
	//페이지 엔터시 이벤트
	$(document).on("keypress","#pageInput",function(){
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			pageInputRep(event, menuListInqr);
		}
	})
	
	//페이지 엔터시 이벤트
	$(document).on("keypress","#pageInput",function(){
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			pageInputRep(event, menuListInqr);
		}
	})
	
	
	
	
	 
	/*리스트 출력및 페이징 처리 함수*/
	function boardListInqr(pageNum){ 
 		var keyword    = $("#keyword").val();
 		 
 		$.post("/board/search_boardInqr",{"keyword":keyword, "pageNum":pageNum}, function(data){
			
 			$(".board_list").html(""); 
			$(data.qna_list).each(function(){
				 
   				var BOARD_NO = this.board_NO;
  				var TITLE = this.title;
				var CREATED_BY = this.created_BY;
				var CREATED  = this.created; 
				var VIEW_CNT = this.view_CNT;
				boardListOutput(BOARD_NO, TITLE, CREATED_BY, CREATED, VIEW_CNT);
			})
			paging(data,"#paging_div", "boardListInqr");
		}).fail(function(){
			alert("목록을 불러오는데 실패하였습니다.")
		})
	}
	 
	
	/* 리스트 출력 함수 */
	function boardListOutput(BOARD_NO, TITLE, CREATED_BY, CREATED, VIEW_CNT){
		 
		var board_Tr = $("<tr>");
 
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + BOARD_NO + "'>");
		
		var board_no_td = $("<td>");
 		board_no_td.html(BOARD_NO); 
 		
		var title_td = $("<td>");
		title_td.html("<a href=\"/board/boardDetail?BOARD_NO=" + BOARD_NO + "\">" + TITLE + "\</a>");
		
		var created_by_td =$("<td>");
		created_by_td.html(CREATED_BY);
		
		var created_td =$("<td>");
		created_td.html(CREATED);
		
		var view_cnt_td =$("<td>");
		view_cnt_td.html(VIEW_CNT);
		
		board_Tr.append(del_code_td).append(board_no_td).append(title_td).append(created_by_td).append(created_td).append(view_cnt_td);
				
		$(".board_list").append(board_Tr);
 			
	} 
 
	
</script>


</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>
