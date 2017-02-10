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
  	    //사용자권한 상세정보 호출
  	    UserAuthVO uav = userAuthService.openUserAuthDetail(user_id);
  	    
        String user_nm = uav.getUser_nm();							
        String agg_auth_id = uav.getAgg_auth_id();							
        String agg_auth_nm = uav.getAgg_auth_nm();							
        String dept_nm = uav.getDept_nm();					
        String email = uav.getEmail();						
        String email_id = uav.getEmail_id();						
        String email_domain = uav.getEmail_domain();				
        String active_flg = uav.getActive_flg();			
        String created_by = uav.getCreated_by();			
        String created = uav.getCreated();			
        String updated_by = uav.getUpdated_by();			
        String updated = uav.getUpdated();			
        if(updated_by == null){
        	updated_by = "";
        }
        if(updated == null){
        	updated = "";
        }
        if(email == null){
        	email = "";
        }
        if(email_id == null){
        	email_id = "";
        }
        if(email_domain == null){
        	email_domain = "";
        }
        if(dept_nm == null){
        	dept_nm = "";
        }
        
        model.addAttribute("user_id", user_id);
        model.addAttribute("user_nm", user_nm);
        model.addAttribute("agg_auth_id", agg_auth_id);
        model.addAttribute("agg_auth_nm", agg_auth_nm);
        model.addAttribute("dept_nm", dept_nm);
        model.addAttribute("email", email);
        model.addAttribute("email_id", email_id);
        model.addAttribute("email_domain", email_domain);
        model.addAttribute("active_flg", active_flg);
        model.addAttribute("created_by", created_by);
        model.addAttribute("created", created);
        model.addAttribute("updated_by", updated_by);
        model.addAttribute("updated", updated);
        
        return model;
     }
     
     /* -----------------------------
 	 * 업 무 명 : 사용자권한 등록
 	    작 성 자 : 공재원 (jwjy0223@naver.com)
 	    작 성 일 : 2017/02/01
 	    수 정 자 : 공재원 (jwjy0223@naver.com)
 	    수 정 일 : 2017/02/01
 	    내 용 : 사용자권한을 등록, 저장한다.
 	   *참고사항 :
 	 -------------------------------*/ 
     @RequestMapping(value = "/createUserAuth", method = RequestMethod.POST)
     public String createUserAuth(Locale locale, Model model, HttpServletRequest request) {
         				
         String[] auth_id = request.getParameterValues("auth_id3");
         String user_id = request.getParameter("user_id3").trim();                  	
         String user_nm = request.getParameter("user_nm3").trim();
         String dept_cd = request.getParameter("dept_cd3").trim();					
         String dept_nm = request.getParameter("dept_nm3").trim();					
         String email_id=request.getParameter("email_id3").trim();				
         String email_domain = request.getParameter("email_domain3").trim();			
         String active_flg = request.getParameter("active_flg3").trim();			
       
         UserAuthVO uav = new UserAuthVO();
         
         if(auth_id.length == 0){
  			System.out.println("입력할 사용자권한 데이터가 없습니다.");
  		 }else{
  		     for(int i=0;i<auth_id.length;i++){
  			     /*UserAuthVO uav = userAuthService.openUserAuthDetail(checks[i]);*/
  		    	 uav.setUser_id(user_id);
  		         uav.setUser_nm(user_nm);
  		         uav.setAuth_id(auth_id[i]);
  		         uav.setDept_cd(dept_cd);
  		         uav.setDept_nm(dept_nm);
  		         uav.setEmail_id(email_id);
  		         uav.setEmail_domain(email_domain);
  		         uav.setActive_flg(active_flg);   
  			     userAuthService.createUserAuth(uav);
  		     }
  		     System.out.println("저장이 완료되었습니다.");
  		 }

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
        //String user_nm=request.getParameter("user_nm1").trim();			
        String[] auth_id=request.getParameterValues("auth_id1");			
        //String dept_cd=request.getParameter("dept_cd1").trim();			
        //String dept_nm=request.getParameter("dept_nm1").trim();			
        //String email_id=request.getParameter("email_id1").trim();			
        //String email_domain=request.getParameter("email_domain1").trim();			
        String active_flg=request.getParameter("active_flg1").trim();			
        UserAuthVO uav = userAuthService.openUserAuthDetail(user_id);
        
        if(auth_id.length == 0){
  			System.out.println("입력할 사용자권한 데이터가 없습니다.");
  		}else{
  		    for(int i=0;i<auth_id.length;i++){
  		        uav.setAuth_id(auth_id[i]);
  		        uav.setActive_flg(active_flg);   
  			    userAuthService.updateUserAuth(uav);
  		    }
  		    System.out.println("수정이 완료되었습니다.");
  		}
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
 	 @RequestMapping(value = "/deleteUserAuth", method = RequestMethod.POST)
 	 public String deleteUserAuth(Locale locale, Model model, 
 			 HttpServletRequest request) {
 		 String[] checks = request.getParameterValues("chk");
 		 if(checks.length == 0){
 			System.out.println("삭제할 데이터가 없습니다.");
 		 }else{
 		     for(int i=0;i<checks.length;i++){
 			     UserAuthVO uav = userAuthService.openUserAuthDetail(checks[i]);
 			
 			     userAuthService.deleteUserAuth(uav);
 		     }
 		     System.out.println("삭제가 완료되었습니다.");
 		 }
 		 return "redirect:" + "/userAuth/view";
 	 }
}
