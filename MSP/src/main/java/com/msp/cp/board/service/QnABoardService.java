package com.msp.cp.board.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.utils.PagerVO;
 
public interface QnABoardService {
	  public List<Object> list(Map map);
	  PagerVO getQnaListCount(Map<String, Object> map);
	  
	  public void insert(BoardVO vo);
	  public BoardVO CODE(String QUESTION_TYPE_CD);
	  
	  public void viewadd(int BOARD_NO); 
	  public BoardVO detail(int BOARD_NO);
	  public BoardVO read(int BOARD_NO); 
	  
	  
	  public void modify(BoardVO vo);
	  public PagerVO getQnACount(Map<String, Object> map);
	  
	  public List<BoardVO> QnAList(Map<String, Object> map);
	  public List<BoardVO> QnAList2(Map<String, Object> map);

}
