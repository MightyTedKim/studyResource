package com.spring.persistence;

import java.util.List;
import java.util.Map;

import com.spring.domain.BoardVO;
import com.spring.domain.SearchCriteria;

public interface BoardDAO {
	//crud
	public void create(BoardVO vo) throws Exception;
	public BoardVO read(int bno) throws Exception;
	public void update(BoardVO vo) throws Exception;
	public void delete(int bno) throws Exception;

	//listpage
	public List<BoardVO> listPage(int page) throws Exception;

	//search
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	//update
	public void updateReplyCnt(int bno, int amount) throws Exception;
	public void updateViewCnt(int bno) throws Exception;
	
	//files
	public void addAttach(String fullName) throws Exception;
	public List<String> getAttach(int bno) throws Exception;
	public void deleteAttach(int bno) throws Exception;
	public void replaceAttach(String fullName, int bno) throws Exception;
	
}
