package com.msp.cp.code.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.code.dao.CodeDao;
import com.msp.cp.code.vo.CodeVO;

@Service
public class CodeServiceImpl implements CodeService {
	
	@Autowired
	CodeDao codeDao;

	@Override
	public List<CodeVO> list() {
		
 		return codeDao.list();
	}

}
