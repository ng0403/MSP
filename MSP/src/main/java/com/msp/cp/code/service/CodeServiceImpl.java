package com.msp.cp.code.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.code.dao.CodeDao;
import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.common.PagerVO;

@Service
public class CodeServiceImpl implements CodeService {
	
	@Autowired
	CodeDao codeDao;

	@Override
	public List<Object> searchCodeList(Map map) {
		List<Object> obj = codeDao.searchCodeList(map);
		
 		return obj;
	}
	
	@Override
	public List<CodeVO> searchCodeDetail(CodeVO codeVo) {
		// TODO Auto-generated method stub
		List<CodeVO> obj = codeDao.searchCodeDetail(codeVo);
		
		return obj;
	}
	
	@Override
	public List<CodeVO> searchGrpList(CodeVO codeVo) {
		// TODO Auto-generated method stub
		List<CodeVO> obj = codeDao.searchGrpList(codeVo);
		
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

	@Override
	public PagerVO getCodeListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int codePageNum = (Integer)map.get("pageNum");
		int totalRowCount = codeDao.CodeListCount("codeListCount", map);
		
		System.out.println(codePageNum + " : " + totalRowCount);
		
		PagerVO page = new PagerVO(codePageNum, totalRowCount, 10, 999);
		
		return page;
	}

}
