package com.spring.community.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.common.search.SearchCriteria;
import com.spring.community.CommunityVO;
 
@Repository
public class CommunityDAOImpl implements CommunityDAO {
	@Inject
	private SqlSession session;

	//basic_crud
	@Override
	public void create(CommunityVO vo) throws Exception{
		session.insert("CommunityMapper.create", vo);
	}
	//basic_D
	@Override
	public Map<String, Object> read(int bno) throws Exception{
		return session.selectOne("CommunityMapper.read", bno);
	}
	//basic_U
	@Override
	public void update(CommunityVO vo) throws Exception{
		session.update("CommunityMapper.update", vo);
	}
	//basic_D
	@Override
	public void delete(int bno) throws Exception{
		session.delete("CommunityMapper.delete", bno);
	}

//files_CRUD
	//files_C
	@Override
	public void addAttach(String fullName) throws Exception {
		session.insert("CommunityMapper.addAttach", fullName);	
	}
	//files_R	
	@Override
	public List<String> getAttach(int no) throws Exception {		
		return session.selectList("CommunityMapper.getAttach",no);
	}
	//files_U	
	@Override
	public void replaceAttach(String fullName, int no) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cno", no);
		paramMap.put("fullName", fullName);
		session.insert("CommunityMapper.replaceAttach", paramMap);		
	}
	//files_D	
	@Override
	public void deleteAttach(int no) throws Exception {
		session.delete("CommunityMapper.deleteAttach", no);
	}

// list_search
	// list_search_R
	@Override
	public List<Map<String, Object>> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList("CommunityMapper.listSearch", cri);
	}
	// list_search_R_count
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne("CommunityMapper.listSearchCount", cri);
	}

	
//Reply_U_count
	@Override
	public void updateReplyCnt(int no, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("cno", no);
		paramMap.put("amount", amount);
		
		session.update("CommunityMapper.updateReplyCnt", paramMap);
	}

//View_U_count
	@Override
	public void updateViewCnt(int no) throws Exception {
		session.update("CommunityMapper.updateViewCnt", no);		
	}
	
//community
	@Override
	public void joinCommunity(String cname, String uid) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cname", cname);
		paramMap.put("uid", uid);
		session.update("CommunityMapper.joinCommunity", paramMap);			
	}
	

}
