package com.msp.cp.user.Controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.dept.service.DeptService;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.user.Service.UserService;
import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	DeptService deptService;
	
	//사용자관리 리스트
//	@ResponseBody
	@RequestMapping(value="/userInqr", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView userListPage(HttpSession session, Locale locale,HttpServletRequest request, Model model,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			userVO userVO,String active_key, String user_sch_key, String dept_nm_sch ,
			@RequestParam(value = "code", defaultValue="empty") String selectcode,
			String excel, 
			@RequestParam Map<String, Object> userMap, 
			@RequestParam Map<String, Object> map)
	{
//		user_id_sch = request.getParameter("user_id_sch");
//		user_nm_sch = request.getParameter("user_nm_sch");
//		dept_nm_sch = request.getParameter("dept_cd_sch");
		active_key = request.getParameter("active_key");
		user_sch_key = request.getParameter("user_sch_key");
		System.out.println("user Controller");
		
		map.put("pageNum", pageNum);
		map.put("active_key", active_key);
		map.put("user_sch_key", user_sch_key);
//		map.put("user_id_sch", user_id_sch);
//		map.put("user_nm_sch", user_nm_sch);
//		map.put("dept_nm_sch", dept_nm_sch);
		
		System.out.println("1. USER List Controller pageNum : " + pageNum);
		
//		System.out.println("2. user_id_sch : " + user_id_sch);
//		System.out.println("3. user_nm_sch : " + user_nm_sch);
//		System.out.println("4. dept_nm_sch : " + dept_nm_sch);
		
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
		ModelAndView mov = new ModelAndView("/user/user_list");
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum);
//		mov.addObject("user_id_sch", user_id_sch);
//		mov.addObject("user_nm_sch", user_nm_sch);
//		mov.addObject("dept_cd_sch", dept_nm_sch);
		mov.addObject("active_key", active_key);
		mov.addObject("user_sch_key", user_sch_key);
		mov.addObject("user_list", user_list);
		System.out.println("16. User Search list : " + mov);
		return mov;
		
	}
	@RequestMapping(value="/userAjax_list", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> userList(ModelMap model,
			HttpServletRequest request,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum){
		System.out.println("aJax list Controller");
		
		String active_key=request.getParameter("active_key").trim();                      
	    String user_sch_key=request.getParameter("user_sch_key").trim(); 
		
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
	    map.put("active_key", active_key);
		map.put("user_sch_key", user_sch_key);
		map.put("pageNum", pageNum);

		PagerVO page=userService.getUserListCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("page", page);

		List<userVO> user_list = userService.searchListUser(map);
		
		System.out.println(user_list);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("user_list", user_list);

		return model;
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
	@RequestMapping(value="/userDel/{del_code}", method={RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<String> userDel(String user_id, @PathVariable("del_code") String del_code) throws Exception {
		System.out.println("삭제 컨트롤러 입성");
		ResponseEntity<String> entity = null;
		int result;
		
		String[] delcode = del_code.split(",");
		System.out.println(delcode.length);
		for(int i = 0; i < delcode.length; i++)
		{
			try{
				String dc = delcode[i];
				result = userService.userDel(dc);
				if(result==1){
					entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				}
			}catch(Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
		}		
		return entity;
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
	
	//상세정보 팝업
	@RequestMapping(value="/excelImportTab", method=RequestMethod.GET)
	public ModelAndView excelImportTab(HttpSession session, Locale locale,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum)
	{
		System.out.println("ExcelTab Controller");
		ModelAndView mov = new ModelAndView("/user/excel_import_tab");
		return mov;
	}
//	Excel Data Import
    @RequestMapping(value = "/excelUploadAjax", headers = "content-type=multipart/*", method = RequestMethod.POST)
    public ModelAndView excelUploadAjax(MultipartHttpServletRequest request)  throws Exception{
        MultipartFile excelFile =request.getFile("excelFile");
        System.out.println("excelFile : " + excelFile);
		
        System.out.println("엑셀 파일 업로드 컨트롤러");
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
//        파일 저장경로입니다. 제 pc에는 D 드라이브가 없어서 E로 써놨습니다. -이지용_2017_02_17-
        File destFile = new File("E:\\"+excelFile.getOriginalFilename());
        System.out.println("destFile : " + destFile);
        try{
            excelFile.transferTo(destFile);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }
        
        int result = userService.excelUpload(destFile);
        System.out.println("result : " + result);
        if(result == 1){
        	System.out.println("Excel Insert 성공");
        }else
        {
        	System.out.println("Excel Insert 실패");
        }
        return new ModelAndView("/user/user_list", "result", result);
    }
}
