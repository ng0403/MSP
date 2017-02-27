<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${ctx}/resources/common/js/mps/include/left_navi.js"></script>
</head>
<body>

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
           <!--  <li class="treeview">
              <a href="/user/userInqr">
                <i class="fa fa-dashboard"></i> 
                <span style="color:#ECF0F5;">사용자관리</span> 
                <i class="fa fa-angle-left pull-right"></i>
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
                <i class="fa fa-angle-left pull-right"></i>
                <small class="label pull-right bg-green">new</small>
              </a>
            </li>
          
            <li class="treeview">
              <a href="/board/boardInqr">
                <i class="fa fa-edit"></i> 
                <span style="color:#ECF0F5;">게시판관리</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
            </li>
            <li class="treeview">
              <a href="/code/codeInqr">
                <i class="fa fa-table"></i> 
                <span style="color:#ECF0F5;">공통코드관리</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
            
            </li>
            <li>
              <a href="/dept/deptInqr">
                <i class="fa fa-calendar"></i> 
                <span style="color:#ECF0F5;">부서관리</span>
                <i class="fa fa-angle-left pull-right"></i>
                <small class="label pull-right bg-red">3</small>
              </a>
            </li>
            <li>
              <a href="/userAuth/view">
                <i class="fa fa-envelope"></i> 
                <span style="color:#ECF0F5;">사용자권한</span>
                <i class="fa fa-angle-left pull-right"></i>
                <small class="label pull-right bg-yellow">12</small>
              </a>
            </li>
            <li>
              <a href="/menuAuth/menuAuthInqr">
                <i class="fa fa-envelope"></i> 
                <span style="color:#ECF0F5;">메뉴권한</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
            </li> -->
          
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>

</body>
</html>