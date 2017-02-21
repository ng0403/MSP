	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#menuInqr_pop_fbtn").click(function(){
			menuListInqrPop(1);
		})
		/*검색창 엔터 시 처리 이벤트*/
		$("#menu_nm_key_pop").keypress(function(){
			enterSearch(event, menuListInqrPop);
		})		
		//검은 막을 눌렀을 때
		$('#menuMask').click(function() {
			$(this).hide();
			$('#menuWindow').hide();
		});
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_menuList", function(){
			if(save_cd == "insert" || save_cd == "update"){
				var menu_cd = $(this).attr("data_num");
				var menu_nm = $(this).children("td").eq(0).html();
				$('#up_menu_cd').val(menu_cd);
				$('#up_menu_nm').val(menu_nm);
				$('.menu_list_pop, #paging_menuPop_div').html("");
				$('#menuMask, #menuWindow').hide();
			}
		})
		//닫기 버튼을 눌렀을 때
		$('#menuInpr_close_nfbtn').click(function(e) {
			$('.menu_list_pop, #paging_menuPop_div').html("");
			$('#menuMask, #menuWindow').hide();
		});
		//페이지 엔터시 이벤트
		$(document).on("keypress","#paging_menuPop_div #pageInput",function(){
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				pageInputRep(event, menuListInqrPop);
			}
		})
	})
	
	/*메뉴 리스트 출력및 페이징 처리 함수*/
	function menuListInqrPop(pageNum){
		var menu_nm_key = $("#menu_nm_key_pop").val();
		
		viewLoadingShow();
		$.post("/menu/search_list_pop",{"menu_nm_key":menu_nm_key, "pageNum":pageNum}, function(data){
			$(".menu_list_pop").html("");
			$(data.menu_list).each(function(){
 				var menu_cd = this.menu_cd;
				var menu_nm = this.menu_nm;
				var menu_url = this.menu_url;
				var up_menu_nm = this.up_menu_nm;
				menuListPopOutput(menu_cd, menu_nm, menu_url, up_menu_nm);
			})
			paging(data,"#paging_menuPop_div", "menuListInqrPop");
		}).fail(function(){
			alert("메뉴 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
		viewLoadingHide();
	}
	/*메뉴 리스트 출력 함수*/
	function menuListPopOutput(menu_cd, menu_nm, menu_url, up_menu_nm){
		
		var menu_tr = $("<tr>");
		menu_tr.addClass("open_menuList");
		menu_tr.attr("data_num",menu_cd);
		
		var menu_nm_td = $("<td>");
		menu_nm_td.html(menu_nm);
		
		var up_menu_nm_td = $("<td>");
		up_menu_nm_td.html(up_menu_nm);
		
		var menu_url_td = $("<td>");
		menu_url_td.html(menu_url);
		
		menu_tr.append(menu_nm_td).append(up_menu_nm_td).append(menu_url_td);
		
		$(".menu_list_pop").append(menu_tr);
	}
