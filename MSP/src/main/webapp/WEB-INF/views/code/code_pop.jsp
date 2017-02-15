<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/common/js/standard/common.js"></script>

<link rel="stylesheet" href="${ctx}/resources/common/css/mainDiv.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/header.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/menu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/subMenu.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/content.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/standard/common.css" type="text/css" />
<link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="menuMask"></div>
	
	<div class="menuWindow" >
		<div id="mainDiv" style="width:100%; align="center">
			<span style="margin-top:1%; font-size: 15px; float:center; margin-left:1%;"><strong style="text-align: center;">공통코드 선택</strong></span>
			<div>
				<input type="button" href="#" id="menuClose" class="func_btn" data-dismiss="modal" 
					   style="font-size:11px;margin-top:1%; margin-right:1%; float: right;" value="닫기"/>
			</div>
			<div class="block_div">
				<div style="height:100px; width:98%;">
					<!-- General -->
					<div>
						<br/>
						<div align="center" style="width: 100%">
							<table class="code_view" style="font-size: 12px; width: 100%" border="1">
								<tbody id="generalTbody">
								
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		
		</div>
	</div> 
	<a href="#" class="menuOpen"></a>
</body>
</html>