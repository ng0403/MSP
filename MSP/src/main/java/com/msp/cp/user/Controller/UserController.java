package com.msp.cp.user.Controller;

import java.util.HashMap;
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

import com.msp.cp.common.PagerVO;
import com.msp.cp.dept.service.DeptService;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.user.Service.UserService;
import com.msp.cp.user.vo.userVO;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	DeptService deptService;
	
	//사용자관리 리스트
	@RequestMapping(value="/userlist", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView userListPage(HttpSession session, Locale locale,HttpServletRequest request, Model model,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			userVO userVO,String user_id_sch, String user_nm_sch, String dept_nm_sch ,
			@RequestParam(value = "code", defaultValue="empty") String selectcode,
			String excel, 
			@RequestParam Map<String, Object> userMap, 
			@RequestParam Map<String, Object> map)
	{
		user_id_sch = request.getParameter("user_id_sch");
		user_nm_sch = request.getParameter("user_nm_sch");
		dept_nm_sch = request.getParameter("dept_cd_sch");
		
		System.out.println("user Controller");
		
		map.put("pageNum", pageNum);
		map.put("user_id_sch", user_id_sch);
		map.put("user_nm_sch", user_nm_sch);
		map.put("dept_nm_sch", dept_nm_sch);
		
		System.out.println("1. USER List Controller pageNum : " + pageNum);
		
		System.out.println("2. user_id_sch : " + user_id_sch);
		System.out.println("3. user_nm_sch : " + user_nm_sch);
		System.out.println("4. dept_nm_sch : " + dept_nm_sch);
		
		PagerVO page=userService.getUserListCount(map);
		map.put("page", page);
		System.out.println("7. Controller USER_LIST Page : " + page.toString());
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
		
		if(excel != null){
			if(excel.equals("true")){
				ModelAndView mav = new ModelAndView("/user/user_list_excel");
				List<userVO> userExcel = userService.userExcel(userMap);
				mav.addObject("userExcel", userExcel);
				return mav;
			}
		}
		List<userVO> user_list = userService.searchListUser(map);

		System.out.println("15. User Search list : " +user_list);
		ModelAndView mov = new ModelAndView("/user/user_list", "user_list", user_list);
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum);
		mov.addObject("user_id_sch", user_id_sch);
		mov.addObject("user_nm_sch", user_nm_sch);
		mov.addObject("dept_cd_sch", dept_nm_sch);
		
		return mov;
		
	}
	
	//상세정보 팝업
	@RequestMapping(value="/userTab", method=RequestMethod.GET)
	public ModelAndView userTabListPage(HttpSession session, Locale locale,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum)
	{
		int entry_flg = 1;
		System.out.println("userTab Controller");
		
		List<userVO> rank_cd_list = userService.rankCdList();
		List<userVO> duty_cd_list = userService.dutyCdList();
		System.out.println("dept_sch_list Controller");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageNum", pageNum);
		//페이징 처리
		com.msp.cp.utils.PagerVO page = deptService.getDeptCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		//검색 결과 list
		List<DeptVO> dept_list = userService.dept_list(map);
		System.out.println("UserTab : " + rank_cd_list);
		ModelAndView mov = new ModelAndView("/user/user_tab");
		
		System.out.println("DeptTab : " + dept_list);
		
		mov.addObject("dept_list", dept_list);
		mov.addObject("entry_flg", entry_flg);
		mov.addObject("rank_cd_list", rank_cd_list);
		mov.addObject("duty_cd_list", duty_cd_list);
		
		return mov;
	}
	
	//사용자 추가
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
	
	//사용자 삭제
	@RequestMapping(value="userDel", method={RequestMethod.GET, RequestMethod.POST})
	public String userDel(String user_id) throws Exception { 
		System.out.println("del controller enter");
		String[] arrIdx = user_id.split(",");
		for (int i=0; i<arrIdx.length; i++) {
			System.out.println(arrIdx[i]);
			userService.userDel(arrIdx[i]);
		}
		return "redirect:/user/userlist";
	}
	
	//userMdfyPop 사용자 정보 수정 팝업
	@RequestMapping(value="/userMdfyPop", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView userMdfyPop(HttpSession session, Locale locale, HttpServletRequest req,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum)
	{
		String user_id = req.getParameter("user_id");
		int entry_flg = 2;
		System.out.println("GET USER_ID : " + user_id);
		 
		userVO vo= userService.searchListUserOne(user_id);
		System.out.println("After Service : " + vo);
		System.out.println("由ъ뒪�듃 : " + vo);
		ModelAndView mov = new ModelAndView("/user/user_detail");
		System.out.println("dept_sch_list Controller");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageNum", pageNum);
		//페이징 처리
		com.msp.cp.utils.PagerVO page = deptService.getDeptCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		//검색 결과 list
		List<DeptVO> dept_list = userService.dept_list(map);
		user_id = vo.getUser_id();
		String user_nm = vo.getUser_nm();
		String user_pwd = vo.getUser_pwd();
		String emp_no = vo.getEmp_no();
		String dept_cd = vo.getDept_cd();
		String dept_nm = vo.getDept_nm();
		String rank_cd = vo.getRank_cd();
		String rank_nm = vo.getRank_nm();
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
		List<userVO> rank_cd_list = userService.rankCdList();
		List<userVO> duty_cd_list = userService.dutyCdList();
		System.out.println("UserTab rank_cd_list : " + rank_cd_list);
		
		
		System.out.println("DeptTab : " + dept_list);
		mov.addObject("dept_list", dept_list);
		mov.addObject("user_id",user_id);
		mov.addObject("user_nm",user_nm);
		mov.addObject("user_pwd",user_pwd);
		mov.addObject("emp_no",emp_no);
		mov.addObject("dept_cd",dept_cd);
		mov.addObject("rank_cd",rank_cd);
		mov.addObject("rank_nm",rank_nm);
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
		mov.addObject("rank_cd_list", rank_cd_list);
		mov.addObject("duty_cd_list", duty_cd_list);
		mov.addObject("dept_nm", dept_nm);
		
		return mov;
	}
	
	//userMdfy 사용자 정보 수정
	@RequestMapping(value="/userMdfy", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView userMdfy(userVO vo, HttpServletRequest req)
	{
		String user_id = vo.getUser_id();
		
		vo.setUser_id(user_id);
		System.out.println("userModfy controller " + vo.getUser_id());
		userService.userMdfy(vo);
		System.out.println("insert success");
		ModelAndView mov = new ModelAndView("/user/user_detail");
		int result = 1;
		mov.addObject("result", result);
		System.out.println(mov);
		return mov;
		
		
	}
	

	//부서 검색 팝업
	@RequestMapping(value="/dept_Pop_sch_list", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView dept_sch_list(HttpSession session, Locale locale
			,HttpServletRequest request, Model model
			,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum
			,DeptVO deptVO, String dept_cd_sch, String sch_pop_condition)
	{
		dept_cd_sch = request.getParameter("dept_sch");
		sch_pop_condition = request.getParameter("sch_pop_condition");
		
		System.out.println("dept_sch_list Controller");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("pageNum", pageNum);
		map.put("dept_sch", dept_cd_sch);
		map.put("sch_pop_condition", sch_pop_condition);
		//페이징 처리
		com.msp.cp.utils.PagerVO page = deptService.getDeptCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		//검색 결과 list
		List<DeptVO> dept_list = userService.dept_list(map);
		
		ModelAndView mov = new ModelAndView("/user/user_tab");
		System.out.println("DeptTab : " + dept_list);
		mov.addObject("dept_list", dept_list);
		mov.addObject("dept_cd_sch", dept_cd_sch);
		mov.addObject("sch_pop_condition", sch_pop_condition);
		
		return mov;
	}
	
}
