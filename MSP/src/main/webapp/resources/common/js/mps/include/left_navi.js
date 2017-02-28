$(function(){
		
	menuTreeListInqr();
	
	$(document).on("click",".treeview", function(){
		var menu_cd = $(this).attr("data_cd");
//		if($(".treeview").attr("data_up_cd")==menu_cd){
//			$(".treeview").attr("data_up_cd").show();
//		}
		$("li[data_up_cd="+menu_cd+"").show();
	})
	
})

/*메뉴 리스트 출력및 페이징 처리 함수*/
function menuTreeListInqr(){		
	//viewLoadingShow();
	$.post("/menu/menuTreeInqr", function(data){
		$(".sidebar-menu").html("");
		$(data).each(function(){
			//console.log(data);
 			var menu_cd = this.menu_cd;
			var menu_nm = this.menu_nm;
			var up_menu_cd = this.up_menu_cd;
			var menu_url = this.menu_url;
			var menu_level = this.menu_level;
			var active_flg = this.active_flg;

			menuTreeMainListOutput(menu_cd, menu_nm, up_menu_cd, menu_url, menu_level, active_flg);
			
		})
	}).fail(function(){
		alert("메뉴 목록을 불러오는데 실패하였습니다. 잠시 후에 다시 시도해 주세요.")
	})
	//viewLoadingHide();
}
/*메뉴 리스트 출력 함수*/
function menuTreeMainListOutput(menu_cd, menu_nm, up_menu_cd, menu_url, menu_level, active_flg){
	if(menu_url == null){
		menu_url = "";
	}
	
	if(active_flg == 'N'){
		return;
	}else{
		var menuT_li = $("<li>");
		var menuT_a = $("<a>");
		var menuT_nm_span = $("<span>");
		var menuT_sul = $("<ul>");
			
		menuT_li.addClass("treeview");
		menuT_li.attr("data_cd",menu_cd);
		menuT_li.attr("data_up_cd",up_menu_cd);
		menuT_li.attr("data_level",menu_level);
		//alert(menu_url);
		//menuT_a.attr("href", menu_url);
		menuT_a.attr("href", "#");
		menuT_a.attr("onClick", "changeContent('"+menu_url+"')");
		//menuT_a.attr("onClick", "changeContent('/menu/menuInqr')");
			
		menuT_nm_span.attr("style","color:#ECF0F5;");
		
		if(menu_level == "ML01"){
			menuT_nm_span.html(menu_nm);
		}else if(menu_level == "ML02"){
			menuT_nm_span.html("&nbsp;&nbsp;&nbsp;"+menu_nm);
			menuT_li.hide();
		}else if(menu_level == "ML03"){
			menuT_nm_span.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+menu_nm);
			menuT_li.hide();
		}else if(menu_level == "ML04"){
			menuT_nm_span.html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+menu_nm);
			menuT_li.hide();
		}
			
		menuT_a.append(menuT_nm_span);
		
		menuT_li.append(menuT_a);
		
		$(".sidebar-menu").append(menuT_li);		
	}
}

function changeContent(url){
	//alert(url);
	if(url != ""){
		alert(url);
		//$("#main_center1").children().remove().load(url);
		$("#main_center1").children().remove().load(url);
	}
	// 동적 폼생성 POST 전송
	/*var $form = $('<form></form>');
     $form.attr('action', url);
     $form.attr('method', 'post');
     $form.appendTo('body');
     $form.submit();*/
}
