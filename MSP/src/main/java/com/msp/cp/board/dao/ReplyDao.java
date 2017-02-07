package com.msp.cp.board.dao;

import java.util.List;

import com.msp.cp.board.vo.ReplyVO;

public interface ReplyDao {

	  public List<ReplyVO> listReply(Integer BOARD_NO) throws Exception;
	  public void addReply(ReplyVO vo) throws Exception;
	
	
}
