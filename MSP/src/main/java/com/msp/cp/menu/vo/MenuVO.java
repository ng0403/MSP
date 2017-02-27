package com.msp.cp.menu.vo;

import java.util.ArrayList;

public class MenuVO {
	
	public String menu_cd;
	public String menu_nm;
	public String menu_url;
	public String menu_level;
	public String up_menu_cd;
	public String active_flg;
	
	public String up_menu_nm;
	
	public String active_key;
	public String menu_nm_key;
	
	public ArrayList<MenuVO> sMenuVO;
	public ArrayList<MenuVO> tMenuVO;
	public ArrayList<MenuVO> fMenuVO;
	
	public MenuVO() {
		super();
	}
	
	public MenuVO(String menu_cd, String menu_nm, String menu_url, String menu_level, String up_menu_cd,
			String active_flg, ArrayList<MenuVO> sMenuVO, ArrayList<MenuVO> tMenuVO,
			ArrayList<MenuVO> fMenuVO) {
		super();
		this.menu_cd = menu_cd;
		this.menu_nm = menu_nm;
		this.menu_url = menu_url;
		this.menu_level = menu_level;
		this.up_menu_cd = up_menu_cd;
		this.active_flg = active_flg;
		this.sMenuVO = sMenuVO;
		this.tMenuVO = tMenuVO;
		this.fMenuVO = fMenuVO;
	}

	public ArrayList<MenuVO> getsMenuVO() {
		return sMenuVO;
	}
	public void setsMenuVO(ArrayList<MenuVO> sMenuVO) {
		this.sMenuVO = sMenuVO;
	}
	public ArrayList<MenuVO> gettMenuVO() {
		return tMenuVO;
	}
	public void settMenuVO(ArrayList<MenuVO> tMenuVO) {
		this.tMenuVO = tMenuVO;
	}
	public ArrayList<MenuVO> getfMenuVO() {
		return fMenuVO;
	}
	public void setfMenuVO(ArrayList<MenuVO> fMenuVO) {
		this.fMenuVO = fMenuVO;
	}

	public String getUp_menu_nm() {
		return up_menu_nm;
	}
	public void setUp_menu_nm(String up_menu_nm) {
		this.up_menu_nm = up_menu_nm;
	}
	public String getMenu_cd() {
		return menu_cd;
	}
	public void setMenu_cd(String menu_cd) {
		this.menu_cd = menu_cd;
	}
	public String getMenu_nm() {
		return menu_nm;
	}
	public void setMenu_nm(String menu_nm) {
		this.menu_nm = menu_nm;
	}
	public String getMenu_url() {
		return menu_url;
	}
	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}
	public String getMenu_level() {
		return menu_level;
	}
	public void setMenu_level(String menu_level) {
		this.menu_level = menu_level;
	}
	public String getUp_menu_cd() {
		return up_menu_cd;
	}
	public void setUp_menu_cd(String up_menu_cd) {
		this.up_menu_cd = up_menu_cd;
	}
	public String getActive_flg() {
		return active_flg;
	}
	public void setActive_flg(String active_flg) {
		this.active_flg = active_flg;
	}
	public String getActive_key() {
		return active_key;
	}
	public void setActive_key(String active_key) {
		this.active_key = active_key;
	}
	public String getMenu_nm_key() {
		return menu_nm_key;
	}
	public void setMenu_nm_key(String menu_nm_key) {
		this.menu_nm_key = menu_nm_key;
	}
		
}