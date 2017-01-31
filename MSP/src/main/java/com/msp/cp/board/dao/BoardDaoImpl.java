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
	public List<BoardVO> list(BoardVO vo) {	
		 
		return sqlSession.selectList("BoardList", vo);
	}

}
