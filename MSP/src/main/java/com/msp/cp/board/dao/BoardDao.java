package com.msp.cp.board.dao;

 

import java.util.List;

import com.msp.cp.board.vo.BoardVO;

public interface BoardDao {
	
	public List<BoardVO> list(BoardVO vo);

}
