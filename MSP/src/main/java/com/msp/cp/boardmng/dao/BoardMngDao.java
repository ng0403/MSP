package com.msp.cp.boardmng.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.boardmng.vo.BoardMngVO;

public interface BoardMngDao {
	int BoardMngListCount(String string, Map<String, Object> map);
	public List<Object> list(Map map);
	public BoardMngVO detail(String BOARD_MNG_NO);
	public void modify(BoardMngVO vo);
}
