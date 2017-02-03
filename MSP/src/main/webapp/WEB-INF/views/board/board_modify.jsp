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
 

<div> <!-- 전체 div-->

	<form role="form" name="modifyForm" action="/board/board_modify " method="post">
	 <input type='hidden' id="BOARD_NO" name='BOARD_NO' value="${boardVO.BOARD_NO}"> 

<div> <!-- 제목 div-->
 <input type="text" class="form-control" name="TITLE" value= "${boardVO.TITLE}" />
</div> 

<div>	
<label for="created_by">${boardVO.CREATED_BY}</label> 
<label for="created"><fmt:formatDate pattern="yyyy-MM-dd HH:mm"	value="${boardVO.CREATED}" /></label> 
<label for="view_cnt">조회 : ${boardVO.VIEW_CNT}</label>
</div> 

<div> <!-- 내용 div -->
 <textarea class="form-control" rows="10" name="CONTENT" >${boardVO.CONTENT}</textarea>
</div> 


<div>   <!-- 댓글div -->
</div>
 </form>
<div> <!-- 버튼 div  -->
<!-- <input type="button" class = "btn btn-default" value="저장"/> -->
 <button type="submit" id = "board_modify_fbtn" class="btn btn-default">저장</button>
<!--  <input type="button" class="btn btn-default" id="board_modify_fbtn" value="저장"/> -->
 <input type="button" class="btn btn-default" id="board_list_fbtn" value="목록"/>
</div>



</div>




<script>
 
$(document).ready(
	function() {
var formObj = $("form[role='form']");

console.log(formObj);
 
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board/board_list";
 	})
 	
$("#board_modify_fbtn").on("click", function(){
/* 	alert("go1"); 
	formObj.submit(); */
	
	$("form[name='modifyForm']").attr("action", "${ctx}/board/board_modify").submit();
	
}) 		
});

 
</script>

 

</body>
</html>
<%@include file="../include/footer.jsp"%>
