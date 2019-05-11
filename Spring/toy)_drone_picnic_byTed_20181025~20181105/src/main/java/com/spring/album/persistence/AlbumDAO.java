package com.spring.album.persistence;

import java.util.List;
import java.util.Map;

import com.spring.album.AlbumVO;
import com.spring.common.search.SearchCriteria;

public interface AlbumDAO {

	//basic_crud
	public void create(AlbumVO vo) throws Exception;	
	public Map<String, Object> read(int no) throws Exception;
	public void update(AlbumVO vo) throws Exception;
	public void delete(int no) throws Exception;

	//files_CRUD
	public void addAttach(String fullName) throws Exception;
	public List<String> getAttach(int bno) throws Exception;
	public void deleteAttach(int bno) throws Exception;
	public void replaceAttach(String fullName, int bno) throws Exception;
	
	//list_search_R
	public List<Map<String, Object>> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	//reply,view_U
	public void updateReplyCnt(int bno, int amount) throws Exception;
	public void updateViewCnt(int bno) throws Exception;
}
