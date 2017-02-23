	$(function(){
		/*검색버튼 클릭 시 처리 이벤트*/
		$("#dept_inqr_fbtn").click(function(){
			deptListInqrPop(1);
		})
		$("#dept_nm_key").keypress(function(){
			enterSearch(event, deptListInqrPop)
		})
		/*부서명 클릭 시 상세정보 출력 이벤트*/
		$(document).on("click", ".open_detail", function(){
			var dept_cd_pop = $(this).attr("dept_cd_pop");
			var dept_nm_pop = $(this).attr("dept_nm_pop");
			$('#dept_cd').val(dept_cd_pop);
			$('#Ddept_cd').val(dept_cd_pop);
			$('#dept_nm').val(dept_nm_pop);
			$('#Ddept_nm').val(dept_nm_pop);
			//deptDetailInqr(dept_cd);
			hideModal();
		})
		//페이지 엔터시 이벤트
		$(document).on("keypress","#paging_deptPop_div #pageInput",function(){
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				pageInputRep(event, deptListInqrPop);
			}
		})
	})
	/*부서 리스트 출력및 페이징 처리 함수*/
	function deptListInqrPop(pageNum){

		var dept_nm_key = $("#dept_nm_key").val();
		
		$.post("/dept/search_list_pop",{"dept_nm_key":dept_nm_key, "pageNum":pageNum}, function(data){
			$(".dept_list").html("");
			$(data.dept_list).each(function(){
 				var dept_cd = this.dept_cd;
				var dept_nm = this.dept_nm;
				var dept_num1 = this.dept_num1;
				var dept_num2 = this.dept_num2;
				var dept_num3 = this.dept_num3;
				var user_nm = this.user_nm;
				deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm);
			})
			paging(data,"#paging_deptPop_div", "deptListInqrPop");
		}).fail(function(){
			alert("부서 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
		})
	}
	/*부서 리스트 출력 함수*/
	function deptListOutput(dept_cd, dept_nm, dept_num1, dept_num2, dept_num3, user_nm){
		
		var dept_tr = $("<tr>");
		dept_tr.addClass("open_detail");
		dept_tr.attr("dept_cd_pop",dept_cd);
		dept_tr.attr("dept_nm_pop",dept_nm);
		
		
		var dept_nm_td = $("<td>");
		dept_nm_td.html(dept_nm);
		
		var dept_num_td = $("<td>");
		dept_num_td.html(dept_num1 + "-" + dept_num2 + "-" + dept_num3);
		
		var user_nm_td = $("<td>");
		user_nm_td.html(user_nm);
		
		dept_tr.append(dept_nm_td).append(dept_num_td).append(user_nm_td);
				
		$(".dept_list").append(dept_tr);
			
	}
