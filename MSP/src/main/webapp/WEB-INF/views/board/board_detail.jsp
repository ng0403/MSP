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


<div>   <!-- 댓글div -->
</div>
 
<div> <!-- 버튼 div  -->
<input type="button" class = "btn btn-default" value="편집"/> <input type="button" class="btn btn-default" value="삭제"/>  <input type="button" class="btn btn-default" id="board_list_fbtn" value="목록"/>
</div>



</div>




<script>
 
 
$("#board_list_fbtn").on("click", function(){  
    	location.href = "/board/board_list";
 	})
 	
 	
 
</script>

 

</body>
</html>
<%@include file="../include/footer.jsp"%>
