package com.msp.cp.code.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.user.vo.userVO;

public interface CodeDao {
	
	public List<Object> searchCodeList(Map map);
	public List<CodeVO> searchCodeDetail(CodeVO codeVo);
	public List<CodeVO> searchGrpList(CodeVO codeVo);
	public List<CodeVO> searchGrpList2(Map<String, Object> map);
	public List<CodeVO> searchGrpPop();	// 공통코드 선택 팝업용
	
	public void insertCodeMaster(CodeVO codeVo);
	public void insertCodeDetail(CodeVO codeVo);
	public void modifyCodeDetail(CodeVO codeVo);
	public void deleteCodeMaster(CodeVO codeVo);
	public void deleteCodeDetail(CodeVO codeVo);
	
	// Paging
	int CodeListCount(String string, Map<String, Object> map);
	
	// menu_level 검색
	public List<CodeVO> menuLevel();
	public List<userVO> userExcel(Map<String, Object> map);

}
