package com.msp.cp.login.service;



public interface LoginService {

	//로그인처리
	String doLogin(String user_id, String pswd);

	// 로그인시 첫페이지 메뉴 처리
	//MenuVo getLoginMenuInfo();

}
