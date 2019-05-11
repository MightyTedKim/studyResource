package com.spring.place.service;

import java.util.List;
import java.util.Map;

import com.spring.board.ReplyVO;
import com.spring.common.pagination.Criteria;
import com.spring.common.search.SearchCriteria;
import com.spring.place.PlaceVO;


public interface PlaceService {
	//json
	public List< Map<String, Object> > readJSON() throws Exception;

	//crud
	public PlaceVO read(int no) throws Exception;
	public void modify(PlaceVO vo) throws Exception;
	public void remove(int no) throws Exception;
	
	//pagination_specific_map
	public List<PlaceVO> listSearchCriteria(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;	
	
	//pagination_ajax_thumb_map
	public List<PlaceVO> listPlacePage(int pno, Criteria cri) throws Exception;
	public int count(int pno) throws Exception;

}

