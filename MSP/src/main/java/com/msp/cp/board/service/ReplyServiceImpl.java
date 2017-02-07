package com.msp.cp.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.board.dao.ReplyDao;
import com.msp.cp.board.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyDao replyDao;
	
	@Override
	public List<ReplyVO> listReply(Integer BOARD_NO) throws Exception {
 		System.out.println("SERVICE" +BOARD_NO);
		return replyDao.listReply(BOARD_NO);
	}

	@Override
	public void addReply(ReplyVO vo) throws Exception {
 		
		  replyDao.addReply(vo);
	}

}
