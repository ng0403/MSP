package com.msp.cp.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.board.dao.ReplyDao;
import com.msp.cp.board.vo.ReplyVO;
import com.msp.cp.utils.PagerVO;
 
@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyDao replyDao;
	
	@Override
	public List<ReplyVO> listReply(Integer BOARD_NO) throws Exception {
		return replyDao.listReply(BOARD_NO);
	}

	@Override
	public void addReply(ReplyVO vo) throws Exception {
 		
		  replyDao.addReply(vo);
	}

	@Override
	public void removeReply(String REPLY_NO) {
		
		replyDao.removeReply(REPLY_NO);
		
	}

	@Override
	public PagerVO getReplyListCount(Map<String, Object> map) {
		int boardPageNum = (Integer)map.get("pageNum");
		int totalRowCount = replyDao.ReplyListCount("replyListCount", map);
		
		PagerVO page = new PagerVO(boardPageNum, totalRowCount, 4, 999);
		
		return page;
	}

	@Override
	public List<ReplyVO> SearchList(Map<String, Object> map) {
		List<ReplyVO> list = replyDao.SearchList(map);
		return list;
	}

}
