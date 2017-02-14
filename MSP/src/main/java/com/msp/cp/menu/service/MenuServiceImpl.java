package com.msp.cp.menu.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.menu.dao.MenuDao;
import com.msp.cp.menu.vo.MenuVO;
import com.msp.cp.utils.PagerVO;

@Service
public class MenuServiceImpl implements MenuService{

	@Autowired
	MenuDao menuDao;
	
	@Override
	public List<MenuVO> menuList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<MenuVO> list = menuDao.menuList(map);
		return list;
	}
	
	@Override
	public PagerVO getMenuCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int PageNum = (Integer) map.get("pageNum");
		int pageListCount = menuDao.getMenuCount(map);
		
		PagerVO page = new PagerVO(PageNum, pageListCount, 10, 10);
		return page;
	}

	@Override
	public List<MenuVO> menuDetailList(String menu_cd) {
		// TODO Auto-generated method stub
		List<MenuVO> list = menuDao.menuDetailList(menu_cd);
		return list;
	}

	@Override
	public int menuInsert(MenuVO mvo) {
		// TODO Auto-generated method stub
		int result = 0;
		result = menuDao.menuInsert(mvo);
		return result;
	}

	@Override
	public int menuUpdate(MenuVO mvo) {
		// TODO Auto-generated method stub
		int result = 0;
		result = menuDao.menuUpdate(mvo);
		return result;
	}

	@Override
	public int menuDelete(String dc) {
		// TODO Auto-generated method stub
		int result = 0;
		result = menuDao.menuDelete(dc);
		return result;
	}

	@Override
	public List<MenuVO> searchListPop(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<MenuVO> list = menuDao.searchListPop(map);
		return list;
	}

}
