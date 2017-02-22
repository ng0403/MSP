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
import com.msp.cp.menu.vo.MenuVO;
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
		active_key = request.getParameter("active_key");
		user_sch_key = request.getParameter("user_sch_key");
		System.out.println("user Controller");
		
		map.put("pageNum", pageNum);
		map.put("active_key", active_key);
		map.put("user_sch_key", user_sch_key);
		
		System.out.println("1. USER List Controller pageNum : " + pageNum);
		
		
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
		mov.addObject("active_key", active_key);
		mov.addObject("user_sch_key", user_sch_key);
		mov.addObject("user_list", user_list);
		System.out.println("16. User Search list : " + mov);
		return mov;
		
	}
	
	//ajax Controller
	@RequestMapping(value="/userAjax_list", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> userList(ModelMap model,
			HttpServletRequest request,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum){
		System.out.println("aJax list Controller");
		
		String active_key=request.getParameter("active_key").trim();                      
	    String user_sch_key=request.getParameter("user_sch_key").trim(); 
	    
	    System.out.println("active_key : "  + active_key);
	    System.out.println("user_sch_key : "  + user_sch_key);
		
	    
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
	@RequestMapping(value="/userMdfyPop/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<List<userVO>> userMdfyPop(HttpSession session, Locale locale, HttpServletRequest req,@PathVariable("id") String user_id)
	{
		ResponseEntity<List<userVO>> entity = null;
		try{
			entity = new ResponseEntity<>(userService.searchListUserOne(user_id), HttpStatus.OK);
			System.out.println("디비 다녀와쪙");
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	//temp code ajax Controller
	@RequestMapping(value="/user_code_list/{id}", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> user_code_list(ModelMap model,
			HttpServletRequest request,@PathVariable("id") String user_id){
		System.out.println("aJax list Controller");
		
//		Map<String,Object> map = new HashMap<String,Object>();
		List<userVO> rank_cd_list = userService.rankCdList();
		List<userVO> duty_cd_list = userService.dutyCdList();
		
		List<userVO> user_list = userService.searchListUserOne(user_id);
		
		System.out.println(user_list);
		
		model.addAttribute("user_list", user_list);
		model.addAttribute("rank_cd_list", rank_cd_list);
		model.addAttribute("duty_cd_list", duty_cd_list);
		
		return model;
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
        return new ModelAndView("/user/excel_import_tab", "result", result);
    }
}
