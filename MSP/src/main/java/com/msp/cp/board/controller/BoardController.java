package com.msp.cp.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.board.service.BoardService;
import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.common.SessionAuth.SessionAuthService;
import com.msp.cp.common.SessionAuth.SessionAuthVO;
import com.msp.cp.utils.FileManager;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	private static final String[] filename = null;
	@Autowired
	BoardService boardService; 
	
	@Autowired
	SessionAuthService sessionAuthService;
	
	@RequestMapping(value="/boardInqr", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView boardList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, @RequestParam Map<String, Object> map ,HttpSession session) throws Exception{
		 
		System.out.println("board_list Insert ");
		
//		접속된 사용자 아이디 
		String sessionID = (String) session.getAttribute("user_id");
		System.out.println("접속된 계정 : " + sessionID);
		 
		
		map.put("pageNum", pageNum);
		map.put("sessionID", sessionID); 
		PagerVO page=boardService.getBoardListCount(map); 
		map.put("page", page);
		
		
		List<SessionAuthVO> session_auth_list = sessionAuthService.sessionInqr(map);
		System.out.println("session 정보 : " + session_auth_list);

		
		if(page.getEndRow() == 1){
			page.setEndRow(0);
		}
 		List<Object> boardlist = boardService.list(map); 
 		
		ModelAndView mov = new ModelAndView("/board/board_list");
		mov.addObject("boardlist", boardlist);
		mov.addObject("page",  page);
		mov.addObject("pageNum",  pageNum);
		mov.addObject("session_auth_list",session_auth_list);
		return mov; 
	} 
	
	@RequestMapping(value="/boardDetail", method= RequestMethod.GET)
	public ModelAndView boardDetail(@RequestParam("BOARD_NO") int BOARD_NO, HttpSession session) throws Exception {
		System.out.println("detail entering");
//		접속된 사용자 아이디 
		String sessionID = (String) session.getAttribute("user_id");
		System.out.println("접속된 계정 : " + sessionID);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sessionID", sessionID);  
		
		List<SessionAuthVO> session_auth_list = sessionAuthService.sessionInqr(map);
		System.out.println("session 정보 : " + session_auth_list); 
		
		BoardVO vo = boardService.detail(BOARD_NO);
		String FILE_CD = vo.getFILE_CD(); 
		
		boardService.viewadd(BOARD_NO);
		ModelAndView mov = new ModelAndView();

	
		if(FILE_CD == null)
		{
		  
			mov.addObject("boardlist", boardService.detail(BOARD_NO));
		}
		else
		{ 
			 
			mov.addObject("boardlist",  boardService.ReadFilePage(BOARD_NO));
		}
		 
			
		
		return mov;
		 
	}
	
	@RequestMapping(value="/boardInsert", method=RequestMethod.GET)
	public ModelAndView board_add() {
		  System.out.println("Entering");
		  
		  ModelAndView mov = new ModelAndView("/board/board_insert");
		  
		  
		  return mov; 
	}
	
	
	@RequestMapping(value="/boardInsert", method=RequestMethod.POST)
	public String  board_insert(MultipartHttpServletRequest multi, HttpServletRequest request, BoardVO attach) { 
 		  
		 MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		 Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	     MultipartFile multipartFile = null; 
 	     
 	     
 	     	 
 	    	 
	     while(iterator.hasNext()){
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        if(multipartFile.isEmpty() == false){
	        	
 	 		    attach.setFILE_NM(multipartFile.getOriginalFilename());
 	 		    String name = multipartFile.getOriginalFilename();
 	 		     
 	 		    StringTokenizer toke = new StringTokenizer(name, ".");
 	 		    String[] filename = new String[2];
 	 		    
 	 		    for(int i= 0; toke.hasMoreElements() ; i++)
 	 		    {
  	 		     filename[i] = toke.nextToken();
  	 		   
  	 		    }
 	 		   
 	 		    attach.setFILE_NM(filename[0]);
 	 		    attach.setFILE_EXT(filename[1]);  
 	 		    
 	        }
	    } 
		
	    if(attach.getFILE_NM() != null){ 
		FileManager fileManager = new FileManager(); 
		
		List<MultipartFile> file = multi.getFiles("filedata");
	
		for(int i=0; i<file.size(); i++){
			
			String uploadpath = fileManager.doFileUpload(file.get(i), request);
		
			attach.setFILE_PATH(uploadpath);
			boardService.insertAttachData(attach);
		
		}
	    }
		
		boardService.insert(attach);  
   
		System.out.println("board_insert success....");
 
	 
		return "redirect:/board/boardInqr"; 
		 
	} 
	  
	
	@RequestMapping(value="/boardModify", method=RequestMethod.GET)
	public void board_modifyPage(int BOARD_NO, Model model)
	{ 
		System.out.println("hi MODIFY" + BOARD_NO);
		
		BoardVO vo = boardService.detail(BOARD_NO);
		String FILE_CD = vo.getFILE_CD();
		
		if(FILE_CD != null){
			model.addAttribute("boardVO", boardService.readFileModify(BOARD_NO));
		}
		else{
			model.addAttribute( "boardVO", boardService.read(BOARD_NO)); 
		}
	  
		
		
	}
	
	@RequestMapping(value="/boardModify", method=RequestMethod.POST)
	public String board_modify(BoardVO vo)
	{
		System.out.println("modify  Entering" + vo);
		
		boardService.modify(vo);
		
		return "redirect:/board/boardInqr";
	}
	
	@RequestMapping(value="/board_remove", method=RequestMethod.POST) 
	 @ResponseBody
	public ResponseEntity<String> board_remove(@RequestBody String del_code){ 
		
		System.out.println("remove insert");

		String[] delcode = del_code.split(",");
		ResponseEntity<String> entity = null;

		
		for(int i = 0; i < delcode.length; i++)
		{
			String dc = delcode[i];
			boardService.removeBoard(dc);
			System.out.println("success"); 
			
			if(i == delcode.length-1)
			{
		 	      entity = new ResponseEntity<>("success", HttpStatus.OK);
		 	      System.out.println(entity);
			}
		}  
	     
	    return entity;
	}
	
	
	@RequestMapping(value="/detail_remove", method=RequestMethod.POST) 
	public String detailRemove(int BOARD_NO){ 
		
		System.out.println("remove insert");

		 
			boardService.removeDetail(BOARD_NO); 
	     
	    return "redirect:/board/boardInqr";
	}
	
	
	@RequestMapping(value="/ajax_list", method=RequestMethod.POST) 
	 @ResponseBody
	public ResponseEntity<List<BoardVO>> ajax_list( ){ 
		
		System.out.println("ajax List Entering");
	  
		ResponseEntity<List<BoardVO>> entity = null;
	    try {
 	      entity = new ResponseEntity<>(boardService.ajaxlist(), HttpStatus.OK);
	      System.out.println("entity? "+ entity);
	      System.out.println("insert entity" + entity);
	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>( HttpStatus.BAD_REQUEST);
	    }
	    return entity;
		 
	}
	
	
	@RequestMapping(value="/QnAajax_list", method=RequestMethod.POST) 
	 @ResponseBody
	public ResponseEntity<List<BoardVO>> QnAajax_list(){ 
		
		System.out.println("QnAajax List Entering");

		ResponseEntity<List<BoardVO>> entity = null;
	    try {
	      entity = new ResponseEntity<>(boardService.QnAajaxlist(), HttpStatus.OK);
	      System.out.println("entity? "+ entity);
	      System.out.println("insert entity" + entity);
	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>( HttpStatus.BAD_REQUEST);
	    }
	    return entity; 
	    
	}
	
	
	@RequestMapping(value="/search_boardInqr", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> search_board_list( ModelMap model, HttpServletRequest request,
													   @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		System.out.println("search entering1111");
 		String keyword    = request.getParameter("keyword");
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
 		map.put("keyword", keyword);
		map.put("pageNum", pageNum);

		PagerVO page = boardService.getBoardListCount(map);
		System.out.println("page?" + page.toString());
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<BoardVO> list = boardService.SearchList(map);
		System.out.println("list?" + list.toString());
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("qna_list", list);

		return model;
	}
	 
	
	@RequestMapping(value = "/file_down", method = RequestMethod.GET)
	public void downloadFile( @RequestParam(value = "FILE_CD") String FILE_CD, HttpServletResponse response, HttpServletRequest request) {
		
		System.out.println("Hello down" + FILE_CD);
		
		Map<?, ?> map = (Map<?, ?>) boardService.searchOneFiledata(FILE_CD); 
    		System.out.println("map??" +map);
		
		if (map != null) {

			String fileroot = map.get("FILE_PATH").toString();
			String[] temp = fileroot.split("\\\\");
			String fileName = temp[temp.length - 1];
			String root = "x`x`";

			for (int i = 0; i < (temp.length - 2); i++) {
				root += temp[i] + "\\";
			}

			FileManager fileManager = new FileManager();
			boolean existfile = fileManager.doFileDownload(fileName, root, response);

			if (!existfile) {
				try {
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out = response.getWriter();
					out.print("<script>alert('다운로드에 실패하였습니다.');history.back();</script>");
				} catch (Exception e) {
				}
			}

		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out;
			try {
				out = response.getWriter();
				out.print("<script>alert('파일이 없습니다.');history.back();</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}

			return;
		}

	}
	 
	
 	
 
}
