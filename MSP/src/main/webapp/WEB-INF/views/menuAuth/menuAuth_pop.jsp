<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<%-- <script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>  --%>

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script> -->

<!-- <link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet"/> -->
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" /> --%>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" /> --%>
<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" /> --%>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
</head>
<body>
	<div id="menuAuthMask"></div>
	
	<div class="menuAuthWindow" >
		<div id="mainDiv" style="align="center">
			<span style="margin-top:1%; font-size: 15px; float:center; margin-left:1%;"><strong style="text-align: center;">메뉴 권한 상세보기</strong></span>
			
			<div class="block_div"></div>
			
			<div style="height:150px; width:98%;">
				<!-- General -->
				<div>
					<br/>
					
					<div align="center">
						<form id="menuAuthMdfyForm" name="menuAuthMdfyForm" action="menuAuthMdfy" method="post">
							<table class="table table-hover">
								<tbody id="generalTbody">
								
								</tbody>
							</table>
						</form>
						
						<div>
							<input type="button" id="menuAuthMdfy_btn" class="btn btn-primary btn-sm" data-dismiss="modal" 
					  			   style="font-size:11px;margin-top:1%; margin-left:1%; float: left;" value="수정"/>
							<input type="button" id="menuAuthClose" class="btn btn-primary btn-sm" data-dismiss="modal" 
					 			   style="font-size:11px;margin-top:1%; margin-left:1%; float: left;" value="닫기"/>
						</div>
					</div>
					
				</div>
			</div>
		
		</div>
	</div> 
	
	<a href="#" class="menuOpen"></a>
</body>
</html>