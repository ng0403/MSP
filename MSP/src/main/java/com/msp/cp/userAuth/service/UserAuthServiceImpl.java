package com.msp.cp.userAuth.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.userAuth.dao.UserAuthDao;
import com.msp.cp.userAuth.vo.UserAuthVO;
import com.msp.cp.utils.PagerVO;

@Service("UserAuthService")
public class UserAuthServiceImpl implements UserAuthService{
	
	@Resource
	UserAuthDao userAuthDao;
	
	//사용자권한 리스트 조회
	@Override
	public List<UserAuthVO> userAuthList(Map<String,Object> map){
		List<UserAuthVO> list = userAuthDao.userAuthList(map);
		return list;
	}
	
	//사용자권한 행 수
	@Override
	public PagerVO getUserAuthCount(Map<String, Object> map) {
		int PageNum = (Integer) map.get("pageNum");
		int pageListCount = userAuthDao.getUserAuthCount(map);
		
		PagerVO page = new PagerVO(PageNum, pageListCount, 15, 10);
		
		return page;
	}
	
	//권한 리스트
	@Override
	public List<AuthVO> authList(Map<String,Object> map){
		List<AuthVO> list = userAuthDao.authList(map);
		return list;
	}
		
	//사용자권한 상세정보 확인
	@Override
	public UserAuthVO openUserAuthDetail(String user_id){
		UserAuthVO userAuthVO = userAuthDao.openUserAuthDetail(user_id);
		return userAuthVO;
	}
	
	//사용자권한 등록
	@Override
	public int createUserAuth(UserAuthVO userAuthVO){
		int result=0;
		userAuthDao.createUserAuth(userAuthVO);
		return result;
	}
	
	//사용자권한 수정
	@Override
	public int updateUserAuth(UserAuthVO userAuthVO) {		
		int result = 0;
		userAuthDao.updateUserAuth(userAuthVO);
		return result;
	}
	
	//사용자권한 삭제
	@Override
	public int deleteUserAuth(UserAuthVO userAuthVO) {		
		int result = 0;
		userAuthDao.deleteUserAuth(userAuthVO);
		return result;
	}
	
	//사용자ID 확인
	@Override
	public UserAuthVO getUserId(Map<String, Object> map){
		UserAuthVO menuVO = userAuthDao.getUserId(map);
		userAuthDao.getUserId(map);
		return menuVO;
	}

}
