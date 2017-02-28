<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="SessionID" value="${sessionScope.user_id}" />
<c:set var="ctx" value="${pageContext.request.contextPath }" />

<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="${ctx}/resources/common/js/common.js"></script>
<script src="${ctx}/resources/common/js/mps/userJS/user_tab_js.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<link rel="stylesheet" href="${ctx}/resources/common/css/common.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/resources/common/css/common_pop.css" type="text/css" />

<title>Code List</title>

<style type="text/css">
#codeMask {position:absolute; z-index:9000; background-color:#000; display:none; left:0; top:0;}
.codeWindow{display: none; position:absolute; width:20%; height:25%; left:45%; top:30%; z-index:10000;
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
   clear: both;
   display: inline-block;
   text-align: center;
   vertical-align: top;
   margin:0 auto;
}

.thth {
   text-align: center;
}

</style>

<script type="text/javascript">
var sessionID = "${SessionID}"

if(sessionID == 'admin')
{
   
}
else
{
   alert(" ** 접근권한이 없습니다. ** \n ** 관리자 권한으로 로그인하세요. **\n ** 확인버튼 클릭 시. **\n ** 로그인화면으로 이동합니다. **");
   location.href = "/";
}

function codeByMask() {
   //화면의 높이와 너비를 구한다.
   var maskHeight = $(document).height();
   var maskWidth = $(window).width();
   
   //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
   $("#codeMask").css({
      'width' : maskWidth,
      'height' : maskHeight
   });
   
   //애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
   $('#codeMask').fadeIn(1000);
   $('#codeMask').fadeTo("slow", 0.5);


   //윈도우 같은 거 띄운다.
   $('.codeWindow').show();
}

$(document).ready(function() {
   //검은 막 띄우기
   $('.menuOpen').click(function(e) {
      e.preventDefault();
      codeByMask();
   });

   //닫기 버튼을 눌렀을 때
   $('.codeWindow #codeClose').click(function(e) {
      //링크 기본동작은 작동하지 않도록 한다.
      e.preventDefault();
      $("#generalTbody").empty();
      $("#codeMask, .codeWindow").hide();
   });
   
   $("#grp_cd_sch").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   $("#grp_nm_sch").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   $("#grp_cd").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   $("#grp_nm").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   $("#grp_desc").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   $("#code1").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   $("#code_txt").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   $("#code_desc").keyup(function(){
      if(lengthCheck($(this).val(), $(this).attr('maxlength')) == false)
      {
         $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
      }
   });
   
   
});

</script>


</head>
<body>
<%-- <%@include file="../include/header.jsp"%> --%>

