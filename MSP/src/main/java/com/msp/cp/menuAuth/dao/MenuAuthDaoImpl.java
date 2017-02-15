package com.msp.cp.menuAuth.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.menuAuth.vo.MenuAuthVO;

@Repository
public class MenuAuthDaoImpl implements MenuAuthDao {
	
	@Autowired
	SqlSession sqlSession;

	public void setSqlSessionTemplate(SqlSession sqlSession)
	{
		this.sqlSession = sqlSession;
	}

	@Override
	public int MenuAuthListCount(String string, Map<String, Object> map) {
		// TODO Auto-generated method stub
		int totalCount = 0;
		
		try {
			totalCount = sqlSession.selectOne("menuAuth.menuAuthListCount", map);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return totalCount;
	}

	@Override
	public List<Object> searchMenuAuthList(Map map) {
		// TODO Auto-generated method stub
		List<Object> obj = sqlSession.selectList("searchListAuthList", map);
		
		return obj;
	}

	@Override
	public List<MenuAuthVO> searchMenuAuth(Map<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("DAO : " + map);
		List<MenuAuthVO> obj = sqlSession.selectList("searchListAuthList", map);
		
		return obj;
	}
}
