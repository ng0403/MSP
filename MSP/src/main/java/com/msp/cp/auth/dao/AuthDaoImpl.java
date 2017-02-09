package com.msp.cp.auth.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.user.vo.userVO;

@Repository
public class AuthDaoImpl implements AuthDao {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<AuthVO> searchListAuth(Map map) {
		System.out.println("09. DaoImpl User List Search Dao Impl");
		System.out.println("10. DaoImpl map. toString : " + map.toString());
		System.out.println("11. DaoImpl endRow : " + map.get("endRow"));
		System.out.println("12. DaoImpl pageSize : " + map.get("pageSize"));
		List<AuthVO> obj = sqlSession.selectList("searchListAuth", map);
		System.out.println("13. DaoImpl User List Search Dao Impl" + obj);
		return obj;
	}

	@Override
	public void insertAuth(AuthVO authVO) {
		
		System.out.println("다오임플 등장");
		sqlSession.insert("insertAuth", authVO);
		
	}

	@Override
	public void updateAuth(AuthVO authVO) {
		
		sqlSession.update("updateAuth", authVO);
		
	}

	@Override
	public List<Object> authCheck(String check) {
		return sqlSession.selectList("authCheck", check);
	}

	@Override
	public void deleteAuth(String dc) {
		
		sqlSession.delete("deleteAuth", dc);
		
	}

	@Override
	public int AuthListCount(String string, Map<String, Object> map) {
		
		int totalCount = 0;
		try {
			totalCount = sqlSession.selectOne("auth.authListCount", map);
			System.out.println("06. DAoImpl totalCount : " + totalCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
		
}
