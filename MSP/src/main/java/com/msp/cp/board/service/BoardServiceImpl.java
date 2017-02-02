package com.msp.cp.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msp.cp.board.dao.BoardDao;
import com.msp.cp.board.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDao boardDao;

	@Override
	public List<Object> list() {
 		return boardDao.list();
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
 
}
