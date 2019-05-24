package com.spring.community.persistence;

import java.util.List;
import java.util.Map;

import com.spring.common.search.SearchCriteria;
import com.spring.community.CommunityVO;

public interface CommunityDAO {

	//basic_crud
	public void create(CommunityVO vo) throws Exception;	
	public Map<String, Object> read(int no) throws Exception;
	public void update(CommunityVO vo) throws Exception;
	public void delete(int no) throws Exception;

	//files_CRUD
	public void addAttach(String fullName) throws Exception;
	public List<String> getAttach(int no) throws Exception;
	public void deleteAttach(int bno) throws Exception;
	public void replaceAttach(String fullName, int no) throws Exception;
	
	//list_search_R
	public List<Map<String, Object>> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	//reply,view_U
	public void updateReplyCnt(int no, int amount) throws Exception;
	public void updateViewCnt(int no) throws Exception;
	
	//community
	public void joinCommunity(String cname, String uid) throws Exception;
	
}
