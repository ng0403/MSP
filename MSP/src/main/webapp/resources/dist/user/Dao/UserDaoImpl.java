package com.crm.cp.test.user.Dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.crm.cp.test.user.vo.userVO;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<Object> searchListUser() {
		
		List<Object> obj = sqlSession.selectList("searchListUser");
		System.out.println(obj);
		
		return obj;

	}

	@Override
	public Object selectOnes(String root, Object obj) {
		try {
			Object result = sqlSession.selectOne(root,  obj);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public void insert(userVO vo) {
		sqlSession.insert("user.userInsert", vo);
		System.out.println("insert success DaoImpl");
		
	}

	@Override
	public void userDel(String dc) {
		sqlSession.update("user.userDel", dc);
		System.out.println("user del dao impl enter");
		
	}

	@Override
	public userVO searchListUserOne(String user_id) {
		System.out.println("After userDaoImpl : " + user_id);
		userVO vo= sqlSession.selectOne("userDetail", user_id);
		System.out.println("Before userDaoImpl : " + vo);
		
		return vo;
	}

	@Override
	public void userMdfy(userVO vo) {
		System.out.println("After userMdfyDaoImpl : " + vo);
		sqlSession.update("userEdit", vo);
		System.out.println("Before userMdfyDaoImpl : " + vo);
		
	}
}

