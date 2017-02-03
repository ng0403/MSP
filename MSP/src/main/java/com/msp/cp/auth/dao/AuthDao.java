package com.msp.cp.auth.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;

public interface AuthDao {
	
	public List<Object> authCheck(String check);
	public List<AuthVO> searchListAuth(Map map);

	public void insertAuth(AuthVO authVO);
	public void updateAuth(AuthVO authVO);
	public void deleteAuth(String dc);

}
