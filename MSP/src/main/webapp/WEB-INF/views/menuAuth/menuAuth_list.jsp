<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="SessionID" value="${sessionScope.user_id}" />
<c:set var="ctx" value="${pageContext.request.contextPath }" />

<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<script src="${ctx}/resources/common/js/common.js"></script>
<script src="${ctx}/resources/common/js/mps/menuAuthJS/menuAuth_list.js"></script>

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">  -->
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />
<!--  -->

<title>MenuAuth List</title>

<style type="text/css">
#menuAuthMask {position:absolute; z-index:10000; background-color:#000; display:none; left:0; top:0;}
#menuAuthInsertMask {position:absolute; z-index:11000; background-color:#000; display:none; left:0; top:0;}

.menuAuthWindow {display: none; position:absolute; width:50%; height:55%; left:28%; top:30%; z-index:10000;
            background-color: white; overflow: auto;}   
.menuAuthInsertWindow {display: none; position:absolute; width:50%; height:65%; left:30%; top:15%; z-index:10000;
            background-color: white; overflow: auto;}

.menuOpen{display: none;}      
.block_div{display:block; height: 10px; clear: both;}

.modal.fade {
  -webkit-transition: opacity .3s linear, top .3s ease-out;
  -moz-transition: opacity .3s linear, top .3s ease-out;
  -ms-transition: opacity .3s linear, top .3s ease-out;
  -o-transition: opacity .3s linear, top .3s ease-out;
  transition: opacity .3s linear, top .3s ease-out;
}

.modal.fade.in {
  top: 5%;
}

.page1 {
   width: 15%;
   text-align: center;
   float: inherit;
}

.search1_div {
   margin-top: 10px;
   margin-left: 20px;
   float: left;
   width: 48%;
}

.page2 {
   width: 15%;
   text-align: center;
   float: inherit;
   margin-left: 35%;
   
}

.tdstyle {
   text-align: left;
}

.thth {
   text-align: center;
}


</style>

<script type="text/javascript">
var save_cd;
var sessionID = "${SessionID}"

if(sessionID == 'admin')
{
   
}
else
{
   alert(" ** 접근권한이 없습니다. ** \n ** 관리자 권한으로 로그인하세요. **\n ** 확인버튼 클릭 시. **\n ** 로그인화면으로 이동합니다. **");
   location.href = "/";
}

function menuAuthByMask() {
   //화면의 높이와 너비를 구한다.
   var maskHeight = $(document).height();
   var maskWidth = $(window).width();
   
   //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
   $("#menuAuthMask").css({
      'width' : maskWidth,
      'height' : maskHeight
   });
   
   //애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
   $('#menuAuthMask').fadeIn(1000);
   $('#menuAuthMask').fadeTo("slow", 0.5);

   //윈도우 같은 거 띄운다.
   $('.menuAuthWindow').show();
}

function menuAuthInsertByMask() {
   //화면의 높이와 너비를 구한다.
   var maskHeight = $(document).height();
   var maskWidth = $(window).width();
   
   //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
   $("#menuAuthInsertMask").css({
      'width' : maskWidth,
      'height' : maskHeight
   });
   
   //애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
   $('#menuAuthInsertMask').fadeIn(1000);
   $('#menuAuthInsertMask').fadeTo("slow", 0.5);

   //윈도우 같은 거 띄운다.
   $('.menuAuthInsertWindow').show();
}

