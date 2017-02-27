package com.msp.cp.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.msp.cp.board.service.ReplyService;
import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.board.vo.ReplyVO;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	ReplyService replyService;
	
	@RequestMapping(value="/reply_add", method=RequestMethod.POST) 
	public ResponseEntity<List<ReplyVO>> replyadd(@RequestBody ReplyVO vo){
		int BOARD_NO = vo.getBOARD_NO();
		System.out.println("replyvo?" +vo.toString());
		ResponseEntity<List<ReplyVO>> entity = null;
		    try {
 		      replyService.addReply(vo); 
		      entity = new ResponseEntity<>(replyService.listReply(BOARD_NO), HttpStatus.OK);
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

	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    
	    return entity;
	  }
	 
	 
	 @RequestMapping(value="/reply_remove", method=RequestMethod.POST) 
		public ResponseEntity<String> reply_remove(@RequestBody String REPLY_NO){
			
		 System.out.println("hello delete reply");
			 
			ResponseEntity<String> entity = null;
			    try {
	 		      replyService.removeReply(REPLY_NO); 
			      entity = new ResponseEntity<>("success", HttpStatus.OK);
			    } catch (Exception e) {
			      e.printStackTrace();
			      entity = new ResponseEntity<>( HttpStatus.BAD_REQUEST);
			    }
			    return entity;
		}
	 
	 
	 @RequestMapping(value="/search_replyInqr", method={RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody Map<String, Object> search_reply_list( ModelMap model, HttpServletRequest request,
														   @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
			System.out.println("search entering1111");
 		    
		    Map<String,Object> map = new HashMap<String,Object>();
		    
 			map.put("pageNum", pageNum);

			PagerVO page = replyService.getReplyListCount(map);
			System.out.println("page?" + page.toString());
			if(page.getEndRow()==1){
				page.setEndRow(0);
			}
			
			int startRow = page.getStartRow();
			int endRow = page.getEndRow();
			
			map.put("startRow", startRow);
			map.put("endRow", endRow);

			List<ReplyVO> list = replyService.SearchList(map);
			System.out.println("list?" + list.toString());
			
			model.addAttribute("page", page);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("qna_list", list);

			return model;
		}
	 
	 
	 

}
