package com.msp.cp.code.service;

import java.util.List;

import com.msp.cp.code.vo.CodeVO;

public interface CodeService {
	
	  public List<Object> searchCodeList();
	  public List<CodeVO> searchCodeDetail(CodeVO codeVo);
	  
	  public void insertCodeMaster(CodeVO codeVo);
	  public void insertCodeDetail(CodeVO codeVo);
	  public void deleteCodeMaster(CodeVO codeVo);
	  public void deleteCodeDetail(CodeVO codeVo);
}
