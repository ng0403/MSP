package com.msp.cp.code.controller;

import java.util.List;
import java.util.Locale;
import java.util.concurrent.SynchronousQueue;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.code.service.CodeService;
import com.msp.cp.code.vo.CodeVO;

@Controller
@RequestMapping(value="/code")
public class CodeController {
	
	@Autowired
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
	public ModelAndView codeInqr(HttpSession session, Locale locale,
			@RequestParam(value = "currentPageNum", defaultValue="1") int currentPageNum, Model model, CodeVO vo) throws Exception{
		
		System.out.println("code 진입");
		
		List<Object> codeInqrList = codeService.searchCodeList();
		 
		ModelAndView mov = new ModelAndView("/code/code_list");
		mov.addObject("codeInqrList", codeInqrList);
		
		return mov;
	}
	
	// 공통코드
	@RequestMapping(value="/codeMasterAdd", method={RequestMethod.GET, RequestMethod.POST})
	public String codeMasterInsert(CodeVO codeVo)
	{
		System.out.println("codeMaster insert");
		
		codeVo.setCreated_by("ADMIN");		
		codeService.insertCodeMaster(codeVo);
				
		return "redirect:/code/codeInqr";
	}
	
	// 상세코드
	@RequestMapping(value="/codeDetailAdd", method={RequestMethod.GET, RequestMethod.POST})
	public String codeDetailInsert(CodeVO codeVo)
	{
		System.out.println("codeDetail insert");

		codeVo.setGrp_cd("06");
		codeVo.setCreated_by("ADMIN");
		
		System.out.println(codeVo.getGrp_cd());
		
		codeService.insertCodeDetail(codeVo);
		
		
		System.out.println("insert 완료");
		
		return "redirect:/code/codeInqr";
	}
	
	@RequestMapping(value="/codeMasterDel", method={RequestMethod.GET, RequestMethod.POST})
	public String codeMasterDelete(CodeVO codeVo)
	{
		codeService.deleteCodeMaster(codeVo);
		
		return "redirect:/code/codeInqr";
	}
	
	@RequestMapping(value="/codeDetailDel", method={RequestMethod.GET, RequestMethod.POST})
	public String codeDetailDelete(CodeVO codeVo, String del_code)
	{
		String[] delCode = del_code.split(",");
		
		for(int i=0; i<delCode.length; i++)
		{
			String dc = delCode[i];
			
			System.out.println(dc);
			
			codeVo.setCode1(dc);
			
			codeService.deleteCodeDetail(codeVo);
		}
		
		return "redirect:/code/codeInqr";
	}
	
	@RequestMapping(value="/codeDetail_list/{code1}", method={RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<List<CodeVO>> codeDetail(@PathVariable("code1") String code1)
	{
		ResponseEntity<List<CodeVO>> entity = null;
		
		CodeVO codeVo = new CodeVO();
		
		codeVo.setCode1(code1);
		
		System.out.println(codeVo.getCode1());
		
		try {
			entity = new ResponseEntity<>(codeService.searchCodeDetail(codeVo), HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
