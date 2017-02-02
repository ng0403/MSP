package com.msp.cp.dept.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.dept.vo.DeptVO;

@Repository
public class DeptDaoImpl implements DeptDao{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<DeptVO> codeList(DeptVO dvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dept.selectDept");
	}

	@Override
	public List<DeptVO> codeDetailList(DeptVO dvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dept.selectDetailDept");
	}

	@Override
	public int deptInsert(DeptVO dvo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("dept.insertDept");
	}

	@Override
	public int deptUpdate(DeptVO dvo) {
		// TODO Auto-generated method stub
		return sqlSession.update("dept.updateDept");
	}

	@Override
	public int deptDelete(String dc) {
		// TODO Auto-generated method stub
		return sqlSession.update("dept.deleteDept");
	}

}
