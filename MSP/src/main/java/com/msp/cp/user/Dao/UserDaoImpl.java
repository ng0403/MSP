package com.msp.cp.user.Dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.ExcelRead;
import com.msp.cp.utils.ExcelReadOption;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
//	사용자관리 리스트 
	@Override
	public List<userVO> searchListUser(Map map) {
		System.out.println("9. DaoImpl User List Search Dao Impl");
		System.out.println("10. DaoImpl map. toString : " + map.toString());
		System.out.println("11. DaoImpl endRow : " + map.get("endRow"));
		System.out.println("12. DaoImpl pageSize : " + map.get("pageSize"));
		List<userVO> obj = sqlSession.selectList("searchListUser", map);
		System.out.println("13. DaoImpl User List Search Dao Impl" + obj);
		
		return obj;

	}


	@Override
	public Object selectOnes(String root, Object obj) {
		try {
			Object result = sqlSession.selectOne(root,  obj);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

//	사용자 신규등록
	@Override
	public void insert(userVO vo) {
		System.out.println("insert start DaoImpl");
		System.out.println("insert start DaoImpl vo : " + vo.toString());
		sqlSession.insert("user.userInsert", vo);
		System.out.println("insert success DaoImpl");
		
	}

//	사용자 삭제
	@Override
	public void userDel(String dc) {
		sqlSession.update("user.userDel", dc);
		System.out.println("user del dao impl enter");
		
	}

//	사용자 관리 상세정보	
	@Override
	public userVO searchListUserOne(String user_id) {
		System.out.println("After userDaoImpl : " + user_id);
		userVO vo= sqlSession.selectOne("userDetail", user_id);
		System.out.println("Before userDaoImpl : " + vo);
		
		return vo;
	}

//	사용자 아이디 클릭 시 팝업
	@Override
	public void userMdfy(userVO vo) {
		System.out.println("After userMdfyDaoImpl : " + vo);
		sqlSession.update("userEdit", vo);
		System.out.println("Before userMdfyDaoImpl : " + vo);
		
	}

//	사용자 갯수 카운트
	@Override
	public int UserListCount(String string, Map<String, Object> map) {
		int totalCount = 0;
		try {
			totalCount = sqlSession.selectOne("user.userListCount", map);
			System.out.println("6. DAoImpl totalCount : " + totalCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}

//	사용자 직급 리스트
	@Override
	public List<userVO> rankCdList() {
		List<userVO> rankCdList = null;
		try {
			rankCdList = sqlSession.selectList("user.rankCDList");
			System.out.println("rank_cd_list DAo Impl : " + rankCdList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rankCdList;
	}

//	사용자 직책 리스트
	@Override
	public List<userVO> dutyCdList() {
		List<userVO> dutyCdList = null;
		try {
			dutyCdList = sqlSession.selectList("user.dutyCDList");
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		return dutyCdList;
	}

//	사용자리스트 엑셀 출력
	@Override
	public List<userVO> userExcel(Map<String, Object> map) {
		List<userVO> userExcel = null;
		
		try {
			userExcel = sqlSession.selectList("user.userlist_excel",map);
			System.out.println("userExcel Dao Impl : " + userExcel);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userExcel;
	}

//	Excel Data Import
	@Override
	public int userUpLoadExcel(File destFile) {
		System.out.println("Excel DAO Impl 시작 : ");
		int result=0;
		ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
/*        A, B, C ... 엑셀 시트 상의 셀 이름입니다. 그냥 두시고 사용하세요 갯수만 본인의 데이터 수만큼 바꾸고 쓰시면 됩니다.-이지용 2017_02_17*/
        excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q");
        excelReadOption.setStartRow(2);
        
        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
        System.out.println("Excel DAO Impl : " + excelContent);
        for(Map<String, String> article: excelContent){
            System.out.println(article);
           result = sqlSession.insert("common.userExcelInsert", article);
        }
		return result;
	}
}

