package com.msp.cp.auth.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.auth.dao.AuthDao;
import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.PagerVO;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	AuthDao authDao;

	@Override
	public List<AuthVO> authList(Map<String, Object> map) {
		
		List<AuthVO> list = authDao.authList(map);
		return list;
	}

	@Override
	public PagerVO getAuthCount(Map<String, Object> map) {
		
		int PageNum = (Integer) map.get("pageNum");
		int pageListCount = authDao.getAuthCount(map);
		
		PagerVO page = new PagerVO(PageNum, pageListCount, 5, 20);
		return page;
	}

	@Override
	public List<AuthVO> authDetailList(String auth_id) {
		
		List<AuthVO> list = authDao.authDetailList(auth_id);
		return list;
	}

	@Override
	public int authInsert(AuthVO authVO) {
		
		int result = 0;
		result = authDao.authInsert(authVO);
		return result;
	}

	@Override
	public int authUpdate(AuthVO authVO) {
		
		int result = 0;
		result = authDao.authUpdate(authVO);
		return result;
	}

	@Override
	public int authDelete(String dc) {
		
		int result = 0;
		result = authDao.authDelete(dc);
		return result;
	}

	@Override
	public List<AuthVO> searchListPop(Map<String, Object> map) {

		List<AuthVO> list = authDao.searchListPop(map);
		return list;
	}
	
	@Override
	public List<userVO> authExcel(Map<String, Object> map) {
		
		List<userVO> authExcel = authDao.authExcel(map);
		System.out.println("authExcel Service Impl : "  + authExcel);
		return authExcel;
	}

	@Override
	public int excelUpload(File destFile) {
		
		System.out.println("Excel Service Impl 시작 : ");
		int result = authDao.authUpLoadExcel(destFile);
		
		return result;
	}


	 
	
	

}
