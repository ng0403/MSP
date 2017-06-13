package com.msp.cp.chart.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.chart.service.DthreeService;
import com.msp.cp.chart.vo.DthreeVO;
import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.PagerVO;

@Controller
@RequestMapping(value="/chart")
public class DthreeController {
	
	private static final Logger logger = LoggerFactory.getLogger(DthreeController.class);
	
	@Autowired
	DthreeService dthreeService;
	
	@RequestMapping(value="/dthreeInqr", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView dthreeList(HttpServletRequest request, @RequestParam(value = "pageNum", defaultValue = "1") 
									int pageNum , String excel,
									@RequestParam Map<String, Object> dthreeMap ){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageNum", pageNum);
		
		//페이징 처리
		PagerVO page = dthreeService.getDthreeCount(map);
		map.put("page", page);
		
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		if(excel != null){
			if(excel.equals("true")){
				ModelAndView mav = new ModelAndView("/chart/dthree_list_excel");
				List<DthreeVO> dthreeExcel = dthreeService.dthreeExcel(dthreeMap);
				mav.addObject("dthreeExcel", dthreeExcel);
				return mav;
			}
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		//검색 결과 list
		List<DthreeVO> dthree_list = dthreeService.dthreeList(map);
		System.out.println(dthree_list);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("page", page);
		mav.addObject("pageNum", pageNum);
		mav.addObject("dthree_list", dthree_list);
		mav.setViewName("/chart/dthree_list");
		
		return mav;
		
	}
	
	@RequestMapping(value="/search_list", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> dthreeList( ModelMap model, HttpServletRequest request,
													     @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		
		String keyword    = request.getParameter("keyword");
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
		map.put("keyword", keyword);
		map.put("pageNum", pageNum);
		System.out.println(map);
		PagerVO page = dthreeService.getDthreeCount(map);
		
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<DthreeVO> list = dthreeService.dthreeList(map);
		System.out.println(list);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("dthree_list", list);

		return model;
	}
	
	@RequestMapping(value="/search_list2", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> dthreeList2( ModelMap model, HttpServletRequest request,
													     @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		
		String keyword    = request.getParameter("keyword");
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
		map.put("keyword", keyword);
		System.out.println(map);

		List<DthreeVO> list = dthreeService.dthreeListAll(map);
		System.out.println(list);
		
		model.addAttribute("dthree_list", list);

		return model;
	}
	
	@RequestMapping(value="/detail_list/{area}", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<List<DthreeVO>> dthreeDetailList(@PathVariable("area") String area){
		
		System.out.println("1 +++++" + area);
		ResponseEntity<List<DthreeVO>> entity = null;
		System.out.println("2 +++++" + entity);
		
		try{
			
			entity = new ResponseEntity<>(dthreeService.dthreeDetailList(area), HttpStatus.OK);
			System.out.println("3 +++++" + entity);
			
		}catch(Exception e){
			
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			System.out.println("4 +++++" + area);
		}
				
		return entity;
	}
	
	@RequestMapping(value="/insert", method={RequestMethod.POST})
	public ResponseEntity<String> dthreeInsert(@RequestBody DthreeVO dthreeVO){
		
		logger.info("insert 컨트롤러 호출");
		
		ResponseEntity<String> entity = null;
		int result;
		
		try{
			result = dthreeService.dthreeInsert(dthreeVO);
			if(result==1){
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}
	
	@RequestMapping(value="/update", method={RequestMethod.POST})
	public ResponseEntity<String> dthreeUpdate(@RequestBody DthreeVO dthreeVO){
		
		ResponseEntity<String> entity = null;
		
		int result;
		
		try{
			result = dthreeService.dthreeUpdate(dthreeVO);
			if(result==1){
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
				
		return entity;
	}

	@RequestMapping(value="/delete/{del_code}", method={RequestMethod.POST})
	public ResponseEntity<String> dthreeDelete(@PathVariable("del_code") String del_code){
		
		ResponseEntity<String> entity = null;
		int result;
		
		String[] delcode = del_code.split(",");
		
		for(int i = 0; i < delcode.length; i++)
		{
			try{
				String dc = delcode[i];
				result = dthreeService.dthreeDelete(dc);
				if(result==1){
					entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				}
			}catch(Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
		}		
		return entity;
	}
	
	@RequestMapping(value="/search_list_pop", method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Map<String, Object> searchListPop( ModelMap model, HttpServletRequest request,
													   @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		                      
		String keyword    = request.getParameter("keyword");
	    
	    Map<String,Object> map = new HashMap<String,Object>();
	    
		map.put("keyword", keyword);
		map.put("pageNum", pageNum);

		PagerVO page = dthreeService.getDthreeCount(map);
		
		if(page.getEndRow()==1){
			page.setEndRow(0);
		}
		
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		List<DthreeVO> dthree_list = dthreeService.searchListPop(map);
		
		model.addAttribute("page", page);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("dthree_list", dthree_list);

		return model;
	}
	
	//상세정보 팝업
	@RequestMapping(value="/excelImportTab", method=RequestMethod.GET)
	public ModelAndView excelImportTab(HttpSession session, Locale locale,
			                           @RequestParam(value = "pageNum", defaultValue = "1") int pageNum)
	{
		System.out.println("ExcelTab Controller");
		ModelAndView mov = new ModelAndView("/chart/excel_import");
		return mov;
	}
	
	//Excel Data Import
    @RequestMapping(value = "/excelUploadAjax", headers = "content-type=multipart/*", method = RequestMethod.POST)
    public ModelAndView excelUploadAjax(MultipartHttpServletRequest request)  throws Exception {
        
    	MultipartFile excelFile =request.getFile("excelFile");
        System.out.println("excelFile : " + excelFile);
        
        System.out.println("엑셀 파일 업로드 컨트롤러");
        
        if(excelFile==null || excelFile.isEmpty()){
        	
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
        //파일 저장경로
        File destFile = new File("E:\\"+excelFile.getOriginalFilename());
        System.out.println("destFile : " + destFile);
        
        try{
        	
            excelFile.transferTo(destFile);
            
        } catch (IllegalStateException | IOException e){
        	
            throw new RuntimeException(e.getMessage(),e);
        }
        
        int result = dthreeService.excelUpload(destFile);
        System.out.println("result : " + result);
        
        if(result == 1){
        	System.out.println("Excel Insert 성공");
        	
        }else {
        	System.out.println("Excel Insert 실패");
        }
        return new ModelAndView("/chart/excel_import", "result", result);
    }
    
	
}
