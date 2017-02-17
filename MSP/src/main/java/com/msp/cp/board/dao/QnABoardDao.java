package com.msp.cp.board.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.board.vo.BoardVO;

public interface QnABoardDao {
	public List<Object> list(Map map);
	int BoardListCount(String string, Map<String, Object> map);
	public BoardVO detail(int BOARD_NO);
	public BoardVO read(int BOARD_NO);  
	public void modify(BoardVO vo);
	public int getQnACount(Map<String, Object> map);
	
	public List<BoardVO> QnAList(Map<String, Object> map);

}
