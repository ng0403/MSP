package com.msp.cp.login.dao;

import com.msp.cp.login.vo.LoginVO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDaoImpl implements LoginDao {
	
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//사용자 정보조회
	@Override
	public LoginVO selectUser(LoginVO loginParam) {
		return sqlSession.selectOne("login.selectUser", loginParam);
	}

	// 사용자 비밀번호 오류 횟수 설정
	@Override
	public void updatePwdErnmYn(LoginVO loginParam) {
		sqlSession.update("login.updatePwdErnmYn", loginParam);
	}

	/*@Override
	public MenuVo getLoginMenuInfo() {
		return sqlSession.selectOne("login.loginMenu");
	}*/
	

}
