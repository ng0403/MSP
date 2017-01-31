package com.msp.cp.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.msp.cp.board.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Inject
	BoardService boardService;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public void boardList() throws Exception{
		
		boardService.list();
		
	}
	
	

}
