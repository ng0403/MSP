package com.msp.cp.user.Service;

import java.util.List;
import java.util.Map;

import com.msp.cp.common.PagerVO;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.user.vo.userVO;

public interface UserService {

	public List<userVO> searchListUser(Map map);

	public void insertUser(userVO vo);

	public Object userOneSelectByIdNM(Object user_id);

	public void userDel(String dc);

	public userVO searchListUserOne(String user_id);

	public void userMdfy(userVO vo);

	PagerVO getUserListCount(Map<String, Object> map);

	public List<userVO> rankCdList();

	public List<userVO> dutyCdList();

	public List<DeptVO> dept_list(Map<String, Object> map);


}