$(document).ready(function() {
   $("#auth_id_pop").on("click", function(){
      authListInqrPop(1);
      popByMask("authMask", "authWindow");
   });
   
   // 등록할 때 메뉴검색 팝업 눌렀을 때
   $("#menu_cd_pop").on("click", function(){
      menuListInqrPop(1);
      popByMask("menuMask", "menuWindow");
   });
   
   // 추가할 때 메뉴선택 팝업클릭 시
   $("#menuAuth_add_btn").on("click", function(){
      save_cd = "insert";
      menuAuthInsertByMask();
   });
   
   //검은 막 띄우기
   $('.menuOpen').click(function(e) {
      e.preventDefault();
      menuAuthByMask();
   });
   
   // 상세보기 수정버튼 클릭 시
   $(".menuAuthWindow #menuAuthMdfy_btn").click(function(e){
      //menuAuthMdfy();
      $("#menuAuthMdfyForm").submit();
   });

   // 상세보기 닫기 버튼을 눌렀을 때
   $('.menuAuthWindow #menuAuthClose').click(function(e) {
      //링크 기본동작은 작동하지 않도록 한다.   
      $("#generalTbody").empty();
      $("#menuAuthMask, .menuAuthWindow").hide();
   });

   // 등록 닫기 버튼을 눌렀을 때
   $('.menuAuthInsertWindow #menuClose').click(function(e) {
      //링크 기본동작은 작동하지 않도록 한다.   
      $("#menuAuthInsertMask, .menuAuthInsertWindow").hide();
   });
   
   // 등록 팝업 취소버튼 클릭 시
   $("#menuAuthClose").click(function(){
      $("#up_menu_nm").val("");
      $("#up_menu_cd").val("");
      $("#auth_id").val("");
      $("#auth_nm").val("");
   });
});

function viewLoadingShow(){
     $('#viewLoadingImg').css('position', 'absolute');
     $('#viewLoadingImg').css('left', '45%');
     $('#viewLoadingImg').css('top', '45%');
     $('#viewLoadingImg').css('z-index', '1200');
     $('#viewLoadingImg').show().fadeIn(500);
}

function viewLoadingHide(){
       $('#viewLoadingImg').fadeOut();   
}

</script>


