package com.msp.cp.boardmng.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.boardmng.service.BoardMngService;
import com.msp.cp.boardmng.vo.BoardMngVO;
import com.msp.cp.common.PagerVO;

@Controller
@RequestMapping("/board_mng")
public class BoardMngController {
	
	@Autowired
	BoardMngService boardmngService;
	
	
	@RequestMapping("/boardmngInqr")
	public ModelAndView boardmngList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, @RequestParam Map<String, Object> map ) throws Exception{
		System.out.println("board_mng_list entering");
		System.out.println("pagenum" + pageNum);
		map.put("pageNum", pageNum);
		
 		PagerVO page= boardmngService.getBoardMngListCount(map); 
		System.out.println("pagevo" + page.toString());
		map.put("page", page);
		
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
 		List<Object> boardmnglist = boardmngService.list(map); 
 		
		ModelAndView mov = new ModelAndView("/board_mng/board_mng_list");
		mov.addObject("boardmnglist", boardmnglist);
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum); 

		System.out.println("board_list" + mov);
		return mov; 
		
	}
	
	@RequestMapping(value="/board_mng_detail", method=RequestMethod.GET)
	public void board_mng_detail(@RequestParam("BOARD_MNG_NO")String BOARD_MNG_NO, Model model ){
		
	System.out.println("board_mng_detail entering");
	
	model.addAttribute("board_mng_list", boardmngService.detail(BOARD_MNG_NO));
	System.out.println("board_mng_detail" + model.toString());
		
	}
	
	@RequestMapping(value="/board_mng_modify", method=RequestMethod.GET)
	public void board_mng_modify(){ 
		System.out.println("modify page entering");
	}
	
	
	@RequestMapping(value="/board_mng_modify", method=RequestMethod.POST)
	public String board_mng_modify(BoardMngVO vo){
			
		System.out.println("BOARD_MNG_MODIFY ENTERING" + vo.toString());
		
		boardmngService.modify(vo);
		System.out.println("modify success" + vo.toString());
		return "redirect:/board_mng/boardmngInqr";
	}
	
	@RequestMapping(value="/board_mng_add" ,method=RequestMethod.GET)
	public void board_mng_add() {
		
	}
	
	
	@RequestMapping(value="/board_mng_add" ,method=RequestMethod.POST)
	public String board_mng_add_post(BoardMngVO vo) {
		
		System.out.println("enter board_mng_add...");
		System.out.println("vo is  " + vo);
		boardmngService.add(vo);
		
		return "redirect:/board_mng/boardmngInqr";
		
	}
	
	
	@RequestMapping(value="/board_mng_remove" ,method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> board_mng_remove(@RequestBody String del_code){
		System.out.println("remove insert" + del_code);
		 
		String[] delcode = del_code.split(",");
		
		
		for(int i = 0; i < delcode.length; i++)
		{
			String dc = delcode[i];
			System.out.println("delete..." + dc);
			boardmngService.remove(dc);
			System.out.println("success"); 
		} 
		
		Map<String, Object> map = new HashMap<String, Object>(); 

		 List<Object> ajaxlist =  boardmngService.ajaxlist(); 
	     map.put("data", ajaxlist);
	     System.out.println("ajax map? " + map.toString());
		
 	     
		return map;
		
	}
	
	@RequestMapping(value="/board_mng_codetxt", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> board_mng_codetxt(@RequestBody String CODE_TXT ) {
		
		System.out.println("hello codetxt" + CODE_TXT);
		Map<String, Object> map = new HashMap<String, Object>(); 
		List<Object> codelist = boardmngService.codetxt(CODE_TXT);
		map.put("data", codelist);
		
		System.out.println(map);
		return map;
	}

}
