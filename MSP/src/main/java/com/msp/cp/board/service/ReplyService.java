package com.msp.cp.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.msp.cp.board.vo.ReplyVO;
import com.msp.cp.common.PagerVO;

 
public interface ReplyService {

	  public List<ReplyVO> listReply(Integer bno) throws Exception;
	  public void addReply(ReplyVO vo) throws Exception;
	  public void removeReply(String REPLY_NO);

	  
}
