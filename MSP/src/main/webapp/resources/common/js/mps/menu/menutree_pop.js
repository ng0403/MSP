	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#menuTree_inqr_fbtn").click(function(){
			menuTreeListInqrPop;
		})		
		//검은 막을 눌렀을 때
		$('#menuTreeMask').click(function() {
			$(this).hide();
			$('#menuTreeWindow').hide();
		});
		//닫기 버튼을 눌렀을 때
		$('#menuTreeInpr_close_nfbtn').click(function(e) {
			$('.menu_tree_list_pop').html("");
			$('#menuTreeMask, #menuTreeWindow').hide();
		});
	})
	
	/*메뉴 리스트 출력및 페이징 처리 함수*/
	function menuTreeListInqrPop(){		
		viewLoadingShow();
		$.post("/menu/menuTreeInqr", function(data){
			$(".menu_list_pop").html("");
			$(data).each(function(){
 				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var menu_level = this.menu_level;
				var active_flg = this.active_flg;
				menuTreeListPopOutput(menu_cd, menu_nm, menu_url, menu_level, active_flg);
			})
		}).fail(function(){
			alert("메뉴 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
		viewLoadingHide();
	}
	/*메뉴 리스트 출력 함수*/
	function menuTreeListPopOutput(menu_cd, menu_nm, menu_url, menu_level, active_flg){
		
		var menuT_tr = $("<tr>");
		menuT_tr.addClass("open_menuTreeList");
		menuT_tr.attr("data_num",menu_cd);
		menuT_tr.attr("menu_url",menu_url);
		menuT_tr.attr("menu_level",menu_level);
		
		var menuT_nm_td = $("<td>");
		if(active_flg == "N"){
			if(menu_level == "ML01"){
				menuT_nm_td.html("<del>"+menu_nm+"</del>");
			}else if(menu_level == "ML02"){
				menuT_nm_td.html("&nbsp;&nbsp;&nbsp;&nbsp;<del>"+menu_nm+"</del>");
			}else if(menu_level == "ML03"){
				menuT_nm_td.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>"+menu_nm+"</del>");
			}else if(menu_level == "ML04"){
				menuT_nm_td.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>"+menu_nm+"</del>");
			}
		}else{
			if(menu_level == "ML01"){
				menuT_nm_td.html(menu_nm);
			}else if(menu_level == "ML02"){
				menuT_nm_td.html("&nbsp;&nbsp;&nbsp;&nbsp;" +menu_nm);
			}else if(menu_level == "ML03"){
				menuT_nm_td.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +menu_nm);
			}else if(menu_level == "ML04"){
				menuT_nm_td.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +menu_nm);
			}
		}
		menuT_tr.append(menuT_nm_td);
		
		$(".menu_tree_list_pop").append(menuT_tr);
	}
