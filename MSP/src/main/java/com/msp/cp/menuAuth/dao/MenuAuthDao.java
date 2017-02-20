package com.msp.cp.menuAuth.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.menuAuth.vo.MenuAuthVO;

public interface MenuAuthDao {
	
	public List<Object> searchMenuAuthList(Map map);
	public List<MenuAuthVO> searchMenuAuth(Map<String, Object> map);
	public List<MenuAuthVO> menuAuthDetail(Map<String, Object> map);

	public void insertMenuAuth(MenuAuthVO menuAuthVo);
	
	// Paging
	int MenuAuthListCount(String string, Map<String, Object> map);
}
