package com.spring.service;

import java.util.List;
import java.util.Map;

import com.spring.domain.BoardVO;
import com.spring.domain.SearchCriteria;

public interface BoardService {
	public void regist(BoardVO board) throws Exception;
	public BoardVO read(int nbo) throws Exception;
	public void modify(Map map) throws Exception;
	public void remove(Map map) throws Exception;
	
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;	
}

