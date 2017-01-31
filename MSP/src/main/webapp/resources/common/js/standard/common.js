	
	/* 고객검색 팝업창 */
	// customer검색 엔터키
	function customerEnter(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			findCusInfo(1);
		}
		event.stopPropagation();
	}
	
	//고객 검색 팝업 find
	function findCusInfo(pageNum){		
		var cusNo = $('#cusNoSearch_txt').val();
		var cusName = $('#cusNameSearch_txt').val();	
		
		if((cusNo == null || cusNo =="") && (cusName == null || cusName =="")){
			alert("Check Please, Customer No Or Customer Name.");
			return;
		}
		
		/*if(cusName == null || cusName ==""){
			alert("Check Please, Customer Name.");
			return;
		}
		*/
		var sendData = {
				"cusNo": cusNo, "cusName":cusName, "pageNum": pageNum };
		var tbody = $('#cusSearchTbody');
		
		$.ajax({			
			url :'/nexen/common/customerSearch',
			type : 'POST',	
			data : sendData,
			success : function(data) {				
				
				if(data.cusSearchList == 0){					
					tbody.empty();
					
					var trElement = $("#cusSearchTable thead tr").clone().removeClass().empty();
					
					$("#cusSearchTbody").append(trElement);
					$("#cusSearchTbody tr:last").append("<td style='height: 160px;background : white;' colspan='9'><b>No result data.</b></td>");					
					
				}else{					
					tbody.empty();
					
					// 테이블 그리기
					$.each(data.cusSearchList, function(i) {
						var trElement = $("#cusSearchTable thead tr").clone().removeClass().empty();

						/* trElement.bind("click", function(e) { // 기능 입히기
							$("#rep_emp_id").val(data.replist[i].user_id);
							$("#rep_emp_nm").val(data.replist[i].user_nm);	
							$.unblockUI();
						}); */
						
						$("#cusSearchTbody").append(trElement);
						$("#cusSearchTbody tr:last").append("<td><input type='radio' name='cusSearchRadio'  id='cusSearchRadio"+i+"' onchange='cusRadioSelect("+i+")' value='"+i+"' /></td>"
								+"<td id='findCusNo"+i+"' value='"+data.cusSearchList[i].kunnr+"'  style='text-align: left;' >"+data.cusSearchList[i].kunnr+"</td>"
								+"<td id='findCusName"+i+"' value='"+data.cusSearchList[i].name1+"'  style='text-align: left;' >"+data.cusSearchList[i].name1+"</td>"
								+"<td style='text-align: left;'>"+data.cusSearchList[i].land1+"</td>"
								+"<td style='text-align: left;'>"+data.cusSearchList[i].region+"</td>"
								+"<td style='text-align: left;'>"+data.cusSearchList[i].vkgrp_T+"</td>"
								+"<td style='text-align: left;'>"+data.cusSearchList[i].vkbur_T+"</td>"
								+"<td style='text-align: left;'>"+data.cusSearchList[i].vkorg+"</td>"
								+"<td style='text-align: left;'>"+data.cusSearchList[i].vtweg+"</td>");
					});
					
					var pageContent = "";
					// 페이징 다시그리기
					$("#customerSearchPagingDiv").empty();
					
					if(data.cusSearchPage.endPageNum==1){
						pageContent = "<input type='hidden' id='cusPageNum' value='"+data.cusSearchPageNum+"'/><input type='hidden' id='cusEndPageNum' value='"+data.cusSearchPage.endPageNum+"'/>" 
						+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='cusPageInput' class='repUserPageInput' value='"+data.cusSearchPage.startPageNum+"' onkeypress='cusSearchEnter(event);'/>"  
						+"<a style='color: black; text-decoration: none;'> / "+data.cusSearchPage.endPageNum+"</a>"
						+"<a style='color: black; text-decoration: none;''> ▶ </a>"
					}else if(data.cusSearchPage.startPageNum == data.cusSearchPage.endPageNum){
						pageContent ="<input type='hidden' id='cusPageNum' value='"+data.cusSearchPageNum+"'/><input type='hidden' id='cusEndPageNum' value='"+data.cusSearchPage.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+(data.cusSearchPageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px;' id='cusPageInput' class='repUserPageInput' value='"+data.cusSearchPage.endPageNum+"' onkeypress=\"cusSearchEnter(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+data.cusSearchPage.endPageNum+") id='pNum'> / "+data.cusSearchPage.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					}else if(data.cusSearchPageNum == data.cusSearchPage.startPageNum){
						pageContent ="<input type='hidden' id='cusPageNum' value='"+data.cusSearchPageNum+"'/><input type='hidden' id='cusEndPageNum' value='"+data.cusSearchPage.endPageNum+"'/>" 
						+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px;' id='cusPageInput' class='repUserPageInput' value='"+data.cusSearchPage.startPageNum+"' onkeypress=\"cusSearchEnter(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+data.cusSearchPage.endPageNum+") id='pNum'> / "+data.cusSearchPage.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+(data.cusSearchPageNum+1)+") id='pNum'> ▶ </a>";
					} else if(data.cusSearchPageNum == data.cusSearchPage.endPageNum){
						pageContent ="<input type='hidden' id='cusPageNum' value='"+data.cusSearchPageNum+"'/><input type='hidden' id='cusEndPageNum' value='"+data.cusSearchPage.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+(data.cusSearchPageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px;' id='cusPageInput' class='repUserPageInput' value='"+data.cusSearchPage.endPageNum+"' onkeypress=\"cusSearchEnter(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+data.cusSearchPage.endPageNum+") id='pNum'> / "+data.cusSearchPage.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					} else {
						pageContent ="<input type='hidden' id='cusPageNum' value='"+data.cusSearchPageNum+"'/><input type='hidden' id='cusEndPageNum' value='"+data.cusSearchPage.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+(data.cusSearchPageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px;' id='cusPageInput' class='repUserPageInput' value='"+data.cusSearchPageNum+"' onkeypress=\"cusSearchEnter(event);\"/>"
						+"<a style='cursor: pointer;' onclick=findCusInfo("+data.cusSearchPage.endPageNum+") id='pNum'> / "+data.cusSearchPage.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=findCusInfo("+(data.cusSearchPageNum+1)+") id='pNum'> ▶ </a>";
					}
					$("#customerSearchPagingDiv").append(pageContent);
				}
			},
			beforeSend: function(){
	        	//viewLoadingShow();			
	        },
	        complete:function(){
	        //	viewLoadingHide();	
	        },
			error : function(request,status,error) {
		          alert("사용자페이징code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		});
	}
	
	//라디오 선택시 배경색 변경
	function cusRadioSelect(index){			
		$('#cusSearchTbody').children().css('background-color','white');
		//var radioId = obj.id;
		$('#cusSearchRadio'+index).parent().parent().css('background-color','#eaeaea');	
	}
	
	function cusSearchOk(){			
		var radioVal = $('input:radio[name="cusSearchRadio"]:checked').val();
		if(radioVal == null || radioVal ==""){
			alert("select.");
			return;
		}
		$('#cusSearchClose').click();
				
		var cusNo = $('#findCusNo'+radioVal).text();
		var cusName = $('#findCusName'+radioVal).text();
		
		$('#customerNo').val(cusNo);
		$('#customerName').val(cusName);

	}
	
	// 고객검색 페이징 엔터키
	function cusSearchEnter(event) {		
		$(document).ready(function() {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				var pageNum = parseInt($("#cusPageInput").val());				
				if ($("#cusPageInput").val() == '') {
					alert("Input page number.")
					$("#cusPageInput").val($("#cusPageNum").val());
					$("#cusPageInput").focus();
				} else if(pageNum > parseInt($("#cusEndPageNum").val())) {
					alert("The page number is too large.");
					$("#cusPageInput").val($("#cusPageNum").val());
					$("#cusPageInput").focus();
				} else if (1 > pageNum) {
					alert("The page number is too small.");
					$("#cusPageInput").val($("#cusPageNum").val());
					$("#cusPageInput").focus();
				} else {
					findCusInfo(pageNum);
				}
			}
			event.stopPropagation();
		});
	}
	
	//고객검색 팝업
	function goCusSearchPop(){ 		
		var cusNo = $('#customerNo').val();
		if(cusNo != ""){			
			$('#cusNoSearch_txt').val(cusNo);
			$('#customerNo').val("");
		}
		
		$('.cusSearchOpen').click();
		$('#cusNoSearch_txt').focus();
	}
	
	/* Material 검색 팝업 */
	//Material검색 팝업
	function goMaterialPop(){ 
		var cusName = $('#material_txt').val();
		if(cusName != ""){			
			$('#materialSearch_txt').val(cusName);
			$('#material_txt').val("");
		}
		$('.materialOpen').click();
		$('#materialSearch_txt').focus();
	}
	
	// material검색 엔터키
	function materialEnter(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			findMaterialInfo(1);
		}
		event.stopPropagation();
	}
	
	//Material 검색 팝업 search
	function findMaterialInfo(pageNum){			
		var plant = $('#selectPopPlant').val();
		var materialNo = $('#materialSearch_txt').val();		
		var pattern = $('#selectPopPattern').val();
		var width = $('#selectPopWidth').val();
		var series = $('#selectPopSeries').val();
		var inch = $('#selectPopInch').val();
		
		if(plant == null || plant ==""){
			alert("Select Please, Plant.");
			return;
		}
		
		var sendData = {
				"plant": plant, "materialNo": materialNo, "pattern": pattern,
				"width": width, "series": series, "inch": inch, "pageNum": pageNum };
		
		var tbody = $('#materialTbody');
		
		$.ajax({			
			url :'/nexen/common/materialSearch',
			type : 'POST',	
			data : sendData,
			success : function(data) {				
				
				if(data.materialSearchList == 0){					
					tbody.empty();
					
					var trElement = $("#materialTable thead tr").clone().removeClass().empty();
					
					$("#materialTbody").append(trElement);
					$("#materialTbody tr:last").append("<td style='height: 160px;background : white;' colspan='8'><b>No result data.</b></td>");					
					
				}else{					
					tbody.empty();
					
					// 테이블 그리기
					$.each(data.materialSearchList, function(i) {
						var trElement = $("#materialTable thead tr").clone().removeClass().empty();
						
						/* trElement.bind("click", function(e) { // 기능 입히기
							$("#rep_emp_id").val(data.replist[i].user_id);
							$("#rep_emp_nm").val(data.replist[i].user_nm);	
							$.unblockUI();
						}); */
						
						$("#materialTbody").append(trElement);
						$("#materialTbody tr:last").append("<td><input type='radio' name='materialRadio'  id='materialRadio"+i+"' onchange='matRadioSelect(this)' value='"+data.materialSearchList[i].matnr+"' /></td>"
								+"<td style='text-align: left;'>"+data.materialSearchList[i].vkorg+"</td>"
								+"<td style='text-align: left;'>"+data.materialSearchList[i].matnr+"</td>"								
								+"<td style='text-align: left;'>"+data.materialSearchList[i].maktx+"</td>"
								+"<td style='text-align: left;'>"+data.materialSearchList[i].zpttn+"</td>"
								+"<td style='text-align: right;'>"+data.materialSearchList[i].zwidth+"</td>"
								+"<td style='text-align: right;'>"+data.materialSearchList[i].zsries+"</td>"
								+"<td style='text-align: right;'>"+data.materialSearchList[i].inch+"</td>");
					});
					
					var pageContent = "";
					// 페이징 다시그리기
					$("#findMaterialPagingDiv").empty();
					
					if(data.matSearchPage.endPageNum==1){
						pageContent = "<input type='hidden' id='matPageNum' value='"+data.matSearchPageNum+"'/><input type='hidden' id='matEndPageNum' value='"+data.matSearchPage.endPageNum+"'/>" 
						+ "<a style='color: black; text-decoration: none;'> ◀ </a><input type='text' style='width: 50px; padding: 3px;' id='matPageInput' class='repUserPageInput' value='"+data.matSearchPage.startPageNum+"' onkeypress='matSearchEnter(event);'/>"  
						+"<a style='color: black; text-decoration: none;'> / "+data.matSearchPage.endPageNum+"</a>"
						+"<a style='color: black; text-decoration: none;''> ▶ </a>"
					} else if(data.matSearchPage.startPageNum == data.matSearchPage.endPageNum){
						pageContent ="<input type='hidden' id='matPageNum' value='"+data.matSearchPageNum+"'/><input type='hidden' id='matEndPageNum' value='"+data.matSearchPage.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+(data.matSearchPageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px;' id='matPageInput' class='repUserPageInput' value='"+data.matSearchPage.endPageNum+"' onkeypress=\"matSearchEnter(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+data.matSearchPage.endPageNum+") id='pNum'> / "+data.matSearchPage.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					} else if(data.matSearchPageNum == data.matSearchPage.startPageNum){
						pageContent ="<input type='hidden' id='matPageNum' value='"+data.matSearchPageNum+"'/><input type='hidden' id='matEndPageNum' value='"+data.matSearchPage.endPageNum+"'/>" 
						+ "<a style='color:black; text-decoration: none;'>◀</a><input type='text' style='width: 50px; padding: 3px;' id='matPageInput' class='repUserPageInput' value='"+data.matSearchPage.startPageNum+"' onkeypress=\"matSearchEnter(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+data.matSearchPage.endPageNum+") id='pNum'> / "+data.matSearchPage.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+(data.matSearchPageNum+1)+") id='pNum'> ▶ </a>";
					} else if(data.matSearchPageNum == data.matSearchPage.endPageNum){
						pageContent ="<input type='hidden' id='matPageNum' value='"+data.matSearchPageNum+"'/><input type='hidden' id='matEndPageNum' value='"+data.matSearchPage.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+(data.matSearchPageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px;' id='matPageInput' class='repUserPageInput' value='"+data.matSearchPage.endPageNum+"' onkeypress=\"matSearchEnter(event);\"/>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+data.matSearchPage.endPageNum+") id='pNum'> / "+data.matSearchPage.endPageNum+"</a>" 
						+"<a style='color:black; text-decoration: none;'>▶</a>";
					} else {
						pageContent ="<input type='hidden' id='matPageNum' value='"+data.matSearchPageNum+"'/><input type='hidden' id='matEndPageNum' value='"+data.matSearchPage.endPageNum+"'/>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+(data.matSearchPageNum-1)+") id='pNum'> ◀ </a>"
						+"<input type='text' style='width: 50px; padding: 3px;' id='matPageInput' class='repUserPageInput' value='"+data.matSearchPageNum+"' onkeypress=\"matSearchEnter(event);\"/>"
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+data.matSearchPage.endPageNum+") id='pNum'> / "+data.matSearchPage.endPageNum+"</a>" 
						+"<a style='cursor: pointer;' onclick=findMaterialInfo("+(data.matSearchPageNum+1)+") id='pNum'> ▶ </a>";
					}
					$("#findMaterialPagingDiv").append(pageContent); 
				}
			},
			beforeSend: function(){
	        	//viewLoadingShow();			
	        },
	        complete:function(){
	        //	viewLoadingHide();	
	        },
			error : function(request,status,error) {
		          alert("사용자페이징code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		});
	}
	
	//라디오 선택시 배경색 변경
	function matRadioSelect(obj){		
		$('#materialTbody').children().css('background-color','white');
		var radioId = obj.id;
		$('#'+radioId).parent().parent().css('background-color','#eaeaea');	
	}
	
	//
	function materialSearchOk(){		
	
		var radioVal = $('input:radio[name="materialRadio"]:checked').val();
		if(radioVal == null || radioVal == ""){
			alert("select.");
			return;
		}
		$('#materialClose').click();
		$('#material_txt').val(radioVal);
		
	}
	
	// material검색 페이징 엔터키
	function matSearchEnter(event) {		
		$(document).ready(function() {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				var pageNum = parseInt($("#matPageInput").val());				
				if ($("#matPageInput").val() == '') {
					alert("Input page number.")
					$("#matPageInput").val($("#matPageNum").val());
					$("#matPageInput").focus();
				} else if(pageNum > parseInt($("#matEndPageNum").val())) {
					alert("The page number is too large.");
					$("#matPageInput").val($("#matPageNum").val());
					$("#matPageInput").focus();
				} else if (1 > pageNum) {
					alert("The page number is too small.");
					$("#matPageInput").val($("#matPageNum").val());
					$("#matPageInput").focus();
				} else {					
					findMaterialInfo(pageNum);
				}
			}
			event.stopPropagation();
		});
	}
	
	///////////////////

	
	
	
	