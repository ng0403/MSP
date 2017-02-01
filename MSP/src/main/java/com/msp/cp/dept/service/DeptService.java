package com.msp.cp.dept.service;

import java.util.List;

import com.msp.cp.dept.vo.DeptVO;

public interface DeptService {

	public List<DeptVO> deptList();

	public List<DeptVO> deptDetailList(DeptVO dvo);

	public int deptInsert(DeptVO dvo);

}
