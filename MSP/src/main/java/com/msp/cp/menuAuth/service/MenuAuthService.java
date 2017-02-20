package com.msp.cp.menuAuth.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.common.PagerVO;
import com.msp.cp.menuAuth.vo.MenuAuthVO;

public interface MenuAuthService {
	
	public List<Object> searchMenuAuthList(Map map);
	public List<MenuAuthVO> searchMenuAuth(Map<String, Object> map);
	public List<MenuAuthVO> menuAuthDetail(Map<String, Object> map);
	
	public void insertMenuAuth(MenuAuthVO menuAuthVo);
	
	// Paging
	PagerVO getMenuAuthListCount(Map<String, Object> map);

}
