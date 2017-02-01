package com.msp.cp.dept.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.dept.dao.DeptDao;
import com.msp.cp.dept.vo.DeptVO;

@Service
public class DeptServiceImpl implements DeptService{

	@Autowired
	DeptDao deptDao;
	
	@Override
	public List<DeptVO> deptList() {
		// TODO Auto-generated method stub
		List<DeptVO> list = deptDao.codeList();
		return list;
	}

	@Override
	public List<DeptVO> deptDetailList(DeptVO dvo) {
		// TODO Auto-generated method stub
		List<DeptVO> list = deptDao.codeDetailList(dvo);
		return list;
	}

	@Override
	public int deptInsert(DeptVO dvo) {
		// TODO Auto-generated method stub
		int result = 0;
		result = deptDao.deptInsert(dvo);
		return result;
	}

}
