package com.msp.cp.code.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.msp.cp.code.vo.CodeVO;

@Repository
public class CodeDaoImpl implements CodeDao {
	
	@Autowired
	SqlSession sqlSession;

	public void setSqlSessionTemplate(SqlSession sqlSession)
	{
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<Object> searchCodeList(Map map) {
		System.out.println("endRow " + map.get("endRow"));
		System.out.println("pageSize " + map.get("pageSize"));
		
		List<Object> obj = sqlSession.selectList("searchCodeList");
		
		return obj;
	}
	
	@Override
	public List<CodeVO> searchCodeDetail(CodeVO codeVo) {
		// TODO Auto-generated method stub
		List<CodeVO> obj = sqlSession.selectList("searchCodeDetail", codeVo);
		
		return obj;
	}
	
	@Override
	public List<CodeVO> searchGrpList(CodeVO codeVo) {
		// TODO Auto-generated method stub
		List<CodeVO> obj = sqlSession.selectList("searchGrpList", codeVo);
		
		return obj;
	}

	@Override
	public void insertCodeMaster(CodeVO codeVo) {
		// TODO Auto-generated method stub
		sqlSession.insert("insertCodeMaster", codeVo);
	}

	@Override
	public void insertCodeDetail(CodeVO codeVo) {
		// TODO Auto-generated method stub
		sqlSession.insert("insertCodeDetail", codeVo);
	}

	@Override
	public void deleteCodeMaster(CodeVO codeVo) {
		// TODO Auto-generated method stub
		sqlSession.delete("deleteCodeMaster", codeVo);
	}

	@Override
	public void deleteCodeDetail(CodeVO codeVo) {
		// TODO Auto-generated method stub
		sqlSession.delete("deleteCodeDetail", codeVo);
	}

	@Override
	public int CodeListCount(String string, Map<String, Object> map) {
		// TODO Auto-generated method stub
		int totalCount = 0;
		
		try {
			totalCount = sqlSession.selectOne("code.codeListCount", map);
			System.out.println("totalCount : " + totalCount);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return totalCount;
	}

}
