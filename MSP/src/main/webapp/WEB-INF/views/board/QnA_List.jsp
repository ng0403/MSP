<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 
<%@include file="../include/header.jsp"%>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<div class= main_div>

<div class = navi_div>

</div>

<div class= search_div>
<div class= search1_div>

</div>
</div>

 
<div class= "container" id="list1_div" style="width:90%">  

 <!-- Q&A 리스트, 조회화면 -->
	    <form name="frm_QnA" id="frm_QnA" action="/board/search_QnA"	enctype="multipart/form-data"  method="post">
		<div id="inputDiv" style="font-size:11.8px;width:100%;font-family:Helvetica, sans-serif;">
				<label for="user_id">질문유형 :</label>
					 <select id="qna_type" name="qna_type" style="width:80px;font-size:10px;">
					    <option value=""> -- 선택 -- </option>
 							<option value="Y">Y</option>
 							<option value="N">N</option>
 					</select>
						<label>답변	 :</label>
					<select id="qna_answer" name="qna_answer" style="width:80px;font-size:10px;">
					    <option value=""> -- 답변 -- </option>
 							<option value="Y">Y</option>
 							<option value="N">N</option>
 					</select>
				<label for="keyword">제목 :</label>
					<input type="text" id="keyword" name="keyword" style="width: 100px" />&nbsp;
			
				</form> 
					<input type="button" class="button-default" onclick="QnAListInqr(1);" value="조회" style="font-size:11px;float:right;margin-right:1%;
					    background-color:#81BEF7;font-color:white;"/> 
					 
		</div>

 

 <form name="delAllForm" id ="delAllForm" method="post" action="/board/board_remove">  
	<table class="table table-bordered" style ="width: 90%">
						<thead>
						<tr>
							<th><input id="checkall" type="checkbox"/></th>
							<th>번호</th>
							<th>질문유형</th>
							<th>답변상태</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr > 
						</thead>
 					   <tbody class="qna_list">
 				 <c:forEach items="${boardlist}" var="boardVO"> 
 						
						    <tr class="open_list">

								<td scope="row"><input type="checkbox" id="del_code" name="del_code" value="${boardVO.BOARD_NO}"></td>
   								<td>${boardVO.BOARD_NO}</td>
   								<td>${boardVO.QUESTION_TYPE_CD}</td>
   								<td>${boardVO.ANSWER_FLG}</td>
								<td><a href="/board/QnA_detail?BOARD_NO=${boardVO.BOARD_NO}">${boardVO.TITLE}</a> </td>
								<td>${boardVO.CREATED_BY} </td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${boardVO.CREATED}" /></td>
								<td>${boardVO.VIEW_CNT}</td>
							</tr> 
						</c:forEach>
						 </tbody>
					</table>
					</form>
					
					<div class="paging_div" style="width: 100%; text-align: center;">
	
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
					
					<input type="button" id = "board_add_fbtn" class = "btn btn-default" value="추가"/> <input type="button" id ="board_remove_fbtn" class="btn btn-default" value="삭제"  onclick="deleteAction() "/>
					
</div>
  
<div class = paging_div>

</div> 

</div>

<!-- 페이징 전용 폼 -->
			<form  action="${ctx}/board/board_QnA_list" id="boardlistPagingForm" method="post">
				<input type="hidden" name="user_id_sch" value="${user_id_sch}"/>
				<input type="hidden" name="user_nm_sch" value="${user_nm_sch}"/>
				<input type="hidden" name="dept_cd_sch" value="${dept_cd_sch}"/>
			</form>

