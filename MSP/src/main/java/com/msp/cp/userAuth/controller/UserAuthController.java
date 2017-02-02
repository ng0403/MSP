package com.msp.cp.userAuth.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.userAuth.dao.UserAuthDao;
import com.msp.cp.userAuth.service.UserAuthService;
import com.msp.cp.userAuth.vo.UserAuthVO;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping(value = "/userAuth")
public class UserAuthController {
	
	@Autowired UserAuthService userAuthService;
	@Autowired UserAuthDao userAuthDao;

	/* -----------------------------
	 * 업 무 명 : 사용자권한 리스트 화면
	    작 성 자 : 공재원 (jwjy0223@naver.com)
	    작 성 일 : 2017/02/01
	    수 정 자 : 공재원 (jwjy0223@naver.com)
	    수 정 일 : 2017/02/01
	    내 용 : 사용자권한 list 화면을 보여준다.
	   *참고사항 :
	  -------------------------------*/ 
	@RequestMapping(value = "/view", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView userAuthList(HttpServletRequest request,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
		ModelAndView mav = new ModelAndView("/userAuth/user_auth_list");
		//UserAuthVO mv = userAuthService.getUserId(map);
		//String user_id5 = mv.getUser_id();
		
		//권한 list
		List<AuthVO> authList= userAuthService.authList(map);
		
		map.put("pageNum", pageNum);
		
		//페이징 처리
		PagerVO page = userAuthService.getUserAuthCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		//검색 결과 list
		List<UserAuthVO> list= userAuthService.userAuthList(map);
		
		mav.addObject("page", page);
		mav.addObject("pageNum", pageNum);
		//mav.addObject("user_id5", user_id5);
		mav.addObject("authList", authList);
		mav.addObject("list", list);

		return mav;
	}
	
	/* -----------------------------
	 * 업 무 명 : 사용자권한 조회 화면
	    작 성 자 : 공재원 (jwjy0223@naver.com)
	    작 성 일 : 2017/02/01
	    수 정 자 : 공재원 (jwjy0223@naver.com)
	    수 정 일 : 2017/02/01
	    내 용 : 사용자권한 list의 조회한 결과 화면을 보여준다.
	   *참고사항 :
	  -------------------------------*/ 
     @RequestMapping(value = "/userAuthSearchList")
	 public @ResponseBody Map<String, Object> userAuthSearchList(ModelMap model,
				HttpServletRequest request,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		    String user_id=request.getParameter("user_id").trim();                      
		    String user_nm=request.getParameter("user_nm").trim();                      
		    String auth_id=request.getParameter("auth_id").trim();                      
		    
		    if(user_id == null){
		    	user_id ="";
		    }
		    if(user_nm == null){
		    	user_nm ="";
		    }
		    if(auth_id == null){
		    	auth_id ="";
		    }
		    
		    Map<String,Object> map = new HashMap<String,Object>();
		    
			map.put("user_id", user_id);
			map.put("user_nm", user_nm);
			map.put("auth_id", auth_id);
			map.put("pageNum", pageNum);
			
			//페이징 처리
			PagerVO page = userAuthService.getUserAuthCount(map);
			if(page.getEndRow()==1){
				page.setEndRow(0);
			}
			
			int startRow = page.getStartRow();
			int endRow = page.getEndRow();
			
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			
			//검색 결과 list
			List<UserAuthVO> list= userAuthService.userAuthList(map);

			model.addAttribute("list", list);
			model.addAttribute("page", page);
			model.addAttribute("pageNum", pageNum);
			return model;
	 }
     
     /* -----------------------------
 	 * 업 무 명 : 사용자권한 상세 화면
 	    작 성 자 : 공재원 (jwjy0223@naver.com)
 	    작 성 일 : 2017/02/01
 	    수 정 자 : 공재원 (jwjy0223@naver.com)
 	    수 정 일 : 2017/02/01
 	    내 용 : 선택한 사용자권한 상세화면을 보여준다.
 	   *참고사항 :
 	   -------------------------------*/ 
     @RequestMapping(value = "/openUserAuthDetail")
     public @ResponseBody Map<String, Object> openUserAuthDetail(HttpServletRequest request,
    		 Locale locale, ModelMap model) {
  	    String user_id = request.getParameter("user_id").trim(); 
  	    //메뉴 상세정보 호출
  	    UserAuthVO mv = userAuthService.openUserAuthDetail(user_id);
  	    
        /*String user_nm = mv.getUser_nm();							
        String p_user_id = mv.getP_user_id();							
        String menu_level = mv.getMenu_level();					
        String menu_url = mv.getMenu_url();						
        String default_flg = mv.getDefault_flg();				
        String active_flg = mv.getActive_flg();			
        String c_user_id = mv.getC_user_id();			
        String cdate = mv.getCdate();			
        String u_user_id = mv.getU_user_id();			
        String udate = mv.getUdate();
        if(u_user_id == null){
        	u_user_id = "";
        }
        if(udate == null){
        	udate = "";
        }
        if(p_user_id == null){
        	p_user_id = "";
        }*/
        
        /*model.addAttribute("user_id", user_id);
        model.addAttribute("user_nm", user_nm);
        model.addAttribute("p_user_id", p_user_id);
        model.addAttribute("menu_level", menu_level);
        model.addAttribute("menu_url", menu_url);
        model.addAttribute("default_flg", default_flg);
        model.addAttribute("active_flg", active_flg);
        model.addAttribute("c_user_id", c_user_id);
        model.addAttribute("cdate", cdate);
        model.addAttribute("u_user_id", u_user_id);
        model.addAttribute("udate", udate);*/
        
        return model;
     }
     
     /* -----------------------------
 	 * 업 무 명 : 사용자권한 등록
 	    작 성 자 : 공재원 (jwjy0223@naver.com)
 	    작 성 일 : 2017/02/01
 	    수 정 자 : 공재원 (jwjy0223@naver.com)
 	    수 정 일 : 2017/02/01
 	    내 용 : menu를 등록, 저장한다.
 	   *참고사항 :
 	 -------------------------------*/ 
     @RequestMapping(value = "/createMenu", method = RequestMethod.POST)
     public String createUserAuth(Locale locale, Model model, HttpServletRequest request) {
         String user_id = request.getParameter("user_id3").trim();                  	
         String user_nm = request.getParameter("user_nm3").trim();				
         String p_user_id = request.getParameter("p_user_id3").trim();					
         String menu_level = request.getParameter("menu_level3").trim();					
         String menu_url=request.getParameter("menu_url3").trim();				
         String default_flg = request.getParameter("default_flg3").trim();			
         String active_flg = request.getParameter("active_flg3").trim();			
       
         UserAuthVO mv = new UserAuthVO();
               
         /*mv.setuser_id(user_id);
         mv.setuser_nm(user_nm);
         mv.setP_user_id(p_user_id);
         mv.setMenu_level(menu_level);
         mv.setMenu_url(menu_url);
         mv.setDefault_flg(default_flg);
         mv.setActive_flg(active_flg);*/

         //userAuthService.createMenu(mv);
         return "redirect:"+"/userAuth/view";
     }
     
     /* -----------------------------
 	 * 업 무 명 : 사용자권한 수정
 	    작 성 자 : 공재원 (jwjy0223@naver.com)
 	    작 성 일 : 2017/02/01
 	    수 정 자 : 공재원 (jwjy0223@naver.com)
 	    수 정 일 : 2017/02/01
 	    내 용 : 선택한 사용자권한을 수정하고 저장한다.
 	   *참고사항 :
 	-------------------------------*/ 
     @RequestMapping(value = "/updateUserAuth", method = RequestMethod.POST)
     public String updateUserAuth(Locale locale, Model model, 
           HttpServletRequest request) {
    	String user_id = request.getParameter("user_id1").trim();
        String user_nm=request.getParameter("user_nm1").trim();			
        String p_user_id=request.getParameter("p_user_id1").trim();			
        String menu_level=request.getParameter("menu_level1").trim();			
        String menu_url=request.getParameter("menu_url1").trim();			
        String default_flg=request.getParameter("default_flg1").trim();			
        String active_flg=request.getParameter("active_flg1").trim();			
        /*UserAuthVO mv = userAuthService.openMenuDetail(user_id);
        
        mv.setuser_id(user_id);
        mv.setuser_nm(user_nm);
        mv.setMenu_level(menu_level);
        mv.setMenu_url(menu_url);
        mv.setDefault_flg(default_flg);
        mv.setActive_flg(active_flg);
        userAuthService.updateMenu(mv);*/
        return "redirect:" + "/userAuth/view";
     }
     
     /* -----------------------------
 	 * 업 무 명 : 사용자권한 삭제
 	    작 성 자 : 공재원 (jwjy0223@naver.com)
 	    작 성 일 : 2017/02/01
 	    수 정 자 : 공재원 (jwjy0223@naver.com)
 	    수 정 일 : 2017/02/01
 	    내 용 : 선택한 사용자권한을 삭제한다.
 	   *참고사항 :
 	-------------------------------*/ 
 	 /*@RequestMapping(value = "/deleteUserAuth", method = RequestMethod.POST)
 	 public String deleteUserAuth(Locale locale, Model model, 
 			 HttpServletRequest request) {
 		 String[] checks = request.getParameterValues("chk");
 		 if(checks.length == 0){
 			System.out.println("삭제할 데이터가 없습니다.");
 		 }else{
 		     for(int i=0;i<checks.length;i++){
 			     UserAuthVO mv = userAuthService.openMenuDetail(checks[i]);
 			
 			     userAuthService.deleteMenu(mv);
 		     }
 		     System.out.println("삭제가 완료되었습니다.");
 		 }
 		 return "redirect:" + "/menu/view";
 	 }*/
}
