package com.msp.cp.menu.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.menu.vo.MenuVO;

@Repository
public class MenuDaoImpl implements MenuDao{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<MenuVO> menuList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("menu.selectMenu", map);
	}
	
	@Override
	public int getMenuCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("menu.menuCount", map);
	}

	@Override
	public List<MenuVO> menuDetailList(String menu_cd) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("menu.selectDetailMenu", menu_cd);
	}

	@Override
	public int menuInsert(MenuVO mvo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("menu.insertMenu", mvo);
	}

	@Override
	public int menuUpdate(MenuVO mvo) {
		// TODO Auto-generated method stub
		return sqlSession.update("menu.updateMenu", mvo);
	}

	@Override
	public int menuDelete(String dc) {
		// TODO Auto-generated method stub
		return sqlSession.update("menu.deleteMenu", dc);
	}

	@Override
	public List<MenuVO> searchListPop(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("menu.selectMenuPop", map);
	}

}
