<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<style type="text/css">

#loginalign{
margin-left: 40%;
}

</style>
<script type="text/javascript">
/**
 * 로그인처리 서비스 호출
 */
 
function doLogin(){
	if ($('#user_id').val()==null || $('#user_id').val()=='') {
		alert('ID를 입력해 주십시오.');
		$('#user_id').focus();
		return false;
	}
	if ($('#user_pwd').val()==null || $('#user_pwd').val()=='') {
		alert('패스워드를 입력해 주십시오.');
		$('#user_pwd').focus();
		return false;
	}

}

// 로그인 시 초기화 처리
function initLogin() {
	
	// 로그인 정보가 맞지 않을 경우
	if ($("#loginResult").val() == "LOGIN_FAIL1") {
		alert("로그인 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
		location.href="${ctx}/";
	} else if ($("#loginResult").val() == "LOGIN_FAIL2") {
		location.href="${ctx}/";
	}else if ($("#loginResult").val() == "LOGIN_DENINED") {
		alert("로그인이 3회 이상 실패하였습니다. 관리자에게 문의해 주십시오.");
		location.href="${ctx}/";
	}
	// 포커스 처리
	$('#user_id').focus();
}
</script>
	<title>Home</title>
</head>
<body onkeydown="javascript:if(event.keyCode == 13) { doLogin(); }" onload="initLogin();">
<input type="hidden" id="ctx" value="${ctx}"/>
<input type="hidden" id="loginResult" value="<%=request.getParameter("loginResult") %>" />
<div id="wrap">
<!-- Logo 영역 -->
    <div class="loginWrap">
        <h1 class="h1Logo"><center>회사 로고 영역</center></h1><%-- <img src="${ctx}/resources/images/bonBack.jpg" alt="CorePlus" /> --%>
        
       <c:if test="${not empty sessionScope.user_id}"> 
        <div id="loginalign">
       		로그인 중입니다.<br><br>
       	<a href="${ctx}/user/userlist" class="loging">메인</a>
       	</div>
       </c:if>  
       <c:if test="${empty sessionScope.user}">
       
        <form id="loginForm" action="${ctx}/login" method="POST">       
        <fieldset id="loginText">
            <legend>로그인</legend>
            <div>
            	<c:if test="${not empty sessionScope.user_id}">
            	<p>세션:${sessionScope.user_id}</p>
            	</c:if>
                <p>
                    <input type="text" name="user_id" id="user_id" placeholder="Your ID" autocomplete="off" autofocus="autofocus"></input> <!-- tabIndex=1 --> 
                </p>
                <p>
                    <input type="password" name="user_pwd" id="user_pwd" placeholder="Your PW"></input>
                </p>
                </div>
                
			    <input type="submit" id="loginBtn" value="로그인">
			   
       	</fieldset>
        </form>
        </c:if>
            
        
    </div><!--//loginWrap  -->
    <hr />

    <!-- //footer -->
    <footer id="main_footer">
             <p>회사명 / 회사 주소 / 회사 대표연락처</p>
             <p>저작권 표시 영역</p>
             </footer>
    </div>
 <!--//wrap  -->
</body>
</html>