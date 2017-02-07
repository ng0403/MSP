package com.msp.cp.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.msp.cp.board.vo.ReplyVO;

 
public interface ReplyService {

	  public List<ReplyVO> listReply(Integer bno) throws Exception;
	  public void addReply(ReplyVO vo) throws Exception;
}
