package com.msp.cp.user.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.common.PagerVO;
import com.msp.cp.user.Dao.UserDao;
import com.msp.cp.user.vo.userVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;

	@Override
	public List<userVO> searchListUser(Map map) {
		System.out.println("User List Search Service Impl");
		List<userVO> obj = userDao.searchListUser(map);
		System.out.println("User List Search Service Impl" + obj.toString());
		return obj;
	}

	@Override
	public Object userOneSelectByIdNM(Object user_id) {
		Object obj = userDao.selectOnes("user.userIDOneSelect", "user_id");
		return obj;
	}

	@Override
	public void insertUser(userVO vo) {
		System.out.println("insert start ServiceImpl");
		userDao.insert(vo);
		System.out.println("insert success ServiceImpl");
		
	}

	@Override
	public void userDel(String dc) {
		userDao.userDel(dc);
		System.out.println("del serviceImpl enter");
		
	}

	@Override
	public userVO searchListUserOne(String user_id) {
		System.out.println("After userServiceImpl : " + user_id);
		userVO vo = userDao.searchListUserOne(user_id);
		System.out.println("Before userServiceImpl : " + vo);
		return vo;
	}

	@Override
	public void userMdfy(userVO vo) {
		System.out.println("After userMdfy ServiceImpl : " + vo);
		userDao.userMdfy(vo);
		System.out.println("Before userMdfy ServiceImpl : " + vo);
	}

	@Override
	public PagerVO getUserListCount(Map<String, Object> map) {
		int userPageNum = (Integer)map.get("pageNum");
		
		int totalRowCount = userDao.UserListCount("userListCount", map);
		
		PagerVO page = new PagerVO(userPageNum, totalRowCount, 5, 999);
		
		return page;
	}
}