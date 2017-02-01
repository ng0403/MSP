package com.crm.cp.test.user.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crm.cp.standard.iuser.vo.IuserVO;
import com.crm.cp.test.user.Dao.UserDao;
import com.crm.cp.test.user.vo.userVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;

	@Override
	public List<Object> searchListUser() {
		
		List<Object> obj = userDao.searchListUser();
		return obj;
	}

	@Override
	public Object userOneSelectByIdNM(Object user_id) {
		Object obj = userDao.selectOnes("user.userIDOneSelect", "user_id");
		return obj;
	}

	@Override
	public void insertUser(userVO vo) {
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
}