package com.msp.cp.menuAuth.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.common.PagerVO;
import com.msp.cp.menuAuth.dao.MenuAuthDao;
import com.msp.cp.menuAuth.vo.MenuAuthVO;

@Service
public class MenuAuthServiceImpl implements MenuAuthService{
	
	@Autowired
	MenuAuthDao menuAuthDao;

	@Override
	public PagerVO getMenuAuthListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int menuAuthPageNum = (Integer)map.get("pageNum");
		int totalRowCount = menuAuthDao.MenuAuthListCount("menuAuthListCount", map);
		
		PagerVO page = new PagerVO(menuAuthPageNum, totalRowCount, 10, 999);
		
		return page;
	}

	@Override
	public List<Object> searchMenuAuthList(Map map) {
		// TODO Auto-generated method stub
		List<Object> obj = menuAuthDao.searchMenuAuthList(map);
		
		return obj;
	}

	@Override
	public List<MenuAuthVO> searchMenuAuth(Map<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("서비스 : " + map);
		List<MenuAuthVO> obj = menuAuthDao.searchMenuAuth(map);
		
		return obj;
	}

	@Override
	public List<MenuAuthVO> menuAuthDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<MenuAuthVO> obj = menuAuthDao.menuAuthDetail(map);
		
		return obj;
	}

	@Override
	public void insertMenuAuth(MenuAuthVO menuAuthVo) {
		// TODO Auto-generated method stub
		menuAuthDao.insertMenuAuth(menuAuthVo);
	}

}
