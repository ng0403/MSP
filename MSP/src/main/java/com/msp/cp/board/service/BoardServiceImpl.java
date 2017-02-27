package com.msp.cp.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.board.dao.BoardDao;
import com.msp.cp.board.vo.BoardVO;
import com.msp.cp.utils.PagerVO;
 
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDao boardDao;

	@Override
	public List<Object> list(Map map) {
 		return boardDao.list(map);
	}

	@Override
	public BoardVO detail(int BOARD_NO) {
 		return boardDao.detail(BOARD_NO);
	}

	@Override
	public void insert(BoardVO vo) {
		
 		 boardDao.insert(vo);
	}

	@Override
	public void modify(BoardVO vo) {
		
		boardDao.modify(vo);
		
	}

	@Override
	public void removeBoard(String dc) {

		boardDao.removeBoard(dc);
	}

	@Override
	public BoardVO read(int BOARD_NO) {
		// TODO Auto-generated method stub
		return boardDao.read(BOARD_NO);
	}

	@Override
	public List<BoardVO> ajaxlist() {
		
 		return boardDao.ajaxlist();
	}
 
	
	@Override
	public PagerVO getBoardListCount(Map<String, Object> map) {
		int boardPageNum = (Integer)map.get("pageNum");
		int totalRowCount = boardDao.BoardListCount("boardListCount", map);
		
		PagerVO page = new PagerVO(boardPageNum, totalRowCount, 10, 999);
		
		return page;
	}

	@Override
	public List<BoardVO> SearchList(Map<String, Object> map) {
		List<BoardVO> list = boardDao.SearchList(map);
		return list;
	}

	@Override
	public void insertAttachData(BoardVO attach) {
		boardDao.insertAttachData(attach);
	}

	@Override
	public Object searchOneFiledata(String FILE_CD) {
		System.out.println("File_cd" + FILE_CD);
		Object obj =  boardDao.searchOneFiledata(FILE_CD); 
 		return obj;
	}

	@Override
	public BoardVO ReadFilePage(int BOARD_NO) {
		// TODO Auto-generated method stub
		return boardDao.ReadFilePage(BOARD_NO);
	}

	@Override
	public BoardVO readFileModify(int BOARD_NO) {
	 
		return boardDao.readFileModify(BOARD_NO);
	}

	@Override
	public void removeDetail(int BOARD_NO) {
		
		 boardDao.removeDetail(BOARD_NO);
		
	}

	@Override
	public List<BoardVO> QnAajaxlist() {
		 
		return boardDao.QnAajaxlist();
	}

	
	@Override
	public void viewadd(int BOARD_NO) {
		
		boardDao.viewadd(BOARD_NO);
		
	}
 
 
 
}
