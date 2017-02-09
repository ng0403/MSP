package com.msp.cp.boardmng.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.boardmng.vo.BoardMngVO;

@Repository
public class BoardMngDaoImpl implements BoardMngDao {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int BoardMngListCount(String string, Map<String, Object> map) {
		int totalCount = 0;
		try {
			System.out.println("6. DAoImpl totalCount : " + totalCount); 
			totalCount = sqlSession.selectOne("boardmng.boardMngListCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}

	@Override
	public List<Object> list(Map map) {
		
		return sqlSession.selectList("BoardMngList", map);


	}

	@Override
	public BoardMngVO detail(String BOARD_MNG_NO) {

		return sqlSession.selectOne("boardmng.ReadPage", BOARD_MNG_NO);
	}

	@Override
	public void modify(BoardMngVO vo) {
		sqlSession.update("boardmng.Modify", vo);
	}
}