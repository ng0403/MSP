package com.msp.cp.code.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.msp.cp.code.service.CodeService;

@Controller
@RequestMapping("/code")
public class CodeController {
	
	@Inject
	CodeService codeService;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public void boardList() throws Exception{
		
		codeService.list();
		
	}
	
	

}
