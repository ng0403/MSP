package com.msp.cp.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.board.vo.BoardVO;

@Repository
public class QnABoardDaoImpl implements QnABoardDao {

	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	
	@Override
	public List<Object> list(Map map) {
		return sqlSession.selectList("board.QnAList", map);

	}

	@Override
	public int BoardListCount(String string, Map<String, Object> map) {
		int totalCount = 0;
		try {
			totalCount = sqlSession.selectOne("board.boardListCount", map);
			System.out.println("6. DAoImpl totalCount : " + totalCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	} 
	
	@Override
	public BoardVO detail(int BOARD_NO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.ReadPage", BOARD_NO); 
	}



	@Override
	public BoardVO read(int BOARD_NO) {
		
 		return sqlSession.selectOne("readBoard", BOARD_NO);
	}



	@Override
	public void modify(BoardVO vo) {
		sqlSession.update("ModifyBoard" ,vo);
		
	}



	@Override
	public int getQnACount(Map<String, Object> map) {
		return sqlSession.selectOne("board.QnACount", map); 
	}



	@Override
	public List<BoardVO> QnAList(Map<String, Object> map) {
		return sqlSession.selectList("board.selectQnA", map);

	}

}