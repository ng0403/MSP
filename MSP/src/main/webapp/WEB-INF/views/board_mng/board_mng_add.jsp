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
 

<div class="container" style="width:90%">

	<div>
	<form role="form" name="board_mng_form">
	<table class="table">
	<tr>
	<td>게시판이름</td> <td><input type="text" class="form-control" id="BOARD_NM" name="BOARD_NM"  value="${board_mng_list.BOARD_NM} " style="width:50%" /></td>
	<td>게시판분류</td>
	<td>
	<select class="form-control" name="BOARD_MNG_NM" >
    <option value="공지사항">공지사항</option>
    <option value="일반게시판">일반게시판</option>
    <option value="Q&A">Q&A</option>
   </select>
	</td>
	</tr>
	<tr>
	<td>관리자</td> <td></td> <td>게시판코드</td> <td></td>
	</tr>
	<tr>
	<td>댓글여부</td><td><label  class="radio-inline"><input type="radio" name="REPLY_FLG" value="Y">Y</label> <label class="radio-inline"><input type="radio" name="REPLY_FLG" value="N">N</label></td><td>게시판활성여부</td><td><label class="radio-inline"><input type="radio" name="ACTIVE_FLG" value="Y">Y</label> <label class="radio-inline"><input type="radio" name="ACTIVE_FLG" value="N">N</label></td>
	</tr>
	<tr>
	<td>파일업로드</td><td><label class="radio-inline"><input type="radio" name="FILE_ATTACH_FLG" value="Y">Y</label> <label class="radio-inline"><input type="radio" name="FILE_ATTACH_FLG" value="N">N</label></td><td>공지활성화</td><td><label class="radio-inline"><input type="radio" name="NOTICE_FLG" value="Y">Y</label> <label class="radio-inline"><input type="radio" name="NOTICE_FLG" value="N">N</label></td>
	</tr>
	</table> 
 	</form>
	</div>
	
	<div>
	<input type="button" id="board_mng_add_fbtn" class = "btn btn-default" value="추가"/> <input type="button" class="btn btn-default" id="board_list_fbtn" value="목록"/>
	</div>

</div>


<script>
	var formObj = $("form[role='form']");

 
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board_mng/board_mng_list";
 	})
 	
 $("#board_mng_add_fbtn").on("click", function() {
 	 var BOARD_MNG_NM =  $("#BOARD_MNG_NM option:selected").val();
 	 
  	 formObj.attr("action", "/board_mng/board_mng_add");
	 formObj.attr("method", "post");
	 formObj.submit();
		
 })	 
 
</script>

 

</body>
</html>
<%@include file="../include/footer.jsp"%>
