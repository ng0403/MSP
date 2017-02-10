package com.msp.cp.login.dao;

import com.msp.cp.login.vo.LoginVO;

public interface LoginDao {

	//사용자 정보조회
	LoginVO selectUser(LoginVO loginParam);

	// 사용자 비밀번호 오류 횟수 설정
	void updatePwdErnmYn(LoginVO loginParam);

	// 로그인시 첫 메뉴 가져오기
//	MenuVo getLoginMenuInfo();

}
