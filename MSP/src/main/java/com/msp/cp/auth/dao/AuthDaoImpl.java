package com.msp.cp.auth.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.user.vo.userVO;

@Repository
public class AuthDaoImpl implements AuthDao {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	@Override
	public List<AuthVO> authList(Map<String, Object> map) {
		
		return sqlSession.selectList("auth.selectAuth", map);
	}
	@Override
	public int getAuthCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("auth.authCount", map);
	}
	@Override
	public List<AuthVO> authDetailList(String auth_id) {
		
		return sqlSession.selectList("auth.selectDetailAuth", auth_id);
	}
	@Override
	public int authInsert(AuthVO authVO) {
		
		return sqlSession.insert("auth.insertAuth", authVO);
	}
	@Override
	public int authUpdate(AuthVO authVO) {
		
		return sqlSession.update("auth.updateAuth", authVO);
	}
	@Override
	public int authDelete(String dc) {
		
		return sqlSession.update("auth.deleteAuth", dc);
	}
	@Override
	public List<AuthVO> searchListPop(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("auth.selectAuthPop", map);
	}
	 
	
}
