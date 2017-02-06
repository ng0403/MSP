package com.msp.cp.dept.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.dept.controller.DeptController;
import com.msp.cp.dept.vo.DeptVO;

@Repository
public class DeptDaoImpl implements DeptDao{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<DeptVO> codeList(DeptVO dvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dept.selectDept", dvo);
	}

	@Override
	public List<DeptVO> codeDetailList(String dept_cd) {
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

}
