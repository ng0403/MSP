<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<%-- <%@include file="header.jsp"%> --%>
<!DOCTYPE html  PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
#main_header1{
background-color:#53C5BA;
color:white;
width:100%;
height:6%;
margin:auto;
clear:both;
display:table;
}
#table_cell{
display:table-cell;
vertical-align:middle;
}
#main{
background-color:#ECF0F5;
width:100%;
height:94%;
margin:auto;
clear:both;
}

#main_left{
background-color:#222D32;
width:15%;
height:100%;
margin:auto;
float:left;
}

#main_center1{
background-color:#ECF0F5;
width:85%;
height:95%;
margin:auto;
float:left;
}

#main_footer1{
background-color:white;
width:85%;
height:5%;
/* margin:auto; */
float:left;
display:table;
}
#table_cell3{
display:table-cell;
vertical-align:middle;
}
    
</style>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- <title>Main DashBoard</title> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css" type="text/css" />
    <script type="text/javascript" src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script> -->
	<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
	<%-- <script type="text/javascript" src="${ctx}/resources/common/js/jquery-ui.js"></script> --%>
	<script type="text/javascript" src="${ctx}/resources/common/js/standard/common.js"></script>
	<%-- <link rel="stylesheet" href="${ctx}/resources/common/css/jquery-ui.css"	type="text/css" /> --%>
	<link rel="stylesheet" href="${ctx}/resources/common/css/standard/header.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/resources/common/css/standard/menu.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/resources/common/css/standard/subMenu.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/resources/common/css/standard/content.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/resources/common/css/standard/common.css" type="text/css" />
	<link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet">
	<!-- Font Awesome Icons -->
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<!-- Ionicons -->
	<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<!-- Theme style -->
	<link href="${ctx}/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
	<link href="${ctx}/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />

	<title>Main</title>
	<script type="text/javascript">
    //사용자권한 상세 팝업
    function fn_changeMngPage(page){
	    	
	    	var div_content = $('#main_center1');
	    	
	    	var div = document.getElementById('user_content');
	    	var div1 = document.getElementById('auth_content');
	    	
	    	var contents1="";
	    	
	    	$.ajax({
	    		url : '/changeMngPage',
	    		type : 'POST',
	    		dataType :'json',
	    		data : { "page":page },
	    		success : function(data){
	    			div_content.empty();
	    			
	    			/* var url = data.url;
	    			alert(url);
	    			contents1="<div><jsp:include page="+url+"/></div>";
	    			alert(contents1);
					div_content.append(contents1); */
					var page1 = data.page;
					if(page1 == "user"){
					    alert("111");
					    div.style.display = "";
					    div1.style.display = "none"
					}else if(page1 == "auth"){
					    div.style.display = 'none';
					    div1.style.display = 'block';
					}
					
	    		},
	    		beforeSend: function(){
	        	//viewLoadingShow();			
	        },
	        complete:function(){
	        	//viewLoadingHide();
	    	},	
	    	error : function(request,status,error) {
	    	    alert("사용자페이징code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    	}
	    }); 
	}
    
    
       $(function(){ 
           var i = 0;
           var c = "";
            $("#user").click(function(){ 
                /* for( i=1 ; i<8 ;i++){
                    c = "m"+""+i;
                    if( 'm1'==c){
                        $('#m1').show();
                    }else{
                        $("#"+c).hide();
                    }
                } */
                
                userListInqr(1);
            }); 
            $("#auth").click(function(){ 
                /* for( i=1 ; i<8 ;i++){
                    c = "m"+""+i;
                    if( c == 'm2'){
                        $('#m2').show();
                    }else{
                        $("#"+c).hide();
                    }
                } */
                authListInqr(1);
            }); 
            $("#board").click(function(){ 
                /* for( i=1 ; i<8 ;i++){
                    c = "m"+""+i;
                    if( c == 'm3'){
                        $('#m3').show();
                    }else{
                        $("#"+c).hide();
                    }
                }  */
                boardListInqr(1);
            }); 
            $("#code").click(function(){ 
                /* for( i=1 ; i<8 ;i++){
                    c = "m"+""+i;
                    if( c == 'm4'){
                        $('#m4').show();
                    }else{
                        $("#"+c).hide();
                    }
                } */ 
                fn_codeSearch(1);
            }); 
            $("#dept").click(function(){ 
                /* for( i=1 ; i<8 ;i++){
                    c = "m"+""+i;
                    if( c == 'm5'){
                        $('#m5').show();
                    }else{
                        $("#"+c).hide();
                    }
                } */
                deptListInqr(1);
            }); 
            $("#userAuth").click(function(){ 
                /* for( i=1 ; i<8 ;i++){
                    c = "m"+""+i;
                    if( c == 'm6'){
                        $('#m6').show();
                    }else{
                        $("#"+c).hide();
                    }
                } */
                fn_userAuthSearchList(1);
            }); 
            $("#menuAuth").click(function(){ 
                /* for( i=1 ; i<8 ;i++){
                    c = "m"+""+i;
                    if( c == 'm7'){
                        $('#m7').show();
                    }else{
                        $("#"+c).hide();
                    }
                } */
                fn_menuAuthSearch(1);
            }); 
        });

</script>

</head>

<body>
    <div id="main_header1" style="background-color:#53C5BA;">
        <div id="table_cell">&nbsp;&nbsp;&nbsp;&nbsp;
        <span style="font-size:21.5px;"><b>Shopping Mall</b> Management</span>
        <span style="float:right;margin-right:1%;">님 환영합니다.</span>
        <a href="#" style="float:right;margin-right:3px;">
             <span style="color:yellow;">${user_nm}</span>
        </a>
        </div>
    </div>
 <div id="main">
 <div id="main_left">
 
 <aside class="main-sidebar"  style="width:15%;">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          <div class="user-panel">
            <div class="pull-left image">
               <img src="/resources/dist/img/images.png" class="img-circle" alt="User Image" /> 
            </div>
            <div class="pull-left info">
              <p style="color:white;">${user_nm}</p>

              <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
          </div>
          <!-- search form -->
          <!-- <form action="#" method="get" class="sidebar-form"  style="margin-top:2%;width:95%;">
            <div class="input-group">
              <input type="text" name="q" class="form-control" placeholder="Search..." style="margin-left:8px;"/>
              <span class="input-group-btn">
                <button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
              </span>
            </div>
          </form> -->
          <!-- /.search form -->
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu" style="width:100%;margin-top:2%;">
            <!-- <li class="header"><div style="height:28px;vertical-align:middle;color:#E5FCF9;font-size:17px;background-color:#1A2226;">&nbsp;&nbsp;MAIN NAVIGATION</div></li> -->
            <li class="treeview">
              <a href="/user/userInqr">
                <i class="fa fa-dashboard"></i> 
                <span style="color:#ECF0F5;">사용자관리</span> 
                <!-- <i class="fa fa-angle-left pull-right"></i> -->
              </a>
              <ul class="treeview-menu">
                <li><a href="/resources/index.html"><i class="fa fa-circle-o"></i> Dashboard v1</a></li>
                <li><a href="/resources/index2.html"><i class="fa fa-circle-o"></i> Dashboard v2</a></li>
              </ul>
            </li>
            <li>
              <a href="/auth/authInqr">
                <i class="fa fa-th"></i> 
                <span style="color:#ECF0F5;">권한관리</span> 
                <!-- <i class="fa fa-angle-left pull-right"></i> -->
                <!-- <small class="label pull-right bg-green">new</small> -->
              </a>
            </li>
          
            <li class="treeview">
              <a href="/board/boardInqr">
                <i class="fa fa-edit"></i> 
                <span style="color:#ECF0F5;">게시판관리</span>
                <!-- <i class="fa fa-angle-left pull-right"></i> -->
              </a>
            </li>
            <li class="treeview">
              <a href="/code/codeInqr">
                <i class="fa fa-table"></i> 
                <span style="color:#ECF0F5;">공통코드관리</span>
                <!-- <i class="fa fa-angle-left pull-right"></i> -->
              </a>
            
            </li>
            <li>
              <a href="/dept/deptInqr">
                <i class="fa fa-calendar"></i> 
                <span style="color:#ECF0F5;">부서관리</span>
                <!-- <i class="fa fa-angle-left pull-right"></i> -->
                <!-- <small class="label pull-right bg-red">3</small> -->
              </a>
            </li>
            <li>
              <a href="/userAuth/view">
                <i class="fa fa-envelope"></i> 
                <span style="color:#ECF0F5;">사용자권한</span>
                <!-- <i class="fa fa-angle-left pull-right"></i> -->
                <!-- <small class="label pull-right bg-yellow">12</small> -->
              </a>
            </li>
            <li>
              <a href="/menuAuth/menuAuthInqr">
                <i class="fa fa-envelope"></i> 
                <span style="color:#ECF0F5;">메뉴권한</span>
                <!-- <i class="fa fa-angle-left pull-right"></i> -->
              </a>
            </li>
          
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>
 
 </div>
 
 <div id="main_center1">
     <tiles:insertAttribute name="main_center1" />
     <%-- <div id="m1" value="m1" style="display:block">
         <jsp:include page="../user/user_list.jsp"/>
     </div>
     <div id="m2" style="display:none">
         <jsp:include page="../auth/auth_list.jsp"/>
     </div>
     <div id="m3" style="display:none">
         <jsp:include page="../board/board_list.jsp"/>
     </div>
     <div id="m4" style="display:none">
         <jsp:include page="../code/code_list.jsp"/>
     </div>
     <div id="m5" style="display:none">
         <jsp:include page="../dept/dept_list.jsp"/>
     </div>
     <div id="m6" style="display:none">
         <jsp:include page="../userAuth/user_auth_list.jsp"/>
     </div>
     <div id="m7" style="display:none">
         <jsp:include page="../menuAuth/menuAuth_list.jsp"/>
     </div> --%>
     
 </div>
 
 <div id="main_footer1">
     <div id="table_cell3">
     <div style="float:right;margin-right:2%;">
          <b>Version</b> 2.0
     </div>
     &nbsp;&nbsp;&nbsp;<strong >Copyright &copy; 2017 
     <a href="http://www.coreplus.co.kr">coreplusMPS</a>.</strong> All rights reserved.
     </div>
 </div>
 </div>

<script type="text/javascript">

</script>

</body>

</html>