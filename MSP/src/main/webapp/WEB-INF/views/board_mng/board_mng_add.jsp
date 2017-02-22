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
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
  
<div class="container" style="width:90%">

	<div id = "board_mng_add">
	<form role="form" name="board_mng_form"> 
  
	<table class="table">
	<tr> 
	<td>게시판이름</td>
 <td><input type="text" class="form-control" id="BOARD_NM" name="BOARD_NM" style="width:50%" /></td> 
	<td>게시판분류</td>
   <td> 
   <select class="form-control" id="sel1" onchange= fn_SelectBox(this.value);>
     <option value="공지사항">공지사항</option>
    <option value="게시판">게시판</option>
    <option value="Q&A">Q&A</option>
   </select>
   </td>
	</tr>
	<tr>
	<td>관리자</td> <td></td> <td>게시판코드</td> <td><input type="text" class="form-control" id="BOARD_NM" name="BOARD_NM" value="${board_mng_list.BOARD_MNG_CD}" style="width:50%; readonly:readonly" /></td>
	</tr>
	<tr>
	<td>
	댓글여부
	</td>
	<td>
	<label class="radio-inline">
	<input type="radio" class="radio_class" id="reply_flg_y" name="REPLY_FLG" value="Y">Y
	</label> <label class="radio-inline">
	<input type="radio" class="radio_class" id="reply_flg_n" name="REPLY_FLG" value="N">N
	</label>
	</td>
	<td>
	게시판활성여부
	</td>
	<td>
	<label class="radio-inline">
	<input type="radio" class="radio_class" value="Y" id="active_flg_y" name="ACTIVE_FLG" value="Y">Y
	</label> 
	<label class="radio-inline">
	<input type="radio" class="radio_class" value="N" id="active_flg_n"  name="ACTIVE_FLG" value="N">N
	</label>
	</td>
	</tr>
	<tr>
	<td>
	파일업로드
	</td>
	<td>
	<label class="radio-inline" >
	<input type="radio" class="radio_class" id="file_attach_flg_y" name="FILE_ATTACH_FLG" value="Y">Y
	</label>
	<label class="radio-inline">
	<input type="radio" class="radio_class" id="file_attach_flg_n" name="FILE_ATTACH_FLG" value="N">N
	</label>
	 </td>
	 <td>
	 공지활성화
	 </td>
	 <td>
	 <label  class="radio-inline">
	 <input type="radio" class="radio_class" id="notice_flg_y" name="NOTICE_FLG" value="Y">Y
	 </label> 
	 <label class="radio-inline">
	 <input type="radio" class="radio_class" id="notice_flg_n" name="NOTICE_FLG" value="N">N
	 </label>
	 </td>
	</tr>
	</table> 
	</form>
	</div>
	
	<div>
	<input type="button" id="board_mng_add_fbtn" class = "btn btn-primary btn-sm" value="저장"/> <input type="button" class="btn btn-primary btn-sm" id="board_list_fbtn" value="목록"/>
	</div>

</div>


<script>
 
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board_mng/boardmngInqr";
 	})
 	
 $("#board_mng_add_fbtn").on("click", function() {
 	 var BOARD_MNG_NM =  $("#BOARD_MNG_NM option:selected").val();
     var formObj = $("form[role='form']");

  	 formObj.attr("action", "/board_mng/board_mng_add");
	 formObj.attr("method", "post");
	 formObj.submit();
		
 })	 
 
 function fn_SelectBox(e){
	 
	var CODE_TXT = e;  
 	 
	 $.ajax({
	 				url : '/board_mng/board_mng_codetxt',
	 				headers : {
	 		            "Content-Type" : "application/json",
	 		            "X-HTTP-Method-Override" : "POST"
	 		         },
	 				data : CODE_TXT,
	 				dataType : 'json',
	 				processData: false,
	 				contentType: false,
	 				type: 'POST',
	 				success : function(result) {
 	 					
	 					var ajaxList = result.data; 
	 					
 	 					var liststr = "";
	 					 
	 				 	liststr    +=  	"<form role='form' name='board_mng_form'>" + 

	 				 		"<table class='table'>" +
	 					"<tr>" +
	 					"<td>게시판이름</td> <td><input type='text' class='form-control' id='BOARD_NM' name='BOARD_NM' style='width:50%' /></td> " +
	 					"<td>게시판분류</td>" +
	 					"<td>" +
	 					"<select class='form-control' name='BOARD_MNG_NM' onchange = fn_SelectBox(this.value); >" +
	 				    "<option value='공지사항'>공지사항</option>" +
	 				    "<option value='게시판'>게시판</option>" +
	 				    "<option value='Q&A'>Q&A</option>" +
	 				  " </select>" +
	 					"</td>" +
	 					"</tr>" +
	 					"<tr>" +
	 					"<td>관리자</td> <td></td> <td>게시판코드</td> <td><input type='text' class='form-control' id='BOARD_MNG_CD' name='BOARD_MNG_CD' value= '"+ajaxList[0].CODE1+"' style='width:50%; readonly:readonly'/></td>" +
	 					"</tr>" +
	 					"<tr>" +
	 					"<td>댓글여부</td><td><label  class='radio-inline'><input type='radio' name='REPLY_FLG' value='Y'>Y</label> <label class='radio-inline'><input type='radio' name='REPLY_FLG' value='N'>N</label></td><td>게시판활성여부</td><td><label class='radio-inline'><input type='radio' name='ACTIVE_FLG' value='Y'>Y</label> <label class='radio-inline'><input type='radio' name='ACTIVE_FLG' value='N'>N</label></td>" +
	 					"</tr>" +
	 					"<tr>"  +
	 					"<td>파일업로드</td><td><label class='radio-inline'><input type='radio' name='FILE_ATTACH_FLG' value='Y'>Y</label> <label class='radio-inline'><input type='radio' name='FILE_ATTACH_FLG' value='N'>N</label></td><td>공지활성화</td><td><label class='radio-inline'><input type='radio' name='NOTICE_FLG' value='Y'>Y</label> <label class='radio-inline'><input type='radio' name='NOTICE_FLG' value='N'>N</label></td>" +
	 					"</tr>" +
	 					"</table>" +
	 					"</form>"; 
	 					
	 					var boardtable = document.getElementById("board_mng_add");
	 					boardtable.innerHTML = liststr;
	 					
						 $(".form-control option[value='"+ ajaxList[0].CODE_TXT+"']").attr("selected", true);
  

			
	 				} 
	 		         
	 				}) 
	 				  
}
 
 

			
  	 
 
 
 
 
 
 
 
 
</script>

 

</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>
