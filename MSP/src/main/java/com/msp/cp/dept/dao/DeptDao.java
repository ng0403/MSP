package com.msp.cp.dept.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.dept.vo.DeptVO;

public interface DeptDao {

	public List<DeptVO> deptList(Map<String, Object> map);

	public List<DeptVO> deptDetailList(String dept_cd);

	public int deptInsert(DeptVO dvo);

	public int deptUpdate(DeptVO dvo);

	public int deptDelete(String dc);

	public int getDeptCount(Map<String, Object> map);

}
