package com.spring.board.service;

import java.util.List;

import com.spring.board.BoardVO;
import com.spring.common.search.SearchCriteria;

public interface BoardService {
	public void regist(BoardVO board) throws Exception;
	public BoardVO read(int nbo) throws Exception;
	public void modify(BoardVO vo) throws Exception;
	public void remove(int bno) throws Exception;
	
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;	

	public List<String> getAttach(int bno) throws Exception;
}

