<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath }" />
<script src="${ctx}/resources/common/js/jquery-1.11.1.js"></script>
<title>부서관리화면</title>
</head>
<script type="text/javascript">
	var dept_cd = "";
	var save_cd = "";
	
	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#dept_inqr_fbtn").click(function(){
			deptListInqr();
		})
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(".open_detail").click(function(){
			dept_cd = $(this).parents("tr").attr("data_num");
			deptDetailInqr(dept_cd);
		})
		/*추가버튼 클릭 시 처리 이벤트*/
		$("#dept_add_fbtn").click(function(){
			dataReset();
			$("#dept_nm").focus();
			save_cd = "insert";
		})
		/*삭제버튼 클릭 시 처리 이벤트*/
		$("#dept_del_fbtn").click(function(){
			deptDel();
		})
		/*편집버튼 클릭 시 처리 이벤트*/
		$("#dept_edit_nfbtn").click(function(){
			$("#dept_nm").focus();
			save_cd = "update";
		})
		/*초기화버튼 클릭 시 처리 이벤트*/
		$("#dept_reset_nfbtn").click(function(){
			dataReset();
			save_cd = "";
		})
		/*저장버튼 클릭 시 처리 이벤트*/
		$("#dept_save_fbtn").click(function(){
			if(save_cd == "insert"){
				deptSave();
			}else if(save_cd == "update"){
				deptMdfy();
			}
		})
		/* 체크박스 전체선택, 전체해제 */
		$("#allCheck").on("click", function(){
		      if( $("#allCheck").is(':checked') ){
		        $("input[name=del_code]").prop("checked", true);
		      }else{
		        $("input[name=del_code]").prop("checked", false);
		      }
		})
	})
	/*부서 리스트 출력및 페이징 처리 함수*/
	function deptListInqr(){
		$("#searchForm").attr({
			"method":"post",
			"action":"list"
		})
		$("#searchForm").submit();
	}
	/*부서 상세정보 요청 함수*/
	function deptDetailInqr(dept_cd){
		$.getJSON("detail_list/"+dept_cd, function(data){
			$(data).each(function(){
				var dept_cd = this.dept_cd;
				var dept_nm = this.dept_nm;
				var dept_num1 = this.dept_num1;
				var dept_num2 = this.dept_num2;
				var dept_num3 = this.dept_num3;
				var dept_fnum1 = this.dept_fnum1;
				var dept_fnum2 = this.dept_fnum2;
				var dept_fnum3 = this.dept_fnum3;
				var active_flg = this.active_flg;
				detailOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, dept_fnum1, dept_fnum2, dept_fnum3, active_flg);
			})
		}).fail(function(){
			warning("부서 상세정보를 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*부서 입력 요청 함수*/
	function deptSave(){
		$.ajax({
			url:"insert",
			type:"post",
			contentType:"application/json; charset=UTF-8",/* "X-HTTP-Method-Override":"POST" */
			dataType:"text",
			data:JSON.stringify({
				dept_nm:$("#dept_nm").val(),
				dept_num1:$("#dept_num1 option:selected").val(),
				dept_num2:$("#dept_num2").val(),
				dept_num3:$("#dept_num3").val(),
				dept_fnum1:$("#dept_fnum1 option:selected").val(),
				dept_fnum2:$("#dept_fnum2").val(),
				dept_fnum3:$("#dept_fnum3").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				warning("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					warning("부서 등록이 완료되었습니다.");
					dataReset();
					deptListInqr();
				}
			}
		})
	}
	/*부서 수정 요청 함수*/
	function deptMdfy(){
		$.ajax({
			url:"update",
			type:"post",
			/* header:{
				"Content-type":"application/json","X-HTTP-Method-Override":"POST"
			}, */
			contentType:"application/json; charset=UTF-8",
			dataType:"text",
			data:JSON.stringify({
				dept_cd:$("#dept_cd").val(),
				dept_nm:$("#dept_nm").val(),
				dept_num1:$("#dept_num1 option:selected").val(),
				dept_num2:$("#dept_num2").val(),
				dept_num3:$("#dept_num3").val(),
				dept_fnum1:$("#dept_fnum1 option:selected").val(),
				dept_fnum2:$("#dept_fnum2").val(),
				dept_fnum3:$("#dept_fnum3").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				warning("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					warning("부서 수정이 완료되었습니다.");
					dataReset();
					deptListInqr();
				}
			}
		})
	}
	/*부서 삭제 요청 함수*/
	function deptDel(){
		var del_code = "";
		$( "input[name='del_code']:checked" ).each (function (){
			  del_code = del_code + $(this).val()+"," ;
		});
		
		del_code = del_code.split(","); //맨끝 콤마 지우기
		
		if(del_code == ""){
			alert("삭제할 대상을 선택해 주세요");
			return false;
		}else{
			$("delAll_form").attr({
				"method":"post",
				"action":"delete"
			});
			$("delAll_form").submit();
		}
	}
	/*부서 상세정보 출력 함수*/
	function detailOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, dept_fnum1, dept_fnum2, dept_fnum3, active_flg){
		dataReset();
		
		$("#dept_cd").val(dept_cd);
		$("#dept_nm").val(dept_nm);
		$("#dept_num1").val(dept_num1).attr("selected","selected");
		$("#dept_num2").val(dept_num2);
		$("#dept_num3").val(dept_num3);
		$("#dept_fnum1").val(dept_fnum1).attr("selected","selected");
		$("#dept_fnum2").val(dept_fnum2);
		$("#dept_fnum3").val(dept_fnum3);
		$(".active_flg:radio[value='"+active_flg+"']").attr("checked", true);
	}
	/*상세정보 초기화*/
	function dataReset(){
		$("#dept_cd").val("");
		$("#dept_nm").val("");
		$("#dept_num1").index(0);
		$("#dept_num2").val("");
		$("#dept_num3").val("");
		$("#dept_fnum1").index(0);
		$("#dept_fnum2").val("");
		$("#dept_fnum3").val("");
		$(".active_flg:radio[value='Y']").attr("checked", true);
	}
	/*경고창 출력함수*/
	function warning(str){
		alert(str);
	}
	
</script>
<body>
	<div class="main_div">
		<div class="navi_div">
			사용자 > 부서관리
		</div>
		<div class="search_div">
			<div class="search2_div">
				<form id="searchForm" name="searchForm">
					<input type="text" id="keyword" name="keyword"> &nbsp;
					<input type="button" id="dept_inqr_fbtn" class="search_btn" value="검색">
				</form>
			</div>
		</div>
		<div class="list_div">
			<div class="list2_div">
				<form id="delAll_form" name="delAll_form">
					<table summary="dept_list">
						<colgroup>
							<col width="10%">
							<col width="35%">
							<col width="20%">
							<col width="15%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="allCheck"></th>
								<td>부서명</td>
								<td>연락처</td>
								<td>대표자명</td>
								<td>활성화여부</td>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty dept_list}">
									<c:forEach var="dept_list" items="${dept_list}">
										<tr data_num="${dept_list.dept_cd}">
											<td>
												<input type="checkbox" class="del_point" name="del_code" value="${dept_list.dept_cd}">
											</td>
											<td>
												<span class="open_detail">${dept_list.dept_nm}</span>
											</td>
											<td>${dept_list.dept_num1}-${dept_list.dept_num2}-${dept_list.dept_num3}</td>
											<td>${dept_list.dept_leader}</td>
											<td>
												<c:if test="${dept_list.active_flg eq 'Y'}">활성화</c:if>
												<c:if test="${dept_list.active_flg eq 'N'}">비활성화</c:if>
											</td>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">등록된 부서가 존재하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</form>
			</div>
			<div class="paging2_div">
				<input type="button" id="dept_add_fbtn" class="func_btn" value="추가">
				<input type="button" id="dept_del_fbtn" class="func_btn" value="삭제">
				<input type="button" id="dept_exIm_fbtn" class="func_btn" value="excelImport">
				<input type="button" id="dept_exEx_fbtn" class="func_btn" value="excelExport">
			</div>
			<div id="dept_detail_div">
				<form id="dept_detail_form" name="dept_detail_form">
					<table summary="dept_detail">
						<colgroup>
							<col width="35%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<td class="dc">부서코드</td>
								<td>
									<input type="text" id="dept_cd" name="dept_cd" value="${dept_detail.dept_cd}">
								</td>
							</tr>
							<tr>
								<td class="dc">부서명</td>
								<td>
									<input type="text" id="dept_nm" name="dept_nm" value="${dept_detail.dept_nm}">
								</td>
							</tr>
							<tr>
								<td class="dc">부서전화</td>
								<td>
									<select id="dept_num1" name="dept_num1">
										<option value="02"<%-- <c:if test="${dept_detail.dept_num1 eq '02'}">selected="selected"</c:if> --%>>02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
									</select>
									<label>-</label>
									<input type="text" id="dept_num2" name="dept_num2" value="${dept_detail.dept_num2}">
									<label>-</label>
									<input type="text" id="dept_num3" name="dept_num3" value="${dept_detail.dept_num3}">
								</td>
							</tr>
							<tr>
								<td class="dc">팩스번호</td>
								<td>
									<select id="dept_fnum1" name="dept_fnum1">
										<option value="02"<%-- <c:if test="${dept_detail.dept_num1 eq '02'}">selected="selected"</c:if> --%>>02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
									</select>
									<label>-</label>
									<input type="text" id="dept_fnum2" name="dept_fnum2" value="${dept_detail.dept_fnum2}">
									<label>-</label>
									<input type="text" id="dept_fnum3" name="dept_fnum3" value="${dept_detail.dept_fnum3}">
								</td>
							</tr>
							<tr>
								<td class="dc">활성화여부</td>
								<td>
									<input type="radio" class="active_flg" name="active_flg" value="Y"/>Y
									<input type="radio" class="active_flg" name="active_flg" value="N"/>N
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_div">
						<input type="button" id="dept_save_fbtn" class="func_btn" value="저장">
						<input type="button" id="dept_edit_nfbtn" class="nonfunc_btn" value="편집">
						<input type="button" id="dept_reset_nfbtn" class="nonfunc_btn" value="초기화">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>