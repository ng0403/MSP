package com.msp.cp.auth.controller;

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


import com.msp.cp.auth.service.AuthService;
import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping(value="/auth")
public class AuthController {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	@Autowired
	AuthService authService;
	
	/* -----------------------------
	    업 무 명 : 권한 리스트 화면
	    작 성 자 : 송영화 (yhsong@coreplus.co.kr)
	    작 성 일 : 2017/01/31
	    수 정 자 : 송영화 (yhsong@coreplus.co.kr)
	    수 정 일 : 2017/02/08
	    내    용 : 권한 list 화면을 보여준다.
	   *참고사항 :
	 ------------------------------- */ 
	
	@RequestMapping(value="/list", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView authList1(HttpServletRequest request, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageNum", pageNum);
		
		//페이징 처리
		PagerVO page = authService.getAuthCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		//검색 결과 list
		List<AuthVO> list = authService.authList(map);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("page", page);
		mav.addObject("pageNum", pageNum);
		mav.addObject("auth_list", list);
		mav.setViewName("/auth/auth_list");
		
		return mav;
	}
	
	
	@RequestMapping(value="/search_list", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> authList( ModelMap model, HttpServletRequest request,
													   @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		
		String active_key = request.getParameter("active_key").trim();                      
		String keyword    = request.getParameter("keyword");
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
	    map.put("active_key", active_key);
		map.put("keyword", keyword);
		map.put("pageNum", pageNum);

		PagerVO page = authService.getAuthCount(map);
		
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<AuthVO> list = authService.authList(map);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("auth_list", list);

		return model;
	}
	
	@RequestMapping(value="/detail_list/{auth_id}", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<List<AuthVO>> authDetailList(@PathVariable("auth_id") String auth_id){
		
		ResponseEntity<List<AuthVO>> entity = null;
		
		try{
			
			entity = new ResponseEntity<>(authService.authDetailList(auth_id), HttpStatus.OK);
			
		}catch(Exception e){
			
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	@RequestMapping(value="/insert", method={RequestMethod.POST})
	public ResponseEntity<String> authInsert(@RequestBody AuthVO authVO){
		
		logger.info("insert 컨트롤러 호출");
		
		ResponseEntity<String> entity = null;
		int result;
		
		try{
			result = authService.authInsert(authVO);
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
	public ResponseEntity<String> authUpdate(@RequestBody AuthVO authVO){
		
		ResponseEntity<String> entity = null;
		
		int result;
		
		try{
			result = authService.authUpdate(authVO);
			if(result==1){
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	
	@RequestMapping(value="/delete/{del_code}", method={RequestMethod.POST})
	public ResponseEntity<String> authDelete(@PathVariable("del_code") String del_code){
		
		ResponseEntity<String> entity = null;
		int result;
		
		String[] delcode = del_code.split(",");
		
		for(int i = 0; i < delcode.length; i++)
		{
			try{
				String dc = delcode[i];
				result = authService.authDelete(dc);
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
	
	@RequestMapping(value="/search_list_pop", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> searchListPop( ModelMap model, HttpServletRequest request,
													   @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		                      
		String keyword    = request.getParameter("keyword");
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
		map.put("keyword", keyword);
		map.put("pageNum", pageNum);

		PagerVO page = authService.getAuthCount(map);
		
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<AuthVO> list = authService.searchListPop(map);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("auth_list", list);

		return model;
	}
	
}
