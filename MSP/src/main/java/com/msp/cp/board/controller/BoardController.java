package com.msp.cp.board.controller;

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

import com.msp.cp.board.service.BoardService;
import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.common.PagerVO;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/board_list", method = RequestMethod.GET)
	public ModelAndView boardList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, @RequestParam Map<String, Object> map ) throws Exception{
		
		System.out.println("board_list Insert ");
		System.out.println("pagenum" + pageNum);
		map.put("pageNum", pageNum);

		PagerVO page=boardService.getBoardListCount(map); 
		System.out.println("pagevo" + page.toString());
		map.put("page", page);
		
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
 		List<Object> boardlist = boardService.list(map); 
 		
		ModelAndView mov = new ModelAndView("/board/board_list");
		mov.addObject("boardlist", boardlist);
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum);
		
		
		

		System.out.println("board_list" + mov);
		return mov; 
	}
	
	@RequestMapping(value="/board_detail", method= RequestMethod.GET)
	public void boardDetail(@RequestParam("BOARD_NO") int BOARD_NO, Model model) throws Exception {
		System.out.println("hi detail" + BOARD_NO);
  		model.addAttribute("boardlist", boardService.detail(BOARD_NO));
		System.out.println("board_detail" + model.toString()); 
		 
	}
	
	@RequestMapping(value="/board_insert", method=RequestMethod.GET)
	public void board_add() {
		  
	}
	
	
	@RequestMapping(value="/board_insert", method=RequestMethod.POST)
	public String board_insert(BoardVO vo) {
		System.out.println("insert entering" + vo);
		boardService.insert(vo);
		System.out.println("board_insert success....");

		return "redirect:/board/board_list"; 
	} 
	
	@RequestMapping(value="/board_modify", method=RequestMethod.GET)
	public void board_modifyPage(int BOARD_NO, Model model)
	{
		System.out.println("hi MODIFY" + BOARD_NO);

		System.out.println("modify Page Entering");
		model.addAttribute( "boardVO", boardService.read(BOARD_NO));
		System.out.println("modify string" + model.toString());
	}
	
	@RequestMapping(value="/board_modify", method=RequestMethod.POST)
	public String board_modify(BoardVO vo)
	{
		System.out.println("modify  Entering" + vo);
		
		boardService.modify(vo);
		System.out.println("modify success" + vo.toString());
		
		return "redirect:/board/board_list";
	}
	
	@RequestMapping(value="/board_remove", method=RequestMethod.POST)
	@ResponseBody 
 	public Map<String, Object> board_remove(@RequestBody String del_code){ 
		
		System.out.println("remove insert" + del_code);
 
		String[] delcode = del_code.split(",");
		
		
		for(int i = 0; i < delcode.length; i++)
		{
			String dc = delcode[i];
			System.out.println("delete..." + dc);
			boardService.removeBoard(dc);
			System.out.println("success"); 
		} 
		

		Map<String, Object> map = new HashMap<String, Object>(); 

		 List<Object> ajaxlist =  boardService.ajaxlist(); 
	     map.put("data", ajaxlist);
	     System.out.println("ajax map? " + map.toString());
	     
		return map;
		
 	}
 
}
