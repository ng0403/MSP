$(function(){
	var ctx = $('#ctx').val();
	HomeDetailPop(ctx);
	atagfunc(ctx);
	contrResult(ctx);
	pipeLine(ctx);
});

function HomeDetailPop(ctx){
	
	$('#schedule_detail').click(function(event){
		location.href = ctx + '/sch';
		/*event.preventDefault();
		window.open(ctx+"/schedulelistpop",'newwindow','width=600, height=350, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		*//*window.open(ctx+'/authmenuSearchList','searchNewPopup','width=400, height=400, left='+(event.screenX+200)+', top='+(event.screenY-90)+', toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');*/
	});
	
	$('#notice_detail').click(function(event){
		location.href = ctx + '/notice';
		/*event.preventDefault();
		window.open(ctx+"/noticelistpop",'newwindow','width=600, height=350, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		*//*window.open(ctx+'/authmenuSearchList','searchNewPopup','width=400, height=400, left='+(event.screenX+200)+', top='+(event.screenY-90)+', toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');*/
	});
	
	$('#dboard_detail').click(function(event){
		location.href = ctx + '/dboard';
		/*event.preventDefault();
		window.open(ctx+"/dboardlistpop",'newwindow','width=600, height=350, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		*//*window.open(ctx+'/authmenuSearchList','searchNewPopup','width=400, height=400, left='+(event.screenX+200)+', top='+(event.screenY-90)+', toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');*/
	});
	
}

function contrResult(ctx){
	$('#estimResultBtn').click(function(event){
		event.preventDefault();
		window.open(ctx+"/contrResultpop",'newwindow','width=600, height=350, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');		
	});
}

function pipeLine(ctx){
	$('#pipeLineBtn').click(function(event){
		event.preventDefault();
		window.open(ctx+"/pipeLinePop",'newwindow','width=600, height=370, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');		
	});
}

function noticelistenToGoPage(ctx, noticeid){
	
	location.href=ctx+"/noticedetail?noticeId="+noticeid;
	
}

function dboardlistenToGoPage(ctx, dboardid){
	
	location.href=ctx+"/dboarddetail?dboardId="+dboardid;
	
}

function atagfunc(ctx){
	
	$('.noticetable').delegate('a', 'click', function(event){
		
		event.preventDefault();
		var hrefdata = $(this).attr("href");
		var notice =hrefdata.split("=");
		var noticeid = notice[1];
		
		$.ajax({
			
			url : ctx+'/noticeclickNum',				//보낼 URL
			dataType : 'text',						//응답 받을 데이터 형식
			type : 'POST',								//서버 요청 방식
			data :  noticeid,						//파라미터 { 'aaa' : 'bbb' }
			contentType : 'text/html; charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
			success : function(data){
				
				location.href=ctx+"/noticedetail?noticeId="+noticeid;
				
			}, error : function(){
				alert("실패");
			}
			
		});
		
	});
	
	$('.dboardtable').delegate('a', 'click', function(event){
		
		event.preventDefault();
		var hrefdata = $(this).attr("href");
		var dboard =hrefdata.split("=");
		var dboardid = dboard[1];
		
		$.ajax({
			
			url : ctx+'/dboardclickNum',				//보낼 URL
			dataType : 'text',						//응답 받을 데이터 형식
			type : 'POST',								//서버 요청 방식
			data :  dboardid,						//파라미터 { 'aaa' : 'bbb' }
			contentType : 'text/html; charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
			success : function(data){
				
				location.href=ctx+"/dboarddetail?dboardId="+dboardid;
				
			}, error : function(){
				alert("실패");
			}
			
		});
		
	});
	
}