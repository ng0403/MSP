package com.msp.cp.auth.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.ExcelRead;
import com.msp.cp.utils.ExcelReadOption;

@Repository
public class AuthDaoImpl implements AuthDao {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<AuthVO> authList(Map<String, Object> map) {
		
		return sqlSession.selectList("auth.selectAuth", map);
	}
	
	@Override
	public int getAuthCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("auth.authCount", map);
	}
	
	@Override
	public List<AuthVO> authDetailList(String auth_id) {
		
		return sqlSession.selectList("auth.selectDetailAuth", auth_id);
	}
	
	@Override
	public int authInsert(AuthVO authVO) {
		
		return sqlSession.insert("auth.insertAuth", authVO);
	}
	
	@Override
	public int authUpdate(AuthVO authVO) {
		
		return sqlSession.update("auth.updateAuth", authVO);
	}
	
	@Override
	public int authDelete(String dc) {
		
		return sqlSession.update("auth.deleteAuth", dc);
	}
	
	@Override
	public List<AuthVO> searchListPop(Map<String, Object> map) {
		return sqlSession.selectList("auth.selectAuthPop", map);
	}
	
	@Override
	public List<userVO> authExcel(Map<String, Object> map) {
		
		List<userVO> authExcel = null;
		
		try {
			
			authExcel = sqlSession.selectList("auth.auth_list_excel", map);
			System.out.println("authExcel Dao Impl : " + authExcel);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return authExcel;
	}
	
	@Override
	public int authUpLoadExcel(File destFile) {
		
		System.out.println("Excel DAO Impl 시작 : ");
		
		int result=0;
		ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        
        //엑셀 시트 상의 셀 이름(데이터 수만큼)
        excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H");
        excelReadOption.setStartRow(2);
        
        List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
        System.out.println("Excel DAO Impl : " + excelContent);
        
        for(Map<String, String> article: excelContent){
        	
           System.out.println(article);
           result = sqlSession.insert("common.authExcelInsert", article);
        }
		return result;
	}

	
	
}
