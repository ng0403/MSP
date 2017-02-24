package com.msp.cp.boardmng.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.boardmng.service.BoardMngService;
import com.msp.cp.boardmng.vo.BoardMngVO;
import com.msp.cp.common.PagerVO;

@Controller
@RequestMapping("/board_mng")
public class BoardMngController {
	
	@Autowired
	BoardMngService boardmngService;
	
	@RequestMapping(value="/boardmngInqr", method=RequestMethod.GET) 
	public ModelAndView boardmngList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, @RequestParam Map<String, Object> map ) throws Exception{
		map.put("pageNum", pageNum);
		
 		PagerVO page= boardmngService.getBoardMngListCount(map); 
		map.put("page", page);
		
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
 		List<Object> boardmnglist = boardmngService.list(map); 
 		
		ModelAndView mov = new ModelAndView("/board_mng/board_mng_list");
		mov.addObject("boardmnglist", boardmnglist);
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum); 

		return mov; 
		
	}
	
	@RequestMapping(value="/board_mng_detail", method=RequestMethod.GET)
	public void board_mng_detail(@RequestParam("BOARD_MNG_NO")String BOARD_MNG_NO, Model model ){
		
	
	model.addAttribute("board_mng_list", boardmngService.detail(BOARD_MNG_NO));
		
	}
	
	@RequestMapping(value="/board_mng_modify", method=RequestMethod.GET)
	public void board_mng_modify(){ 
		System.out.println("modify page entering");
	}
	
	
	@RequestMapping(value="/board_mng_modify", method=RequestMethod.POST)
	public String board_mng_modify(BoardMngVO vo){
			
		System.out.println("BOARD_MNG_MODIFY ENTERING");
		
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
		boardmngService.add(vo);
		
		return "redirect:/board_mng/boardmngInqr";
		
	}
	
	
	@RequestMapping(value="/board_mng_remove" ,method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> board_mng_remove(@RequestBody String del_code){
		System.out.println("remove insert" + del_code);
		 
		String[] delcode = del_code.split(",");
		ResponseEntity<String> entity = null;
		
		for(int i = 0; i < delcode.length; i++)
		{
			String dc = delcode[i];
			boardmngService.remove(dc);
			System.out.println("success"); 
			
			if(i == delcode.length-1)
			{
		 	      entity = new ResponseEntity<>("success", HttpStatus.OK);
		 	      System.out.println(entity);
			}
		}  
	     
	    return entity;
		
	}
	
	@RequestMapping(value="/board_mng_codetxt", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> board_mng_codetxt(@RequestBody String CODE_TXT ) {
		
		Map<String, Object> map = new HashMap<String, Object>(); 
		List<Object> codelist = boardmngService.codetxt(CODE_TXT);
		map.put("data", codelist);
		
		System.out.println(map);
		return map;
	}
	
	@RequestMapping(value="/ajax_list", method=RequestMethod.POST) 
	 @ResponseBody
	public ResponseEntity<List<BoardMngVO>> ajax_list(){ 
		
		System.out.println("ajax List Entering");

		ResponseEntity<List<BoardMngVO>> entity = null;
	    try {
	      
	     List<BoardMngVO> vo = boardmngService.ajaxlist();
	     String ACTIVE_FLG;
	     String ACTIVE_FLGS = "Y";
	     for(int i = 0; i< vo.size() ; i++){ 
	     ACTIVE_FLG = vo.get(i).getACTIVE_FLG(); 
 	     boolean A = ACTIVE_FLG.equals(ACTIVE_FLGS);
 	     
	    if(A == true)
	     { 
 	    	 vo.get(i).setACTIVE_FLG("활성화");
	     }
	     else{ 
 	    	 vo.get(i).setACTIVE_FLG("비활성화"); 
	    }
	    
	      entity = new ResponseEntity<>(vo, HttpStatus.OK);
	     }
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>( HttpStatus.BAD_REQUEST);
	    }
	    return entity;
		 
	}
	
	

}
