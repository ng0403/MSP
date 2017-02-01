package com.crm.cp.test.user.Controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.crm.cp.test.user.Service.UserService;
import com.crm.cp.test.user.vo.userVO;

@Controller
@RequestMapping(value="/usertest")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value="/userlist", method=RequestMethod.GET)
	public ModelAndView userListPage(HttpSession session, Locale locale,
			@RequestParam(value = "currentPageNum", defaultValue="1") int currentPageNum,
			@RequestParam(value = "searchnotice", defaultValue="") String searchnotice,
			@RequestParam(value = "code", defaultValue="empty") String selectcode)
	{
		System.out.println("user Controller");
		
		List<Object> list = userService.searchListUser();
//		if(session.getAttribute("user") == null){
//			 //ModelAndView mov = new ModelAndView("redirect:/");
//			employeeService.searchListEmployee();   
//			//return mov;
//		}
		//userService.searchListUser();
		System.out.println(list);
		ModelAndView mov = new ModelAndView("/test/user/user", "list", list);
		
		return mov;
		
	}

	@RequestMapping(value="/userTab", method=RequestMethod.GET)
	public ModelAndView userTabListPage(HttpSession session, Locale locale)
	{
		int entry_flg = 1;
		System.out.println("userTab Controller");
		ModelAndView mov = new ModelAndView("/test/user/userTab");
		mov.addObject("entry_flg", entry_flg);
		
		return mov;
	}
	
	@RequestMapping(value="/userInsert", method=RequestMethod.POST)
	public ModelAndView userInsert(userVO vo, HttpSession session) {
		System.out.println("userInsert Controller" + vo.toString());
		userService.insertUser(vo);
		System.out.println("insert success");
		ModelAndView mov = new ModelAndView("/test/user/userTab");
		int result = 1;
		mov.addObject("result", result);
		System.out.println(mov);
		
		return mov;
	}
	
	@RequestMapping(value="userDel", method=RequestMethod.GET)
	public String userDel(String user_id) throws Exception { 
		System.out.println("del controller enter");
		String[] arrIdx = user_id.split(",");
		for (int i=0; i<arrIdx.length; i++) {
			System.out.println(arrIdx[i]);
			userService.userDel(arrIdx[i]);
		}
		return "redirect:/usertest/userlist";
	}
	
	//userMdfyPop
	@RequestMapping(value="/userMdfyPop", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView userMdfyPop(HttpSession session, Locale locale, HttpServletRequest req)
	{
		String user_id = req.getParameter("user_id");
		int entry_flg = 2;
		System.out.println("GET USER_ID : " + user_id);
		 
		userVO vo= userService.searchListUserOne(user_id);
		System.out.println("After Service : " + vo);
		System.out.println("리스트 : " + vo);
		ModelAndView mov = new ModelAndView("test/user/userTab");
		
		String USER_ID = vo.getUSER_ID();
		String USER_NAME = vo.getUSER_NAME();
		String PWD = vo.getPWD();
		String CELL_PHONE = vo.getCELL_PHONE();
		String COMPANY_PHONE = vo.getCOMPANY_PHONE();
		String P_CHANNEL_CD = vo.getP_CHANNEL_CD();
		String USER_TYPE_CD = vo.getUSER_TYPE_CD();
		String EMAIL = vo.getEMAIL();
		String HOME_PHONE = vo.getHOME_PHONE();
		String ORG_ID = vo.getORG_ID();
		String ACTIVE_FLG = vo.getACTIVE_FLG();
		
		
		mov.addObject("USER_ID",USER_ID);
		mov.addObject("USER_NAME",USER_NAME);
		mov.addObject("PWD",PWD);
		mov.addObject("EMAIL",EMAIL);
		mov.addObject("HOME_PHONE",HOME_PHONE);
		mov.addObject("CELL_PHONE",CELL_PHONE);
		mov.addObject("COMPANY_PHONE",COMPANY_PHONE);
		mov.addObject("P_CHANNEL_CD",P_CHANNEL_CD);
		mov.addObject("USER_TYPE_CD",USER_TYPE_CD);
		mov.addObject("ORG_ID",ORG_ID);
		mov.addObject("ACTIVE_FLG",ACTIVE_FLG);
		mov.addObject("entry_flg", entry_flg);
		
		return mov;
	}
	
	//userMdfy
	@RequestMapping(value="/userMdfy", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView userMdfy(userVO vo, HttpServletRequest req)
	{
		String user_id = vo.getUSER_ID();
		
		vo.setUSER_ID(user_id);
		System.out.println("정보수정 controller " + vo.getUSER_ID());
		userService.userMdfy(vo);
		System.out.println("insert success");
		ModelAndView mov = new ModelAndView("/test/user/userTab");
		int result = 1;
		mov.addObject("result", result);
		System.out.println(mov);
		return mov;
		
		
	}
}
