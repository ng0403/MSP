package com.msp.cp.auth.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.auth.service.AuthService;
import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.common.PagerVO;
import com.msp.cp.user.vo.userVO;

@Controller
@RequestMapping(value="/auth")
public class AuthController {
	
	@Autowired
	AuthService authService;
	
	/* -----------------------------
	    업 무 명 : 권한 리스트 화면
	    작 성 자 : 송영화 (yhsong@coreplus.co.kr)
	    작 성 일 : 2017/01/31
	    수 정 자 : 송영화 (yhsong@coreplus.co.kr)
	    수 정 일 : 2017/02/08
	    내    용 : 권한 list 화면을 보여준다.
	   *참고사항 :
	 ------------------------------- */ 
	
	@RequestMapping(value="/authlist", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView authList(HttpSession session, Locale locale,HttpServletRequest request, Model model,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			AuthVO authVO, String active_flg_y, String active_flg_n, String keyword ,
			@RequestParam(value = "code", defaultValue="empty") String selectcode,
			@RequestParam Map<String, Object> map) {
		active_flg_y = request.getParameter("active_flg_y");
		active_flg_n = request.getParameter("active_flg_n");
		keyword  	 = request.getParameter("keyword");
		
		System.out.println("auth 진입");
		
		map.put("pageNum", pageNum);
		map.put("active_flg_y", active_flg_y);
		map.put("active_flg_n", active_flg_n);
		map.put("keyword", keyword);
		
		System.out.println("01. List Controller pageNum : " + pageNum);
		System.out.println("02. active_flg_y : " + active_flg_y);
		System.out.println("03. active_flg_n : " + active_flg_n);
		System.out.println("04. keyword : " + keyword);
		
		PagerVO page = authService.getAuthListCount(map);
		
		map.put("page", page);
		System.out.println("07. Controller AUTH_LIST Page : " + page.toString());
		
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
		
		List<AuthVO> list = authService.searchListAuth(map);
		 
		ModelAndView mov = new ModelAndView("/auth/auth_list", "list", list);
		
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum);
		mov.addObject("active_flg_y", active_flg_y);
		mov.addObject("active_flg_n", active_flg_n);
		mov.addObject("keyword", keyword);
		
		return mov;
		
	}
	
	@RequestMapping(value="/auth_pop", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView authPop(HttpSession session, Locale locale, AuthVO authVO,  HttpServletRequest req) {
 	  
		ModelAndView mov = new ModelAndView("/auth/auth_pop");
  		return mov; 
	}
	
	@RequestMapping(value="/auth_update_pop", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView authUpdatePop(HttpSession session, Locale locale, AuthVO authVO, HttpServletRequest req) {
		String check = req.getParameter("auth_id");
		
		System.out.println("check : " + check);

		List<Object> authCheck = authService.authCheck(check);
		System.out.println("1111111"+ authCheck);
		
		ModelAndView mov = new ModelAndView("/auth/auth_update_pop");
 		mov.addObject("authCheck", authCheck);
 		System.out.println("업데이트" + mov);
 		
 		return mov; 
	}
	
	
	@RequestMapping(value="/auth_write", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView authInsertPage(AuthVO authVO){
		
		System.out.println("write입성" + authVO.toString());
	    authService.insertAuth(authVO);
	    
	    ModelAndView mov = new ModelAndView("/auth/auth_pop");
	   
	    mov.addObject("result", "success");
 	    return mov; 
	} 
	
	@RequestMapping(value="/auth_update", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView authUpdatePage(AuthVO authVO){
		
		System.out.println("업데이트" + authVO.toString());
		authService.updateAuth(authVO);
		
		ModelAndView mov = new ModelAndView("/auth/auth_pop");
		mov.addObject("result", "success");
		System.out.println("업데이트 시작" + mov);

		return mov;
	}
	
	@RequestMapping(value="auth_delete",  method={RequestMethod.POST})
	public String authDel(String del_code) throws Exception { 
		
		System.out.println("del controller enter");
		
		System.out.println("++++여기: " + del_code);
		
		String[] delcode = del_code.split(",");
		
		System.out.println("delcode" + delcode);
		
		for(int i = 0; i < delcode.length; i++)
		{
			String dc = delcode[i];
			System.out.println("delete..." + dc);
			authService.deleteAuth(dc);
		}
		
		return "redirect:/auth/authlist";
		
	}
	
	
}
