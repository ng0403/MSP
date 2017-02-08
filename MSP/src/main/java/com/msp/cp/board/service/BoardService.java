package com.msp.cp.board.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.common.PagerVO;
 
public interface BoardService {
	
	  public List<Object> list(Map map);
	  public List<Object> ajaxlist();
	  public BoardVO detail(int BOARD_NO);
	  public BoardVO read(int BOARD_NO); 
	  public void insert(BoardVO vo);
	  public void modify(BoardVO vo);
	  public void removeBoard(String dc);
	  
	  PagerVO getBoardListCount(Map<String, Object> map);

}
