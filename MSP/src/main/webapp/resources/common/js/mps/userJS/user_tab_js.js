/* 리스트 클릭 시 팝업 숨김. */
	function hideModal(){
 		$('#dept_pop_div').hide();
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
	    function fn_press_han(obj)
	    {
	        //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
	        if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
	        || event.keyCode == 46 ) return;
	        //obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	        obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	    }
	 
	    //비밀번호 유효성 검사 (영문,숫자,특수문자 혼합하여 8자리~20자리 이내.(비밀번호 표준))
		  function passwordCheck() {
			var userID = document.getElementById("user_id").value;
			var user_pwd = document.getElementById("user_pwd").value; 
			var user_pwd_chk = document.getElementById("user_pwd_chk").value; 
			
			// 재입력 일치 여부 
			if (user_pwd != user_pwd_chk) { 
				alert("입력한 두 개의 비밀번호가 서로 일치하지 않습니다.");
				return ; 
				} 
			// 길이 
			if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{6,15}$/.test(user_pwd_chk)) 
			{ 
				alert("비밀번호는 숫자, 영문, 특수문자 조합으로 6~15자리를 사용해야 합니다.");
				return ;
			} 
			// 영문, 숫자, 특수문자 2종 이상 혼용 
			var chk = 0; 
			if(user_pwd.search(/[0-9]/g) != -1 ) chk ++; 
			if(user_pwd_chk.search(/[a-z]/ig) != -1 ) chk ++; 
			if(user_pwd_chk.search(/[!@#$%^&*()?_~]/g) != -1 ) chk ++; 
			if(chk < 2) {
				alert("비밀번호는 숫자, 영문, 특수문자를 두가지이상 혼용하여야 합니다."); 
				return ; 
				}
			// 동일한 문자/숫자 4이상, 연속된 문자 
			if(/(\w)\1\1\1/.test(user_pwd_chk) || isContinuedValue(user_pwd_chk)) 
			{
				alert("비밀번호에 4자 이상의 연속 또는 반복 문자 및 숫자를 사용하실 수 없습니다."); 
				return ; 
				}
			// 아이디 포함 여부 
			if(user_pwd_chk.search(userID)>-1) 
			{
				alert("ID가 포함된 비밀번호는 사용하실 수 없습니다."); 
				return ;
				}
			/* // 기존 비밀번호와 새 비밀번호 일치 여부 
			if (user_pwd == user_pwd_chk) 
			{
				alert("기존 비밀본호와 새 비밀번호가 일치합니다."); 
				return false; 
				} */ 
				
				return true;
			} 
	
		  function isContinuedValue(value) {
			  console.log("value = " + value);
			  var intCnt1 = 0; 
			  var intCnt2 = 0; 
			  var temp0 = ""; 
			  var temp1 = ""; 
			  var temp2 = ""; 
			  var temp3 = ""; 
			  for (var i = 0; i < value.length-3; i++) {
				  console.log("=========================");
				  temp0 = value.charAt(i); 
				  temp1 = value.charAt(i + 1); 
				  temp2 = value.charAt(i + 2); 
				  temp3 = value.charAt(i + 3); 
				  console.log(temp0); console.log(temp1); console.log(temp2); console.log(temp3);
				  if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == 1 && temp1.charCodeAt(0) - temp2.charCodeAt(0) == 1 && temp2.charCodeAt(0) - temp3.charCodeAt(0) == 1) {
					  intCnt1 = intCnt1 + 1;
				  } 
				  if (temp0.charCodeAt(0) - temp1.charCodeAt(0) == -1 && temp1.charCodeAt(0) - temp2.charCodeAt(0) == -1 && temp2.charCodeAt(0) - temp3.charCodeAt(0) == -1) {
					  intCnt2 = intCnt2 + 1;
				  }
				  console.log("=========================");
				  } 
			  console.log(intCnt1 > 0 || intCnt2 > 0); 
			  return (intCnt1 > 0 || intCnt2 > 0); 
			  }