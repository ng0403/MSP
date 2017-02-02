<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <%@include file="../include/header.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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


<div class= main_div>

<div class = navi_div>

</div>

<div class= search_div>
<div class= search1_div>

</div>
</div>

<div class= list_div>
<div class= list1_div >
	<table class="table table-bordered" style ="width: 90%">
						<tr>
							<th><input id="checkall" type="checkbox"/></th>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
 						<c:forEach items="${boardlist}" var="boardVO"> 
							<tr>
								<td scope="row"><input type="checkbox" name="del_code" value="${boardVO.BOARD_NO}"></td>
  								<td>${boardVO.BOARD_NO}</td>
								<td><a href="/board/board_detail?BOARD_NO=${boardVO.BOARD_NO}">${boardVO.TITLE}</a> </td>
								<td>${boardVO.CREATED_BY} </td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${boardVO.CREATED}" /></td>
								<td>${boardVO.VIEW_CNT}</td>
							</tr> 
						</c:forEach>
					</table>
					<input type="button" id = "board_add_fbtn" class = "btn btn-default" value="추가"/> <input type="button" class="btn btn-default" value="삭제"/>
					
</div>
</div>

<div class = paging_div>

</div> 

</div>


<script>
 
 
$("#board_add_fbtn").on("click", function(){
	location.href="/board/board_insert";
	
})
 
 
 
	$("#checkall").on("click", function() {

		if ($("#checkall").prop("checked")) {

			$("input[name=del_code]").prop("checked", true);
		} else {
			$("input[name=del_code]").prop("checked", false);
		}

	}) 
	
</script>


</body>
</html>
<%@include file="../include/footer.jsp"%>
