	package com.msp.cp.boardmng.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.boardmng.dao.BoardMngDao;
import com.msp.cp.boardmng.vo.BoardMngVO;
import com.msp.cp.common.PagerVO;

@Service
public class BoardMngServiceImpl implements BoardMngService {

	@Autowired
	BoardMngDao boardmngDao;
	
	@Override
	public PagerVO getBoardMngListCount(Map<String, Object> map) {
		int boardPageNum = (Integer)map.get("pageNum");
		System.out.println("5. ServiceImpl Page userPageNum : " + boardPageNum);
		int totalRowCount = boardmngDao.BoardMngListCount("boardmngListCount", map);
		System.out.println("7. ServiceImpl Page totalRowCount : " + totalRowCount);
		
		PagerVO page = new PagerVO(boardPageNum, totalRowCount, 10, 999);
		
		return page;
	}

	@Override
	public List<Object> list(Map map) {
		// TODO Auto-generated method stub
 		return boardmngDao.list(map);

	}

	@Override
	public BoardMngVO detail(String BOARD_MNG_NO) {
			
		return boardmngDao.detail(BOARD_MNG_NO);
	}

	@Override
	public void modify(BoardMngVO vo) {
		boardmngDao.modify(vo);
	}

	@Override
	public void add(BoardMngVO vo) {

		boardmngDao.add(vo);
	}

	@Override
	public void remove(String dc) {

		boardmngDao.remove(dc);
		
	}

	@Override
	public List<Object> ajaxlist() {

		return boardmngDao.ajaxlist();
	}

	@Override
	public List<Object> codetxt(String CODE_TXT) {
		
		return boardmngDao.codetxt(CODE_TXT);
		
	}

}
