package com.msp.cp.user.Dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.msp.cp.user.vo.userVO;

public interface UserDao {
	public List<userVO> searchListUser(Map map);

	public Object selectOnes(String root, Object obj);

	public int insert(userVO vo);

	public int userDel(String dc);

	public List<userVO> searchListUserOne(String user_id);

	public int userMdfy(userVO vo);

	int UserListCount(String string, Map<String, Object> map);

	public List<userVO> rankCdList();

	public List<userVO> dutyCdList();

	public List<userVO> userExcel(Map<String, Object> map);

	public int userUpLoadExcel(File destFile);
}
