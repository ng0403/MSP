<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<c:set var="SessionID" value="${sessionScope.user_id}" />

<!DOCTYPE html  PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
    
</style>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   
<!-- 	/* CSS */ -->
    
<!-- common -->
    
	

<!-- 	/* 사용자 */ -->
<%-- 	<link rel="stylesheet" href="${ctx}/resources/common/css/mps/userCSS/userTabCSS.css" type="text/css" />  --%>
<%-- 	<link rel="stylesheet" href="${ctx}/resources/common/css/mps/userCSS/userCSS.css" type="text/css" /> --%>
	
<!-- 	권한 -->
<%-- 	<link rel="stylesheet" href="${ctx}/resources/common/css/mps/AuthCSS/authCSS.css" type="text/css" /> --%>
<!-- 	게시판 -->
<%-- 	<link rel="stylesheet" href="${ctx}/resources/common/css/mps/BoardCSS/boardCSS.css" type="text/css" /> --%>
<!-- 	공통코드 -->
<%-- 	<link rel="stylesheet" href="${ctx}/resources/common/css/mps/CodeCSS/codeCSS.css" type="text/css" /> --%>
	
	<!-- <title>Main DashBoard</title> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css" type="text/css" />

	<!-- Font Awesome Icons -->
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<!-- Ionicons -->
	<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<!-- Theme style -->
	<link href="${ctx}/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
	<link href="${ctx}/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" /> 
	<link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet">
	
<!-- JS	 -->
<!-- 공통JS -->
	<script type="text/javascript" src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
	
<!-- 	메뉴권한  -->
<%-- 	<script src="${ctx}/resources/common/js/mps/menuAuthJS/menuAuth_list.js"></script> --%>
	<!-- 	사용자  -->
<%-- 	<script src="${ctx}/resources/common/js/mps/userJS/user_tab_js.js"></script> --%>
<%-- 	<script src="${ctx}/resources/common/js/mps/userJS/user_list_js.js"></script> --%>
<%-- 	<script src="${ctx}/resources/common/js/mps/dept/deptlist_pop.js"></script> --%>
	<!-- 	권한  -->
<%-- 	<script src="${ctx}/resources/common/js/mps/authJS/auth_list.js"></script> --%>
	<!-- 	부서  -->
<%-- 	<script src="${ctx}/resources/common/js/mps/dept/dept_list.js"></script> --%>
	
	<script type="text/javascript" src="${ctx}/resources/common/js/common.js"></script>

	<title>Main</title>
	<script type="text/javascript">
	var sessionID = "${SessionID}";

</script>

</head>

<body>
    <div id="main_header1">
        <tiles:insertAttribute name="main_header1" />
    </div>
    
    <div id="main_left">
     <tiles:insertAttribute name="main_left" />
 
 </div>
    
 <div id="main_center1">
     <tiles:insertAttribute name="main_center1" />
     
 </div>
 
 <div id="main_footer1">
     <tiles:insertAttribute name="main_footer1" />
 </div>

<script type="text/javascript">

</script>

</body>

</html>