package com.msp.cp.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.auth.vo.AuthVO;
import com.msp.cp.board.dao.QnABoardDao;
import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.common.PagerVO;

@Service
public class QnaBoardServiceImpl implements QnABoardService {
	  
	@Autowired
	QnABoardDao qnaboardDao;

	@Override
	public List<Object> list(Map map) {
 		return qnaboardDao.list(map);

	}

	@Override
	public PagerVO getBoardListCount(Map<String, Object> map) {
		
		int boardPageNum = (Integer)map.get("pageNum");
		System.out.println("5. ServiceImpl Page userPageNum : " + boardPageNum);
		int totalRowCount = qnaboardDao.BoardListCount("boardListCount", map);
		System.out.println("7. ServiceImpl Page totalRowCount : " + totalRowCount);
		
		PagerVO page = new PagerVO(boardPageNum, totalRowCount, 10, 999);
		
		return page;
	}

	@Override
	public BoardVO detail(int BOARD_NO) {
  		return qnaboardDao.detail(BOARD_NO);
	}

	@Override
	public BoardVO read(int BOARD_NO) {
		// TODO Auto-generated method stub
		return qnaboardDao.read(BOARD_NO);
	}

	@Override
	public void modify(BoardVO vo) {
		qnaboardDao.modify(vo);		
	}

	@Override
	public PagerVO getQnACount(Map<String, Object> map) {
		
		int PageNum = (Integer) map.get("pageNum");
		int pageListCount = qnaboardDao.getQnACount(map);
		
		PagerVO page = new PagerVO(PageNum, pageListCount, 5, 20);
		return page;
		 
	}

	@Override
	public List<BoardVO> QnAList(Map<String, Object> map) {
		List<BoardVO> list = qnaboardDao.QnAList(map);
		return list;
	}

	@Override
	public void insert(BoardVO vo) {
		
		qnaboardDao.insert(vo);
		
	}

	@Override
	public BoardVO CODE(String QUESTION_TYPE_CD) {
		 
		return qnaboardDao.CODE(QUESTION_TYPE_CD);
	}
	
	

}
