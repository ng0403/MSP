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
	public List<BoardVO> list(BoardVO vo) {
		
 		return boardDao.list(vo);
	}
 
}
