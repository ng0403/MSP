var save_cd = "";

$(function(){
	/*검색버튼 클릭 시 처리 이벤트*/
	$("#auth_inqr_fbtn").click(function(){
		authListInqrPop(1);
	})
	
	/*검색창 엔터 시 처리 이벤트*/
	$("#keyword_pop").keypress(function(){
		enterSearch(event, authListInqrPop);
	})
	
	//검은 막을 눌렀을 때
	$('#authMask').click(function() {
		$(this).hide();
		$('#authWindow').hide();
	});
	/*권한명 클릭 시 상세정보 출력 이벤트*/
	$(document).on("click", ".open_authList", function(){
		if(save_cd == "insert"||save_cd == "update"){
			var auth_id = $(this).attr("data_num");
			var auth_nm = $(this).children("td").eq(1).html();
			$('#auth_id').val(auth_id);
			$('#auth_nm').val(auth_nm);
			$('.auth_list_pop, #paging_authPop_div').html("");
			$('#authMask, #authWindow').hide();
		}
	})
	//닫기 버튼을 눌렀을 때
	$('#authInpr_close_nfbtn').click(function(e) {
		$('.auth_list_pop, #paging_authPop_div').html("");
		$('#authMask, #authWindow').hide();
	});
	//페이지 엔터시 이벤트
	$(document).on("keypress","#paging_authPop_div #pageInput",function(){
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			pageInputRep(event, authListInqrPop);
		}
	})
})
	
	/*리스트 출력및 페이징 처리 함수*/
	function authListInqrPop(pageNum){
		var keyword    = $("#keyword_pop").val();
		viewLoadingShow();
		$.post("/auth/search_list_pop",{"keyword":keyword, "pageNum":pageNum}, function(data){
			$(".auth_list_pop").html("");
			$(data.auth_list).each(function(){
 				var auth_id = this.auth_id;
				var auth_nm = this.auth_nm;
				authListPopOutput(auth_id, auth_nm);
			})
			paging(data,"#paging_authPop_div", "authListInqrPop");
		}).fail(function(){
			alert("목록을 불러오는데 실패하였습니다.")
		})
		viewLoadingHide();
	}
		
	/* 리스트 출력 함수 */
	function authListPopOutput(auth_id, auth_nm){
	
		var auth_tr = $("<tr>");
		auth_tr.addClass("open_authList");
		auth_tr.attr("data_num",auth_id);

		var auth_id_td = $("<td>");
		auth_id_td.html(auth_id);
		
		var auth_nm_td = $("<td>");
		auth_nm_td.html(auth_nm);
				
		auth_tr.append(auth_id_td).append(auth_nm_td);
				
		$(".auth_list_pop").append(auth_tr);
			
	}