package com.msp.cp.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.msp.cp.login.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService loginService;
	
/*	@Autowired
	MenuService menuService;*/
	
	@Autowired
	private HttpSession session;
	
/*	// 로그인 페이지로 이동
	@RequestMapping(value = "/", method=RequestMethod.GET)
	public String loginPage(HttpSession session){
		return "/login/login";
	}*/
	
	//로그인처리
	@RequestMapping(value = "/login", method={RequestMethod.POST,RequestMethod.GET})
	public String Login(String user_id, String user_pwd, Model model
			, RedirectAttributes redirectAttributes){
		
		String result = loginService.doLogin(user_id, user_pwd);
		/*MenuVo loginMenu = loginService.getLoginMenuInfo();
		
		String menu_id = loginMenu.getMenu_id();
		String menu_url = loginMenu.getMenu_url();*/
		redirectAttributes.addAttribute("user_id",user_id);
		redirectAttributes.addAttribute("user_pwd",user_pwd);
		
		model.addAttribute("user_id",user_id);
		model.addAttribute("user_pwd",user_pwd);
		//ModelAndView mav = new ModelAndView("/include/main");
		
		//String destPage="";
		if(result.equals("LOGIN_SUCCESS")){
			// 로그인이 성공한 경우, 모니터링 - 통합상황판 페이지로 이동
			/*destPage ="redirect:/user/userInqr";*/
			//destPage ="redirect:/main";
//			destPage = "redirect:/"+menu_url+"?menu_id="+menu_id;
			return "redirect:/user/userInqr";
		}else{
			// 로그인이 실패한 경우
			return "redirect:/user/userInqr";
//			redirect:/" + "?loginResult=" + result
		}
		
	}
	@RequestMapping(value = "/main", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView gotoMain(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
		ModelAndView mav = new ModelAndView("/user/user_list");
		
		System.out.println(user_id);
		mav.addObject("user_id",user_id);
		mav.addObject("user_pwd",user_pwd);
		
		return mav;
	}

	//로그아웃
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logoutPage(HttpSession session){
		session.invalidate();
		return "redirect:/";
	}
	
	//세션이 만료되었거나 로그인정보가 없을 때
	@RequestMapping(value="/sessionExpire", method=RequestMethod.GET)
	public String sessionExpire(HttpSession session){
		session.invalidate();
		return "/login/session_expire";
	}
	
	//에러페이지로 이동
	@RequestMapping(value="/goToError")
	public String goErrorPage(){
		return "/common/error";
	}
	
	//에러페이지로 이동 Redirect
	@RequestMapping(value="/error")
	public String errorPage(){
		return "redirect:/goToError";
	}
		
	// 임시 메인 페이지
	@RequestMapping(value="/mainPage")
	public ModelAndView mainPage(HttpSession session){
		ModelAndView mav = new ModelAndView("mainPage");
		menuImport(mav, "mainPage");
		return mav;
	}
	
	// 메뉴 가져오기
	public void menuImport(ModelAndView mav, String url){
		//String menu_id = menuService.getMenuUrlID(url);
		String user_id = session.getAttribute("user").toString();
			
		// 메뉴에 따른 권한 주기
		Map<String, String> menuAuthMap = new HashMap<String, String>();
		menuAuthMap.put("menu_url", url);
		menuAuthMap.put("user_id", user_id);
		//menuAuthMap.put("menu_id", menu_id);
			
		//메뉴 그리기
		//List<MenuVo> mainMenuList = menuService.getMainMenuList(user_id);
		//List<MenuVo> subMenuList = menuService.getSubMenuList(menuAuthMap);
		//mav.addObject("mainMenuList", mainMenuList);  //mainMenuList
		//mav.addObject("subMenuList", subMenuList);    //subMenuList
	}
	
}
