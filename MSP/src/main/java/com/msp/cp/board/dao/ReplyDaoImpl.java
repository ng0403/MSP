package com.msp.cp.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.board.vo.ReplyVO;

@Repository
public class ReplyDaoImpl implements ReplyDao {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<ReplyVO> listReply(Integer BOARD_NO) throws Exception {
 		System.out.println("DAO" +BOARD_NO);

	    return sqlSession.selectList("replyList", BOARD_NO);

	}

	@Override
	public void addReply(ReplyVO vo) throws Exception {

		sqlSession.insert("addReply", vo);
		
	}

	@Override
	public void removeReply(String REPLY_NO) {
		
		sqlSession.delete("removeReply", REPLY_NO);
		
	}

	@Override
	public int ReplyListCount(String string, Map<String, Object> map) {
		int totalCount = 0;
		try {
			totalCount = sqlSession.selectOne("reply.replyListCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}

	@Override
	public List<ReplyVO> SearchList(Map<String, Object> map) {
		
		return sqlSession.selectList("reply.SearchList", map);

	}

}
