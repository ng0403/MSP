package com.msp.cp.dept.dao;

import java.util.List;

import com.msp.cp.dept.vo.DeptVO;

public interface DeptDao {

	public List<DeptVO> codeList();

	public List<DeptVO> codeDetailList(DeptVO dvo);

	public int deptInsert(DeptVO dvo);

}
