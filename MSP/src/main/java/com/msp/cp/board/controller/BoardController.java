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

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ModelAndView boardList( ) throws Exception{
		
 		List<Object> boardlist = boardService.list();
		ModelAndView mov = new ModelAndView("/board/list");
		mov.addObject("boardlist", boardlist);
		System.out.println("gggg" + mov);
		return mov; 
	}
	
	@RequestMapping(value="/readpage", method= RequestMethod.GET)
	public void boardReadPage(@RequestParam("BOARD_NO") int BOARD_NO, Model model) throws Exception {
		
		System.out.println("no?" + BOARD_NO); 
  		model.addAttribute("boardlist", boardService.readPage(BOARD_NO));
		System.out.println("하히이" + model.toString()); 
		 
	}
	
	

}
