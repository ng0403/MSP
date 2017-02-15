package com.msp.cp.menuAuth.controller;

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

import com.msp.cp.common.PagerVO;
import com.msp.cp.menuAuth.service.MenuAuthService;
import com.msp.cp.menuAuth.vo.MenuAuthVO;

@Controller
@RequestMapping(value="/menuAuth")
public class MenuAuthController {
	
	@Autowired
	MenuAuthService menuAuthService;

	/**
	 * 업 무 명 : menuAuthInqr 메뉴권한조회 화면
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/14
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 메뉴권한을 조회한다. 
	 * */
	@RequestMapping(value="/menuAuthInqr", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView menuAuthInqr(HttpSession session, Locale locale,
			@RequestParam(value = "pageNum", defaultValue="1") int pageNum, 
			@RequestParam(value = "currentPageNum", defaultValue="1") int currentPageNum, 
			@RequestParam Map<String, Object> map, Model model, MenuAuthVO vo) throws Exception {
		System.out.println(pageNum);
		map.put("pageNum", pageNum);
		
		PagerVO page = menuAuthService.getMenuAuthListCount(map);
		
		map.put("page", page);
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
		
		System.out.println("page map :" + map.get("page"));
		
		List<Object> menuAuthInqrList = menuAuthService.searchMenuAuthList(map);
		System.out.println(menuAuthInqrList.toString());
		
		ModelAndView mov = new ModelAndView("/menuAuth/menuAuth_list");
		
		mov.addObject("page", page);
		mov.addObject("pageNum", pageNum);
		mov.addObject("menuAuthInqrList", menuAuthInqrList);
			
		return mov;
	}
	
	/**
	 * 업 무 명 : 메뉴권한조회 화면(검색)
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/14
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 조건에 맞는 메뉴권한를 검색한다.
	 * */
	@RequestMapping(value="/menuAuth_list", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String, Object> searchMenuAuthList(ModelMap model, HttpServletRequest request, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum)
	{
		System.out.println(pageNum);
		
		String menuAuth_sch = request.getParameter("menuAuth_sch").trim();
		
		if(menuAuth_sch == null)
		{
			menuAuth_sch = "";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("menuAuth_sch", menuAuth_sch);
		map.put("pageNum", pageNum);
		
		PagerVO page = menuAuthService.getMenuAuthListCount(map);
		map.put("page", page);
		
		if(page.getEndRow() == 1)
		{
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow   = page.getStartRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		List<MenuAuthVO> menuAuthInqrList = menuAuthService.searchMenuAuth(map);
		
		System.out.println("맵 : " + map);
		System.out.println("리스트 : " + menuAuthInqrList);
		
		model.addAttribute("menuAuthInqrList", menuAuthInqrList);
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		
		return model;
	}
	
	
	
	
	
	
	
}
