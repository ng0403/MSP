package com.msp.cp.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.common.PagerVO;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Object> list(Map map) {	
		 
		return sqlSession.selectList("BoardList", map);
	}

	@Override
	public BoardVO detail(int BOARD_NO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.ReadPage", BOARD_NO);
	}

	@Override
	public void insert(BoardVO vo) {
		 
 		 sqlSession.insert("InsertBoard",vo);
	}

	@Override
	public void modify(BoardVO vo) {
		
		sqlSession.update("ModifyBoard" ,vo);
		
	}

	@Override
	public void removeBoard(String dc) {
		sqlSession.update("removeBoard", dc);
	}

	@Override
	public BoardVO read(int BOARD_NO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("readBoard", BOARD_NO);
	}

	@Override
	public List<Object> ajaxlist() {
		 
		return sqlSession.selectList("ajaxList");
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

}
