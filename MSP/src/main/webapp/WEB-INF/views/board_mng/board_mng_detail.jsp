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
 <input type='hidden' id="BOARD_NO" name='BOARD_NO' value="${board_mng_list.BOARD_MNG_NO}"> 
</form>
 

<div class="container" style="width:50%">

	<div>
	<table class="table">
	<tr> 
	<td>게시판이름</td>
 <td><input type="text" class="form-control" id="BOARD_NM" name="BOARD_NM"  value="${board_mng_list.BOARD_NM} " style="width:50%" readonly ="readonly"/></td> 
	<td>게시판분류</td>
   <td> 
   <select class="form-control" id="sel1"  disabled>
    <option>공지사항</option>
    <option>일반게시판</option>
    <option>Q&A</option>
   </select>
   </td>
	</tr>
	<tr>
	<td>관리자</td> <td></td> <td>게시판코드</td> <td>${board_mng_list.BOARD_MNG_CD} </td>
	</tr>
	<tr>
	<td>댓글여부</td><td><label class="radio-inline"><input type="radio" id="reply_flg" >Y</label> <label class="radio-inline"><input type="radio" name="reply_flg">N</label></td><td>게시판활성여부</td><td><label class="radio-inline"><input type="radio" name="active_flg">Y</label> <label class="radio-inline"><input type="radio" name="active_flg">N</label></td>
	</tr>
	<tr>
	<td>파일업로드</td><td><label class="radio-inline" ><input type="radio" name="file_attach_flg">Y</label> <label class="radio-inline"><input type="radio" name="file_attach_flg">N</label></td><td>공지활성화</td><td><label class="radio-inline"><input type="radio" name="notice_flg">Y</label> <label class="radio-inline"><input type="radio" name="notice_flg">N</label></td>
	</tr>
	</table> 
	</div>
	
	<div id = "button_div">
	<input type="button" id="board_mng_modify_fbtn" class = "btn btn-default" value="편집"/>
	<input type="button" class="btn btn-default" id="board_list_fbtn" value="목록"/>
	</div>

</div>
 
<script>
 
 
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board_mng/board_mng_list";
 	})
 	
 $("#board_mng_modify_fbtn").on("click", function() {
	alert("ㅎㅎㅎ2");
	 $("#BOARD_NM").attr("readonly", false);
	 $("#BOARD_MNG_CD").attr("disabled", false);
	 $("#sel1").attr("disabled", false);
 	 })	 
 	 
 
$(document).ready(function(){ 
	  
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
   

})
 
</script>

 

</body>
</html>
<%@include file="../include/footer.jsp"%>
