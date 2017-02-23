package com.msp.cp.menu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.code.service.CodeService;
import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.menu.dao.MenuDao;
import com.msp.cp.menu.vo.MenuVO;
import com.msp.cp.utils.PagerVO;

@Service
public class MenuServiceImpl implements MenuService{

	@Autowired
	MenuDao menuDao;
	
	@Autowired
	CodeService codeService;
	
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

	@Override
	public List<MenuVO> menuTreeList() {
		// TODO Auto-generated method stub
		List<CodeVO> mLevel = codeService.menuLevel();
		List<MenuVO> list = new ArrayList<MenuVO>();
		Map<String, List<MenuVO>> menuMap = new HashMap<String, List<MenuVO>>();
		//ArrayList<String> mlevelS = new ArrayList<>();
		for (int i = 0; i < mLevel.size(); i++ ) {
			CodeVO cvo = (CodeVO) mLevel;
			//mlevelS.add(cvo.getCode1());
			List<MenuVO> menu = menuDao.selectMenuTree(cvo.getCode1());
			menuMap.put("menu" + i, menu);
		}
		List<MenuVO> menu = menuMap.get("menu0");
		
		return list;
	}

}
