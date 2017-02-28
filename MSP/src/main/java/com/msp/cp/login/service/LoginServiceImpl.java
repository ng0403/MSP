package com.msp.cp.login.service;

import com.msp.cp.common.Commons;
import com.msp.cp.login.dao.LoginDao;
import com.msp.cp.login.vo.LoginVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.junit.runner.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("LoginService")
public class LoginServiceImpl implements LoginService {
	
	@Resource
	LoginDao loginDao;
	
	@Autowired
	private HttpSession httpSession;

	//로그인처리
	@Override
	public String doLogin(String user_id, String user_pwd) {
		String result = null;
	
		// 로그인한 사용자 정보를 가져온다
		LoginVO userInfo = null;
		userInfo = getUserInfo(user_id);
		System.out.println("userInfo : " + userInfo);
		
		if(userInfo != null){
			// 비밀번호 오류횟수
			int pwdErnm = 0;/*userInfo.getPwd_ernm_yn();*/
			
			// 비밀번호 오류횟수 확인
			if (pwdErnm < 3) {
				
				String pswdno = null;
				try{
					// 정상일 경우
					// 암호화된 비밀번호 취득
					pswdno = user_pwd;/*Commons.getCryptoMD5String(user_pwd);*/
					System.out.println("password Check : " + user_pwd);
							/*userInfo.getUser_pwd();*/
					System.out.println("login service Impl pswdno : " + pswdno);
				}catch (Exception e) {
					e.printStackTrace();
				}
				System.out.println("getUser_pwd : " + pswdno );/*userInfo.getUser_pwd()*/
				// 비밀번호가 일치하는 경우
				if (userInfo.getUser_pwd().equals(pswdno)) {
					
					System.out.println("login service Impl getUser_pwd() : " + userInfo.getUser_pwd());
					// 세션에 사용자 정보를 저장한다
					setUserInfo(userInfo);
					
					// 비밀번호 오류 횟수가 0이 아닌경우 초기화 시킨다
					if (pwdErnm != 0) {
						setPwdErnmYn(userInfo.getUser_id(), 0);
					}
					
					result = "LOGIN_SUCCESS";
				} else {
					// 비밀번호가 일치하지 않는 경우, 비밀번호 오류 횟수를 1증가시킨다
//					setPwdErnmYn(userInfo.getUser_id(), pwdErnm + 1);
					if (pwdErnm + 1 == 3) {
						result = "LOGIN_DENINED";
					} else {
						result = "LOGIN_FAIL1";
					}
				}
			} else {
				// 3회 이상 틀렸을 경우, 에러메세지를 반환한다
				result = "LOGIN_DENINED";
			}
		} else {
			result = "LOGIN_FAIL2";
		}
		System.out.println("result : " + result);
		return result;
	}

	//사용자 비밀번호 오류 횟수를 설정한다
	private void setPwdErnmYn(String user_id, int num) {
		
		// 유저정보 설정
//		LoginVO loginParam = new LoginVO();
//		loginParam.setUser_id(user_id);
//		loginParam.setPwd_ernm_yn(num);
		
		// 사용자 비밀번호 오류 횟수 설정
//		loginDao.updatePwdErnmYn(loginParam);
	 
	}

	//세션에 사용자 정보를 저장한다
	private void setUserInfo(LoginVO userInfo) {
		
		httpSession.setAttribute("user_id", userInfo.getUser_id());
		
		httpSession.setAttribute("user_nm", userInfo.getUser_nm());
		
	}

	//아이디로 유저정보를 가져온다
	private LoginVO getUserInfo(String user_id) {
		
		LoginVO loginParam = new LoginVO();
		loginParam.setUser_id(user_id);
		
		LoginVO userInfo = loginDao.selectUser(loginParam);
		System.out.println("loginSErviceImpl userInfo : " + userInfo);
		return userInfo;
	}

	/*// 로그인시 첫 메뉴 가져오기
	@Override
	public MenuVo getLoginMenuInfo() {
		MenuVo loginMenu = loginDao.getLoginMenuInfo();
		return loginMenu;
	}*/
}
