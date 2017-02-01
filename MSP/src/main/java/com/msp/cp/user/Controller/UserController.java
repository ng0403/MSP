package com.msp.cp.user.Controller;

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

import com.msp.cp.user.Service.UserService;
import com.msp.cp.user.vo.userVO;

@Controller
@RequestMapping(value="/user")
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
		System.out.println("User Search list" + list);
		ModelAndView mov = new ModelAndView("/user/user_list", "list", list);
		
		return mov;
		
	}

	@RequestMapping(value="/userTab", method=RequestMethod.GET)
	public ModelAndView userTabListPage(HttpSession session, Locale locale)
	{
		int entry_flg = 1;
		System.out.println("userTab Controller");
		ModelAndView mov = new ModelAndView("/user/user_tab");
		mov.addObject("entry_flg", entry_flg);
		
		return mov;
	}
	
	@RequestMapping(value="/userInsert", method=RequestMethod.POST)
	public ModelAndView userInsert(userVO vo, HttpSession session) {
		System.out.println("userInsert Controller : " + vo.toString());
		userService.insertUser(vo);
		System.out.println("insert success");
		ModelAndView mov = new ModelAndView("/user/user_tab");
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
		return "redirect:/user/userlist";
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
		System.out.println("由ъ뒪�듃 : " + vo);
		ModelAndView mov = new ModelAndView("/user/user_tab");
		
		user_id = vo.getUser_id();
		String user_nm = vo.getUser_nm();
		String user_pwd = vo.getUser_pwd();
		String emp_no = vo.getEmp_no();
		String dept_cd = vo.getDept_cd();
		String rank_cd = vo.getRank_cd();
		String duty_cd = vo.getDuty_cd();
		String cphone_num1 = vo.getCphone_num1();
		String cphone_num2 = vo.getCphone_num2();
		String cphone_num3 = vo.getCphone_num3();
		String phone_num1 = vo.getPhone_num1();
		String phone_num2 = vo.getPhone_num2();
		String phone_num3 = vo.getPhone_num3();
		String email_id = vo.getEmail_id();
		String email_domain = vo.getEmail_domain();
		String hiredate = vo.getHiredate();
		String retiredate = vo.getRetiredate();
		String active_flg = vo.getActive_flg();
		String del_flg = vo.getDel_flg();
		
		
		
		
		mov.addObject("user_id",user_id);
		mov.addObject("user_nm",user_nm);
		mov.addObject("user_pwd",user_pwd);
		mov.addObject("emp_no",emp_no);
		mov.addObject("dept_cd",dept_cd);
		mov.addObject("rank_cd",rank_cd);
		mov.addObject("duty_cd",duty_cd);
		mov.addObject("cphone_num1",cphone_num1);
		mov.addObject("cphone_num2",cphone_num2);
		mov.addObject("cphone_num3",cphone_num3);
		mov.addObject("phone_num1",phone_num1);
		mov.addObject("phone_num2",phone_num2);
		mov.addObject("phone_num3",phone_num3);
		mov.addObject("email_id",email_id);
		mov.addObject("email_domain",email_domain);
		mov.addObject("hiredate",hiredate);
		mov.addObject("retiredate",retiredate);
		mov.addObject("active_flg",active_flg);
		mov.addObject("del_flg", del_flg);
		mov.addObject("entry_flg", entry_flg);
		
		return mov;
	}
	
	//userMdfy
	@RequestMapping(value="/userMdfy", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView userMdfy(userVO vo, HttpServletRequest req)
	{
		String user_id = vo.getUser_id();
		
		vo.setUser_id(user_id);
		System.out.println("�젙蹂댁닔�젙 controller " + vo.getUser_id());
		userService.userMdfy(vo);
		System.out.println("insert success");
		ModelAndView mov = new ModelAndView("/user/user_tab");
		int result = 1;
		mov.addObject("result", result);
		System.out.println(mov);
		return mov;
		
		
	}
}
