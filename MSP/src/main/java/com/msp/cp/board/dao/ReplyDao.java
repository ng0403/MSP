package com.msp.cp.board.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.board.vo.ReplyVO;
import com.msp.cp.common.PagerVO;

public interface ReplyDao {

	  public List<ReplyVO> listReply(Integer BOARD_NO) throws Exception;
	  public void addReply(ReplyVO vo) throws Exception;

	
}
