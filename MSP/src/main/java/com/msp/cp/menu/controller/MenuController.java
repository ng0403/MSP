package com.msp.cp.menu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.code.service.CodeService;
import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.menu.service.MenuService;
import com.msp.cp.menu.vo.MenuVO;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping(value="/menu")
public class MenuController {
	
	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@Autowired
	MenuService menuService;
	
	@Autowired
	CodeService codeService;
	
	@RequestMapping(value="/menuInqr", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView deptList1(HttpServletRequest request, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageNum", pageNum);
		//페이징 처리
		PagerVO page = menuService.getMenuCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		//곹통코드 메뉴레벨 출력 list
		List<CodeVO> mLevel = codeService.menuLevel();
		
		//검색 결과 list
		List<MenuVO> list = menuService.menuList(map);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("page", page);
		mav.addObject("pageNum", pageNum);
		mav.addObject("level_list", mLevel);
		mav.addObject("menu_list", list);
		mav.setViewName("/menu/menu_list");
		
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
	    String menu_nm_key=request.getParameter("menu_nm_key").trim(); 
		
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
	    map.put("active_key", active_key);
		map.put("menu_nm_key", menu_nm_key);
		map.put("pageNum", pageNum);

		PagerVO page = menuService.getMenuCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<MenuVO> list = menuService.menuList(map);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("menu_list", list);

		return model;
	}
	
	@RequestMapping(value="/menuTreeInqr", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<List<MenuVO>> menuTreeList(HttpSession session){
		
		ResponseEntity<List<MenuVO>> entity = null;
		
		try{
			entity = new ResponseEntity<>(menuService.menuTreeList(), HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	
	@RequestMapping(value="/detail_list/{menu_cd}", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<List<MenuVO>> deptDetailList(@PathVariable("menu_cd") String menu_cd){
		
		ResponseEntity<List<MenuVO>> entity = null;
		
		try{
			entity = new ResponseEntity<>(menuService.menuDetailList(menu_cd), HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	@RequestMapping(value="/insert", method={RequestMethod.POST})
	public ResponseEntity<String> deptInsert(@RequestBody MenuVO mvo){
		
		ResponseEntity<String> entity = null;
		int result;

		try{
			result = menuService.menuInsert(mvo);
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
	public ResponseEntity<String> deptUpdate(@RequestBody MenuVO mvo){
		
		ResponseEntity<String> entity = null;
		int result;
		
		try{
			result = menuService.menuUpdate(mvo);
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
	
	@RequestMapping(value="/delete/{del_code}", method={RequestMethod.POST})
	public ResponseEntity<String> deptDelete(@PathVariable("del_code") String del_code){
		
		ResponseEntity<String> entity = null;
		int result;
		
		String[] delcode = del_code.split(",");
		
		for(int i = 0; i < delcode.length; i++)
		{
			try{
				String dc = delcode[i];
				result = menuService.menuDelete(dc);
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
	public @ResponseBody Map<String, Object> searchListPop(ModelMap model,
			HttpServletRequest request,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum){
		               
	    String menu_nm_key=request.getParameter("menu_nm_key").trim(); 
		
	    Map<String,Object> map = new HashMap<String,Object>();
	    
		map.put("menu_nm_key", menu_nm_key);
		map.put("pageNum", pageNum);

		PagerVO page = menuService.getMenuCount(map);
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<MenuVO> list = menuService.searchListPop(map);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("menu_list", list);

		return model;
	}

}