<script type="text/javascript">
 
 
$("#board_add_fbtn").on("click", function(){
	location.href="/board/board_insert";
	
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
 				url : '/board/board_remove',
 				headers : {
 		            "Content-Type" : "application/json",
 		            "X-HTTP-Method-Override" : "POST"
 		         },
 				data : del_code,
 				dataType : 'json',
 				processData: false,
 				contentType: false,
 				type: 'POST',
 				success : function(result) {
 					alert("hello ajax");
 					
 					var ajaxList = result.data; 
 						
 					var liststr = "";
 					var liststr1 = "";
 					var liststr2 = "";
 					
 				 	var list = ajaxList.length;
 				 	alert("list" + list);  
 				 	
 				 	liststr    += "<table class='table table-bordered' style ='width: 90%'>" +
										"<tr>" +
									"<th>" +
										"<input id='checkall' type='checkbox'/>" +
									"<th>번호</th>" +
									"<th>제목</th>" +
									"<th>작성자</th>" +
									"<th>작성일</th>" +
									"<th>조회수</th>" +
									"</tr>";
 				 	
					for(var i=0 ; i<ajaxList.length; i++) {  
						 liststr1  +=    "<tr>" +
  										"<td scope='row'><input type='checkbox' name='del_code' value=" + ajaxList[i].BOARD_NO + "/>" +
 										"<td>" + ajaxList[i].BOARD_NO + "</td>" +
 										"<td><a href=\"/board/board_detail?BOARD_NO=" + ajaxList[i].BOARD_NO + "\">" + ajaxList[i].TITLE + "\</a> </td>" +
 										"<td>" + ajaxList[i].CREATED_BY + "</td>" +
 										"<td>" + ajaxList[i].CREATED + "</td>" +
 										"<td>" + ajaxList[i].VIEW_CNT + "</td>" +
 										"</tr>";
  								
 				 	}
					
					liststr2 +=  "</table>";
 					
 					var boardtable = document.getElementById("list1_div");
 					boardtable.innerHTML = liststr + liststr1 + liststr2;
  					 

 				} ,  error:function(request,status,error){
		             alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		          } 
 				}) 
			
  		} 
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
	
	
	
	/*리스트 출력및 페이징 처리 함수*/
	function QnAListInqr(pageNum){
 		var qna_answer = $("#qna_answer").val();
		var keyword    = $("#keyword").val();
		
		$.post("/board/search_QnA_list",{"qna_answer":qna_answer, "keyword":keyword, "pageNum":pageNum}, function(data){
			$(".qna_list").html("");
			$(data.qna_list).each(function(){
  				var BOARD_NO = this.board_NO;
				var QUESTION_TYPE_CD = this.question_TYPE_CD;
				var ANSWER_FLG = this.answer_FLG;
				var TITLE = this.title;
				var CREATED_BY = this.created_BY;
				var CREATED  = this.created;
				var VIEW_CNT = this.view_CNT;
				qnaListOutput(BOARD_NO, QUESTION_TYPE_CD, ANSWER_FLG, TITLE, CREATED_BY, CREATED, VIEW_CNT);
			})
			$("#paging_div").html("");
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
				pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount);
			})
		}).fail(function(){
			alert("목록을 불러오는데 실패하였습니다.")
		})
	}
	
	 
	
	
	/*페이징 출력 함수*/
	function pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount){
		if(endPageNum == 1)
		{
			pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress='pageInputRepDept(event);'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
			+"<a style='color:black; text-decoration: none;'>▶</a>"
		}
		else if(startPageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=authListInqrt("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=authListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\"pageInputRepDept(event);\"/>" 
			+"<a style='cursor: pointer;' onclick=authListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\"pageInputRepDept(event);\"/>"
			+"<a style='cursor: pointer;' onclick=authListInqr("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick=authListInqr("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		$("#paging_div").append(pageContent);

	}
	
	
	
	/* 리스트 출력 함수 */
	function qnaListOutput(BOARD_NO, QUESTION_TYPE_CD, ANSWER_FLG, TITLE, CREATED_BY, CREATED, VIEW_CNT){
	
		var qna_Tr = $("<tr>");
 	
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + BOARD_NO + "'>");
		
		var board_no_td = $("<td>");
 		board_no_td.html(BOARD_NO);
		
		var question_type_cd_td = $("<td>");
		question_type_cd_td.html(QUESTION_TYPE_CD);
		
		var answer_flg_td = $("<td>");
		if(ANSWER_FLG=='Y'){
			answer_flg_td.html("Y");
		}else if(ANSWER_FLG=='N'){
			answer_flg_td.html("N");
		}
		
		var title_td = $("<td>");
		title_td.html("<a href=\"/board/QnA_detail?BOARD_NO=" + BOARD_NO + "\">" + TITLE + "\</a>");
		
		var created_by_td =$("<td>");
		created_by_td.html(CREATED_BY);
		
		var created_td =$("<td>");
		created_td.html(CREATED_BY);
		
		var view_cnt_td =$("<td>");
		view_cnt_td.html(VIEW_CNT);
		
		qna_Tr.append(del_code_td).append(board_no_td).append(question_type_cd_td).append(answer_flg_td).append(title_td).append(created_by_td).append(created_td).append(view_cnt_td);
				
		$(".qna_list").append(qna_Tr);
 	}

	
</script>


</body>
</html>
<%@include file="../include/footer.jsp"%>