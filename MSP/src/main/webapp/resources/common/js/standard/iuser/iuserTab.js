$(function() {
	var ctx = $('#ctx').val();
	userFormInit();
	codePop(ctx);
	orgPop(ctx);
	formData(ctx);
	modifyData(ctx);
	getUserAuth(ctx);
	addsaveUser(ctx);
	modifysaveUser(ctx);
	getUserAuthSearch(ctx);
	addkeyman(ctx);
	addOperatingA(ctx);
	addSalesChance(ctx);
	addEstimate(ctx);
	addContract(ctx);
	cancelbtnEvent();
});

function userFormInit(){
	$('#joinform').find('input[type="text"]').attr('disabled',true);
	$('#modifybtn').attr('disabled', true);
	$('#addsavebtn').attr('disabled', true);
	$('#cancelbtn').attr('disabled', true);
	$('#submitbtn').attr('disabled',false);
}

function codePop(ctx){
	$('#userTypePop').click(function(){ 
		
		window.open(ctx+'/userTypePopup','newwindow','width=700, height=450, toolbar=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no');
	});
}

function iuserCode(code){
	if($(code).val() != ""){
		$('#user_type_cd').val(code);
	}
}

function orgPop(ctx){
  $('#orgPopup').click(function(){
	 window.open(ctx+'/orgNamePopup','newwindow','width=700, height=450, toolbar=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no');
  }); 
}

function orgIdCheck(org_id){
	if($(org_id).val() != ""){
		$('#org_id').val(org_id);
	}
}

//날짜 13자리를 yyyy-mm-dd형식으로 변환해주는 함수
function dateFormat(timestamp) {

	var date = new Date(timestamp);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var hour = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();

	var retVal = year + "-" + (month < 10 ? "0" + month : month) + "-"
			+ (day < 10 ? "0" + day : day);

	return retVal
}

function getUserAuth(ctx) {
	$('#userAuthTab').click(function(){
		//사용자 권한 조회
		$('#userAuthBody').children("tr").remove();
		
		$.ajax(
				{
				url : ctx+'/userauth',					//보낼 URL
				dataType : 'json',							//응답 받을 데이터 형식
				type : 'POST',								//서버 요청 방식
				contentType : 'application/json;charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
				success : function(data){
					
					var fst_reg_d = null;
					var tbody = $('#userAuthBody');
					var tbodyContent = "";
					
					for (var i=0; i < data.length; i++) {
						
						//날짜함수변환 
						fst_reg_d = dateFormat(Number(data[i].fst_reg_d));
						
						tbodyContent = "<tr><td>"+data[i].auth_id+"<td>"+data[i].fst_reg_id_nm+"</td><td>"+fst_reg_d+"</td><td>"+data[i].id_nm+"</td></tr>";
						tbody.append(tbodyContent);
					}
					
				},
				error : function(e){
					alert(e);
				}
			});
	});
}

function getUserAuthSearch(ctx) {
	$('#iuserAuthSearch').click(function(){
		//사용자 권한 검색
		var iuserAuthData = {
				keyfield : $('#iuserKeyfield').val(),
				keyword : $('#iuserKeyword').val()
		}
		
		var jsonData = JSON.stringify(iuserAuthData);

		jQuery.ajaxSettings.traditional = true;	
		
		$.ajax(
				{
				url : ctx+'/userAuthSearch',				//보낼 URL
				dataType : 'json',							//응답 받을 데이터 형식
				type : 'POST',								//서버 요청 방식
				data :  jsonData,	
				contentType : 'application/json;charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
				success : function(data){
					$('#userAuthBody').children("tr").remove();
					var tbody = $('#userAuthBody');
					var tbodyContent = "";

					for (var i=0; i < data.length; i++) {
						//날짜함수변환 
						fst_reg_d = dateFormat(Number(data[i].fst_reg_d));
						tbodyContent = "<tr><td>"+data[i].auth_id+"<td>"+data[i].fst_reg_id_nm+"</td><td>"+fst_reg_d+"</td><td>"+data[i].id_nm+"</td></tr>";
						tbody.append(tbodyContent);
					}
					
				},
				error : function(e){
					alert(e.responseText);
				}
			});
	});
}

