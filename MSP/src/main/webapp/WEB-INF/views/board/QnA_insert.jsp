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
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>  
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 


<div class="container" style=" width:90%">  <!-- 전체 div-->

<form role="form" method="post" >
<div> <!-- 제목 div-->
 <input type="text" class="inputTxt" id="TITLE" name="TITLE" placeholder="제목을 입력해 주세요."  />
 <select class="form-control" id="sel1" name = "QUESTION_TITLE">
     <option value="인적서비스">인적서비스</option>
     <option value="점포서비스">점포서비스</option>
     <option value="제휴카드">제휴카드</option>
     <option value="쿠폰">쿠폰</option>
     <option value="제휴서비스">제휴서비스</option>
   </select>
</div> 
  
<div> <!-- 내용 div -->
 <textarea class="form-control" rows="10" id="CONTENT" name="CONTENT" placeholder="내용을 입력해 주세요." ></textarea>
</div> 

 
  
  </form>

 
 
<div> <!-- 버튼 div  -->
 <input type="button" id ="board_add_fbtn" class = "btn btn-primary btn-sm" value="저장"/>
 	
 <input type="button" id="board_list_fbtn" class="btn btn-primary btn-sm" value="취소"/> 
</div>

</div> 
 

<script> 
 

$("#board_list_fbtn").on("click", function(){  
    	 location.href = "/board/QnAInqr"; 
    	
 	}) 
 	
 	$("#board_add_fbtn").on("click", function(){
 	     var formObj = $("form[role='form']");
  	     
 		 formObj.attr("action", "/board/QnA_insert");
 		 formObj.attr("method", "post");
 		 formObj.submit(); 
 		 
 	})
   
</script>

 

</body>
</html>
<%-- <%@include file="../include/footer.jsp"%> --%>
