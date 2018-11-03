package com.spring.persistence;

import java.util.List;
import java.util.Map;

import com.spring.domain.BoardVO;
import com.spring.domain.SearchCriteria;

public interface BoardDAO {
	//crud
	public void create(BoardVO vo) throws Exception;
	public BoardVO read(int bno) throws Exception;
	public void update(Map map) throws Exception;
	public void delete(Map map) throws Exception;

	//listpage
	public List<BoardVO> listPage(int page) throws Exception;

	//search
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	//update
	public void updateReplyCnt(int bno, int amount) throws Exception;
	public void updateViewCnt(int bno) throws Exception;
	
}
