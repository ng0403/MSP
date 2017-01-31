package com.msp.cp.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.msp.cp.board.service.BoardService;
import com.msp.cp.board.vo.BoardVO;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public void boardList(Model model, BoardVO vo) throws Exception{
		
		model.addAttribute("list", boardService.list(vo));
		
	}
	
	

}
