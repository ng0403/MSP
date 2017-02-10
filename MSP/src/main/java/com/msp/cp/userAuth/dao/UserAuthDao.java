package com.msp.cp.userAuth.dao;

import java.util.List;
import java.util.Map;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.userAuth.vo.UserAuthVO;

public interface UserAuthDao {
	
	public List<UserAuthVO> userAuthList(Map<String, Object> map);
	public int getUserAuthCount(Map<String, Object> map);
	public List<AuthVO> authList(Map<String, Object> map);
	public List<AuthVO> user_authList(Map<String, Object> map);
	public UserAuthVO openUserAuthDetail(String user_id);
	public int createUserAuth(UserAuthVO userAuthVO);
	public int updateUserAuth(UserAuthVO userAuthVO);
	public int deleteUserAuth(UserAuthVO userAuthVO);
	public UserAuthVO getUserId(Map<String, Object> map);

}