function formData(ctx){ 
	$('.bt_position_authuser').delegate('#submitbtn', 'click', function(event){
		event.preventDefault();      //기본동작을 취소하는 이벤트 
		
		$('#iuser_id').val("");
		$('#id_nm').val("");
		$('#iuser_nm').val("");
		$('#pwd').val("");
		$('#user_type_cd').val("");
		$('#org_id').val("");
		$('#home_phone1').val("");
		$('#home_phone2').val("")+"-"+$('#home_phone3').val("");
		$('#company_phone1').val("")+"-"+$('#company_phone2').val("")+"-"+$('#company_phone3').val("");
		$('#cell_phone1').val("")+"-"+$('#cell_phone2').val("")+"-"+$('#cell_phone3').val("");
		$('#email1').val("") + "@"+$('#email2').val("");
		
		$('#tabDiv1 input').attr("disabled", false);
		$('#auth_name').attr("disabled", false);
		$('#addsavebtn').attr("disabled", false);
		$('#modifybtn').attr("disabled", true);
		$('#submitbtn').attr("disabled", true);
		$('#addsavebtn').css("display", "inline-block");
		$('#modifysavebtn').css("display", "none");
	});
}

function modifyData(ctx){  //편집 버튼에 대한 내용 (버튼 활성화 비활성화)
	$('.bt_position_authuser').delegate('#modifybtn','click', function(event){
		event.preventDefault();
		
		$('#tabDiv1 input').attr("disabled", false);
		$('#user_id').attr("disabled", true);
		$('#auth_name').attr("disabled", false);
		
		$('#modifysavebtn').css("display", "inline-block");
		$('#addsavebtn').css("display", "none");
		$('#modifybtn').attr("disabled", true);
		$('#submitbtn').attr('disabled',true);
	});
}

