package com.msp.cp.user.Service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.utils.PagerVO;
import com.msp.cp.dept.dao.DeptDao;
import com.msp.cp.dept.vo.DeptVO;
import com.msp.cp.user.Dao.UserDao;
import com.msp.cp.user.vo.userVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;
	@Autowired
	DeptDao deptDao;

	
//	사용자관리 리스트
	@Override
	public List<userVO> searchListUser(Map<String,Object> map) {
		System.out.println("8. ServiceImpl User List Search Service Impl");
		List<userVO> obj = userDao.searchListUser(map);
		System.out.println("14. ServiceImpl User List Search Service Impl" + obj.toString());
		return obj;
	}

	
	@Override
	public Object userOneSelectByIdNM(Object user_id) {
		Object obj = userDao.selectOnes("user.userIDOneSelect", "user_id");
		return obj;
	}

//	사용자 신규 추가
	@Override
	public void insertUser(userVO vo) {
		System.out.println("insert start ServiceImpl");
		userDao.insert(vo);
		System.out.println("insert success ServiceImpl");
		
	}

//	사용자 삭제
	@Override
	public int userDel(String dc) {
		int result = 0;
		result = userDao.userDel(dc);
		System.out.println("del serviceImpl enter");
		return result;
		
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
		System.out.println("5. ServiceImpl Page userPageNum : " + userPageNum);
		int totalRowCount = userDao.UserListCount("userListCount", map);
		System.out.println("7. ServiceImpl Page totalRowCount : " + totalRowCount);
		
		PagerVO page = new PagerVO(userPageNum, totalRowCount, 10, 999);
		
		return page;
	}

	@Override
	public List<userVO> rankCdList() {
		List<userVO> rank_cd_list = userDao.rankCdList();
		System.out.println("rank_cd_list DAo Impl : " + rank_cd_list);
		return rank_cd_list;
	}

	@Override
	public List<userVO> dutyCdList() {
		List<userVO> duty_cd_list = userDao.dutyCdList();
		
		return duty_cd_list;
	}

	@Override
	public List<DeptVO> dept_list(Map<String, Object> map) {
		List<DeptVO> dept_list = deptDao.searchListPop(map);
		return dept_list;
	}

	@Override
	public List<userVO> userExcel(Map<String, Object> map) {
		List<userVO> userExcel = userDao.userExcel(map);
		System.out.println("userExcel Service Impl : "  + userExcel);
		return userExcel;
	}


	@Override
    public int excelUpload(File destFile) throws Exception{
		System.out.println("Excel Service Impl 시작 : ");
		int result = userDao.userUpLoadExcel(destFile);
		
		return result;
	}
	
}