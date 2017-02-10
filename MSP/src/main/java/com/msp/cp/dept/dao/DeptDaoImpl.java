package com.msp.cp.dept.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.dept.vo.DeptVO;

@Repository
public class DeptDaoImpl implements DeptDao{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<DeptVO> deptList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dept.selectDept", map);
	}
	
	@Override
	public int getDeptCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dept.deptCount", map);
	}

	@Override
	public List<DeptVO> deptDetailList(String dept_cd) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dept.selectDetailDept", dept_cd);
	}

	@Override
	public int deptInsert(DeptVO dvo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("dept.insertDept", dvo);
	}

	@Override
	public int deptUpdate(DeptVO dvo) {
		// TODO Auto-generated method stub
		return sqlSession.update("dept.updateDept", dvo);
	}

	@Override
	public int deptDelete(String dc) {
		// TODO Auto-generated method stub
		return sqlSession.update("dept.deleteDept", dc);
	}

	@Override
	public List<DeptVO> searchListPop(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dept.selectDeptPop", map);
	}

}
