package com.msp.cp.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.board.service.BoardService;
import com.msp.cp.board.vo.BoardVO;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/board_list", method = RequestMethod.GET)
	public ModelAndView boardList( ) throws Exception{
		
		System.out.println("board_list Insert ");
		
 		List<Object> boardlist = boardService.list();
		ModelAndView mov = new ModelAndView("/board/board_list");
		mov.addObject("boardlist", boardlist);
		
		System.out.println("board_list" + mov);
		return mov; 
	}
	
	@RequestMapping(value="/board_detail", method= RequestMethod.GET)
	public void boardDetail(@RequestParam("BOARD_NO") int BOARD_NO, Model model) throws Exception {
		
  		model.addAttribute("boardlist", boardService.detail(BOARD_NO));
		System.out.println("board_detail" + BOARD_NO); 
		 
	}
	
	@RequestMapping(value="/board_insert", method=RequestMethod.GET)
	public void board_add() {
		
		 
		
	}
	
	
	@RequestMapping(value="/board_insert", method=RequestMethod.POST)
	public String board_insert(BoardVO vo) {
		System.out.println("insert entering");
		boardService.insert(vo);
		System.out.println("board_insert success....");

		return "redirect : /board_list"; 
	}
	
	@RequestMapping(value="/board_modify", method=RequestMethod.GET)
	public void board_modifyPage(BoardVO vo)
	{
		System.out.println("modify Page Entering");
	}
	
	@RequestMapping(value="/board_modify", method=RequestMethod.POST)
	public String board_modify(BoardVO vo)
	{
		System.out.println("modify  Entering");
		
		boardService.modify(vo);
		System.out.println("modify success");
		return "";
	}
	
	 

}
