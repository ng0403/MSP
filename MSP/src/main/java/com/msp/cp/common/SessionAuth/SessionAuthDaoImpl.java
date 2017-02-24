package com.msp.cp.common.SessionAuth;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class SessionAuthDaoImpl implements SessionAuthDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<SessionAuthVO> sessionInqr(Map<String, Object> map) {
		System.out.println("sessionDao Impl 진입 : " + map);
		List<SessionAuthVO> sa = sqlSession.selectList("common.sessionInqr", map);
		return sa;
	}

}
