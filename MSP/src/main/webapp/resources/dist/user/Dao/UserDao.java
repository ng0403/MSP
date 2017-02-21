package com.crm.cp.test.user.Dao;

import java.util.List;

import com.crm.cp.test.user.vo.userVO;

public interface UserDao {
	public List<Object> searchListUser();

	public Object selectOnes(String root, Object obj);

	public void insert(userVO vo);

	public void userDel(String dc);

	public userVO searchListUserOne(String user_id);

	public void userMdfy(userVO vo);
}
