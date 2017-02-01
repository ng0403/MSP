package com.crm.cp.test.user.Service;

import java.util.List;

import com.crm.cp.test.user.vo.userVO;

public interface UserService {

	public List<Object> searchListUser();

	public void insertUser(userVO vo);

	public Object userOneSelectByIdNM(Object user_id);

	public void userDel(String dc);

	public userVO searchListUserOne(String user_id);

	public void userMdfy(userVO vo);


}
