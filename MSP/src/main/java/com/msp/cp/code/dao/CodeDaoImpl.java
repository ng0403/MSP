package com.msp.cp.code.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.code.vo.CodeVO;

@Repository
public class CodeDaoImpl implements CodeDao {
	
	@Autowired
	SqlSession sqlsession;

	@Override
	public List<CodeVO> list() {
		 
		return null;
	}

}
