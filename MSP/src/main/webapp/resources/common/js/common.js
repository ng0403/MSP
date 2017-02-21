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
			+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\'pageInputRep(event,"+fMessage+");\'/>"  
			+"<a style='color: black; text-decoration: none;'> / "+endPageNum+"</a>"
			+"<a style='color:black; text-decoration: none;'>▶</a>"
		}
		else if(startPageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+data.pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px;' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\'pageInputRep(event,"+fMessage+");\'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else if(pageNum == 1)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+startPageNum+"' onkeypress=\'pageInputRep(event,"+fMessage+");\'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum+1)+") id='pNum'> ▶ </a>";
		}
		else if(pageNum == endPageNum)
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+endPageNum+"' onkeypress=\'pageInputRep(event,"+fMessage+");\'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+"("+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
			+"<a style='color:black; text-decoration: none;'>▶</a>";
		}
		else
		{
			pageContent ="<input type='hidden' id='pageNum' value='"+pageNum+"'/><input type='hidden' id='endPageNum' value='"+endPageNum+"'/>" 
			+"<a style='cursor: pointer;' onclick="+fMessage+""+(pageNum-1)+") id='pNum'> ◀ </a>"
			+"<input type='text' style='width: 50px; padding: 3px; ' id='pageInput' class='repPageInput' value='"+pageNum+"' onkeypress=\'pageInputRep(event,"+fMessage+");\'/>"
			+"<a style='cursor: pointer;' onclick="+fMessage+""+endPageNum+") id='pNum'> / "+endPageNum+"</a>" 
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