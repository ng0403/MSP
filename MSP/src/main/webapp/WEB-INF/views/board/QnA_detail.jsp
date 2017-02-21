<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@include file="../include/header.jsp"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 합쳐지고 최소화된 최신 CSS -->
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<form role="form" name = "form_modify" method="post">
 <input type='hidden' id="BOARD_NO" name='BOARD_NO' value="${boardlist.BOARD_NO}"> 
</form>
 

<div class="container" style=" width:90%" > <!-- 전체 div-->

<div> <!-- 제목 div-->
 <input type="text" class="form-control" id="title" value= "${boardlist.QUESTION_TITLE}"  readonly="readonly" />
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
<input type="button" id="board_modify_fbtn" class = "btn btn-primary btn-sm" value="편집"/> <input type="button" id="board_remove_fbtn" class="btn btn-primary btn-sm" value="삭제"/>  <input type="button" class="btn btn-primary btn-sm" id="board_list_fbtn" value="목록"/>
</div>
 
 
</div>
 
 
 <div class="col-md-12" id="reply_list" style="margin-top:10px">
 
 <table id = "reply_table" class="table">
 
 </table>
 
 </div> 

</div>	




<script>
 
 
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board/QnAInqr";
 	})
 	
 	  
 
$(document).ready(function(){ 
	  
	 var BOARD_NO = $("#BOARD_NO").val(); 
     var formObj = $("form[role='form']");
	 console.log(formObj);
	
 $("#board_modify_fbtn").on("click", function(){
	 	formObj.attr("action", "/board/QnA_modify");
		formObj.attr("method", "get");		
		formObj.submit();
	 /* $("form[name='form_modify']").attr("action", "${ctx}/board/board_read?BOARD_NO=?").submit();  */ 
 })
 
 $("#board_remove_fbtn").on("click", function(){
	 formObj.attr("action", "/board/board_remove");
	 formObj.attr("method", "post");
	 formObj.submit();
 })
   
  

})
 
</script>

 

</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>
