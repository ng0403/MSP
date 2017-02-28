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
	public List<MenuVO> menuTreeList(String sessionID) {
		// TODO Auto-generated method stub
		List<MenuVO> list = menuDao.menuTreeList(sessionID);
		return list;
	}

	/*@Override
	public List<MenuVO> menuTreeList() {
		// TODO Auto-generated method stub
		List<MenuVO> menu = menuDao.menuTreeList("ML01");
		List<MenuVO> smenu = menuDao.menuTreeList("ML02");
		List<MenuVO> tmenu = menuDao.menuTreeList("ML03");
		List<MenuVO> fmenu = menuDao.menuTreeList("ML04");
		List<MenuVO> list = new ArrayList<MenuVO>();
		
		for (MenuVO menuVO : menu) {
			ArrayList<MenuVO> slist = new ArrayList<MenuVO>();
			ArrayList<MenuVO> tlist = new ArrayList<MenuVO>();
			ArrayList<MenuVO> flist = new ArrayList<MenuVO>();
			MenuVO mov = menuVO;
			for(MenuVO smenuVO : smenu){
				MenuVO smov = smenuVO;
				if(mov.getMenu_cd().equals(smov.getUp_menu_cd())){
					slist.add(smov);
				}
				for(MenuVO tmenuVO : tmenu){
					MenuVO tmov = tmenuVO;
					if(smov.getMenu_cd().equals(tmov.getUp_menu_cd())){
						tlist.add(tmov);
					}
					for(MenuVO fmenuVO : fmenu){
						MenuVO fmov = fmenuVO;
						if(tmov.getMenu_cd().equals(fmov.getUp_menu_cd())){
							flist.add(fmov);
						}
					}
				}
			}
			list.add(new MenuVO(mov.getMenu_cd(), mov.getMenu_nm(),  mov.getMenu_url(),
					mov.getMenu_level(), mov.getUp_menu_cd(),  mov.getActive_key(), slist, tlist, flist));
		}
		
		return list;
	}*/

}
