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
	public int QnaListCount(String string, Map<String, Object> map) {
		int totalCount = 0;
		try {
			totalCount = sqlSession.selectOne("board.qnaListCount", map);
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



	@Override
	public void insert(BoardVO vo) {
		
		sqlSession.insert("board.QnAInsert" , vo);
		
	}
	

	@Override
	public BoardVO CODE(String QUESTION_TYPE_CD) {
		// TODO Auto-generated method stub

		return  sqlSession.selectOne("CODE", QUESTION_TYPE_CD);
	}



	@Override
	public void viewadd(int BOARD_NO) {
		sqlSession.update("viewadd", BOARD_NO);
		
	}



	@Override
	public List<BoardVO> QnAList2(Map<String, Object> map) {
		// TODO Auto-generated method stub
	  return sqlSession.selectList("board.selectQnA2", map);
 
	}
	 

}
