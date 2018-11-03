package com.spring.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardVO;
import com.spring.domain.SearchCriteria;
import com.spring.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;

	@Transactional
	@Override
	public void regist(BoardVO board) throws Exception {
		dao.create(board);// 1. create board
		
		String[] files = board.getFiles();
		if(files == null) {return;}
		
		for(String fileName : files) {
			dao.addAttach(fileName); //insert attachName to tbl_attach
		}
		
	}
	
	//update
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(int bno) throws Exception{
		dao.updateViewCnt(bno);// transactional
		return dao.read(bno);
	}
	
	@Transactional
	@Override
	public void modify(BoardVO board) throws Exception {
		dao.update(board); // board info update
		int bno = board.getBno();
		
		dao.deleteAttach(bno); //delete attach file
		String[] files = board.getFiles();
		if(files == null) {return; }
		
		for (String fileName : files) {
			dao.replaceAttach(fileName, bno); //insert new attach file
		}
	}
	
	@Transactional
	@Override
	public void remove(int bno) throws Exception {
		dao.deleteAttach(bno); // attach
		dao.delete(bno); // board
	}

//search
	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}

	@Override
	public List<String> getAttach(int bno) throws Exception {
		return dao.getAttach(bno);
	}
	

}
