package com.msp.cp.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.msp.cp.board.service.ReplyService;
import com.msp.cp.board.vo.ReplyVO;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	ReplyService replyService;
	
	@RequestMapping(value="/reply_add", method=RequestMethod.POST) 
	public ResponseEntity<List<ReplyVO>> replyadd(@RequestBody ReplyVO vo){
		System.out.println("hello add reply");
		System.out.println("vovo" + vo);
		int BOARD_NO = vo.getBOARD_NO();
		ResponseEntity<List<ReplyVO>> entity = null;
		    try {
 		      replyService.addReply(vo); 
		      entity = new ResponseEntity<>(replyService.listReply(BOARD_NO), HttpStatus.OK);
		      System.out.println("entity? "+ entity);
		      System.out.println("insert entity" + entity);
		    } catch (Exception e) {
		      e.printStackTrace();
		      entity = new ResponseEntity<>( HttpStatus.BAD_REQUEST);
		    }
		    return entity;
	}
	
	
	 @RequestMapping(value = "/reply_list/{BOARD_NO}", method = RequestMethod.GET)
	  public ResponseEntity<List<ReplyVO>> list(@PathVariable("BOARD_NO") Integer BOARD_NO) {
		System.out.println("board_no ajax " + BOARD_NO); 
 	    ResponseEntity<List<ReplyVO>> entity = null;
	    try {
	    	
 	      entity = new ResponseEntity<>(replyService.listReply(BOARD_NO), HttpStatus.OK);
	      System.out.println("entity" + entity.toString());

	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    
	    return entity;
	  }

}
