	var menu_cd = "";
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
		//팝업찬 숨기기
		//$('#menuMask, #menuWindow').hide();
		
		/*테스트 입력제어*/
		pageReady(true);
		
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#menu_inqr_fbtn").click(function(){
			menuListInqr(1);
		})
		$("#menu_nm_key").keypress(function(){
			enterSearch(event, menuListInqr);
		})
		
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			menu_cd = $(this).attr("data_num");
			menuDetailInqr(menu_cd);
		})
		/*추가버튼 클릭 시 처리 이벤트*/
		$("#menu_add_nfbtn").click(function(){
			dataReset();
			pageReady(false);
			$("#menu_nm").focus();
			save_cd = "insert";
		})
		/*삭제버튼 클릭 시 처리 이벤트*/
		$("#menu_del_fbtn").click(function(){
			if (confirm("정보를 삭제 하시겠습니까?")) {
				menuDel();
			}
		})
		/*편집버튼 클릭 시 처리 이벤트*/
		$("#menu_edit_nfbtn").click(function(){
			pageReady(false);
			$("#menu_nm").focus();
			save_cd = "update";
		})
		/*초기화버튼 클릭 시 처리 이벤트*/
		$("#menu_reset_nfbtn").click(function(){
			dataReset();
			save_cd = "";
			pageReady(true);
		})
		/*저장버튼 클릭 시 처리 이벤트*/
		$("#menu_save_fbtn").click(function(){
			if(save_cd == "insert"){
				if (confirm("정보를 추가 하시겠습니까?")) {
					menuSave();
					pageReady(true);
				}
			}else if(save_cd == "update"){
				if (confirm("정보를 수정 하시겠습니까?")) {
					menuMdfy();
					pageReady(true);
				}
			}
		})
		
		//메뉴검색 버튼 클릭시 이벤트
		$("#menuInqr_popup_fbtn").click(function(){
			menuListInqrPop(1);
			popByMask("menuMask", "menuWindow");
		})
		//페이지 엔터시 이벤트
		$(document).on("keypress","#pageInput",function(){
			var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
				pageInputRep(event, menuListInqr);
    		}
		})
		
	})
	
	/*메뉴 리스트 출력및 페이징 처리 함수*/
	function menuListInqr(pageNum){
		/* $("#searchForm").attr({
			"method":"post",
			"action":"list"
		})
		$("#searchForm").submit(); */
		var active_key = $("#active_key").val();
		var menu_nm_key = $("#menu_nm_key").val();
		
		$.post("/menu/search_list",{"active_key":active_key, "menu_nm_key":menu_nm_key, "pageNum":pageNum}, function(data){
			$(".menu_list").html("");
			$(data.menu_list).each(function(){
 				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var up_menu_nm = this.up_menu_nm;
				var active_flg = this.active_flg;
				menuListOutput(menu_cd, menu_nm, menu_url, up_menu_nm, active_flg);
			})
			paging(data,"#paging_div", "menuListInqr");
		}).fail(function(){
			alert("메뉴 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*메뉴 상세정보 요청 함수*/
	function menuDetailInqr(menu_cd){
		$.post("/menu/detail_list/"+menu_cd, function(data){
			$(data).each(function(){
				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var menu_level = this.menu_level;
				var up_menu_cd = this.up_menu_cd;
				var up_menu_nm = this.up_menu_nm;
				var active_flg = this.active_flg;
				detailOutput(menu_cd, menu_nm, menu_url, menu_level, up_menu_cd, up_menu_nm, active_flg);
			})
		}).fail(function(){
			alert("메뉴 상세정보를 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*메뉴 입력 요청 함수*/
	function menuSave(){
		$.ajax({
			url:"/menu/insert",
			type:"post",
			contentType:"application/json; charset=UTF-8",/* "X-HTTP-Method-Override":"POST" */
			dataType:"text",
			data:JSON.stringify({
				menu_nm:$("#menu_nm").val(),
				menu_url:$("#menu_url").val(),
				menu_level:$("#menu_level").val(),
				up_menu_cd:$("#up_menu_cd").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("메뉴 등록이 완료되었습니다.");
					dataReset();
					menuListInqr(1);
				}
			}
		})
	}
	/*메뉴 수정 요청 함수*/
	function menuMdfy(){
		$.ajax({
			url:"/menu/update",
			type:"post",
			/* header:{
				"Content-type":"application/json","X-HTTP-Method-Override":"POST"
			}, */
			contentType:"application/json; charset=UTF-8",
			dataType:"text",
			data:JSON.stringify({
				menu_cd:$("#menu_cd").val(),
				menu_nm:$("#menu_nm").val(),
				menu_url:$("#menu_url").val(),
				menu_level:$("#menu_level").val(),
				up_menu_cd:$("#up_menu_cd").val(),
				active_flg:$(".active_flg:checked").val()
			}),
			error:function(){
				alert("시스템 오류 입니다. 관리자에게 문의하세요.");
			},
			success:function(resultData){
				if(resultData == "SUCCESS"){
					alert("메뉴 수정이 완료되었습니다.");
					dataReset();
					menuListInqr(1);
				}
			}
		})
	}
	/*메뉴 삭제 요청 함수*/
	function menuDel(){
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
				url:"/menu/delete/"+del_code,
				type:"post",
				contentType:"application/json; charset=UTF-8",
				dataType:"text",
				//data:JSON.stringify({del_code : del_code}),
				error:function(){
					alert("시스템 오류 입니다. 관리자에게 문의하세요.");
				},
				success:function(resultData){
					if(resultData == "SUCCESS"){
						alert("메뉴 삭제가 완료되었습니다.");
						dataReset();
						menuListInqr(1);
					}
				}
			})
		}
	}
	/*메뉴 리스트 출력 함수*/
	function menuListOutput(menu_cd, menu_nm, menu_url, up_menu_nm, active_flg){
		
		var menu_tr = $("<tr>");
		menu_tr.addClass("open_detail");
		menu_tr.attr("data_num",menu_cd);
		
		var del_code_td = $("<td>");
		del_code_td.html("<input type='checkbox' class='del_point' name='del_code' value='" + menu_cd + "'>");
		
		var menu_nm_td = $("<td>");
		menu_nm_td.html(menu_nm);
		
		var up_menu_nm_td = $("<td>");
		up_menu_nm_td.html(up_menu_nm);
		
		var menu_url_td = $("<td>");
		menu_url_td.html(menu_url);
		
		var active_flg_td = $("<td>");
		if(active_flg=='Y'){
			active_flg_td.html("활성화");
		}else if(active_flg=='N'){
			active_flg_td.html("비활성화");
		}
		
		menu_tr.append(del_code_td).append(menu_nm_td).append(up_menu_nm_td).append(menu_url_td).append(active_flg_td);
				
		$(".menu_list").append(menu_tr);
			
	}
	
	/*메뉴 상세정보 출력 함수*/
	function detailOutput(menu_cd, menu_nm, menu_url, menu_level, up_menu_cd, up_menu_nm, active_flg){
		dataReset();
		
		$("#menu_cd").val(menu_cd);
		$("#menu_nm").val(menu_nm);
		$("#menu_url").val(menu_url);
		$("#menu_level").val(menu_level).prop("selected","selected");
		$("#up_menu_cd").val(up_menu_cd);
		$("#up_menu_nm").val(up_menu_nm);
		$(".active_flg:radio[value='"+active_flg+"']").prop("checked", "checked");
	}
	/*상세정보 초기화*/
	function dataReset(){
		$("#menu_cd").val("");
		$("#menu_nm").val("");
		$("#menu_url").val("");
		$("#menu_level").find("option:eq(0)").prop("selected","selected");
		$("#up_menu_cd").val("");
		$("#up_menu_nm").val("");
		$("input:radio[name='active_flg']").removeAttr("checked");
		save_cd = "";
	}
	//페이지 처음 출력시 이벤트
	function pageReady(boolean){
		if(boolean == true){
			$("#menu_save_fbtn").hide();
			$("#menu_edit_nfbtn").show();
		}else if(boolean == false){
			$("#menu_save_fbtn").show();
			$("#menu_edit_nfbtn").hide();
		}
		$("#menu_cd").attr("readonly",true);
		$("#menu_nm").attr("readonly",boolean);
		$("#menu_url").attr("readonly",boolean);
		$("#menu_level").attr("disabled",boolean);
		$("#up_menu_cd").attr("readonly",true);
		$("#up_menu_nm").attr("readonly",true);
		$(".active_flg").attr("disabled",boolean);
	}
