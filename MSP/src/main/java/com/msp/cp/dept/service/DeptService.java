package com.msp.cp.dept.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.utils.PagerVO;

public interface DeptService {

	public List<DeptVO> deptList(Map<String, Object> map);

	public List<DeptVO> deptDetailList(String dept_cd);

	public int deptInsert(DeptVO dvo);

	public int deptUpdate(DeptVO dvo);

	public int deptDelete(String dc);

	public PagerVO getDeptCount(Map<String, Object> map);

}
