package com.msp.cp;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.msp.cp.userAuth.vo.UserAuthVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/home";
	}
	
	/* -----------------------------
 	 * 업 무 명 : 메인화면 페이지 변경
 	    작 성 자 : 공재원 (jwjy0223@naver.com)
 	    작 성 일 : 2017/02/23
 	    수 정 자 : 공재원 (jwjy0223@naver.com)
 	    수 정 일 : 2017/02/23
 	    내 용 : 왼쪽 탭 선택으로 변경된 페이지 url전달.
 	   *참고사항 :
 	   -------------------------------*/ 
     @RequestMapping(value = "/changeMngPage", method = { RequestMethod.GET, RequestMethod.POST })
     public @ResponseBody Map<String, Object> changeMngPage(HttpServletRequest request,
    		 Locale locale, ModelMap model) {
  	    //String user_id = request.getParameter("user_id").trim(); 
    	//String user_nm = request.getParameter("user_nm").trim(); 
  	    //페이지명
  	    String page = request.getParameter("page");
  	    String url = "";
  	    if("user".equals(page)){
  	    	url = "../user/user_list.jsp";
  	    }else if("auth".equals(page)){
  	    	url = "../auth/auth_list.jsp";	
  	    }else if("board".equals(page)){
  	    	url = "../board/board_list.jsp";	
  	    }else if("code".equals(page)){
  	    	url = "../code/code_list.jsp";	
  	    }else if("dept".equals(page)){
  	    	url = "../dept/dept_list.jsp";	
  	    }else if("userAuth".equals(page)){
  	    	url = "../userAuth/user_auth_list.jsp";	
  	    }else if("menuAuth".equals(page)){
  	    	url = "../menuAuth/menuAuth_list.jsp";	
  	    }
        
        model.addAttribute("url", url);
        model.addAttribute("page", page);
        //model.addAttribute("user_nm",user_nm);
        //model.addAttribute("user_id",user_id);
        return model;
     }
	
}
