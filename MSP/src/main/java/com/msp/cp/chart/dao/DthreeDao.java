package com.msp.cp.chart.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.chart.vo.DthreeVO;
import com.msp.cp.user.vo.userVO;

public interface DthreeDao {

	public List<DthreeVO> dthreeList(Map<String, Object> map);

	public int getDthreeCount(Map<String, Object> map);

	public List<DthreeVO> dthreeDetailList(String area);

	public int dthreeInsert(DthreeVO dthreeVO);

	public int dthreeUpdate(DthreeVO dthreeVO);

	public int dthreeDelete(String dc);

	public List<DthreeVO> searchListPop(Map<String, Object> map);

	public List<DthreeVO> dthreeExcel(Map<String, Object> map);

	public int dthreeUpLoadExcel(File destFile);

	public List<DthreeVO> dthreeListAll(Map<String, Object> map);


	
}
