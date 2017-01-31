package com.msp.cp.auth.dao;

import java.util.List;

import com.msp.cp.auth.vo.AuthVO;

public interface AuthDao {
	
	public List<Object> searchListAuth();
	public List<Object> authCheck(String check);

	public void insertAuth(AuthVO authVO);
	public void updateAuth(AuthVO authVO);
	public void deleteAuth(String dc);

}
