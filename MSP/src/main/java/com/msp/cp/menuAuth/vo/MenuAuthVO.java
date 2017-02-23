package com.msp.cp.menuAuth.vo;

public class MenuAuthVO {
	String auth_id, auth_nm, menu_cd, menu_nm, up_menu_cd, up_menu_nm, menu_url, 
		   inqr_auth, add_auth, mdfy_auth, del_auth, menu_acc_auth,
		   active_flg, created_by, updated_by;

	public String getAuth_id() {
		return auth_id;
	}

	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}

	public String getMenu_cd() {
		return menu_cd;
	}

	public void setMenu_cd(String menu_cd) {
		this.menu_cd = menu_cd;
	}

	public String getUp_menu_cd() {
		return up_menu_cd;
	}

	public void setUp_menu_cd(String up_menu_cd) {
		this.up_menu_cd = up_menu_cd;
	}

	public String getUp_menu_nm() {
		return up_menu_nm;
	}

	public void setUp_menu_nm(String up_menu_nm) {
		this.up_menu_nm = up_menu_nm;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getInqr_auth() {
		return inqr_auth;
	}

	public void setInqr_auth(String inqr_auth) {
		this.inqr_auth = inqr_auth;
	}

	public String getAdd_auth() {
		return add_auth;
	}

	public void setAdd_auth(String add_auth) {
		this.add_auth = add_auth;
	}

	public String getMdfy_auth() {
		return mdfy_auth;
	}

	public void setMdfy_auth(String mdfy_auth) {
		this.mdfy_auth = mdfy_auth;
	}

	public String getDel_auth() {
		return del_auth;
	}

	public void setDel_auth(String del_auth) {
		this.del_auth = del_auth;
	}

	public String getMenu_acc_auth() {
		return menu_acc_auth;
	}

	public void setMenu_acc_auth(String menu_acc_auth) {
		this.menu_acc_auth = menu_acc_auth;
	}

	public String getActive_flg() {
		return active_flg;
	}

	public void setActive_flg(String active_flg) {
		this.active_flg = active_flg;
	}

	public String getCreated_by() {
		return created_by;
	}

	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}

	public String getUpdated_by() {
		return updated_by;
	}

	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}

	public String getAuth_nm() {
		return auth_nm;
	}

	public void setAuth_nm(String auth_nm) {
		this.auth_nm = auth_nm;
	}

	public String getMenu_nm() {
		return menu_nm;
	}

	public void setMenu_nm(String menu_nm) {
		this.menu_nm = menu_nm;
	}

	@Override
	public String toString() {
		return "MenuAuthVO [auth_id=" + auth_id + ", menu_cd=" + menu_cd + ", up_menu_cd=" + up_menu_cd
				+ ", up_menu_nm=" + up_menu_nm + ", menu_url=" + menu_url + ", inqr_auth=" + inqr_auth + ", add_auth="
				+ add_auth + ", mdfy_auth=" + mdfy_auth + ", del_auth=" + del_auth + ", menu_acc_auth=" + menu_acc_auth
				+ ", active_flg=" + active_flg + ", created_by=" + created_by + ", updated_by=" + updated_by + "]";
	}
	
	

}
