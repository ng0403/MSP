package com.msp.cp.auth.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.dept.vo.DeptVO;

public interface AuthDao {

	public List<AuthVO> authList(Map<String, Object> map);

	public int getAuthCount(Map<String, Object> map);

	public List<AuthVO> authDetailList(String auth_id);

	public int authInsert(AuthVO authVO);

	public int authUpdate(AuthVO authVO);

	public int authDelete(String dc);



 
}
