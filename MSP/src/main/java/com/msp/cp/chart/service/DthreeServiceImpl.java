package com.msp.cp.chart.service;


import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.chart.dao.DthreeDao;
import com.msp.cp.chart.vo.DthreeVO;
import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.PagerVO;

@Service
public class DthreeServiceImpl implements DthreeService {

	@Autowired
	DthreeDao dthreeDao;
	
	@Override
	public List<DthreeVO> dthreeList(Map<String, Object> map) {
		
		List<DthreeVO> list = dthreeDao.dthreeList(map);
		return list;
	}

	@Override
	public PagerVO getDthreeCount(Map<String, Object> map) {
		
		int PageNum = (Integer) map.get("pageNum");
		int pageListCount = dthreeDao.getDthreeCount(map);
		
		PagerVO page = new PagerVO(PageNum, pageListCount, 10, 20);
		return page;
	}

	@Override
	public List<DthreeVO> dthreeDetailList(String area) {
		System.out.println("service before : " + area);
		List<DthreeVO> list = dthreeDao.dthreeDetailList(area);
		System.out.println("service after : " + list);
		return list;
	}

	@Override
	public int dthreeInsert(DthreeVO dthreeVO) {
		
		int result = 0;
		result = dthreeDao.dthreeInsert(dthreeVO);
		return result;
	}

	@Override
	public int dthreeUpdate(DthreeVO dthreeVO) {
		
		int result = 0;
		result = dthreeDao.dthreeUpdate(dthreeVO);
		return result;
	}

	@Override
	public int dthreeDelete(String dc) {
		
		int result = 0;
		result = dthreeDao.dthreeDelete(dc);
		return result;
	}

	@Override
	public List<DthreeVO> searchListPop(Map<String, Object> map) {
		
		List<DthreeVO> list = dthreeDao.searchListPop(map);
		return list;
	}

	@Override
	public List<DthreeVO> dthreeExcel(Map<String, Object> map) {
		
		List<DthreeVO> dthreeExcel = dthreeDao.dthreeExcel(map);
		System.out.println("dthreeExcel Service Impl : "  + dthreeExcel);
		return dthreeExcel;
	}
	
	@Override
	public int excelUpload(File destFile) throws Exception {
		
		System.out.println("Excel Service Impl 시작 : ");
		int result = dthreeDao.dthreeUpLoadExcel(destFile);
		
		return result;
	}

	@Override
	public List<DthreeVO> dthreeListAll(Map<String, Object> map) {

		List<DthreeVO> list = dthreeDao.dthreeListAll(map);
		return list;
	}

	

}
