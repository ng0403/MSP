package com.msp.cp.board.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.board.service.QnABoardService;
import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.common.PagerVO;
import com.msp.cp.utils.FileManager;

@Controller
@RequestMapping("/board/*")
public class QnABoardController {
	
	@Autowired
	QnABoardService qnaService; 
	
	@RequestMapping(value="/QnAInqr", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView QnA_List(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, @RequestParam Map<String, Object> map ) {

		System.out.println("board_list Insert ");
		System.out.println("pagenum" + pageNum);
		map.put("pageNum", pageNum);

		PagerVO page= qnaService.getBoardListCount(map); 
		System.out.println("pagevo" + page.toString());
		map.put("page", page);
		
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
 		List<Object> boardlist = qnaService.list(map); 
 		
		ModelAndView mov = new ModelAndView("/board/QnA_List");
		mov.addObject("boardlist", boardlist);
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum);
		 
		System.out.println("board_list" + mov);
		
		return mov; 
	}
	
	@RequestMapping(value="/QnA_detail", method= RequestMethod.GET)
	public void boardDetail(@RequestParam("BOARD_NO") int BOARD_NO, Model model) throws Exception {
		
		System.out.println("hi detail" + BOARD_NO);
		
		BoardVO vo = new BoardVO();
		vo = qnaService.detail(BOARD_NO);
		String QUESTION_TYPE_CD = vo.getQUESTION_TYPE_CD();
		System.out.println("question_type_cd?" + QUESTION_TYPE_CD);
		String TITLE = vo.getTITLE();
		
		BoardVO vo1 = new BoardVO();
		vo1 = (BoardVO) qnaService.CODE(QUESTION_TYPE_CD);
		
		String CODE_TXT = vo1.getCODE_TXT();
		
		String QUESTION_TITLE = "[" + CODE_TXT + "] " + "    " + TITLE;
		
		
 		vo.setQUESTION_TITLE(QUESTION_TITLE);
		
  		model.addAttribute("boardlist", vo );
		System.out.println("QnA_detail" + model.toString()); 
		 
	}
	 
	
	@RequestMapping(value="/QnA_insert", method=RequestMethod.GET)
	public void board_add() {
		  
	}
	
	@RequestMapping(value="/QnA_insert", method=RequestMethod.POST)
	public String  board_insert(BoardVO vo) { 
		System.out.println("QnA Insert Entering");
		System.out.println("QnA vo?" + vo.toString());
		qnaService.insert(vo);  
   
		System.out.println("board_insert success....");
 
	 
		return "redirect:/board/QnAInqr"; 
		 
	} 
	
	
	@RequestMapping(value="/QnA_modify", method=RequestMethod.GET)
	public void board_modifyPage(int BOARD_NO, Model model)
	{
		System.out.println("hi MODIFY" + BOARD_NO);
		BoardVO vo = new BoardVO();
		vo = qnaService.read(BOARD_NO);
		String QUESTION_TYPE_CD = vo.getQUESTION_TYPE_CD();
		String TITLE = vo.getTITLE();
		System.out.println("11" + QUESTION_TYPE_CD + "TITLE"  + TITLE);
		
		String QUESTION_TITLE = "[" + QUESTION_TYPE_CD + "] " + "    " + TITLE;
		
		
		System.out.println("gg" + QUESTION_TITLE );
		vo.setQUESTION_TITLE(QUESTION_TITLE);
		System.out.println("modify Page Entering");
		model.addAttribute( "boardVO", vo );
		System.out.println("modify string" + model.toString());
	}
	
	@RequestMapping(value="/QnA_modify", method=RequestMethod.POST)
	public String board_modify(BoardVO vo)
	{
		System.out.println("modify  Entering" + vo);
		
		qnaService.modify(vo);
		System.out.println("modify success" + vo.toString());
		
		return "redirect:/board/board_list";
	}
	
	
	@RequestMapping(value="/search_QnAInqr", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> search_QnA_list( ModelMap model, HttpServletRequest request,
													   @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		System.out.println("search entering");
 		String keyword    = request.getParameter("keyword");
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
 		map.put("keyword", keyword);
		map.put("pageNum", pageNum);

		PagerVO page = qnaService.getQnACount(map);
		System.out.println("page?" + page.toString());
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<BoardVO> list = qnaService.QnAList(map);
		System.out.println("list?" + list.toString());
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("qna_list", list);

		return model;
	}
	 

}
