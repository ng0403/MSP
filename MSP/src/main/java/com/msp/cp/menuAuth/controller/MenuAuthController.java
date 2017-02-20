package com.msp.cp.menuAuth.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
		
		String auth_id_sch = request.getParameter("auth_id_sch").trim();
		String menu_nm_sch = request.getParameter("menu_nm_sch").trim();
		
		if(auth_id_sch == null)
		{
			auth_id_sch = "";
		}
		if(menu_nm_sch == null)
		{
			menu_nm_sch = "";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("auth_id_sch", auth_id_sch);
		map.put("menu_nm_sch", menu_nm_sch);
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
	
	/**
	 * 업 무 명 : 메뉴권한상세보기
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/15
     * 수 정 자 : 이재욱
     * 수 정 일 : 2017/02/16
	 * 내     용 : 해당 클릭한 값의 상세정보를 띄어준다.
	 * 		    팝업위치 및 CSS 수정 
	 * */
	@RequestMapping(value="/menuAuthDetail", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String, Object> menuAuthDeatail(ModelMap model, HttpServletRequest request)
	{
		String menu_cd = request.getParameter("menu_cd").trim();
		String auth_nm = request.getParameter("auth_nm").trim();
		
		if(menu_cd == null)
		{
			menu_cd = "";
		}
		if(auth_nm == null)
		{
			auth_nm = "";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("menu_cd", menu_cd);
		map.put("auth_nm", auth_nm);
		
		List<MenuAuthVO> menuAuthDetail = menuAuthService.menuAuthDetail(map);
		
		System.out.println("맵 : " + map);
		System.out.println("리스트 : " + menuAuthDetail);
		
		model.addAttribute("menuAuthDetail", menuAuthDetail);
		
		return model;
	}
	
	/**
	 * 업 무 명 : 메뉴권한 등록
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/17
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 공통코드 등록한다. 
	 * */
	@RequestMapping(value="/menuAuthAdd", method={RequestMethod.GET, RequestMethod.POST})
	public String menuAuthInsert(MenuAuthVO menuAuthVo, HttpServletRequest request)
	{
		String auth_id = request.getParameter("auth_id");
		String menu_cd = request.getParameter("menu_cd");
		String inqr_auth = request.getParameter("inqr_auth3");
		String add_auth = request.getParameter("add_auth3");
		String mdfy_auth = request.getParameter("mdfy_auth3");
		String del_auth = request.getParameter("del_auth3");
		String menu_acc_auth = request.getParameter("menu_acc_auth3");
		
		System.out.println(auth_id);
		System.out.println(inqr_auth);
		
		menuAuthVo.setAuth_id(auth_id);
		menuAuthVo.setMenu_cd(menu_cd);
		menuAuthVo.setInqr_auth(inqr_auth);
		menuAuthVo.setAdd_auth(add_auth);
		menuAuthVo.setMdfy_auth(mdfy_auth);
		menuAuthVo.setDel_auth(del_auth);
		menuAuthVo.setMenu_acc_auth(menu_acc_auth);
		menuAuthVo.setCreated_by("ADMIN");
		
		menuAuthService.insertMenuAuth(menuAuthVo);
		
		return "redirect:/menuAuth/menuAuthInqr";
	}
	
	/**
	 * 업 무 명 : 메뉴권한 수정
	 * 작 성 자 : 이재욱
     * 작 성 일 : 2017/02/20
     * 수 정 자 : 
     * 수 정 일 : 
	 * 내     용 : 공통코드 수정한다. 
	 * */
	@RequestMapping(value="/menuAuthMdfy", method={RequestMethod.GET, RequestMethod.POST})
	public String menuAuthMdfy(MenuAuthVO menuAuthVo, HttpServletRequest request)
	{
		String auth_id    = request.getParameter("auth_id2");
		String menu_cd    = request.getParameter("menu_cd1");
		String active_flg = request.getParameter("active_flg1");
		String inqr_auth  = request.getParameter("inqr_auth1");
		String add_auth   = request.getParameter("add_auth1");
		String mdfy_auth  = request.getParameter("mdfy_auth1");
		String del_auth   = request.getParameter("del_auth1");
		String menu_acc_auth = request.getParameter("menu_acc_auth1");
		
		menuAuthVo.setAuth_id(auth_id);
		menuAuthVo.setMenu_cd(menu_cd);
		menuAuthVo.setActive_flg(active_flg);
		menuAuthVo.setInqr_auth(inqr_auth);
		menuAuthVo.setAdd_auth(add_auth);
		menuAuthVo.setMdfy_auth(mdfy_auth);
		menuAuthVo.setDel_auth(del_auth);
		menuAuthVo.setMenu_acc_auth(menu_acc_auth);
		
		menuAuthService.mdfyMenuAuth(menuAuthVo);
		
		return "redirect:/menuAuth/menuAuthInqr";
	}
	
}
