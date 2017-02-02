package com.msp.cp.dept.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.dept.service.DeptService;
import com.msp.cp.dept.vo.DeptVO;

@Controller
@RequestMapping(value="/dept")
public class DeptCotroller {
	
	@Autowired
	DeptService deptService;
	
	@RequestMapping(value="/list", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView deptList(){
		
		List<DeptVO> list = deptService.deptList();
		
		ModelAndView mav = new ModelAndView("dept/dept_list");
		
		mav.addObject("dept_list", list);
		
		return mav;
	}
	
	@RequestMapping(value="/detail_list/{dept_cd}", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<List<DeptVO>> deptDetailList(@RequestBody DeptVO dvo){
		
		ResponseEntity<List<DeptVO>> entity = null;
		
		try{
			entity = new ResponseEntity<>(deptService.deptDetailList(dvo), HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	@RequestMapping(value="/insert", method={RequestMethod.POST})
	public ResponseEntity<String> deptInsert(@RequestBody DeptVO dvo){
		
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
	
	@RequestMapping(value="/delete", method={RequestMethod.GET,RequestMethod.POST})
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
	}

}
