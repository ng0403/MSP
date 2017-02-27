<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <c:set var="SessionID" value="${sessionScope.user_id}" />
 <c:set var="SessionID" value="${sessionScope.user_id}" />
<%-- <%@include file="../include/header.jsp"%> --%>

 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/BoardCSS/boardCSS.css" type="text/css" /> 
 <%-- <script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<script src="${ctx}/resources/common/js/common.js"></script> --%>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" /> --%>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />--%> 
 <!-- 합쳐지고 최소화된 최신 CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
부가적인 테마
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
합쳐지고 최소화된 최신 자바스크립트
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> --> 

<title>Insert title here</title>
</head>
<body>
 
 
<form role="form" name = "form_modify" method="post">
 <input type='hidden' id="BOARD_NO" name='BOARD_NO' value="${boardlist.BOARD_NO}"/> 

 <input type='hidden' id="REPLY_FLG" name='REPLY_FLG' value="${boardlist.REPLY_FLG}"/>
</form>

<form role="form1">
 <input type='hidden' id="BOARD_NO" name='BOARD_NO' value="${boardlist.BOARD_NO}"/> 
</form>

 <div class="navi_div">
		Q&A > 리스트 > 게시글
</div> 

<div class="container"> <!-- 전체 div-->

	<div> <!-- 제목 div-->
		<label id="txt" >제  목</label>
		<input type="text" class="inputTxt" name= "TITLE" id="TITLE" value= "${boardlist.TITLE}"  readonly="readonly" />
	</div> 

<!-- 	<div id="created"> -->
<%-- 		<label for="created_by">${boardlist.CREATED_BY}</label>  --%>
<%-- 		<%-- <label for="created"><fmt:formatDate pattern="yyyy-MM-dd HH:mm"	value="${boardlist.CREATED}" /></label>  --%> 
<%-- 		<label for="created"> ${boardlist.CREATED} </label> --%>
<%-- 		<label for="view_cnt">조회 : ${boardlist.VIEW_CNT}</label> --%>
<%-- 		<label> <a href="/board/file_down?FILE_CD=${boardlist.FILE_CD}">${boardlist.FILE_NM}</a></label>	 --%>
<!-- 		<br /> -->
<!-- 	</div>  -->

	<div id="detail_con"> <!-- 내용 div -->
		 <label id="txt" >내  용</label>  
		 <textarea  rows="10" id="boardcontent"  readonly="readonly" >${boardlist.CONTENT}</textarea>
	</div> 

	<div id="detail_btns"> <!-- 버튼 div  -->
		<input type="button" id="board_modify_fbtn" class = "btn btn-primary btn-sm" value="편집"/> 
		<input type="button" id="board_remove_fbtn" class="btn btn-primary btn-sm" value="삭제"/>  
		<input type="button" class="btn btn-primary btn-sm" id="board_list_fbtn" value="목록"/>
	</div>


	<!-- 댓글div -->
	<div id="reply_div" class="timeline-body" style ="height:100px; margin-top:10px "> 
	
		<div class="col-sm-10" style=" height:40px">
			<textarea id = "reply_content" class="form-control" rows="2" id="content" ></textarea>
		</div>
 
		<!-- 댓글 등록 버튼 -->
		<div id="detail_btn_div" class="reply_div col-md-2 " >
			<input type="button" id="reply_add_fbtn" class = "btn btn-primary btn-sm " value="저장"/>
		</div>
	
	</div>
 
	<div class="col-md-12" id="reply_list" style="margin-top:10px">
		<table id = "reply_table" class="table"> 
		</table> 
	</div> 

</div>	
 
<script>
  
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board/boardInqr";
 	})
 	 

 function remove_reply(e){ 
		var REPLY_NO = e;
		
		if(confirm("정보를 삭제 하시겠습니까?")){
		 $.ajax({
				url : '/reply/reply_remove/',
				headers : {
		            "Content-Type" : "application/json",
		            "X-HTTP-Method-Override" : "POST"
		         },
				data : REPLY_NO,
				dataType : 'text',
				processData: false,
				contentType: false,
				type: 'POST',
				success : function(result) {
					 
					if(result=="success"){
						ajax_list();
					}
					  
				} 
		         
				}) 
		}
	}
	
