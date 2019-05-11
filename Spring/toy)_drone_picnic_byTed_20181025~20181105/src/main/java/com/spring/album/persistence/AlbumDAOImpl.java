package com.spring.album.persistence;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.album.AlbumVO;
import com.spring.common.search.SearchCriteria;
 
@Repository
public class AlbumDAOImpl implements AlbumDAO {
	@Inject
	private SqlSession session;

	//basic_crud
	@Override
	public void create(AlbumVO vo) throws Exception{
		session.insert("AlbumMapper.create", vo);
	}
	//basic_D
	@Override
	public Map<String, Object> read(int bno) throws Exception{
		return session.selectOne("AlbumMapper.read", bno);
	}
	//basic_U
	@Override
	public void update(AlbumVO vo) throws Exception{
		session.update("AlbumMapper.update", vo);
	}
	//basic_D
	@Override
	public void delete(int bno) throws Exception{
		session.delete("AlbumMapper.delete", bno);
	}

//files_CRUD
	//files_C
	@Override
	public void addAttach(String fullName) throws Exception {
		session.insert("AlbumMapper.addAttach", fullName);	
	}
	//files_R	
	@Override
	public List<String> getAttach(int no) throws Exception {		
		return session.selectList("AlbumMapper.getAttach",no);
	}
	//files_U	
	@Override
	public void replaceAttach(String fullName, int no) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bno", no);
		paramMap.put("fullName", fullName);
		session.insert("AlbumMapper.replaceAttach", paramMap);		
	}
	//files_D	
	@Override
	public void deleteAttach(int no) throws Exception {
		session.delete("AlbumMapper.deleteAttach", no);
	}

// list_search
	// list_search_R
	@Override
	public List<Map<String, Object>> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList("AlbumMapper.listSearch", cri);
	}
	// list_search_R_count
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne("AlbumMapper.listSearchCount", cri);
	}

	
//Reply_U_count
	@Override
	public void updateReplyCnt(int no, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ano", no);
		paramMap.put("amount", amount);
		
		session.update("AlbumMapper.updateReplyCnt", paramMap);
	}

//View_U_count
	@Override
	public void updateViewCnt(int no) throws Exception {
		session.update("AlbumMapper.updateViewCnt", no);		
	}
	

}