function addsaveUser(ctx){ // 사용자추가 ajax부분
	$('.bt_position_authuser').delegate('#addsavebtn','click', function(event){
		event.preventDefault();
		var obj = new Object();
		obj.id_nm = $('#id_nm').val();
		obj.iuser_nm = $('#iuser_nm').val();
		obj.pwd = $('#pwd').val();
		obj.iuser_div_cd = $('#user_type_cd').val();
		obj.org_id = $('#org_id').val();
 		obj.ph1 =  $('#home_phone1').val();
 		obj.ph2 =  $('#home_phone2').val();
 		obj.ph3 =  $('#home_phone3').val();
 		obj.comp_ph1 = $('#company_phone1').val();
 		obj.comp_ph2 = $('#company_phone2').val();
 		obj.comp_ph3 = $('#company_phone3').val();
		obj.cell_ph1 = $('#cell_phone1').val();
		obj.cell_ph2 = $('#cell_phone2').val();
		obj.cell_ph3 = $('#cell_phone3').val();	
		obj.auth_id = $('#auth_name').val();
		obj.email1 = $('#email1').val();
		obj.email2 = $('#email2').val();
		
		if($('#active_flg_Y').is(':checked')){
			obj.act_yn=$('#active_flg_Y').val();
		}else{
			obj.act_yn=$('#active_flg_N').val();
		}
		
		if(obj.id_nm==""||obj.id_nm==null){
			alert("아이디를 입력해 주세요");
			return false;
		}else if(obj.iuser_nm==""||obj.iuser_nm==null){
			alert("사용자명을 입력해 주세요");
			return false;
		}else if(obj.pwd==""||obj.pwd==null){
			alert("비밀번호를 입력해 주세요");
			return false;
		}else if(obj.iuser_div_cd==""||obj.iuser_div_cd==null){
			alert("구분값을 입력해 주세요");
			return false;
		}else if(obj.ph1==""||obj.ph1==null || obj.ph2==""||obj.ph2==null || obj.ph3==""||obj.ph3==null){
			alert("전화번호를 입력해 주세요");
			return false;
		}else if(obj.comp_ph1==""||obj.comp_ph1==null || obj.comp_ph2==""||obj.comp_ph2==null || obj.comp_ph3==""||obj.comp_ph3==null){
			alert("회사번호를 입력해 주세요");
			return false;
		}else if(obj.cell_ph1==""||obj.cell_ph1==null || obj.cell_ph2==""||obj.cell_ph2==null || obj.cell_ph3==""||obj.cell_ph3==null){
			alert("핸드폰번호를 입력해 주세요");
			return false;
		}else if(obj.email1==""||obj.email1==null || obj.email2==""||obj.email2==null){
			alert("이메일을 입력해 주세요");
			return false;
		}else if(obj.org_id==""||obj.org_id==null){
			alert("조직코드를 입력해 주세요");
			return false;
		}else if(obj.act_yn==""||obj.act_yn==null){
			alert("상태를 입력해 주세요");
			return false;
		}else if(obj.auth_id==""||obj.auth_id==null){
			alert("권한값을 입력해 주세요");
			return false;
		}
		
		var jsonData = JSON.stringify(obj);		//JSON Object 생성
		
		jQuery.ajaxSettings.traditional = true;	//JSON Object 보낼시 설정

		$.ajax({
			url : ctx+'/insertuser',					//보낼 URL
			dataType : 'json',						//응답 받을 데이터 형식
			type : 'POST',								//서버 요청 방식
			data :  jsonData,							//파라미터 { 'aaa' : 'bbb' }
			contentType : 'application/json; charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
			success : function(data){
				alert("사용자가 등록되었습니다.");
				//사용자 텍스트 부분 초기화 
				reset_text();
				
				//추가한 내용을 리스트에 붙여주는 작업
				var args = "<tr><th scope='row'><input type='checkbox' class='ab' name='del_code' value='"+data.IUSER_ID+"'></th>" +
						"<td style='width:10%;' id='user_id_a'><a href='#'>"+data.ID_NM+"</a></td>" +
								"<td style='width:10%;' class='user_name_tag'>"+data.IUSER_NM+"</td>" +
										"<td style='width:10%;' class='org_name_tag'>"+data.ORG_NM+"</td>" +
												"<td style='width:20%;' class='email_tag'>"+data.EMAIL1+"@"+data.EMAIL2+"</td>" +
														"<td style='width:20%;' class='cell_phone_tag'>"+data.CELL_PH1+"-"+data.CELL_PH2+"-"+data.CELL_PH3+"</td>" +
																"<td style='width:10%;' class='auth_name_tag'>"+data.AUTH_NM+"</td>" +
																		"<td style='width:10%;' class='code_name_tag'>"+data.CD_NM+"</td>";

				if(data.ACT_YN=='Y'){
					args+="<td style='width:10%;' class='active_flag_tag'>"+'활성화'+"</td>";
				}else{
					args+="<td style='width:10%;' class='active_flag_tag'>"+'비활성화'+"</td>";
				}
				
				$('#usertbody').append(args);
				
			},
			error : function(e){
				alert('오류');
			}
		});
		$('#addsavebtn').css('display','inline-block');
		$('#modifysavebtn').css('display','none');
		$('#modifybtn').attr("disabled", true);
	});
}

