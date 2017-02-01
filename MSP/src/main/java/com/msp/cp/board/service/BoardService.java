package com.msp.cp.board.service;

import java.util.List;

import com.msp.cp.board.vo.BoardVO;
 
public interface BoardService {
	
	  public List<Object> list();
	  public BoardVO readPage(int BOARD_NO);


}
