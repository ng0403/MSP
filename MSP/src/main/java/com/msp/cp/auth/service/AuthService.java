package com.msp.cp.auth.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.utils.PagerVO;

public interface AuthService {

	public List<AuthVO> authList(Map<String, Object> map);

	public PagerVO getAuthCount(Map<String, Object> map);

	public List<AuthVO> authDetailList(String auth_id);

	public int authInsert(AuthVO authVO);

	public int authUpdate(AuthVO authVO);

	public int authDelete(String dc);






}