function modifysaveUser(ctx){ //사용자 편집 ajax부분
	$('.bt_position_authuser').delegate('#modifysavebtn','click', function(event){ 
		event.preventDefault();
		var obj = new Object();
		
		obj.iuser_id = $('#iuser_id').val();
		obj.id_nm = $('#id_nm').val();
		obj.iuser_nm = $('#iuser_nm').val();
		obj.pwd = $('#pwd').val();
		obj.iuser_div_cd = $('#user_type_cd').val();
		obj.org_id = $('#org_id').val();
		
		if($('#active_flg_Y').is(':checked')){
			obj.act_yn=$('#active_flg_Y').val();
		}else{
			obj.act_yn=$('#active_flg_N').val();
		}
	
 		obj.ph1 =  $('#home_phone1').val();
 		obj.ph2 =  $('#home_phone2').val();
 		obj.ph3 =  $('#home_phone3').val();
 		obj.comp_ph1 =  $('#company_phone1').val();
 		obj.comp_ph2 =  $('#company_phone2').val();
 		obj.comp_ph3 =  $('#company_phone3').val();
 		obj.cell_ph1 = $('#cell_phone1').val();
 		obj.cell_ph2 = $('#cell_phone2').val();
 		obj.cell_ph3 = $('#cell_phone3').val(); 		
		obj.auth_id = $('#auth_name').val();
		obj.email1 = $('#email1').val();
		obj.email2 = $('#email2').val();
		
		var jsonData = JSON.stringify(obj);		//JSON Object 생성
		
		jQuery.ajaxSettings.traditional = true;	//JSON Object 보낼시 설정

		$.ajax({
			url : ctx+'/iuserEdit',					//보낼 URL
			dataType : 'json',						//응답 받을 데이터 형식
			type : 'POST',								//서버 요청 방식
			data :  jsonData,							//파라미터 { 'aaa' : 'bbb' }
			contentType : 'application/json; charset=UTF-8',	//서버 전송 시 데이터가 JSON 객체
			success : function(data){
				alert("사용자가 편집되었습니다.");
				//편집한 내용 리스트에 붙여주기
				var list = $('#usertbody tr').find('#user_id_a');
				for(var i=0; i<list.length; i++){
					if($(list[i]).parent().find('input[type="checkbox"]').val() == data.IUSER_ID){
						$(list[i]).parent().children('.user_name_tag').text(data.IUSER_NM);
						$(list[i]).parent().find('#user_id_a a').text(data.ID_NM);
						$(list[i]).parent().children('.org_name_tag').text(data.ORG_NM);
						$(list[i]).parent().children('.email_tag').text(data.EMAIL1+'@'+data.EMAIL2);
						$(list[i]).parent().children('.cell_phone_tag').text(data.CELL_PH1+'-'+data.CELL_PH2+'-'+data.CELL_PH3);
						$(list[i]).parent().children('.auth_name_tag').text(data.AUTH_NM);
						$(list[i]).parent().children('.code_name_tag').text(data.CD_NM);

						if(data.ACT_YN == 'Y'){
							$(list[i]).parent().children('.active_flag_tag').text('활성화');
						}else{
							$(list[i]).parent().children('.active_flag_tag').text('비활성화');
						}
					}
				}
				reset_text();
			},
			error : function(e){
				alert("오류:" + e.responseText);
			}
		});
		reset_text();
		$('#addsavebtn').css('display','inline-block');
		$('#modifysavebtn').css('display','none');
		userFormInit();
	});
}

function cancelbtnEvent(){
	$('#cancelbtn').click(function(){
		$('#addsavebtn').css('display','inline-block');
		$('#modifysavebtn').css('display','none');
		userFormInit();
	});
}

function reset_text(){
	$("#joinform").each(function() {  
		this.reset();
	});
}


function addkeyman(ctx){
	
	$('#addkeymanpopupbtn').click(function(){
		
		window.open(ctx+'/keymanpopup','newwindow','width=400, height=450, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		
	});
	
}

function addOperatingA(ctx){
	
	$('#addOperApopupbtn').click(function(){
		
		window.open(ctx+'/operatingApopup','newwindow','width=400, height=560, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		
	});
	
}

function addSalesChance(ctx){
	
	$('#addsaleschancepopupbtn').click(function(){
		
		window.open(ctx+'/saleschancepopup','newwindow','width=400, height=510, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		
	});
	
}

function addEstimate(ctx){
	
	$('#addestimatepopupbtn').click(function(){
		
		window.open(ctx+'/estimatepopup','newwindow','width=550, height=560, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		
	});
	
}

function addContract(ctx){
	
	$('#addcontractpopupbtn').click(function(){
		
		window.open(ctx+'/contractpopup','newwindow','width=550, height=560, toolbar=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
		
	});
	
}