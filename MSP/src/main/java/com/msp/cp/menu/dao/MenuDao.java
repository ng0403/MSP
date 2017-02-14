package com.msp.cp.menu.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.menu.vo.MenuVO;

public interface MenuDao {

	public List<MenuVO> menuList(Map<String, Object> map);

	public List<MenuVO> menuDetailList(String Menu_cd);

	public int menuInsert(MenuVO mvo);

	public int menuUpdate(MenuVO mvo);

	public int menuDelete(String dc);

	public int getMenuCount(Map<String, Object> map);

	public List<MenuVO> searchListPop(Map<String, Object> map);

}
