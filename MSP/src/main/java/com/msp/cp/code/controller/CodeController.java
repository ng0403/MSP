package com.msp.cp.code.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.code.service.CodeService;
import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.common.SessionAuth.SessionAuthService;
import com.msp.cp.common.SessionAuth.SessionAuthVO;
import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping(value="/code")
public class CodeController {
	
	@Autowired
	CodeService codeService;
	
	@Autowired
	SessionAuthService sessionAuthService;
	
	/**
	 * 업 무 명 : codeInqr 코드조회 화면
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/01/31
     * 수 정 자 : 이재욱
     * 수 정 일 : 2017/02/23
	 * 내     용 : 공통코드 및 상세코드를 조회한다. 
	 *        엑셀출력 버트능ㄹ 클릭 했을 시 엑셀 Export 기능을 추가.
	 * */
	@RequestMapping(value="/codeInqr", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView codeInqr(HttpSession session, Locale locale,
			@RequestParam(value = "pageNum", defaultValue="1") int pageNum, 
			@RequestParam(value = "currentPageNum", defaultValue="1") int currentPageNum, 
			@RequestParam Map<String, Object> map, @RequestParam Map<String, Object> codeMap, 
			Model model, CodeVO vo, String excel) throws Exception {
		
		map.put("pageNum", pageNum);
		
		String sessionID = (String)session.getAttribute("user_id");
		PagerVO page = codeService.getCodeListCount(map);
		
		map.put("sessionID", sessionID);
		map.put("page", page);
		
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
		
		// Excel Export 해주는 부분
		if(excel != null){
			if(excel.equals("true")){
				ModelAndView mav = new ModelAndView("/code/code_list_excel");
				List<userVO> codeExcel = codeService.userExcel(codeMap);
				
				mav.addObject("codeExcel", codeExcel);
				
				return mav;
			}
		}
		
		System.out.println("CodeInqr");
		
		List<Object> codeInqrList = codeService.searchCodeList(map);
		List<SessionAuthVO> session_auth_list = sessionAuthService.sessionInqr(map);
		ModelAndView mov = new ModelAndView("/code/code_list");
		
		System.out.println(session_auth_list);
		
		mov.addObject("page", page);
		mov.addObject("pageNum", pageNum);
		mov.addObject("codeInqrList", codeInqrList);
			
		return mov;
	}
	
	/**
	 * 업 무 명 : 공통코드 등록
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/01
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 공통코드 등록한다. 
	 * */
	@RequestMapping(value="/codeMasterAdd", method={RequestMethod.GET, RequestMethod.POST})
	public String codeMasterInsert(CodeVO codeVo)
	{
		codeVo.setCreated_by("ADMIN");		
		codeService.insertCodeMaster(codeVo);
				
		return "redirect:/code/codeInqr";
	}
	
	/**
	 * 업 무 명 : 공통코드 삭제
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/02
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 선택한 공통코드를 삭제한다. 
	 * */
	@RequestMapping(value="/codeMasterDel", method={RequestMethod.GET, RequestMethod.POST})
	public String codeMasterDelete(CodeVO codeVo)
	{
		codeService.deleteCodeMaster(codeVo);
		
		return "redirect:/code/codeInqr";
	}
	
	/**
	 * 업 무 명 : 상세코드 등록
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/01
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 공통코드를 선택 후에 상세코드를 등록한다. 
	 * */
	@RequestMapping(value="/codeDetailAdd", method={RequestMethod.GET, RequestMethod.POST})
	public String codeDetailInsert(CodeVO codeVo)
	{
		codeVo.setCreated_by("ADMIN");
		
		codeService.insertCodeDetail(codeVo);
		
		return "redirect:/code/codeInqr";
	}
	
	/**
	 * 업 무 명 : 상세코드 수정
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/13
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 해당 상세코드 수정
	 * */
	@RequestMapping(value = "codeDetailMdfy", method={RequestMethod.GET, RequestMethod.POST})
	public String codeDetailModify(CodeVO codeVo)
	{
		codeService.modifyCodeDetail(codeVo);
		
		return "redirect:/code/codeInqr"; 
	}
	
	/**
	 * 업 무 명 : 상세코드 삭제
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/02
     * 수 정 자 : 이재욱
     * 수 정 일 : 2017/02/03
	 * 내     용 : 전체 선택을 한 후에 모든 정보(해당된 상세코드의 정보)를 삭제를 한다. 
	 * */
	@RequestMapping(value="/codeDetailDel", method={RequestMethod.GET, RequestMethod.POST})
	public String codeDetailDelete(CodeVO codeVo, String del_code)
	{
		String[] delCode = del_code.split(",");
		
		for(int i=0; i<delCode.length; i++)
		{
			String dc = delCode[i];
			
			codeVo.setCode1(dc);
			
			codeService.deleteCodeDetail(codeVo);
		}
		
		return "redirect:/code/codeInqr";
	}
	
	/**
	 * 업 무 명 : 상세보기 화면
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/06
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 리스트 행을 클릭 했을 시 해당 정보를 띄어준다. 
	 * */
	@RequestMapping(value="/codeDetail_list/{code1}", method={RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<List<CodeVO>> codeDetail(@PathVariable("code1") String code1)
	{
		ResponseEntity<List<CodeVO>> entity = null;
		
		CodeVO codeVo = new CodeVO();
		codeVo.setCode1(code1);		// code1을 통해 검색을 하면 공통코드까지 함께 나온다.
				
		try {
			entity = new ResponseEntity<>(codeService.searchCodeDetail(codeVo), HttpStatus.OK);
			
		} catch(Exception e) {
			// TODO: handle exception
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	/**
	 * 업 무 명 : Search 코드조회 화면(수정본)
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/08
     * 수 정 자 : 이재욱
     * 수 정 일 : 2017/02/13
	 * 내     용 : 조건에 맞는 공통코드를 검색한다.
	 *        공통코드를 입력하지 않았을 경우에는 전체 리스트를 페이징 처리하여 띄어준다.(17/02/13) 
	 * */	
	@RequestMapping(value="/codeSearch_list2", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String, Object> searchGrpList2(ModelMap model, HttpServletRequest request, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum)
	{
		String grp_cd = request.getParameter("grp_cd_sch").trim();
		String grp_nm = request.getParameter("grp_nm_sch").trim();
		
		if(grp_cd == null)
		{
			grp_cd = "";
		}
		if(grp_nm == null)
		{
			grp_nm = "";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("grp_cd", grp_cd);
		map.put("grp_nm", grp_nm);
		map.put("pageNum", pageNum);
		
		PagerVO page = codeService.getCodeListCount(map);
		map.put("page", page);
		
		if(page.getEndRow() == 1)
		{
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		List<CodeVO> codeInqrList = codeService.searchGrpList2(map);
		
		model.addAttribute("codeInqrList", codeInqrList);
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		
		return model;
	}
	
	/**
	 * 업 무 명 : 공통코드 선택팝업
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/10
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 공통코드를 선택할 수 있는 팝업을 띄어준다. 
	 * */
	@RequestMapping(value="/searchGrpPop", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String, Object> searchGrpPopup(ModelMap model)
	{
		List<CodeVO> grpPop = codeService.searchGrpPop();
		
		model.addAttribute("grpPop", grpPop);
		
		return model;
	}
	
	
}

















