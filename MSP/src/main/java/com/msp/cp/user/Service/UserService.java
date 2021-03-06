package com.msp.cp.user.Service;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.msp.cp.utils.PagerVO;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.user.vo.userVO;

public interface UserService {

	public List<userVO> searchListUser(Map map);

	public int insertUser(userVO vo);

	public Object userOneSelectByIdNM(Object user_id);

	public int userDel(String dc);

	public List<userVO> searchListUserOne(String user_id);

	public int userMdfy(userVO vo);

	PagerVO getUserListCount(Map<String, Object> map);

	public List<userVO> rankCdList();

	public List<userVO> dutyCdList();

	public List<DeptVO> dept_list(Map<String, Object> map);

	public List<userVO> userExcel(Map<String, Object> map);

	public int excelUpload(File destFile) throws Exception;

}
