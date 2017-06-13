package com.msp.cp.chart.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.chart.vo.DthreeVO;
import com.msp.cp.user.vo.userVO;
import com.msp.cp.utils.ExcelRead;
import com.msp.cp.utils.ExcelReadOption;

@Repository
public class DthreeDaoImpl implements DthreeDao {

	@Autowired
	SqlSession sqlSession;
	public void setSqlSessionTemplate(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<DthreeVO> dthreeList(Map<String, Object> map) {

		return sqlSession.selectList("chart.selectDthree", map);
		
	}

	@Override
	public int getDthreeCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("chart.dthreeCount", map);
	}

	@Override
	public List<DthreeVO> dthreeDetailList(String area) {
		System.out.println("dao before : " + area);
		List<DthreeVO> list = sqlSession.selectList("chart.selectDetailDthree", area);
		System.out.println("dao after : " + list);
		return list;
	}

	@Override
	public int dthreeInsert(DthreeVO dthreeVO) {
		
		return sqlSession.insert("chart.insertDthree", dthreeVO);
	}

	@Override
	public int dthreeUpdate(DthreeVO dthreeVO) {
		
		return sqlSession.update("chart.updateDthree", dthreeVO);
	}

	@Override
	public int dthreeDelete(String dc) {
		
		return sqlSession.update("chart.deleteDthree", dc);
	}

	@Override
	public List<DthreeVO> searchListPop(Map<String, Object> map) {
		
		return sqlSession.selectList("chart.selectDthreePop", map);
	}
	
	@Override
	public List<DthreeVO> dthreeExcel(Map<String, Object> map) {
		
		List<DthreeVO> dthreeExcel = null;
		
		try {
			
			dthreeExcel = sqlSession.selectList("chart.dthree_list_excel",map);
			System.out.println("dthreeExcel Dao Impl : " + dthreeExcel);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return dthreeExcel;
	}
	
	@Override
	public int dthreeUpLoadExcel(File destFile) {
		
		System.out.println("Excel DAO Impl 시작 : ");
		
		int result=0;
		ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        
        /*엑셀 시트 상의 셀 이름, 본인의 데이터 수만큼 바꾸고 쓰시면 됩니다*/
        excelReadOption.setOutputColumns("A", "B", "C", "D");
        excelReadOption.setStartRow(2);
        
        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
        //System.out.println("Excel DAO Impl : " + excelContent);
        
        for(Map<String, String> article: excelContent){
        	
           System.out.println(article);
           result = sqlSession.insert("common.dthreeExcelInsert", article);
        }
		return result;
	}

	@Override
	public List<DthreeVO> dthreeListAll(Map<String, Object> map) {
		
		return sqlSession.selectList("chart.selectDthreeAll", map);
	}
}