</head>
<body>
<%-- <%@include file="../include/header.jsp"%> --%>
   
   <!--Main_Div  -->
   <div class="main_div">
      <!-- Navigation Div -->
      <div class="navi_div">
         권한별 메뉴관리
      </div>

      <!-- Search Cover Div -->
      <div class="search_div">
         <div class="search1_div">
            <label>권한명</label>&nbsp;
               <input type="text" id="auth_id_sch" name="auth_id_sch" class="inputTxt" style="width: 10%; height: 34px;"> &nbsp;&nbsp;
               <label>메뉴명</label>&nbsp;
               <input type="text" id="menu_nm_sch" name="menu_nm_sch" class="inputTxt" style="width: 20%; height: 34px;"> &nbsp;&nbsp;
               <input type="button" id="search_fbtn" class="btn btn-primary btn-sm" onclick="fn_menuAuthSearch(1)" value="검색">
               
            <!-- Paging Form -->
            <form id="menuAuthlistPagingForm" method="post" action="menuAuthInqr">
         
            </form>
         </div>
      <!-- class="search_div" -->
      </div>
         
      <!-- List Cover Div -->
      <div class="list_div">
         <div class="list_div1">
            <div class="table_div">
            <form name="delAllForm" id="delAllForm" method="post" action="menuAuthDel">
               <table class="table table-hover">
                  <thead>
                     <tr>
                        <th class="thth"><input id="checkall" type="checkbox" /></th>
                        <th class="thth">메뉴코드</th>
                        <th class="thth">메뉴명</th>
                        <th class="thth">권한명</th>
                        <th class="thth">조회권한</th>
                        <th class="thth">생성권한</th>
                        <th class="thth">수정권한</th>
                        <th class="thth">삭제권한</th>
                        <th class="thth">메뉴접근권한</th>
                     </tr>
                  </thead>
                  
                  <tbody id="menuAuthListTbody">
                     <c:forEach var="menuAuthInqrList" items="${menuAuthInqrList}">
                        <tr class="open_detail" data_num="${menuAuthInqrList.MENU_CD}">
                           <td align="center" scope="row">
                              <input type="checkbox" name="del_menuAuth" id="del_menuAuth" value="${menuAuthInqrList.MENU_CD}:${menuAuthInqrList.AUTH_ID}" />
                           </td>
                           <td>
                              <a href="javascript:void(0)" onclick="fn_menuAuthPop('${menuAuthInqrList.MENU_CD}', '${menuAuthInqrList.AUTH_NM }')">${menuAuthInqrList.MENU_CD}</a>
                           </td>
                           <td class="tdstyle">${menuAuthInqrList.MENU_NM}</td>
                           <td class="tdstyle">${menuAuthInqrList.AUTH_NM}</td>
                           <td>${menuAuthInqrList.INQR_AUTH}</td>
                           <td>${menuAuthInqrList.ADD_AUTH}</td>
                           <td>${menuAuthInqrList.MDFY_AUTH}</td>
                           <td>${menuAuthInqrList.DEL_AUTH}</td>
                           <td>${menuAuthInqrList.MENU_ACC_AUTH}</td>
                        </tr>
                     </c:forEach>
                  </tbody>
               </table>
            </form>
            </div>
            <!-- class="list1_div" -->   
         </div>
         
         <!-- Button Div -->
         <div class="paging_div">
            <div class="left">
               <input type="button" id="menuAuth_add_btn" class="btn-default btn" data-target="#menuAuthAddLayer" data-toggle="modal" value="추가"/> 
               <input type="button" id="menuAuth_del_btn" class="btn btn-primary btn-sm" value="삭제" onclick="menuAuthDel()" />
            </div>
            
            <!-- Pagine Div -->
            <div id="menuAuthPagingDiv" class="page2">
               <input type="hidden" id="endPageNum" value="${page.endPageNum}" />
               <input type="hidden" id="startPageNum" value="${page.startPageNum}" />
               <input type="hidden" id="userPageNum" value="${pageNum}" />
               
               <c:choose>
                  <c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
                     <a style="color: black; text-decoration: none;">◀ </a>
                     <input type="text" id="pageInput" class="inputTxt" value="${page.startPageNum}" onkeypress="pageInputRep(event, fn_menuAuthSearch);" style="width: 50px;" />
                     <a style="color: black; text-decoration: none;">/ 1</a>
                     <a style="color: black; text-decoration: none;">▶ </a>
                  </c:when>
                  <c:when test="${pageNum == page.startPageNum}">
                     <a style="color: black; text-decoration: none;">◀ </a>
                     <input type="text" id="pageInput" class="inputTxt" value="${page.startPageNum}" onkeypress="pageInputRep(event, fn_menuAuthSearch);" style="width: 50px;" />
                     <a href="#" onclick="fn_menuAuthSearch('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
                     <a href="#" onclick="fn_menuAuthSearch('${pageNum+1}');" id="pNum">▶</a>
                  </c:when>
                  <c:when test="${pageNum == page.endPageNum}">
                     <a href="#" onclick="fn_menuAuthSearch('${pageNum-1}');" id="pNum">◀</a>
                     <input type="text" id="pageInput" class="inputTxt" value="${page.endPageNum}" onkeypress="pageInputRep(event, fn_menuAuthSearch);" style="width: 50px;" />
                     <a href="#" onclick="fn_menuAuthSearch('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
                     <a style="color: black; text-decoration: none;">▶</a>
                  </c:when>
                  <c:otherwise>
                     <a href="#" onclick="fn_menuAuthSearch('${pageNum-1}');" id="pNum">◀</a>
                     <input type="text" id="pageInput" class="inputTxt" value="${pageNum}" onkeypress="pageInputRep(event, fn_menuAuthSearch);;" style="width: 50px;" />
                     <a href="#" onclick="fn_menuAuthSearch('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
                     <a href="#" onclick="fn_menuAuthSearch('${pageNum+1}');" id="pNum">▶</a>
                  </c:otherwise>
               </c:choose>
            <!-- class="page1" -->
            </div>
         </div>
      <!-- class="list_div" -->
      </div>
      
      <!-- 메뉴권한 상세정보 창 띄우기(취소 - 부트스트랩을 mask모달로 변경) -->
      <div id="menuAuthDetail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="menuAuthDetail-tab" aria-hidden="true" data-backdrop="static" data-keyboard="true" >
           <div class="modal-dialog modal-lg">
               <div class="modal-content">
               </div>
           </div>
      </div>
      
      <div id="viewLoadingImg" style="display: none;">
         <img src="${ctx}/resources/image/viewLoading.gif">
         </div>
      
       <!-- menuAuth 팝업 -->
      <div style="font-size:11.5px;">
          <jsp:include page="../menuAuth/menuAuth_pop.jsp"></jsp:include>
      </div>
      <!-- //menu detail 팝업 -->
      
      <jsp:include page="../menuAuth/menuAuth_insert.jsp"></jsp:include>
      
   <!-- class="main_div" -->
   </div>

</body>
</html>

<%-- <%@include file="../include/footer.jsp"%> --%>
