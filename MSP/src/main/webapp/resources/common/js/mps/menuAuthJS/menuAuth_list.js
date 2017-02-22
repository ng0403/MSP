		$("#navisub11").show();
		$("#naviuser").css("font-weight", "bold");
		
		$("#auth_id_sch").keypress(function(){
			enterSearch(event, fn_search);
		});
		
		$("#menu_nm_sch").keypress(function(){
			enterSearch(event, fn_search);
		});
		
		//페이지 엔터시 이벤트
		$(document).on("keypress","#pageInput",function(){
			var keycode = (event.keyCode ? event.keyCode : event.which);
    		if (keycode == '13') {
				pageInputRep(event, fn_search);
    		}
		});
		
		
		// 검색 버튼 클릭시
		function fn_search(pageNum)
		{
			var auth_id_sch = $("#auth_id_sch").val();
			var menu_nm_sch = $("#menu_nm_sch").val();
			var tbody = $("#menuAuthListTbody");
			var contents = "";
			var pageContent = "";
				
			$.ajax({
				url      : 'menuAuth_list',
				type     : 'POST',
				dataType : 'json',
				data     : {
					"auth_id_sch":auth_id_sch, "menu_nm_sch":menu_nm_sch, "pageNum":pageNum
				},
				success  : function(data) {						
					tbody.empty();
					var menuAuthInqrList = data.menuAuthInqrList;
					
					if(menuAuthInqrList.lenght != 0)
					{
						for(var i=0; i<menuAuthInqrList.length; i++)
						{
							var menu_cd = menuAuthInqrList[i].MENU_CD;
							var menu_nm  = menuAuthInqrList[i].MENU_NM;
							var auth_id   = menuAuthInqrList[i].AUTH_ID;
							var auth_nm   = menuAuthInqrList[i].AUTH_NM;
							var inqr_auth = menuAuthInqrList[i].INQR_AUTH;
							var add_auth = menuAuthInqrList[i].ADD_AUTH;
							var mdfy_auth = menuAuthInqrList[i].MDFY_AUTH;
							var del_auth = menuAuthInqrList[i].DEL_AUTH;
							var menu_acc_auth = menuAuthInqrList[i].MENU_ACC_AUTH;
							
							contents += "<tr class='open_detail' data_num='"+menu_cd+"' onmouseover='this.style.background='#c0c4cb' onmouseout='this.style.background='white''>"
							+"<td align='center' scope='row'>"
							+"<input type='checkbox' name='del_menuAuth' id='del_menuAuth' value='"+menu_cd+":"+auth_id+"'></td>"
							+"<td><a href='javascript:void(0)' onclick='fn_menuAuthPop(\""+menu_cd+"\", \""+auth_nm+"\")'>"+menu_cd+"</a></td>"
		    				+"<td>"+menu_nm+"</td>"
		    				+"<td>"+auth_nm+"</td>"
							+"<td>"+inqr_auth+"</td>"
							+"<td>"+add_auth+"</td>"
							+"<td>"+mdfy_auth+"</td>"
							+"<td>"+del_auth+"</td>"
							+"<td>"+menu_acc_auth+"</td>"
							+"</tr>";
						}
					}
					
					tbody.append(contents);
					
					paging(data, "#menuAuthPagingDiv", "fn_search");
					
				}
			});
		}
	
		// 상세보기 팝업
		function fn_menuAuthPop(menu_cd, auth_nm)
		{
			var menu_cd = menu_cd;
			var auth_nm = auth_nm;
			
			var tbody = $("#generalTbody");
			var contents  = "";
			var contents1 = "";
			
			var active_radio1 = "";
			var active_radio2 = "";
			var inqr_radio1 = "";
			var inqr_radio2 = "";
			var add_radio1 = "";
			var add_radio2 = "";
			var mdfy_radio1 = "";
			var mdfy_radio2 = "";
			var del_radio1 = "";
			var del_radio2 = "";
			var menu_acc_radio1 = "";
			var menu_acc_radio2 = "";
			
			$.ajax({
				url		 : 'menuAuthDetail',
				type	 : 'POST',
				dataType : 'json',
				data	 : {
					"menu_cd":menu_cd, "auth_nm":auth_nm
				},
				success  : function(data){
					tbody.empty();
					var menuAuthDetail = data.menuAuthDetail;
					
					for(var i=0; i<menuAuthDetail.length; i++)
					{
						var auth_id = menuAuthDetail[i].auth_id;
						var auth_nm = menuAuthDetail[i].auth_nm;
						var menu_cd = menuAuthDetail[i].menu_cd;
						var menu_nm = menuAuthDetail[i].menu_nm;
						var up_menu_cd = menuAuthDetail[i].up_menu_cd;
	 					var up_menu_nm = menuAuthDetail[i].up_menu_nm;
	 					var menu_url   = menuAuthDetail[i].menu_url;
	 					var active_flg = menuAuthDetail[i].active_flg;
	 					var inqr_auth  = menuAuthDetail[i].inqr_auth;
						var add_auth   = menuAuthDetail[i].add_auth;
						var mdfy_auth  = menuAuthDetail[i].mdfy_auth;
	 					var del_auth   = menuAuthDetail[i].del_auth;
	 					var menu_acc_auth = menuAuthDetail[i].menu_acc_auth;
	 					
	 					if(up_menu_cd == null)
	 					{
	 						up_menu_cd = "없음";
	 					}
	 					if(up_menu_nm == null)
	 					{
	 						up_menu_nm = "없음";
	 					}
	 					if(menu_url == null)
	 					{
	 						menu_url = "없음";
	 					}
	 					
	 					contents1 ="<tr height='15px'>"+
	 					"<th style=' width: 12%; text-align: center;'>권한ID&nbsp;&nbsp;</th>"+
	 					"<td style='width: 38%; text-align: left;'>"+
						"<input type = 'text' id='auth_id1' name='auth_nm' value='"+auth_nm+"' style='font-size:12px;width:80%;background-color:#F2F2F2;' readonly='readonly'>"+
						"<input type = 'hidden' id='auth_id2' name='auth_id2' value='"+auth_id+"'>"+
						"</td>"+
						"<th style=' width: 12%; text-align: center;'>메뉴코드&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type = 'text' id='menu_cd1' name='menu_cd1' value='"+menu_cd+"' style='font-size:12px;width:80%;background-color:#F2F2F2;' readonly='readonly'>"+
						"</td>"+
						"</tr>"+
						"<tr height='15px'>"+
						"<th style='width: 12%; text-align: center;'>메뉴명&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='menu_nm1' name='menu_nm1' value='"+menu_nm+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"<th style='width: 12%; text-align: center;'>상위메뉴코드&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='up_menu_cd1' name='up_menu_cd1' value='"+up_menu_cd+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"</tr>"+
						"<tr height='15px'>"+
						"<th style='width: 12%; text-align: center;'>상위메뉴명&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='up_menu_nm1' name='up_menu_nm1' value='"+up_menu_nm+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"</td>"+
						"<th style='width: 12%; text-align: center;'>메뉴URL&nbsp;&nbsp;</th>"+
						"<td style='width: 38%; text-align: left;'>"+
							"<input type='text' id='menu_url1' name='menu_url1' value='"+menu_url+"' style='width: 80%;' readonly='readonly'/>"+
						"</td>"+
						"</tr>";
						
						active_radio1 = "<tr><th style='width: 12%; text-align: center;'>활성화 상태&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='active_flg1' id='active1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='active_flg1' id='active2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td>";
						active_radio2 = "<tr><th style='width: 12%; text-align: center;'>활성화 상태&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='active_flg1' id='active1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='active_flg1' id='active2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td>";
							
						inqr_radio1 = "<th style='width: 12%; text-align: center;'>조회권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='inqr_auth1' id='inqr_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='inqr_auth1' id='inqr_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='true false;'/>N"
							+"</td></tr>";
						inqr_radio2 = "<th style='width: 12%; text-align: center;'>조회권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='inqr_auth1' id='inqr_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='inqr_auth1' id='inqr_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td></tr>";
							
						add_radio1 = "<tr><th style='width: 12%; text-align: center;'>생성권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='add_auth1' id='add_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='add_auth1' id='add_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td>";
						add_radio2 = "<tr><th style='width: 12%; text-align: center;'>생성권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='add_auth1' id='add_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='add_auth1' id='add_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td>";
							
						mdfy_radio1 = "<th style='width: 12%; text-align: center;'>수정권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='mdfy_auth1' id='mdfy_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='mdfy_auth1' id='mdfy_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td></tr>";
						mdfy_radio2 = "<th style='width: 12%; text-align: center;'>수정권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='mdfy_auth1' id='mdfy_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='mdfy_auth1' id='mdfy_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td></tr>";
							
						del_radio1 = "<tr><th style='width: 12%; text-align: center;'>삭제권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='del_auth1' id='del_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='del_auth1' id='del_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td>";
						del_radio2 = "<tr><th style='width: 12%; text-align: center;'>삭제권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='del_auth1' id='del_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='del_auth1' id='del_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td>";
						
						menu_acc_radio1 = "<th style='width: 12%; text-align: center;'>메뉴접근권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;' checked/>Y"+
							"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;'/>N"
							+"</td></tr>";
						menu_acc_radio2 = "<th style='width: 12%; text-align: center;'>메뉴접근권한&nbsp;&nbsp;</th>"+ 
							"<td style='width: 38%; text-align: left;'>"				   
							+"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth1' value='Y' style='text-align:right;width:10%;' onclick='return true;'/>Y"+
							"<input type='radio' name='menu_acc_auth1' id='menu_acc_auth2' value='N' style='margin-left:15px;text-align:left;width:10%;' onclick='return true;' checked/>N"
							+"</td></tr>";	
							
						if(active_flg == 'Y') {
							contents = contents1 + active_radio1;
						}
						else {
							contents = contents1 + active_ardio2;
						}
						
						if(inqr_auth == 'Y') {
							contents = contents + inqr_radio1;
						}
						else {
							contents = contents + inqr_radio2;
						}
						
						if(add_auth == 'Y') {
							contents = contents + add_radio1;
						}
						else {
							contents = contents + add_radio2;
						}
						
						if(mdfy_auth == 'Y') {
							contents = contents + mdfy_radio1;
						}
						else {
							contents = contents + mdfy_radio2;
						}
						
						if(del_auth == 'Y') {
							contents = contents + del_radio1;
						}
						else {
							contents = contents + del_radio2;
						}
						
						if(menu_acc_auth == 'Y') {
							contents = contents + menu_acc_radio1;
						}
						else {
							contents = contents + menu_acc_radio2;
						}
						
						tbody.append(contents);
					}
				}
			});
			
			$('.menuOpen').click();
		}
		
		// 상세보기 수정버튼
		function menuAuthMdfy()
		{
			alert("수정버튼");
		}
		
		// 추가버튼 눌렀을 때
		function menuAuthInsert()
		{
			// 유효성 검사
			if($("#auth_nm").val() == "" || $("#auth_nm").val() == null)
			{
				alert("권한을 선택하세요.");
				document.menuAuthAdd.auth_id_pop.focus();
				
				return false;
			}
			if($("#up_menu_nm").val() == "" || $("#up_menu_nm").val() == null)
			{
				alert("메뉴를 선택하세요.");
				document.menuAuthAdd.menu_cd_pop.focus();
				
				return false;
			}
			if($("input:radio[name=active_flg3]:checked").val() == "" || $("input:radio[name=active_flg3]:checked").val() == null)
			{
				alert("황성화여부를 선택하세요.");
				document.menuAuthAdd.active_flg3.focus();
				
				return false;
			}
			if($("input:radio[name=inqr_auth3]:checked").val() == "" || $("input:radio[name=inqr_auth3]:checked").val() == null)
			{
				alert("조회권한을 선택하세요.");
				document.menuAuthAdd.inqr_auth3.focus();
				
				return false;
			}
			if($("input:radio[name=add_auth3]:checked").val() == "" || $("input:radio[name=add_auth3]:checked").val() == null)
			{
				alert("생성권한을 선택하세요.");
				document.menuAuthAdd.add_auth3.focus();
				
				return false;
			}
			if($("input:radio[name=mdfy_auth3]:checked").val() == "" || $("input:radio[name=mdfy_auth3]:checked").val() == null)
			{
				alert("수정권한을 선택하세요.");
				document.menuAuthAdd.mdfy_auth3.focus();
				
				return false;
			}
			if($("input:radio[name=del_auth3]:checked").val() == "" || $("input:radio[name=del_auth3]:checked").val() == null)
			{
				alert("삭제권한을 선택하세요.");
				document.menuAuthAdd.del_auth3.focus();
				
				return false;
			}
			if($("input:radio[name=menu_acc_auth3]:checked").val() == "" || $("input:radio[name=menu_acc_auth3]:checked").val() == null)
			{
				alert("메뉴접근권한을 선택하세요.");
				document.menuAuthAdd.menu_acc_auth3.focus();
				
				return false;
			}
			else
			{
				if(confirm("헤당 메뉴권한을 등록하시겠습니까?"))
				{
					$("#menuAuthAdd").submit();
					
					alert("메뉴권한이 등록되었습니다.");
				}
				else
				{
					return false;
				}
			}
		}
		
		// 삭제 버튼 눌렀을 때
		function menuAuthDel()
		{
			if(confirm("선택한 메뉴권한을 삭제 하시겠습니까?")) {
				var check = document.getElementsByName("del_menuAuth");
				var check_len = check.length;
				var checked = 0;
				
				for(i=0; i<check_len; i++)
				{
					if(check[i].checked == true)
					{
						$("#delAllForm").submit();
						checked++;
					}
				}
				
				if(checked == 0)
				{
					alert("체크박스를 체크하세요.");
				}
			}
			else {
				return false;
			}
		}
