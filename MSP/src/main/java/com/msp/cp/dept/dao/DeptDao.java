package com.msp.cp.dept.dao;

import java.util.List;

import com.msp.cp.dept.vo.DeptVO;

public interface DeptDao {

	public List<DeptVO> codeList(DeptVO dvo);

	public List<DeptVO> codeDetailList(String dept_cd);

	public int deptInsert(DeptVO dvo);

	public int deptUpdate(DeptVO dvo);

	public int deptDelete(String dc);

}
