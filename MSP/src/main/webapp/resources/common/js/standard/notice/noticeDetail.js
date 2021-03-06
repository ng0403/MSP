$(function() {
	var ctx = $('#ctx').val();
	noticebtnfunc(ctx);

});

function noticebtnfunc(ctx){
	
	$('#addnoticebtn').click(function(){	
		
		var noticeData = {
				
				code : $('.selectorgcode').val(),
				notice_id : $('#hiddenId').val(),
				title : $('#notice_title').text(),
				cont : $('#notice_cont').text(),
				strd : $('#strd_d').val(),
				end : $('#end_d').val()
		}
		
		var modifyconfirm = window.confirm("수정 하시겠습니까?");
		
		if(modifyconfirm == false){
			return false;
		}
		
		var jsonData = JSON.stringify(noticeData);
		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			
			url : ctx+'/noticeModify',				//보낼 URL
			dataType : 'json',						//응답 받을 데이터 형식
			type : 'POST',								//서버 요청 방식
			data :  jsonData,						//파라미터 { 'aaa' : 'bbb' }
			contentType : 'application/json; charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
			success : function(data){
				alert("수정 되었습니다.");
				location.href=ctx+"/notice";
			}, error : function(e){
				alert(e.responseText);
			}
			
		});
		
	});
	
	$('#btndiv').delegate('#modifynoticebtn', 'click', function(){
		
		$('#addnoticebtn').attr("disabled", false);
		$('#notice_cont').attr("contenteditable", "true");
		$('#notice_title').attr("contenteditable", "true");
		$('#modifynoticebtn').attr("disabled", true);
		
		$('#modifynoticebtn').removeClass('btn');
		$('#modifynoticebtn').removeClass('btn-default');
		$('#modifynoticebtn').addClass('wbtn');
		$('#addnoticebtn').removeClass('wbtn');
		$('#addnoticebtn').addClass('btn');
		$('#addnoticebtn').addClass('btn-default');
		
		var strd = $('#strd_div').text();
		var end = $('#end_div').text();
		
		$('#strd_d').attr("readonly",false);
		$('#end_d').attr("readonly",false);
		
/*		$('#strd_div').append("<input type='text' class='dateinput' name='strd_d' id='strd_d' value='"+strd+"'>");
		$('#end_div').append("<input type='text' class='dateinput' name='end_d' id='end_d' value='"+end+"'>");*/
		
		startCalendar(ctx);
		endCalendar(ctx);
		
		$.ajax({
			
			url : ctx+'/noticecode',				//보낼 URL
			dataType : 'json',						//응답 받을 데이터 형식
			type : 'POST',								//서버 요청 방식
			contentType : 'application/json; charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
			success : function(data){
				
				$('#org_nm').text("");
				var orgcode = "<select id='selectorgcode' class='selectorgcode'>";
				var orgId = $('#org_nm').parent().find("input[type='hidden']").val();
				
				for(var i=0; i<data.length; i++){
					
					if(data[i].ORG_ID==orgId){
						orgcode += "<option value='"+data[i].ORG_ID+"' selected='selected'>"+data[i].ORG_NM+"</option>";
					}else{
						orgcode += "<option value='"+data[i].ORG_ID+"'>"+data[i].ORG_NM+"</option>";
					}
					
				}
				
				orgcode += "</select>";
				$('#org_nm').append(orgcode);
				
			}, error : function(){
				alert("실패");
			}
			
		});
		
		$('#org_nm').append("")
		
	});
	
	$('#listnoticebtn').click(function(){
		
		location.href=ctx+"/notice";
		
	});
	
	$('#deletenoticebtn').click(function(){
		
		var delYN= window.confirm("게시물을 삭제 하시겠습니까?");
		
		if(delYN==false){
			return false;
		}
		
		var notice_id = $('#hiddenId').val();
		location.href=ctx+"/noticedelete?noticeId="+notice_id;
		
	});
	
}

function startCalendar(ctx){
	$("#strd_d").datepicker({
	     changeMonth: true, //콤보 박스에 월 보이기
	     changeYear: true, // 콤보 박스에 년도 보이기
	     showOn: 'button', // 우측에 달력 icon 을 보인다.
	     buttonImage: ctx+'/resources/image/calendar.jpg',  // 우측 달력 icon 의 이미지 경로
	     buttonImageOnly: true //달력에 icon 사용하기
	 }); 
	  //마우스를 손가락 손가락 모양으로 하고 여백주기
	 $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px', 'margin-bottom':'-6px'});
	//날짜 형식을 0000-00-00으로 지정하기
	 $.datepicker.setDefaults({dateFormat:'yyyy-MM-dd'});
	 $('.ui-datepicker select.ui-datepicker-year').css('background-color', '#8C8C8C');
}

function endCalendar(ctx){
	$("#end_d").datepicker({
	     changeMonth: true, //콤보 박스에 월 보이기
	     changeYear: true, // 콤보 박스에 년도 보이기
	     showOn: 'button', // 우측에 달력 icon 을 보인다.
	     buttonImage: ctx+'/resources/image/calendar.jpg',  // 우측 달력 icon 의 이미지 경로
	     buttonImageOnly: true //달력에 icon 사용하기
	 }); 
	  //마우스를 손가락 손가락 모양으로 하고 여백주기
	 $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px', 'margin-bottom':'-6px'});
	//날짜 형식을 0000-00-00으로 지정하기
	 $.datepicker.setDefaults({dateFormat:'yy-mm-dd'});
	 $('.ui-datepicker select.ui-datepicker-year').css('background-color', '#8C8C8C');
}