<!--Main_Div  -->
<div class="main_div">
   
   <!-- Navigation Div -->
   <div class="navi_div">
         공통코드관리
      </div>

   <!-- Search Cover Div -->
   <div class="search_div">
      <div class="search2_div">
         <label>공통코드</label>&nbsp;
               <input type="text" class="inputTxt" id="grp_cd_sch" name="grp_cd_sch" value="${grp_cd_sch}" maxlength="2" style="width: 10%; height: 34px;"> &nbsp;&nbsp;
            
            <label>공통코드명</label>&nbsp;
                 <input type="text" class="inputTxt" id="grp_nm_sch" name="grp_nm_sch" value="${grp_nm_sch}" maxlength="50" style="width: 20%; height: 34px;"> &nbsp;&nbsp;
               <input type="button" id="search_fbtn" class="btn btn-primary btn-sm" onclick="fn_codeSearch(1)" value="검색"> 
               <input type="button" value="엑셀출력"  class="btn btn-info btn-sm"  onclick="download_list_Excel('codelistExcelForm');" style="float: right;">
         <!-- Paging Form -->
         <form id="codelistPagingForm" method="post" action="codeInqr"></form>
         <!-- Excel -->
         <form id="codelistExcelForm" method="post" action="${ctx}/code/codeInqr"></form>
         
         
      </div>
   </div>
     
   <!-- List Cover Div -->
      <div class="list_div">
         <div class="list2_div">
            <div class="table_div">
            <form name="delAllForm" id="delAllForm" method="post" action="codeDetailDel">
               <table class="table table-hover">
                  <thead>
                     <tr>
                        <th class="thth"><input id="checkall" type="checkbox" /></th>
                        <th class="thth" style="font-weight: bold;">공통코드</th>
                        <th class="thth" style="font-weight: bold;">공통코드명</th>
                        <th class="thth" style="font-weight: bold;">상세코드</th>
                        <th class="thth" style="font-weight: bold;">상세코드명</th>
                     </tr>
                  </thead>
                  <tbody id="codeListTbody">
                     <c:forEach var="codeInqrList" items="${codeInqrList}">
                        <tr class="open_detail" data_num="${codeInqrList.CODE1}">
                           <td align="center" scope="row">
                              <input type="checkbox" name="del_code" id="del_code" value="${codeInqrList.CODE1}">
                           </td>
                           <td align="center">${codeInqrList.GRP_CD}</td>
                           <td>${codeInqrList.GRP_NM}</td>
                           <td align="center">${codeInqrList.CODE1}</td>
                           <td>${codeInqrList.CODE_TXT}</td>
                        </tr>
                     </c:forEach>
                  </tbody>
               </table>
            </form>
            </div>
            
            <!-- Button Div -->
            <div class="paging_div">
               <div class="left">
                  <input type="button" id="code_add_btn" class="btn-default btn" value="추가" /> 
                  <input type="button" id="code_del_btn" class="btn btn-primary btn-sm" value="삭제" />
               </div>
               
               <!-- Pagine Div -->
               <div id="codePagingDiv" class="page1">
                  <input type="hidden" id="endPageNum" value="${page.endPageNum}" />
                  <input type="hidden" id="startPageNum" value="${page.startPageNum}" />
                  <input type="hidden" id="userPageNum" value="${pageNum}" />
                  <c:choose>
                     <c:when test="${page.endPageNum == 1 || page.endPageNum == 0}">
                        <a style="color: black; text-decoration: none;">◀ </a>
                        <input type="text" id="pageInput" class="inputTxt" value="${page.startPageNum}" onkeypress="pageInputRep(event, fn_codeSearch);" style="width: 50px;" />
                        <a style="color: black; text-decoration: none;">/ 1</a>
                        <a style="color: black; text-decoration: none;">▶ </a>
                     </c:when>
                     <c:when test="${pageNum == page.startPageNum}">
                        <a style="color: black; text-decoration: none;">◀ </a>
                        <input type="text" id="pageInput" class="inputTxt" value="${page.startPageNum}" onkeypress="pageInputRep(event, fn_codeSearch);" style="width: 50px;" />
                        <a href="#" onclick="fn_codeSearch('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
                        <a href="#" onclick="fn_codeSearch('${pageNum+1}');" id="pNum">▶</a>
                     </c:when>
                     <c:when test="${pageNum == page.endPageNum}">
                        <a href="#" onclick="fn_codeSearch('${pageNum-1}');" id="pNum">◀</a>
                        <input type="text" id="pageInput" class="inputTxt" value="${page.endPageNum}" onkeypress="pageInputRep(event, fn_codeSearch);" style="width: 50px;" />
                        <a href="#" onclick="fn_codeSearch('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
                        <a style="color: black; text-decoration: none;">▶</a>
                     </c:when>
                     <c:otherwise>
                        <a href="#" onclick="fn_codeSearch('${pageNum-1}');" id="pNum">◀</a>
                        <input type="text" id="pageInput" class="inputTxt" value="${pageNum}" onkeypress="pageInputRep(event, fn_codeSearch);" style="width: 50px;" />
                        <a href="#" onclick="fn_codeSearch('${page.endPageNum}');" id="pNum">/ ${page.endPageNum}</a>
                        <a href="#" onclick="fn_codeSearch('${pageNum+1}');" id="pNum">▶</a>
                     </c:otherwise>
                  </c:choose>
               </div>
               
            </div>
         </div>

         <div class="list3_div">
         <h5 id="h5">공통코드 상세</h5>
            <form method="post" id="joinform1" name="joinform1" action="codeMasterAdd">
               <table class="table table-hover">
                  <colgroup>
                     <col width="22%">
                     <col width="28%">
                     <col width="22%">
                     <col width="28%">
                  </colgroup>
                  <tbody id="tbody1">
                     <tr>
                        <th>공통코드</th>
                        <td>
                           <input type="text" name="grp_cd" id="grp_cd" class="inputTxt" style="width: 95%" value="${grp_cd}" maxlength="2" readonly="readonly"/>
                        </td>
                        <td></td>
                        <td></td>
                     </tr>
                     <tr>
                        <th>공통코드명</th>
                        <td>
                           <input type="text" name="grp_nm" id="grp_nm" class="inputTxt" style="width: 95%" value="${grp_nm}" maxlength="50" readonly="readonly"/>
                        </td>
                        <th>공통코드설명</th>
                        <td>
                           <input type="text" name="grp_desc" id="grp_desc" class="inputTxt" style="width: 95%" value="${grp_desc}" maxlength="500" readonly="readonly"/>
                        </td>
                     </tr>
                  </tbody>
               </table>
            </form>
            
            <!-- Button Div -->
            <div class="btn02">
               <div class="right">
                  <input type="button" id="codeMaster_add_btn" class="btn btn-primary btn-sm" value="추가" style="display: none" /> 
                  <input type="button" id="codeMaster_reset_btn" class="btn-default btn" value="취소" style="display: none" />
               </div>
            </div>
            
            <br><br>
            
            <h5 id="h5" >상세코드 상세</h5>
            <form method="post" id="joinform2" name="joinform2">
               <table class="table table-hover">
                  <colgroup>
                     <col width="22%">
                     <col width="28%">
                     <col width="22%">
                     <col width="28%">
                  </colgroup>
                  <tbody id="tbody1">
                     <tr>
                        <th>공통코드</th>
                        <td>
                           <input type="text" name="grp_cd" id="grp_cd1" class="inputTxt" style="width: 90%" value="${grp_cd}" readonly="readonly" />
                        </td>
                        <td>
                           <input type="button" class="btn btn-primary btn-sm" name="selectGrp" id="sel_grp1" value="선택" 
                                  style="width: 90%; display: none; text-align: center;" onclick="fn_selGrpPop()" readonly="readonly"/> 
                        </td>
                        <td>
                        </td>
                     </tr>
                     <tr>
                        <th>상세코드</th>
                        <td>
                           <input type="text" name="code1" id="code1" class="inputTxt" style="width: 90%" value="${code1}" maxlength="4" readonly="readonly"/>
                        </td>
                        <th>상세코드명</th>
                        <td>
                           <input type="text" name="code_txt" id="code_txt" class="inputTxt" style="width: 90%" value="${code_txt}" maxlength="100"/>
                        </td>
                     </tr>
                     <tr>   
                        <th>상세코드<br>설명</th>
                        <td>
                           <input type="text" name="code_desc" id="code_desc" class="inputTxt" maxlength="500" style="width: 90%;" value="${code_desc}"/>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                     </tr>
                  </tbody>
               </table>
            </form>
            
            <!-- Button Div -->
            <div class="btn02">
               <div class="right">
                  <input type="button" id="codeDetail_add_btn" class="btn btn-primary btn-sm" value="추가" style="display: none" /> 
                  <input type="button" id="codeDetail_mdfy_btn" class="btn btn-primary btn-sm" value="편집" style="display: none" /> 
                  <input type="button" id="codeDetail_reset_btn" class="btn-default btn" value="취소" style="display: none" />
               </div>
            </div>
         </div>
         
         <!-- POPUP Div -->
         <div id="codePagingDiv1" class="paging_div">
            <div id="menuDetail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="menuDetail-tab" aria-hidden="true" data-backdrop="static" data-keyboard="true" >
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                       </div>
                    </div>
             </div>
         </div>
      </div>
      
      <jsp:include page="../code/code_pop.jsp"></jsp:include>
      
   <script type="text/javascript">
      
      $("#navisub11").show();
      $("#naviuser").css("font-weight", "bold");
      
      // grp_cd_sch grp_nm_sch
      $("#grp_cd_sch").keypress(function(){
         enterSearch(event, fn_codeSearch);
      });
      
      $("#grp_nm_sch").keypress(function(){
         enterSearch(event, fn_codeSearch);
      });
      
      //페이지 엔터시 이벤트
      $(document).on("keypress","#pageInput",function(){
         var keycode = (event.keyCode ? event.keyCode : event.which);
          if (keycode == '13') {
            pageInputRep(event, fn_codeSearch);
          }
      });
      
      // 코드 추가버튼을 눌렀을 시
      $("#code_add_btn").on("click", function(){
         // 숨겨놓은 각각의 버튼을 보여준다.
         var form1 = document.joinform1;
         var form2 = document.joinform2;
         
         $("#codeMaster_add_btn").show();
         $("#codeMaster_reset_btn").show();
         $("#codeDetail_add_btn").show();
         $("#codeDetail_mdfy_btn").hide();
         $("#codeDetail_reset_btn").show();
         $("#sel_grp").show();
         $("#sel_grp1").show();
         
         // 상세보기에 걸려 있는 readOnly false 
         form1.grp_cd.readOnly = false;
         form1.grp_nm.readOnly = false;
         form1.grp_desc.readOnly = false;
         
         form2.code1.readOnly = false;
         form2.code_txt.readOnly = false;
         form2.code_desc.readOnly = false;
         
         // 상세보기로 내용이 있을 경우 reset해준다.
         $("#joinform1").each(function(){
            this.reset();
         })
         
         $("#joinform2").each(function(){
            this.reset();
         })
      });
   
      // 코드 삭제버튼 클릭 시
      $("#code_del_btn").on("click", function(){
         
         if(confirm("선택한 상세코드를 삭제 하시겠습니까?")) {
            var check = document.getElementsByName("del_code");
            var check_len = check.length;
            var checked = 0;
            
            for(i=0; i<check_len; i++)
            {
               if(check[i].checked == true)
               {
                  $("#delAllForm").submit();
                  checked++;
                  
                  alert("선택한 정보를 삭제하였습니다.")
               }
            }
      
            if(checked == 0)
            {
               alert("체크박스를 선택해주세요.");
            }
         }
         else {
            return false;
         }
      });
      
      // 공통코드 상세보기 추가 버튼
      $("#codeMaster_add_btn").on("click", function(){
         if($("#grp_cd").val() == "" || $("#grp_cd").val() == null){
            alert("공통코드를 입력해주세요");
            document.joinform1.grp_cd.focus();
            
            return false;
         }
         else if($("#grp_nm").val() == "" || $("#grp_nm").val() == null){
            alert("공통코드명을 입력해주세요");
            document.joinform1.grp_nm.focus();
            
            return false;
         }
         else if($("#grp_desc").val() == "" || $("#grp_desc").val() == null)
         {
            alert("공통코드설명를 입력해주세요");
            document.joinform1.grp_desc.focus();
            
            return false;
         }
         else
         {
            if(confirm("공통코드를 등록 하시겠습니까?"))
            {
               $("#joinform1").submit();
               
               alert("공통코드가 등록 되었습니다.");
            }
            else
            {
               return false;
            }
            
         }
      });
      
      // 상세코드 상세보기 추가버튼 
      $("#codeDetail_add_btn").on("click", function(){
         if($("#grp_cd1").val() == "" || $("#grp_cd1").val() == null){
            alert("공통코드를 선택해주세요");
            document.joinform2.selectGrp.focus();
            
            return false;
         }
         if($("#code1").val() == "" || $("#code1").val() == null){
            alert("상세코드를 입력해주세요");
            document.joinform2.code1.focus();
            
            return false;
         }
         else if($("#code_txt").val() == "" || $("#code_txt").val() == null)
         {
            alert("상세코드명를 입력해주세요");
            document.joinform2.code_txt.focus();
            
            return false;
         }
         else if($("#code_desc").val() == "" || $("#code_desc").val() == null)
         {
            alert("상세코드설명를 입력해주세요");
            document.joinform2.code_desc.focus();
            
            return false;
         }
         else
         {
            if(confirm("상세코드를 등록 하시겠습니까?"))
            {
               $('form').attr("action", "codeDetailAdd");
               $("#joinform2").submit();
               
               alert("상세코드가 등록 되었습니다.");
            }
            else
            {
               return false;
            }
            
         }
      });
      
      // 상세코드 상세보기 수정버튼
      $("#codeDetail_mdfy_btn").on("click", function(){
         $("#code1").readOnly = true;
         
         if($("#code_txt").val() == "" || $("#code_txt").val() == null)
         {
            alert("상세코드명를 입력해주세요");
            document.joinform2.code_txt.focus();
            
            return false;
         }
         else if($("#code_desc").val() == "" || $("#code_desc").val() == null)
         {
            alert("상세코드설명를 입력해주세요");
            document.joinform2.code_desc.focus();
            
            return false;
         }
         else
         {   
            if(confirm("해당 상세코드를 수정하시겠습니까?"))
            {
               $('form').attr("action", "codeDetailMdfy"); 
               $("#joinform2").submit();
               
               alert("상세코드가 수정 되었습니다.");
            }
            else
            {
               return false;
            }
         }
      });
      
      // 상세코드 상세보기 취소버튼
      $("#codeDetail_reset_btn").on("click", function(){
          $("form").each(function() {  
                  this.reset();  
               });  
      });
      
      // 공통코드 상세보기 취소버튼
      $("#codeMaster_reset_btn").on("click", function(){
          $("form").each(function() {  
                  this.reset();  
               });  
      });
      
      // 문자열 Byte 계싼
      function lengthCheck(obj, maxlength)
      {
         var str = new String(obj.value);
         var byteCount = 0;
         
         if(obj.length != 0)
         {
            for(var i=0; i<obj.length; i++)
            {
               var str2 = obj.charAt(i);
               
               if(escape(str2).length > 4)
               {
                  byteCount += 2;
               }
               else
               {
                  byteCount += 1;
               }
            }
         }
         
         if(byteCount > maxlength)
         {
            alert("글자수를 초과하였습니다.");
            return false;
         }

      }
      
      // 검색 버튼 클릭시
      function fn_codeSearch(pageNum)
      {
         var grp_cd = $("#grp_cd_sch").val();
         var grp_nm = $("#grp_nm_sch").val();
         
         var tbody = $("#codeListTbody");
         var contents = "";
         var pageContent = "";
         
         $.ajax({
            url      : 'codeSearch_list2',
            type     : 'POST',
            dataType : 'json',
            data     : {
               "grp_cd_sch":grp_cd, "grp_nm_sch":grp_nm, "pageNum":pageNum
            },
            success  : function(data) {                  
               tbody.empty();
               var codeInqrList = data.codeInqrList;
                                    
               if(codeInqrList.lenght != 0)
               {
                  for(var i=0; i<codeInqrList.length; i++)
                  {
                     var grp_cd1 = codeInqrList[i].grp_cd;
                     var grp_nm1  = codeInqrList[i].grp_nm;
                     var code1   = codeInqrList[i].code1;
                     var code_txt = codeInqrList[i].code_txt;
                     
                     contents += "<tr class='open_detail' data_num='"+code1+"' >"
                     +"<td align='center' scope='row'>"
                     +"<input type='checkbox' name='del_code' id='del_code' value='"+code1+"'></td>"
                      +"<td align='center'>"+grp_cd1+"</td>"
                      +"<td>"+grp_nm1+"</td>"
                      +"<td align='center'>"+code1+"</td>"
                     +"<td>"+code_txt+"</td>"
                     +"</tr>";
                  }
               }
               
               tbody.append(contents);
               paging(data, "#codePagingDiv", "fn_codeSearch");
               
            }
         });
      }
         
      // 공통코드 선택하기 위한 팝업조회
      function fn_selGrpPop()
      {
         var tbody_general = $('#generalTbody');
         var contents = "";
         
         $.ajax({
            url     : 'searchGrpPop',
            type     : 'POST',
            dataType : 'json',
            success  : function(data){
               tbody_general.empty();
               var grpPop = data.grpPop;
               
               if(grpPop.lenght != 0)
               {
                  for(var i=0; i<grpPop.length; i++)
                  {
                     var grp_cd_pop = grpPop[i].grp_cd;
                     var grp_nm_pop = grpPop[i].grp_nm;
                     
                     contents +=
                        "<tr height='15px'>"+
                           "<td style='text-align: center;' onclick='pop_grpCode("+grp_cd_pop+")'>"+
                              grp_cd_pop+
                           "</td>"+
                           "<td style='width: 80%; text-align: left;'>"+
                              grp_nm_pop+
                           "</td>"+
                        "</tr>";
                  }
               }
               tbody_general.append(contents);
            }
         });
         $('.menuOpen').click();
      }
      
      // Main창에 상세코드 상세보기란에 있는 공통코드 부분에 값을 넣는다.
      function pop_grpCode(grpCode)
      {
         var tmp = grpCode;

         $("#grp_cd1").val("0"+grpCode);
         $("#codeMask, .codeWindow").hide();
      }
      
      // 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.)
      $(function(){
         $(document).on("click", ".open_detail", function() {   // ajax일 경우 이런 식으로 사용해야한다.
            code1 = $(this).attr("data_num");
            
            codeDetailInqr(code1);
         });
         
      });
      
      // 상세보기 (공통코드를 클릭 햇을 시 해당 정보를 하단에 띄어준다.)
      function codeDetailInqr(code1) 
      {            
         //$.getJSON("codeDetail_list/"+code1, function(data){   // 와 같이 써도 똑같다. (get이냐 post냐의 차이)
         $.post("codeDetail_list/"+code1, function(data){
            $(data).each(function() {
               var grp_cd = this.grp_cd;
               var grp_nm = this.grp_nm;
               var grp_desc = this.grp_desc;
               var code1  = this.code1;
               var code_txt  = this.code_txt;
               var code_desc = this.code_desc;
               
               $("#grp_cd").val(grp_cd);
               $("#grp_cd1").val(grp_cd);
               $("#grp_nm").val(grp_nm);
               $("#grp_desc").val(grp_desc);
               $("#code1").val(code1);
               $("#code_txt").val(code_txt);
               $("#code_desc").val(code_desc);
            });
            
         });
   
         // 수정을 하지 말아야 할 것들은 readOnly로 바꿔준다.
         $("#grp_cd").attr("readOnly", true);
         $("#grp_nm").attr("readOnly", true);
         $("#grp_desc").attr("readOnly", true);
         $("#code1").attr("readOnly", true);
         
         // 추가 버튼이 아닌 수정버튼이 보이도록 해준다.
         $("#codeDetail_add_btn").hide();
         $("#codeDetail_mdfy_btn").show();
         $("#codeDetail_reset_btn").show();
      }
         
         
      //AS-ID 엑셀 다운로드 적용 함수
      function download_list_Excel(formID){
         var ctx = $("#ctx").val();
         var form = $("#"+formID);
         var excel = $('<input type="hidden" value="true" name="excel">');
         
         if(confirm("리스트를 출력하시겠습니까? 대량의 경우 대기시간이 필요합니다."))
         {
            form.append(excel);
            form.submit();
         }
         
         $("input[name=excel]").val("");
      }
      
      
      // 검색 버튼 클릭시 - 기존
      $(function(){
         $("#search_fbtn1").click(function(){
            var grp_cd = $("#grp_nm_sch").val();
            //var url = "codeSearch_list/"+grp_cd;
            var url = "codeSearch_list2";
            var tbody = $("#codeListTbody");
            var contents = "";
            
            // getJSON은 get 방식으로 post는 post 방식으로 ajax를 사용한다. (getJSON = get)
            $.post(url, function(data){
               $(data).each(function() {   // each -> foreach
                  tbody.empty();         // tbody 부분을 비워주는 역할.
                  
                  contents += "<tr class='open_detail' data_num='"+this.code1+"' onmouseover='this.style.background=#c0c4cb' onmouseout='this.style.background=white'>"
                  +"<td align='center' scope='row'>"
                  +"<input type='checkbox' name='del_code' id='del_code' value='"+this.code1+"'></td>"
                   +"<td align='center'>"+this.grp_cd+"</td>"
                   +"<td>"+this.grp_nm+"</td>"
                   +"<td align='center'>"+this.code1+"</td>"
                  +"<td>"+this.code_txt+"</td>"
                  +"</tr>";
                  
                  tbody.append(contents);
               });
               
            });
         });
         
       });
   
   </script>
</div>
</body>
</html>

<%-- <%@include file="../include/footer.jsp"%> --%>