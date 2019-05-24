package com.spring.community.service;

import java.util.List; 
import java.util.Map;

import com.spring.common.search.SearchCriteria;
import com.spring.community.CommunityVO;

public interface CommunityService {
	//CRUD
	public void create(CommunityVO vo) throws Exception;
	public Map<String, Object> read(int no) throws Exception;
	public void modify(CommunityVO vo) throws Exception;
	public void remove(int no) throws Exception;
	
	//pagination
	public List<Map<String, Object>> listSearchCriteria(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;	
	
	//files_R
	public List<String> getAttach(int no) throws Exception;
}

