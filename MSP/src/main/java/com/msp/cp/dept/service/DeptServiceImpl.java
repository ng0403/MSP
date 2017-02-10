package com.msp.cp.dept.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.dept.dao.DeptDao;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.utils.PagerVO;

@Service
public class DeptServiceImpl implements DeptService{

	@Autowired
	DeptDao deptDao;
	
	@Override
	public List<DeptVO> deptList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<DeptVO> list = deptDao.deptList(map);
		return list;
	}
	
	@Override
	public PagerVO getDeptCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int PageNum = (Integer) map.get("pageNum");
		int pageListCount = deptDao.getDeptCount(map);
		
		PagerVO page = new PagerVO(PageNum, pageListCount, 2, 10);
		return page;
	}

	@Override
	public List<DeptVO> deptDetailList(String dept_cd) {
		// TODO Auto-generated method stub
		List<DeptVO> list = deptDao.deptDetailList(dept_cd);
		return list;
	}

	@Override
	public int deptInsert(DeptVO dvo) {
		// TODO Auto-generated method stub
		int result = 0;
		result = deptDao.deptInsert(dvo);
		return result;
	}

	@Override
	public int deptUpdate(DeptVO dvo) {
		// TODO Auto-generated method stub
		int result = 0;
		result = deptDao.deptUpdate(dvo);
		return result;
	}

	@Override
	public int deptDelete(String dc) {
		// TODO Auto-generated method stub
		int result = 0;
		result = deptDao.deptDelete(dc);
		return result;
	}

	@Override
	public List<DeptVO> searchListPop(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<DeptVO> list = deptDao.searchListPop(map);
		return list;
	}

}
