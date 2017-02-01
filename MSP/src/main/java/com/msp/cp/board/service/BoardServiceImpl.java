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
	public BoardVO readPage(int BOARD_NO) {
 		return boardDao.readPage(BOARD_NO);
	}
 
}
