<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<c:set var="SessionID" value="${sessionScope.user_id}" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<style type="text/css">

#loginalign{
margin-left: 40%;
}

</style>
<script type="text/javascript">
/* 접속된 세션 아이디 입니다. */
var sessionID = "${SessionID}" 
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
			<div style="margin-left: 0%;">
        		<center><img src="${ctx}/resources/common/css/logo.jpg" alt="CorePlus" style="width: 10%; margin-top: 50px;"/></center>
        		<%-- <img src="${ctx}/resources/images/bonBack.jpg" alt="CorePlus" /> --%>
        	</div>
       			 <h1 class="h1Logo" ><center>Shopping Mall Management</center></h1>
        <c:if test="${not empty sessionScope.user_id}"> 
        <div id="loginalign" style="margin-top: 35px; margin-bottom: 50px;">
<!--              로그인 중입니다.<br><br>  -->
          <a href="${ctx}/user/userInqr" class="loging" style="width: 40%;  margin-left: 10%; " >메인</a>
          </div>
       </c:if>  
     
	   <div style="width: 50%;  margin: auto; margin-top: 100px;" >	     
	       <c:if test="${empty sessionScope.user}">
	        <form id="loginForm" action="${ctx}/login" method="POST">       
	        <fieldset id="loginText">
	            <legend>로그인</legend>
	            <div >
	               <c:if test="${not empty sessionScope.user_id}">
	               <p style="width: 50%;  margin-left: 40%; margin-bottom: 30px;">접속된 계정:${sessionScope.user_id}</p>
	               </c:if>
	                <p>
	                    <input type="text" class="form-control" name="user_id" id="user_id" placeholder="Your ID" autocomplete="off" autofocus="autofocus" style="width: 50%;  margin: auto;" ></input> <!-- tabIndex=1 --> 
	                </p>
	                <p>
	                    <input type="password" class="form-control" name="user_pwd" id="user_pwd" placeholder="Your PW" style="width: 50%;  margin: auto;"></input>
	                </p>
	                </div>
	                
	             <input type="submit" id="loginBtn"  class="btn btn-default btn-sm" style="width: 20%;  margin-left: 40%; margin-top: 20px;" value="로그인">
	            
	          </fieldset>
	        </form>
	        </c:if>
         </div>   
        
    </div><!--//loginWrap  -->
     <hr style="width: 50%; " />

    <!-- //footer -->
    	
    	<hr  style="margin-top: 280px;"/>
    	<div style="margin-left: 29%; font-size: 9pt; ">
		    <footer id="main_footer">
             <p>코어플러스 / 서울시 관악구 조원동 1668-12 코어빌딩 / 02 - 761 - 2223&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(C)Coreplus COMPANY. ALL RIGHTS RESSERVED.</p>
             <p style="margin:auto;"></p>
             </footer>
    	</div>
    </div>
 <!--//wrap  -->
</body>
</html>