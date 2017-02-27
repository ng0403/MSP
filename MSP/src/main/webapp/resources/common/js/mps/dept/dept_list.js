	var dept_cd = "";
	var save_cd = "";
	
	$(function(){
		/* $(".dept_list").load(function(){
			deptListInqr(active_key, dept_nm_key);
		}) */
		
		/* 검색 후 검색 대상과 검색 단어 출력 */
		/* if("<c:out value='${data.active_key}'/>" != ""){
			$("#active_key").val("<c:out value='${data.active_key}'/>").attr("selected","selected");
		}
		if("<c:out value='${data.dept_nm_key}'/>" != ""){
			$("#dept_nm_key").val("<c:out value='${data.dept_nm_key}'/>");
		} */
		pageReady(true);
		
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#dept_inqr_fbtn").click(function(){
			deptListInqr(1);
		})
		$("#dept_nm_key").keypress(function(){
			enterSearch(event, deptListInqr);
		})
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			dept_cd = $(this).attr("data_num");
			deptDetailInqr(dept_cd);
		})
		/*추가버튼 클릭 시 처리 이벤트*/
		$("#dept_add_fbtn").click(function(){
			dataReset();
			pageReady(false);
			$("#dept_nm").focus();
			save_cd = "insert";
		})
		/*삭제버튼 클릭 시 처리 이벤트*/
		$("#dept_del_fbtn").click(function(){
			if (confirm("정보를 삭제 하시겠습니까?")) {
				deptDel();
			}
		})
		/*편집버튼 클릭 시 처리 이벤트*/
		$("#dept_edit_nfbtn").click(function(){
			pageReady(false);
			$("#dept_nm").focus();
			save_cd = "update";
		})
		/*초기화버튼 클릭 시 처리 이벤트*/
		$("#dept_reset_nfbtn").click(function(){
			dataReset();
			save_cd = "";
			pageReady(true);
		})
		/*저장버튼 클릭 시 처리 이벤트*/
		$("#dept_save_fbtn").click(function(){
			if(save_cd == "insert"){
				if (confirm("정보를 추가 하시겠습니까?")) {
					deptSave();
					pageReady(true);
				}
			}else if(save_cd == "update"){
				if (confirm("정보를 수정 하시겠습니까?")) {
					deptMdfy();
					pageReady(true);
				}
			}
		})
		
		//페이지 엔터시 이벤트
		$(document).on("keypress","#pageInput",function(){
			var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
				pageInputRep(event, deptListInqr);
    		}
		})
	})
	
	/*부서 리스트 출력및 페이징 처리 함수*/
	function deptListInqr(pageNum){
		/* $("#searchForm").attr({
			"method":"post",
			"action":"list"
		})
		$("#searchForm").submit(); */
		/*var active_key = $("#active_key").val();*/
		var dept_nm_key = $("#dept_nm_key").val();
		
		$.post("/dept/search_list",{/*"active_key":active_key,*/ "dept_nm_key":dept_nm_key, "pageNum":pageNum}, function(data){
			$(".dept_list").html("");
			$(data.dept_list).each(function(){
 				var dept_cd = this.dept_cd;
				var dept_nm = this.dept_nm;
				var dept_num1 = this.dept_num1;
				var dept_num2 = this.dept_num2;
				var dept_num3 = this.dept_num3;
				var user_nm = this.user_nm;
				var active_flg = this.active_flg;
				deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm, active_flg);
			})
			paging(data,"#paging_div", "deptListInqr");
		}).fail(function(){
			alert("부서 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*부서 상세정보 요청 함수*/
	function deptDetailInqr(dept_cd){
		$.post("/dept/detail_list/"+dept_cd, function(data){
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
			alert("부서 상세정보를 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*부서 입력 요청 함수*/
	function deptSave(){
		$.ajax({
			url:"/dept/insert",
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
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("부서 등록이 완료되었습니다.");
					dataReset();
					deptListInqr(1);
				}
			}
		})
	}
	/*부서 수정 요청 함수*/
	function deptMdfy(){
		$.ajax({
			url:"/dept/update",
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
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("부서 수정이 완료되었습니다.");
					dataReset();
					deptListInqr(1);
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
		
		var delCode = del_code.split(","); //맨끝 콤마 지우기
		
		if(delCode == ""){
			alert("삭제할 대상을 선택해 주세요");
			return false;
		}else{
			/* $("#delAll_form").attr({
				"method":"post",
				"action":"delete"
			});
			$("#delAll_form").submit(); */
			/* console.log(delCode);
			console.log(del_code); */
			$.ajax({
				url:"/dept/delete/"+del_code,
				type:"post",
				contentType:"application/json; charset=UTF-8",
				dataType:"text",
				//data:JSON.stringify({del_code : del_code}),
				error:function(){
					alert("시스템 오류 입니다. 관리자에게 문의하세요.");
				},
				success:function(resultData){
					if(resultData == "SUCCESS"){
						alert("부서 삭제가 완료되었습니다.");
						dataReset();
						deptListInqr(1);
					}
				}
			})
		}
	}
	/*부서 리스트 출력 함수*/
	function deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm, active_flg){
		
		var dept_tr = $("<tr>");
		dept_tr.addClass("open_detail");
		dept_tr.attr("data_num",dept_cd);
		
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + dept_cd + "'>");
		
		var dept_nm_td = $("<td>");
		dept_nm_td.html(dept_nm);
		
		var dept_num_td = $("<td>");
		dept_num_td.html(dept_num1 + "-" + dept_num2 + "-" + dept_num3);
		
		var user_nm_td = $("<td>");
		user_nm_td.html(user_nm);
		
		var active_flg_td = $("<td>");
		if(active_flg=='Y'){
			active_flg_td.html("활성화");
		}else if(active_flg=='N'){
			active_flg_td.html("비활성화");
		}
		
		dept_tr.append(del_code_td).append(dept_nm_td).append(dept_num_td).append(user_nm_td).append(active_flg_td);
				
		$(".dept_list").append(dept_tr);
			
	}
	
	/*부서 상세정보 출력 함수*/
	function detailOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, dept_fnum1, dept_fnum2, dept_fnum3, active_flg){
		dataReset();
		
		$("#dept_cd").val(dept_cd);
		$("#dept_nm").val(dept_nm);
		$("#dept_num1").val(dept_num1).prop("selected","selected");
		$("#dept_num2").val(dept_num2);
		$("#dept_num3").val(dept_num3);
		$("#dept_fnum1").val(dept_fnum1).prop("selected","selected");
		$("#dept_fnum2").val(dept_fnum2);
		$("#dept_fnum3").val(dept_fnum3);
		$(".active_flg:radio[value='"+active_flg+"']").prop("checked", "checked");
	}
	/*상세정보 초기화*/
	function dataReset(){
		$("#dept_cd").val("");
		$("#dept_nm").val("");
		$("#dept_num1").find("option:eq(0)").prop("selected","selected");
		$("#dept_num2").val("");
		$("#dept_num3").val("");
		$("#dept_fnum1").find("option:eq(0)").prop("selected","selected");
		$("#dept_fnum2").val("");
		$("#dept_fnum3").val("");
		$("input:radio[name='active_flg']").removeAttr("checked");
	}
	//페이지 처음 출력시 이벤트
	function pageReady(boolean){
		if(boolean == true){
			$("#dept_save_fbtn").hide();
			$("#dept_edit_nfbtn").show();
		}else if(boolean == false){
			$("#dept_save_fbtn").show();
			$("#dept_edit_nfbtn").hide();
		}
		$("#dept_cd").attr("readonly",true);
		$("#dept_nm").attr("readonly",boolean);
		$("#dept_num1").attr("disabled",boolean);
		$("#dept_num2").attr("readonly",boolean);
		$("#dept_num3").attr("readonly",boolean);
		$("#dept_fnum1").attr("disabled",boolean);
		$("#dept_fnum2").attr("readonly",boolean);
		$("#dept_fnum3").attr("readonly",boolean);
		$(".active_flg").attr("disabled",boolean);
	}