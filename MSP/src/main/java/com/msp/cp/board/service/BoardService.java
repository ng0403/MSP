package com.msp.cp.board.service;

import java.util.List;

import com.msp.cp.board.vo.BoardVO;
 
public interface BoardService {
	
	  public List<Object> list();
	  public List<Object> ajaxlist();
	  public BoardVO detail(int BOARD_NO);
	  public BoardVO read(int BOARD_NO); 
	  public void insert(BoardVO vo);
	  public void modify(BoardVO vo);
	  public void removeBoard(String dc);
}
