package com.msp.cp.login.vo;

public class LoginVO {
	
	String user_id;
	String user_nm;
	String user_pwd;
	String del_yn;
	//int pwd_ernm_yn;
	
	public LoginVO(){}
	
	public LoginVO(String user_id, String user_nm, String user_pwd, String del_yn) {/*, int pwd_ernm_yn*/
		super();
		this.user_id = user_id;
		this.user_nm = user_nm;
		this.user_pwd = user_pwd;
		this.del_yn = del_yn;
	//	this.pwd_ernm_yn = pwd_ernm_yn;
	}


	

	@Override
	public String toString() {
		return "LoginVO [user_id=" + user_id + ", user_nm=" + user_nm + ", user_pwd=" + user_pwd + ", del_yn=" + del_yn
				+ ", getUser_id()=" + getUser_id() + ", getUser_nm()=" + getUser_nm() + ", getUser_pwd()="
				+ getUser_pwd() + ", getDel_yn()=" + getDel_yn() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_nm() {
		return user_nm;
	}

	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	
	
	
}
