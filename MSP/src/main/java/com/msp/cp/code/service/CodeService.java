package com.msp.cp.code.service;

import java.util.List;
import java.util.Map;

import com.msp.cp.code.vo.CodeVO;
import com.msp.cp.common.PagerVO;

public interface CodeService {
	
	  public List<Object> searchCodeList(Map map);
	  public List<CodeVO> searchCodeDetail(CodeVO codeVo);
	  public List<CodeVO> searchGrpList(CodeVO codeVo);
	  public List<CodeVO> searchGrpList2(Map<String, Object> map);
	  
	  public void insertCodeMaster(CodeVO codeVo);
	  public void insertCodeDetail(CodeVO codeVo);
	  public void deleteCodeMaster(CodeVO codeVo);
	  public void deleteCodeDetail(CodeVO codeVo);
	  
	  // Paging
	  PagerVO getCodeListCount(Map<String, Object> map);
}
