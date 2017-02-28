package com.msp.cp.menu.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.menu.vo.MenuVO;
import com.msp.cp.utils.PagerVO;

public interface MenuService {

	public List<MenuVO> menuList(Map<String, Object> map);

	public List<MenuVO> menuDetailList(String menu_cd);

	public int menuInsert(MenuVO mvo);

	public int menuUpdate(MenuVO mvo);

	public int menuDelete(String dc);

	public PagerVO getMenuCount(Map<String, Object> map);

	public List<MenuVO> searchListPop(Map<String, Object> map);

	public List<MenuVO> menuTreeList(String sessionID);

}
