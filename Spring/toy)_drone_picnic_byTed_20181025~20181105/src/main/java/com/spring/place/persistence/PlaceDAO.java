package com.spring.place.persistence;

import java.util.List;
import java.util.Map;

import com.spring.board.ReplyVO;
import com.spring.common.pagination.Criteria;
import com.spring.common.search.SearchCriteria;
import com.spring.place.PlaceVO;


public interface PlaceDAO {
	//JSON
	public List< Map<String, Object> > readJSON() throws Exception;
	
	//CRUD
	public void create(PlaceVO vo) throws Exception;
	public PlaceVO read(int no) throws Exception;
	public void update(PlaceVO vo) throws Exception;
	public void delete(int no) throws Exception;

	//search
	public List<PlaceVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;

	
	//Pagination_specific_map?
	public List<PlaceVO> listPage(int page) throws Exception;
	
	//pagination_thumbnail_map
	public List<PlaceVO> listPage(int pno, Criteria cri) throws Exception;
	public int count(int pno) throws Exception;
}
