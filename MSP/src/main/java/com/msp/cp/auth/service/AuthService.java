package com.msp.cp.auth.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;

public interface AuthService {

	public List<AuthVO> searchListAuth(Map<String, Object> map);
	public List<Object> authCheck(String check);

	public void insertAuth(AuthVO authVO);
	public void updateAuth(AuthVO authVO);
	public void deleteAuth(String dc);

}
