$(function(){
	/* 체크박스 전체선택, 전체해제 */
	$("#checkall").on("click", function(){
	      if( $("#checkall").is(':checked') ){
	        $("input[name=del_code]").prop("checked", true);
	      }else{
	        $("input[name=del_code]").prop("checked", false);
	      }
	})
})

// 검색 페이징 엔터키
    function pageInputRep(event, fMessage) {	
    	$(document).ready(function() {
    		var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
    			var pageNum = parseInt($("#pageInput").val());
    			if ($("#pageInput").val() == '') {
    				alert("Input page number.")
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else if(pageNum > parseInt($("#endPageNum").val())) {
    				alert("The page number is too large.");
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else if (1 > pageNum) {
    				alert("The page number is too small.");
    				$("#pageInput").val($("#pageNum").val());
    				$("#pageInput").focus();
    			} else {
    				fMessage(pageNum);
    			}
    		}
    		event.stopPropagation();
    	});
    }
	
  //검색 엔터키
    function enterSearch(event, fMessage) {		
    	var keycode = (event.keyCode ? event.keyCode : event.which);
    	if (keycode == '13') {
    		fMessage(1);
    	}
    	event.stopPropagation();
    }
    
    /*페이징 ajax()*/
    function paging(data, divMessage, fMessage){ 
    	$(divMessage).html("");
    	$(divMessage).empty();
		$(data).each(function(){
			var pageNum = this.pageNum;
 			var totalCount = this.page.totalCount;
			var pageSize = this.page.pageSize;
			var pageBlockSize = this.page.pageBlockSize;
			var startRow = this.page.startRow;
			var endRow = this.page.endRow;
			var startPageNum = this.page.startPageNum;
			var endPageNum = this.page.endPageNum;
			var currentPageNum = this.page.currentPageNum;
			var totalPageCount = this.page.totalPageCount;
			pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount, divMessage, fMessage);
		})
    }
    
    /*페이징 출력 함수*/
	function pageOutput(pageNum, totalCount, pageSize, pageBlockSize, startRow, endRow, startPageNum, endPageNum, currentPageNum, totalPageCount, divMessage, fMessage){
		if(endPageNum == 1)
		{
			pageContent = "<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px;' id='pageInput' class='inputTxt' value='"+startPageNum+"'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
			+"<a style='color:black; text-decoration: none;'>▶</a>"
		}
		else if(startPageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px;' id='pageInput' class='inputTxt' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px;' id='pageInput' class='inputTxt' value='"+startPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px;' id='pageInput' class='inputTxt' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px;' id='pageInput' class='inputTxt' value='"+pageNum+"'/>"
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum+1)+") id='pNum'> ▶ </a>";
		} 
		$(divMessage).append(pageContent);

	}
	
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
	//menuDetail image popup
	function popByMask(message1,message2) {
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$('#'+message1+'').css({
			'width' : maskWidth,
			'height' : maskHeight
		});

		//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
		$('#'+message1+'').fadeIn(1000);
		$('#'+message1+'').fadeTo("slow", 0.5);

		//윈도우 같은 거 띄운다.
		$('#'+message2+'').show();
	}
	function onlyNumber(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8|| keyID == 9|| keyID == 18 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	 /* 숫자만 입력받기 */
	function fn_press(event, type) {
		if(type == "numbers") {
			if(event.keyCode < 48 || event.keyCode > 57) return false;
			//onKeyDown일 경우 좌, 우, tab, backspace, delete키 허용 정의 필요
		}
	}
	 /* 한글입력 방지 */
	function fn_press_han(obj){
		//좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
		if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
				|| event.keyCode == 46 ) return;
		//obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
		obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	}
	