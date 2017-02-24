package com.msp.cp.common.SessionAuth;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service("SessionAuthService")
public class SessionAuthServiceImpl implements SessionAuthService {
	
	@Autowired
	SessionAuthDao saDao;

	@Override
	public List<SessionAuthVO> sessionInqr(Map<String, Object> map) {
		System.out.println("Dao 진입 : " + map);
		List<SessionAuthVO> sa = saDao.sessionInqr(map);
		System.out.println("Dao 완료 : " + sa);
		
		return sa;
	}

}
