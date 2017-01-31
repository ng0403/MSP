package com.msp.cp.auth.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.auth.dao.AuthDao;
import com.msp.cp.auth.vo.AuthVO;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	AuthDao authDao;

	@Override
	public List<Object> searchListAuth() {
		
		List<Object> obj = authDao.searchListAuth();
		return obj;
	}

	@Override
	public void insertAuth(AuthVO authVO) {
		System.out.println("서비스 임플 등장");
		authDao.insertAuth(authVO);
		
	}

	@Override
	public void updateAuth(AuthVO authVO) {
		
		authDao.updateAuth(authVO);
		
	}
	
	@Override
	public List<Object> authCheck(String check) {
		
		List<Object> obj = authDao.authCheck(check);
		return obj;
	}

	@Override
	public void deleteAuth(String dc) {
		
		authDao.deleteAuth(dc);
		
	}
	
	
	

}
