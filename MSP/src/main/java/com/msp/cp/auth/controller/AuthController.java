package com.msp.cp.auth.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.auth.service.AuthService;
import com.msp.cp.auth.vo.AuthVO;

@Controller
@Repository(value="/ahth")
public class AuthController {
	
	@Autowired
	AuthService authService;
	
	@RequestMapping(value="/auth_list", method=RequestMethod.GET)
	public ModelAndView authList(HttpSession session, Locale locale,
			@RequestParam(value = "currentPageNum", defaultValue="1") int currentPageNum,
			@RequestParam(value = "searchnotice", defaultValue="") String searchnotice,
			@RequestParam(value = "code", defaultValue="empty") String selectcode)
	{
		System.out.println("auth 진입");
		
		List<Object> authList = authService.searchListAuth();
		 
		ModelAndView mov = new ModelAndView("/auth/auth_list");
		mov.addObject("authList", authList);
		System.out.println("리스트" + mov);
		return mov;
		
	}
	
	@RequestMapping(value="/auth_pop", method=RequestMethod.GET)
	public ModelAndView authPop(HttpSession session, Locale locale, AuthVO authVO,  HttpServletRequest req) {
 	  
		ModelAndView mov = new ModelAndView("/auth/auth_pop");
  		return mov; 
	}
	
	@RequestMapping(value="/auth_update_pop", method=RequestMethod.GET)
	public ModelAndView authUpdatePop(HttpSession session, Locale locale, AuthVO authVO, HttpServletRequest req) {
		String check = req.getParameter("AUTH_NM");
		
		System.out.println("check" + check);

		List<Object> authCheck = authService.authCheck(check);
		System.out.println("1111111"+ authCheck);
		ModelAndView mov = new ModelAndView("/auth/auth_update_pop");
 		mov.addObject("authCheck", authCheck);
 		System.out.println("업데이트" + mov);
 		return mov; 
	}
	
	
	@RequestMapping(value="/auth_write", method=RequestMethod.POST)
	public ModelAndView authInsertPage(AuthVO authVO){
		System.out.println("write입성" + authVO.toString());
	    authService.insertAuth(authVO);
	    
	    ModelAndView mov = new ModelAndView("/auth/auth_pop");
	   
	    mov.addObject("result", "success");
 	    return mov; 
	} 
	
	@RequestMapping(value="/auth_update", method=RequestMethod.POST)
	public ModelAndView authUpdatePage(AuthVO authVO){
		System.out.println("업데이트" + authVO.toString());
		authService.updateAuth(authVO);
		ModelAndView mov = new ModelAndView("/auth/auth_pop");
		mov.addObject("result", "success");
		System.out.println("업데이트 시작" + mov);

		return mov;
	}
	
	@RequestMapping(value="auth_delete", method=RequestMethod.POST)
	public String authDeletePage(String del_code) { 
		
	String[] delcode = del_code.split(",");
	
	for(int i = 0; i < delcode.length; i++)
	{
		String dc = delcode[i];
		System.out.println("delete..." + dc);
		authService.deleteAuth(dc);
	}
	
	return "redirect:/auth/auth_list";
	  
	}  
	

}
