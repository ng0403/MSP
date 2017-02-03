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
	public List<Object> searchCodeList() {
		List<Object> obj = codeDao.searchCodeList();
		
 		return obj;
	}
	
	@Override
	public List<CodeVO> searchCodeDetail(CodeVO codeVo) {
		// TODO Auto-generated method stub
		List<CodeVO> obj = codeDao.searchCodeDetail(codeVo);
		
		return obj;
	}
	
	@Override
	public void insertCodeMaster(CodeVO codeVo) {
		// TODO Auto-generated method stub
		System.out.println("insertCodeMaster 서비스");
		
		codeDao.insertCodeMaster(codeVo);
	}

	@Override
	public void insertCodeDetail(CodeVO codeVo) {
		// TODO Auto-generated method stub
		System.out.println("insertCodeDetail 서비스");
		
		codeDao.insertCodeDetail(codeVo);
	}

	@Override
	public void deleteCodeMaster(CodeVO codeVo) {
		// TODO Auto-generated method stub
		System.out.println("deleteCodeMaster 서비스");
		
		codeDao.deleteCodeMaster(codeVo);
	}

	@Override
	public void deleteCodeDetail(CodeVO codeVo) {
		// TODO Auto-generated method stub
		System.out.println("deleteCodeDetail 서비스");
		
		codeDao.deleteCodeDetail(codeVo);
	}

}
