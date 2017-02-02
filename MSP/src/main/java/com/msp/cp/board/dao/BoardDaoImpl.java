package com.msp.cp.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.board.vo.BoardVO;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Object> list() {	
		 
		return sqlSession.selectList("BoardList");
	}

	@Override
	public BoardVO detail(int BOARD_NO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReadPage", BOARD_NO);
	}

	@Override
	public void insert(BoardVO vo) {
		 
 		 sqlSession.insert("InsertBoard",vo);
	}

	@Override
	public void modify(BoardVO vo) {
		
		sqlSession.update("ModifyBoard" ,vo);
		
	}

}
