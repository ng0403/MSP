package com.msp.cp.code.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.msp.cp.code.service.CodeService;

@Controller
@RequestMapping("/code/*")
public class CodeController {
	
	@Inject
	CodeService codeService;
	
	/**
	 * 업 무 명 : codeInqr 코드조회 화면
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/01/31
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 공통코드 및 상세코드를 조회한다. 
	 * */
	@RequestMapping(value="/codeInqr", method={RequestMethod.GET, RequestMethod.POST})
	public void codeInqr() throws Exception{
		
		//codeService.list();
	}
	
}
