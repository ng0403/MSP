package com.msp.cp.dept.service;

import java.util.List;

import com.msp.cp.dept.vo.DeptVO;

public interface DeptService {

	public List<DeptVO> deptList(DeptVO dvo);

	public List<DeptVO> deptDetailList(String dept_cd);

	public int deptInsert(DeptVO dvo);

	public int deptUpdate(DeptVO dvo);

	public int deptDelete(String dc);

}