function ajax_list(){
	 var BOARD_NO = $("#BOARD_NO").val();
	 var liststr = "";
	 var liststr1 ="";
	 var liststr2 = ""; 
	 $.ajax({
			url : '/reply/reply_list/' + BOARD_NO,
			headers : {
	            "Content-Type" : "application/json",
	            "X-HTTP-Method-Override" : "POST"
	         },
			data : "",
			dataType : 'json',
			processData: false,
			contentType: false,
			type: 'GET',
			success : function(result) {
				var ajaxList = result;
      				 liststr    += " <table class='table'>";
				for(var i=0 ; i<ajaxList.length; i++) {  
  				liststr1 +=   "<thead>" +
				 			  "<th class='col-sm-1'>" + ajaxList[i].created_BY + "</th> <th class='col-sm-10'>" +ajaxList[i].reply_CONTENT+ "<span style='float:right' class='glyphicon glyphicon-remove' id = '"+ajaxList[i].reply_NO+"' onclick='remove_reply(this.id);'></span> </th>";
				 } 
				
				liststr2 +=  "</table>";
				var replytable = document.getElementById("reply_table");
				 replytable.innerHTML = liststr + liststr1 + liststr2;
				 liststr = "";
				 liststr1= "";
				 liststr2 = "";
				 
			} 
	         
			})  
}

	
	 
 
$(document).ready(function(){    

	 var REPLY_FLG = $("#REPLY_FLG").val(); 
	 var BOARD_NO = $("#BOARD_NO").val();
 	 var liststr = "";
	 var liststr1 ="";
	 var liststr2 = ""; 
     var formObj = $("form[role='form']");
	 
	
	 ajax_list(); 
	 
  /*리스트 출력및 페이징 처리 함수*/
	/* 	function boardListInqr(pageNum){ 
			var keyword    = $("#keyword").val();
			 
			$.post("/board/search_boardInqr",{"keyword":keyword, "pageNum":pageNum}, function(data){
				
				$(".board_list").html(""); 
				$(data.qna_list).each(function(){
					 
					var REPLY_NO = this.reply_NO;
					var CREATED_BY = this.created_BY;
					var CONTENT = this.CONTENT;
					replyListOutput(REPLY_NO, CREATED_BY, CONTENT);
				})
				paging(data,"#paging_div", "replyListInqr");
			}).fail(function(){
				alert("목록을 불러오는데 실패하였습니다.")
			})
		} */
	 
 
 $("#board_modify_fbtn").on("click", function(){
	 
	 /* 접속된 세션 아이디 입니다. */
		var sessionID = "${SessionID}" 

		if(sessionID == 'admin'){
 		 	formObj.attr("action", "/board/boardModify");
			formObj.attr("method", "get");		
			formObj.submit();
			
	 	 }else{
			 alert("${SessionID}");
				alert(" ** 접근권한이 없습니다. ** \n ** 관리자 권한으로 로그인하세요. **\n ** 로그인화면으로 이동합니다. **");
//				location.href = "/logout";
				location.href = "/";
		 }
	
	 /* $("form[name='form_modify']").attr("action", "${ctx}/board/board_read?BOARD_NO=?").submit();  */
	 
 })
 
 
 
 
 $("#board_remove_fbtn").on("click", function(){
	 var formObj1 = $("form[role='form1']");
	 if(confirm("정보를 삭제 하시겠습니까?")){
	 formObj1.attr("action", "/board/detail_remove");
	 formObj1.attr("method", "post");
	 formObj1.submit();
	 }
	 else{
		 
	 }
 }) 
 
 
  
 
  function ajax_list(){
 	 $.ajax({
			url : '/reply/reply_list/' + BOARD_NO,
			headers : {
	            "Content-Type" : "application/json",
	            "X-HTTP-Method-Override" : "POST"
	         },
			data : "",
			dataType : 'json',
			processData: false,
			contentType: false,
			type: 'GET',
			success : function(result) {
				var ajaxList = result;
       				 liststr    += " <table class='table'>";
				for(var i=0 ; i<ajaxList.length; i++) {  
   				liststr1 +=   "<thead>" +
 				 			  "<th class='col-sm-1'>" + ajaxList[i].created_BY + "</th> <th class='col-sm-10'>" +ajaxList[i].reply_CONTENT+ "<span style='float:right' class='glyphicon glyphicon-remove' id = '"+ajaxList[i].reply_NO+"' onclick='remove_reply(this.id);'></span> </th>";
				 } 
				
				liststr2 +=  "</table>";
				var replytable = document.getElementById("reply_table");
 				 replytable.innerHTML = liststr + liststr1 + liststr2;
 				 liststr = "";
 				 liststr1= "";
 				 liststr2 = "";
 				 
			} 
	         
			})  
 }
 
  
 $("#reply_add_fbtn").on("click", function() {
  
	 var REPLY_CONTENT_OBJ = $("#reply_content");
	 var REPLY_CONTENT = REPLY_CONTENT_OBJ.val();
  	 var CREATED_BY = "${SessionID}" ;
  	 
  	$.ajax({
		type:'POST',
		url:'/reply/reply_add',
		headers: { 
		      "Content-Type": "application/json",
		      "X-HTTP-Method-Override": "POST" },
		dataType:'text',
		processData: false,
		contentType: false,
		data:  JSON.stringify({"board_NO":BOARD_NO, "reply_CONTENT":REPLY_CONTENT, "created_BY":CREATED_BY}),
		success:function(result){
  				ajax_list();
   				$("#reply_content").blur();
	 
			} 
	          
		      }); 
 }) 
 
 
 
 

 

})
 
</script>

 

</body>
</html>
<%-- <%@include file="../include/footer.jsp"%>
 --%>