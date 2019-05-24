package com.spring.album.service;

import java.util.List;
import java.util.Map;

import com.spring.album.AlbumVO;
import com.spring.common.search.SearchCriteria;

public interface AlbumService {
	//CRUD
	public void create(AlbumVO album) throws Exception;
	public Map<String, Object> read(int no) throws Exception;
	public void modify(AlbumVO vo) throws Exception;
	public void remove(int no) throws Exception;
	
	//pagination
	public List<Map<String, Object>> listSearchCriteria(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;	
	
	//files_R
	public List<String> getAttach(int ano) throws Exception;
}

