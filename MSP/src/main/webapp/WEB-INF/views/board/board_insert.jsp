<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@include file="../include/header.jsp"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/BoardCSS/boardCSS.css" type="text/css" />
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/common/css/mps/BoardCSS/boardCSS.css" type="text/css" />

<title>Insert title here</title>
</head>
<body>
  
<div class="navi_div">
		게시판 > 리스트 > 추가
</div>

<div class="container" >  <!-- 전체 div-->
     <input type='hidden' id="BOARD_MNG_NO" name='BOARD_MNG_NO' value="${board_mng}"/>  

	<form role="form" method="post" enctype="multipart/form-data">
		<div> <!-- 제목 div-->
			<label id="txt" >제  목</label>
		 	<input type="text" class="form-control" id="TITLE" name="TITLE" placeholder="제목을 입력해 주세요."  />
		</div> 
	  
		<div> <!-- 내용 div -->
			<label id="txt" >내  용</label>
			<textarea class="form-control" rows="10" id="CONTENT" name="CONTENT" placeholder="내용을 입력해 주세요." ></textarea>
		</div> 
	 
		<div id="file">
			<input type="file" multiple="multiple" name="filedata" id="filedata"> 
		</div> 
	</form>

	<div id="btns"> <!-- 버튼 div  -->
		 <input type="button" id ="board_add_fbtn" class = "btn btn-primary btn-sm" value="저장"/>
		 <input type="button" id="board_list_fbtn" class="btn btn-default btn-sm" value="취소"/> 
	</div>

</div> 
 
<script>  

$("#board_list_fbtn").on("click", function(){  
		
	     var BOARD_MNG_NO = $("#BOARD_MNG_NO").val();
	 	alert(BOARD_MNG_NO);
    	 location.href = "/board/boardInqr?BOARD_MNG_NO="+BOARD_MNG_NO; 
    	
 	}) 
 	
 	$("#board_add_fbtn").on("click", function(){
 	 
 	     var formObj = $("form[role='form']");
  	     
 		 formObj.attr("action", "/board/boardInsert");
 		 formObj.attr("method", "post");
 		 formObj.submit(); 
 		 
 	})
 	
 	
 	$("#fileuploadPop").on("click",function(){
	     var formObj = $("form[role='form1']");

 		 formObj.attr("action", "/board/file_insert");
 		 formObj.attr("method", "post");
 		 formObj.submit(); 
 		
 	})
  
	 
  
</script>

 

</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>
