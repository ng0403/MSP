package com.msp.cp.auth.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.user.vo.userVO;

public interface AuthDao {

	public List<AuthVO> authList(Map<String, Object> map);

	public int getAuthCount(Map<String, Object> map);

	public List<AuthVO> authDetailList(String auth_id);

	public int authInsert(AuthVO authVO);

	public int authUpdate(AuthVO authVO);

	public int authDelete(String dc);

	public List<AuthVO> searchListPop(Map<String, Object> map);

	public List<userVO> authExcel(Map<String, Object> map);
	
	public int authUpLoadExcel(File destFile);




 
}
