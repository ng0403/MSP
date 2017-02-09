package com.msp.cp.dept.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.HomeController;
import com.msp.cp.utils.PagerVO;
import com.msp.cp.dept.service.DeptService;
import com.msp.cp.dept.vo.DeptVO;

@Controller
@RequestMapping(value="/dept/*")
public class DeptController {
	
	private static final Logger logger = LoggerFactory.getLogger(DeptController.class);
	
	@Autowired
	DeptService deptService;
	
	@RequestMapping(value="/list", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView deptList1(HttpServletRequest request, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageNum", pageNum);
		//페이징 처리
		PagerVO page = deptService.getDeptCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		//검색 결과 list
		List<DeptVO> list = deptService.deptList(map);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("page", page);
		mav.addObject("pageNum", pageNum);
		mav.addObject("dept_list", list);
		mav.setViewName("/dept/dept_list");
		
		return mav;
	}
	
	/*@RequestMapping(value="/search_list", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<List<DeptVO>> deptList(@ModelAttribute DeptVO dvo){
		
		ResponseEntity<List<DeptVO>> entity = null;
		
		try{
			entity = new ResponseEntity<>(deptService.deptList(dvo), HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}*/
	@RequestMapping(value="/search_list", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> deptList(ModelMap model,
			HttpServletRequest request,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum){
		
		String active_key=request.getParameter("active_key").trim();                      
	    String dept_nm_key=request.getParameter("dept_nm_key").trim(); 
		
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
	    map.put("active_key", active_key);
		map.put("dept_nm_key", dept_nm_key);
		map.put("pageNum", pageNum);

		PagerVO page = deptService.getDeptCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<DeptVO> list = deptService.deptList(map);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("dept_list", list);
		System.out.println(model);
		return model;
	}
	
	@RequestMapping(value="/detail_list/{dept_cd}", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<List<DeptVO>> deptDetailList(@PathVariable("dept_cd") String dept_cd){
		
		ResponseEntity<List<DeptVO>> entity = null;
		
		try{
			entity = new ResponseEntity<>(deptService.deptDetailList(dept_cd), HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	@RequestMapping(value="/insert", method={RequestMethod.POST})
	public ResponseEntity<String> deptInsert(@RequestBody DeptVO dvo){
		
		logger.info("insert 컨트롤러 호출");
		
		ResponseEntity<String> entity = null;
		int result;
		
		try{
			result = deptService.deptInsert(dvo);
			if(result==1){
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	@RequestMapping(value="/update", method={RequestMethod.POST})
	public ResponseEntity<String> deptUpdate(@RequestBody DeptVO dvo){
		
		ResponseEntity<String> entity = null;
		int result;
		
		try{
			result = deptService.deptUpdate(dvo);
			if(result==1){
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	/*@RequestMapping(value="/delete", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView deptDelete(@RequestParam(value="del_code") String del_code){

		String[] delcode = del_code.split(",");
		
		ModelAndView mav = new ModelAndView();
		
		for(int i = 0; i < delcode.length; i++)
		{
			String dc = delcode[i];
			
			int result1 = deptService.deptDelete(dc);
		}
		
		mav.setViewName("redirect:/dept/list");
		
		return mav;
	}*/
	
	@RequestMapping(value="/delete", method={RequestMethod.POST})
	public ResponseEntity<String> deptDelete(@PathVariable("del_code") String del_code){
		
		ResponseEntity<String> entity = null;
		int result;
		
		String[] delcode = del_code.split(",");
		
		for(int i = 0; i < delcode.length; i++)
		{
			try{
				String dc = delcode[i];
				result = deptService.deptDelete(dc);
				
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

}
