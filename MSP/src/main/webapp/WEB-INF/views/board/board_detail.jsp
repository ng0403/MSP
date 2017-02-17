<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<form role="form" name = "form_modify" method="post">
 <input type='hidden' id="BOARD_NO" name='BOARD_NO' value="${boardlist.BOARD_NO}"/> 
 <input type='hidden' id="REPLY_FLG" name='REPLY_FLG' value="${boardlist.REPLY_FLG}"/>
</form>
 

<div class="container" style=" width:90%" > <!-- 전체 div-->

<div> <!-- 제목 div-->
 <input type="text" class="form-control" id="title" value= "${boardlist.TITLE}"  readonly="readonly" />
</div> 

<div>
<label for="created_by">${boardlist.CREATED_BY}</label> 
<label for="created"><fmt:formatDate pattern="yyyy-MM-dd HH:mm"	value="${boardlist.CREATED}" /></label> 
<label for="view_cnt">조회 : ${boardlist.VIEW_CNT}</label>
</div> 

<div> <!-- 내용 div -->
 <textarea class="form-control" rows="10" id="content"  readonly="readonly" >${boardlist.CONTENT}</textarea>
</div> 

 
<div> <!-- 버튼 div  -->
<input type="button" id="board_modify_fbtn" class = "btn btn-default" value="편집"/> <input type="button" id="board_remove_fbtn" class="btn btn-default" value="삭제"/>  <input type="button" class="btn btn-default" id="board_list_fbtn" value="목록"/>
</div>


 <!-- 댓글div -->
<div id="reply_div" class="timeline-body" style ="height:100px; margin-top:10px "> 
 <div>
 <div class="col-sm-10" style=" height:40px">
 <textarea id = "reply_content" class="form-control" rows="2" id="content" ></textarea>
 </div>
 
  <!-- 댓글 등록 버튼 -->
 <div class="col-md-2" >
 <input type="button" id="reply_add_fbtn" class = "btn btn-default" value="저장"/>
 </div>
</div>
 
 
 <div class="col-md-12" id="reply_list" style="margin-top:10px">
 
 <table id = "reply_table" class="table">
 
 </table>
 
 </div> 

</div>	
 
<script>
 
 
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board/board_list";
 	})
 	 
 	
 	
 
$(document).ready(function(){ 
	 var REPLY_FLG = $("#REPLY_FLG").val(); 
	 var BOARD_NO = $("#BOARD_NO").val();
 	 var liststr = "";
	 var liststr1 ="";
	 var liststr2 = ""; 
     var formObj = $("form[role='form']");
	 console.log(formObj);
	
 $("#board_modify_fbtn").on("click", function(){
	 	formObj.attr("action", "/board/board_modify");
		formObj.attr("method", "get");		
		formObj.submit();
	 /* $("form[name='form_modify']").attr("action", "${ctx}/board/board_read?BOARD_NO=?").submit();  */
	 
 })
 
 $("#board_remove_fbtn").on("click", function(){
	 formObj.attr("action", "/board/board_remove");
	 formObj.attr("method", "post");
	 formObj.submit();
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
 				 			  "<th class='col-sm-1'>" + ajaxList[i].created_BY + "</th> <th class='col-sm-10'>" +ajaxList[i].reply_CONTENT+ "</th>";
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
  	 var CREATED_BY = '이준석';
  	 
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
<%@include file="../include/footer.jsp"%>
